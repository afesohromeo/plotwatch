import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';
part 'notifications_bloc.freezed.dart';

const kNotificationsPageSize = 20;

/// The signed-in user's notifications, app-wide (NOT-01; doc/04e M5-4,
/// M5-6): the unread badge follows live notifications and marking read;
/// the notification centre pages through them.
class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc({required this._notificationRepository})
    : super(const NotificationsState()) {
    on<_Started>(_onStarted);
    on<_Stopped>(_onStopped);
    on<_FetchNotifications>(_onFetchNotifications);
    on<_RefreshNotifications>(_onRefreshNotifications);
    on<_MarkRead>(_onMarkRead);
    on<_MarkAllRead>(_onMarkAllRead);
    on<_LiveUpdateReceived>(_onLiveUpdateReceived);
  }

  final NotificationRepository _notificationRepository;
  StreamSubscription<LiveUpdate<AppNotification>>? _live;

  Future<void> _onStarted(
    _Started event,
    Emitter<NotificationsState> emit,
  ) async {
    if (state.watching) return;
    emit(state.copyWith(watching: true));
    try {
      final (count, newest) = await (
        _notificationRepository.fetchUnreadCount(),
        _notificationRepository.fetchNotifications(size: 1),
      ).wait;
      if (!state.watching) return;
      emit(state.copyWith(unreadCount: count));
      // Live from the newest one, so nothing in between is missed.
      _watch(afterId: newest.content.firstOrNull?.id ?? 0);
    } catch (e) {
      // The badge waits for the next sign-in or app start.
      log('NotificationsBloc._onStarted error: $e');
      emit(state.copyWith(watching: false));
    }
  }

  Future<void> _onStopped(
    _Stopped event,
    Emitter<NotificationsState> emit,
  ) async {
    await _live?.cancel();
    _live = null;
    emit(const NotificationsState());
  }

  Future<void> _onFetchNotifications(
    _FetchNotifications event,
    Emitter<NotificationsState> emit,
  ) async {
    final l10n = LocalizationService.localization;
    final size = event.size ?? kNotificationsPageSize;
    emit(
      state.copyWith(
        notificationsListStatus: GenericStatus.loading,
        notificationsListError: null,
        notifications: event.pageKey == 0 ? [] : state.notifications,
        notificationsRefreshController: false,
      ),
    );

    try {
      final result = await _notificationRepository.fetchNotifications(
        beforeId: event.pageKey == 0 ? null : event.pageKey,
        size: size,
      );
      final page = result.content;
      final known = {for (final n in state.notifications) n.id};
      final fresh = [
        for (final n in page)
          if (!known.contains(n.id)) n,
      ];
      emit(
        state.copyWith(
          notificationsListStatus: GenericStatus.success,
          paginatedNotifications: fresh,
          maxNotifications: page.length < (result.pagination.size ?? size),
          notificationsPageKey: page.isEmpty ? event.pageKey : page.last.id!,
          notifications: [...state.notifications, ...fresh],
        ),
      );
    } on HttpException400 catch (e) {
      emit(_failure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_failure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_failure(l10n.networkError));
    } catch (e) {
      log('NotificationsBloc._onFetchNotifications error: $e');
      emit(_failure(l10n.errorNotificationsLoad));
    }
  }

  void _onRefreshNotifications(
    _RefreshNotifications event,
    Emitter<NotificationsState> emit,
  ) {
    emit(
      state.copyWith(
        notificationsListStatus: GenericStatus.initial,
        notifications: [],
        paginatedNotifications: [],
        notificationsPageKey: 0,
        maxNotifications: false,
        notificationsRefreshController: true,
      ),
    );
  }

  Future<void> _onMarkRead(
    _MarkRead event,
    Emitter<NotificationsState> emit,
  ) async {
    try {
      await _notificationRepository.markRead(event.notificationId);
      final now = DateTime.now().toUtc();
      final wasUnread = state.notifications.any(
        (n) => n.id == event.notificationId && n.isUnread,
      );
      emit(
        state.copyWith(
          notifications: [
            for (final n in state.notifications)
              n.id == event.notificationId && n.isUnread
                  ? n.copyWith(readAt: now)
                  : n,
          ],
          unreadCount: wasUnread && state.unreadCount > 0
              ? state.unreadCount - 1
              : state.unreadCount,
          revision: state.revision + 1,
        ),
      );
    } catch (e) {
      // Still unread; the next tap tries again.
      log('NotificationsBloc._onMarkRead error: $e');
    }
  }

  Future<void> _onMarkAllRead(
    _MarkAllRead event,
    Emitter<NotificationsState> emit,
  ) async {
    try {
      await _notificationRepository.markAllRead();
      final now = DateTime.now().toUtc();
      emit(
        state.copyWith(
          notifications: [
            for (final n in state.notifications)
              n.isUnread ? n.copyWith(readAt: now) : n,
          ],
          unreadCount: 0,
          revision: state.revision + 1,
        ),
      );
    } catch (e) {
      log('NotificationsBloc._onMarkAllRead error: $e');
    }
  }

  void _onLiveUpdateReceived(
    _LiveUpdateReceived event,
    Emitter<NotificationsState> emit,
  ) {
    switch (event.update) {
      case LiveItem(:final item):
        if (state.notifications.any((n) => n.id == item.id)) {
          emit(state.copyWith(reconnecting: false));
          return;
        }
        emit(
          state.copyWith(
            notifications: [item, ...state.notifications],
            unreadCount: state.unreadCount + (item.isUnread ? 1 : 0),
            revision: state.revision + 1,
            reconnecting: false,
          ),
        );
      case LiveReconnecting():
        emit(state.copyWith(reconnecting: true));
      case LiveConnected():
        emit(state.copyWith(reconnecting: false));
    }
  }

  void _watch({required int afterId}) {
    _live = _notificationRepository
        .watchNotifications(afterId: afterId)
        .listen(
          (update) => add(NotificationsEvent.liveUpdateReceived(update)),
          // E.g. the session expired: the sign-in flow takes over.
          onError: (Object e) => log('NotificationsBloc live stream ended: $e'),
        );
  }

  NotificationsState _failure(String message) => state.copyWith(
    notificationsListStatus: GenericStatus.failure,
    notificationsListError: message,
  );

  @override
  Future<void> close() async {
    await _live?.cancel();
    return super.close();
  }
}
