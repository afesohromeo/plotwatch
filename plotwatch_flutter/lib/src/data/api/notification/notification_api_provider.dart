import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The signed-in user's notifications (`client.notification`, NOT-01;
/// doc/04e M5-4).
class NotificationApiProvider {
  Client get _client => ApiProvider().client;

  Future<NotificationPage> list({int? beforeId, int? pageSize}) async {
    try {
      return await _client.notification.list(
        beforeId: beforeId,
        pageSize: pageSize,
      );
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<int> unreadCount() async {
    try {
      return await _client.notification.unreadCount();
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<void> markRead(int notificationId) async {
    try {
      await _client.notification.markRead(notificationId);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<void> markAllRead() async {
    try {
      await _client.notification.markAllRead();
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  /// The notifications after [afterId], then the new ones as they come.
  Stream<AppNotification> watch({int? afterId}) => _client.notification
      .watch(afterId: afterId)
      .transform(ApiErrorHandler.streamErrors());
}
