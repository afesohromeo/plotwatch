part of 'notifications_bloc.dart';

@freezed
sealed class NotificationsState with _$NotificationsState {
  const factory NotificationsState({
    /// The bell's badge (NOT-01).
    @Default(0) int unreadCount,
    @Default(false) bool watching,

    // --- Notifications (infinite scroll keyed by the last ID,
    // _standards/14 §3.3)
    /// Everything shown, newest first: live ones on top, then the pages.
    @Default([]) List<AppNotification> notifications,
    @Default([]) List<AppNotification> paginatedNotifications,
    @Default(false) bool maxNotifications,
    @Default(false) bool notificationsRefreshController,

    /// The ID of the last notification of the last page: the next page's
    /// key.
    @Default(0) int notificationsPageKey,
    @Default(GenericStatus.initial) GenericStatus notificationsListStatus,
    String? notificationsListError,

    // --- Live (doc/04e M5-6)
    /// Counts the changes made outside a page load (live, mark read), so
    /// the page knows to redraw.
    @Default(0) int revision,
    @Default(false) bool reconnecting,
  }) = _NotificationsState;
}
