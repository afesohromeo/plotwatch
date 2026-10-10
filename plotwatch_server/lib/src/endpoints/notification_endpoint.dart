import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import '../services/notification_service.dart';

/// The signed-in user's in-app notifications (NOT-01, doc/04e M5-4). Each
/// call only ever touches the caller's own notifications.
class NotificationEndpoint extends Endpoint {
  static const _service = NotificationService();

  @override
  bool get requireLogin => true;

  /// Newest first, older than [beforeId], with the unread count; only the
  /// unread ones with [unreadOnly] (doc/05 §9.4). Nullable instead of
  /// default values: see `ProjectEndpoint.list`.
  Future<NotificationPage> list(
    Session session, {
    int? beforeId,
    int? pageSize,
    bool? unreadOnly,
  }) => _service.list(
    session,
    _userId(session),
    beforeId: beforeId,
    pageSize: pageSize ?? 20,
    unreadOnly: unreadOnly ?? false,
  );

  Future<int> unreadCount(Session session) =>
      _service.unreadCount(session, _userId(session));

  Future<void> markRead(Session session, int notificationId) =>
      _service.markRead(session, _userId(session), notificationId);

  Future<void> markAllRead(Session session) =>
      _service.markAllRead(session, _userId(session));

  /// The notifications after [afterId], then the new ones as they come.
  /// Without [afterId], only the new ones.
  Stream<AppNotification> watch(Session session, {int? afterId}) =>
      _service.watch(session, _userId(session), afterId: afterId);

  UuidValue _userId(Session session) => session.authenticated!.authUserId;
}
