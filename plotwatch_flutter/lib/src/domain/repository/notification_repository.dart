import 'dart:developer';

import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The signed-in user's notifications: pages keyed by the last ID, the
/// unread count, marking read, and the live stream that reconnects by
/// itself (NOT-01; doc/04e M5-4, M5-6). Errors are logged and rethrown
/// (RULE-012).
class NotificationRepository {
  NotificationRepository({
    NotificationApiProvider? apiProvider,
    this._backoff = liveBackoff,
  }) : _apiProvider = apiProvider ?? NotificationApiProvider();

  final NotificationApiProvider _apiProvider;
  final Duration Function(int attempt) _backoff;

  /// The notifications older than [beforeId] (the newest without it),
  /// newest first; only the unread ones with [unreadOnly] (doc/05 §9.5).
  Future<PaginatedList<AppNotification>> fetchNotifications({
    int? beforeId,
    required int size,
    bool unreadOnly = false,
  }) => _logged('fetching notifications', () async {
    final page = await _apiProvider.list(
      beforeId: beforeId,
      pageSize: size,
      unreadOnly: unreadOnly ? true : null,
    );
    return PaginatedList(
      content: page.items,
      pagination: Pagination(size: size),
    );
  });

  Future<int> fetchUnreadCount() =>
      _logged('fetching the unread count', _apiProvider.unreadCount);

  Future<void> markRead(int notificationId) => _logged(
    'marking a notification read',
    () => _apiProvider.markRead(notificationId),
  );

  Future<void> markAllRead() =>
      _logged('marking every notification read', _apiProvider.markAllRead);

  /// The notifications after [afterId] as they come, reconnecting after a
  /// drop.
  Stream<LiveUpdate<AppNotification>> watchNotifications({int? afterId}) =>
      reconnectingStream(
        subscribe: (lastId) => _apiProvider.watch(afterId: lastId),
        idOf: (notification) => notification.id!,
        afterId: afterId,
        backoff: _backoff,
      );

  Future<T> _logged<T>(String what, Future<T> Function() call) async {
    try {
      return await call();
    } catch (e) {
      log('Error $what: $e');
      rethrow;
    }
  }
}
