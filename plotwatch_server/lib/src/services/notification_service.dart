import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'live_service.dart';

/// In-app notifications (NOT-01, NOT-02 core subset; doc/04e M5-4).
/// Cross-cutting: services call [notify] in their transaction.
class NotificationService {
  const NotificationService();

  static const maxPageSize = 50;

  /// One notification per user of [userIds] except [actorId] (nobody is
  /// notified of their own action), and a wake-up of their streams.
  Future<void> notify(
    Session session, {
    required Iterable<UuidValue> userIds,
    required UuidValue actorId,
    required int projectId,
    required NotificationType type,
    required Map<String, String> payload,
    Transaction? transaction,
  }) async {
    final recipients = {...userIds}..remove(actorId);
    if (recipients.isEmpty) return;
    final now = DateTime.now().toUtc();
    await AppNotification.db.insert(session, [
      for (final userId in recipients)
        AppNotification(
          userId: userId,
          projectId: projectId,
          type: type,
          payload: payload,
          createdAt: now,
        ),
    ], transaction: transaction);
    for (final userId in recipients) {
      await LiveService.signal(session, LiveService.userChannel(userId));
    }
  }

  /// The user's notifications, newest first, older than [beforeId].
  Future<NotificationPage> list(
    Session session,
    UuidValue userId, {
    required int? beforeId,
    required int pageSize,
    bool unreadOnly = false,
  }) async {
    final items = await AppNotification.db.find(
      session,
      where: (t) {
        var where = t.userId.equals(userId);
        if (beforeId != null) where &= t.id < beforeId;
        if (unreadOnly) where &= t.readAt.equals(null);
        return where;
      },
      orderBy: (t) => t.id.desc(),
      limit: pageSize.clamp(1, maxPageSize),
    );
    return NotificationPage(
      items: items,
      unreadCount: await unreadCount(session, userId),
    );
  }

  Future<int> unreadCount(Session session, UuidValue userId) =>
      AppNotification.db.count(
        session,
        where: (t) => t.userId.equals(userId) & t.readAt.equals(null),
      );

  Future<void> markRead(
    Session session,
    UuidValue userId,
    int notificationId,
  ) async {
    final notification = await AppNotification.db.findFirstRow(
      session,
      where: (t) => t.id.equals(notificationId) & t.userId.equals(userId),
    );
    if (notification == null) {
      throw AppException(code: AppErrorCode.notificationNotFound);
    }
    if (notification.readAt != null) return;
    await AppNotification.db.updateRow(
      session,
      notification.copyWith(readAt: DateTime.now().toUtc()),
    );
  }

  Future<void> markAllRead(Session session, UuidValue userId) async {
    final unread = await AppNotification.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.readAt.equals(null),
    );
    if (unread.isEmpty) return;
    final now = DateTime.now().toUtc();
    await AppNotification.db.update(session, [
      for (final notification in unread) notification.copyWith(readAt: now),
    ]);
  }

  /// The user's new notifications as they come (M5-5).
  Stream<AppNotification> watch(
    Session session,
    UuidValue userId, {
    required int? afterId,
  }) => LiveService.watch<AppNotification>(
    session,
    channel: LiveService.userChannel(userId),
    afterId: afterId,
    currentMaxId: () async =>
        (await AppNotification.db.findFirstRow(
          session,
          where: (t) => t.userId.equals(userId),
          orderBy: (t) => t.id.desc(),
        ))?.id ??
        0,
    fetch: (floorId, lastId, since) => AppNotification.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          (t.id > floorId) &
          ((t.id > lastId) | (t.createdAt >= since)),
      orderBy: (t) => t.id,
    ),
    idOf: (notification) => notification.id!,
    check: () async {},
  );
}
