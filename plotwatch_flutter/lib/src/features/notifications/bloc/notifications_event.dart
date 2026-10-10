part of 'notifications_bloc.dart';

@freezed
sealed class NotificationsEvent with _$NotificationsEvent {
  /// Signed in: loads the unread count and starts the live stream.
  const factory NotificationsEvent.started() = _Started;

  /// Signed out: stops the stream and forgets everything.
  const factory NotificationsEvent.stopped() = _Stopped;

  /// Fetches the notifications older than [pageKey] (the last loaded ID; 0
  /// for the newest), `_standards/14` §3.3; only the unread ones with
  /// [unreadOnly] (doc/05 §9.5).
  const factory NotificationsEvent.fetchNotifications({
    @Default(0) int pageKey,
    @Default(false) bool unreadOnly,
    int? size,
  }) = _FetchNotifications;

  const factory NotificationsEvent.refreshNotifications() =
      _RefreshNotifications;

  const factory NotificationsEvent.markRead(int notificationId) = _MarkRead;

  const factory NotificationsEvent.markAllRead() = _MarkAllRead;

  /// From the live stream (doc/04e M5-6).
  const factory NotificationsEvent.liveUpdateReceived(
    LiveUpdate<AppNotification> update,
  ) = _LiveUpdateReceived;
}
