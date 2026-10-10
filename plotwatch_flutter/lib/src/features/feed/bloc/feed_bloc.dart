import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'feed_event.dart';
part 'feed_state.dart';
part 'feed_bloc.freezed.dart';

const kFeedPageSize = 20;

/// A project's activity feed, live (FEED-01–03; doc/04e M5-5 to M5-7):
/// older pages load below as the list scrolls; new events arrive on top
/// through the live stream, each event once even if a page brings it too.
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc({required this._activityRepository}) : super(const FeedState()) {
    on<_FetchActivity>(_onFetchActivity);
    on<_RefreshActivity>(_onRefreshActivity);
    on<_LiveUpdateReceived>(_onLiveUpdateReceived);
  }

  final ActivityRepository _activityRepository;
  StreamSubscription<LiveUpdate<ActivityEntry>>? _live;

  Future<void> _onFetchActivity(
    _FetchActivity event,
    Emitter<FeedState> emit,
  ) async {
    final l10n = LocalizationService.localization;
    final size = event.size ?? kFeedPageSize;
    emit(
      state.copyWith(
        projectId: event.projectId,
        filterTypes: event.types,
        filterStageId: event.stageId,
        activityListStatus: GenericStatus.loading,
        activityListError: null,
        activity: event.pageKey == 0 ? [] : state.activity,
        activityRefreshController: false,
      ),
    );

    try {
      final result = await _activityRepository.fetchActivity(
        event.projectId,
        beforeId: event.pageKey == 0 ? null : event.pageKey,
        size: size,
        types: event.types,
        stageId: event.stageId,
      );
      final page = result.content;
      // A live event may already be on top (_standards/14 §3.3).
      final known = {for (final entry in state.activity) entry.event.id};
      final fresh = [
        for (final entry in page)
          if (!known.contains(entry.event.id)) entry,
      ];
      emit(
        state.copyWith(
          activityListStatus: GenericStatus.success,
          paginatedActivity: fresh,
          maxActivity: page.length < (result.pagination.size ?? size),
          activityPageKey: page.isEmpty ? event.pageKey : page.last.event.id!,
          activity: [...state.activity, ...fresh],
        ),
      );
      // Live from the newest event shown, so nothing in between is missed.
      if (event.pageKey == 0 && _live == null) {
        _watch(event.projectId, afterId: page.firstOrNull?.event.id ?? 0);
      }
    } on HttpException400 catch (e) {
      emit(_failure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_failure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_failure(l10n.networkError));
    } catch (e) {
      log('FeedBloc._onFetchActivity error: $e');
      emit(_failure(l10n.errorActivityLoad));
    }
  }

  void _onRefreshActivity(_RefreshActivity event, Emitter<FeedState> emit) {
    emit(
      state.copyWith(
        activityListStatus: GenericStatus.initial,
        activity: [],
        paginatedActivity: [],
        activityPageKey: 0,
        maxActivity: false,
        activityRefreshController: true,
      ),
    );
  }

  void _onLiveUpdateReceived(
    _LiveUpdateReceived event,
    Emitter<FeedState> emit,
  ) {
    switch (event.update) {
      case LiveItem(:final item):
        final known = state.activity.any((e) => e.event.id == item.event.id);
        emit(
          known || !_matches(item.event)
              ? state.copyWith(reconnecting: false)
              : state.copyWith(
                  // Oldest first from the stream: each goes on top.
                  activity: [item, ...state.activity],
                  liveCount: state.liveCount + 1,
                  reconnecting: false,
                ),
        );
      case LiveReconnecting():
        emit(state.copyWith(reconnecting: true));
      case LiveConnected():
        emit(state.copyWith(reconnecting: false));
    }
  }

  /// Whether a live event fits the chosen filter (doc/05 §9.5).
  bool _matches(ActivityEvent event) {
    final types = state.filterTypes;
    final stageId = state.filterStageId;
    return (types == null || types.isEmpty || types.contains(event.type)) &&
        (stageId == null || event.stageId == stageId);
  }

  void _watch(int projectId, {required int afterId}) {
    _live = _activityRepository
        .watchActivity(projectId, afterId: afterId)
        .listen(
          (update) => add(FeedEvent.liveUpdateReceived(update)),
          // E.g. the member was removed: the feed stays as it is.
          onError: (Object e) => log('FeedBloc live stream ended: $e'),
        );
  }

  FeedState _failure(String message) => state.copyWith(
    activityListStatus: GenericStatus.failure,
    activityListError: message,
  );

  @override
  Future<void> close() async {
    await _live?.cancel();
    return super.close();
  }
}
