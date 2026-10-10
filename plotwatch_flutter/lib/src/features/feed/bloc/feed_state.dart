part of 'feed_bloc.dart';

@freezed
sealed class FeedState with _$FeedState {
  const factory FeedState({
    int? projectId,

    // --- Activity (infinite scroll keyed by the last ID, _standards/14 §3.3)
    /// Everything shown, newest first: live events on top, then the pages.
    @Default([]) List<ActivityEntry> activity,
    @Default([]) List<ActivityEntry> paginatedActivity,
    @Default(false) bool maxActivity,
    @Default(false) bool activityRefreshController,

    /// The ID of the last event of the last page: the next page's key.
    @Default(0) int activityPageKey,
    @Default(GenericStatus.initial) GenericStatus activityListStatus,
    String? activityListError,

    // --- Filter (doc/05 §9.5): the last fetch's, applied to live events
    List<ActivityType>? filterTypes,
    int? filterStageId,

    // --- Live (doc/04e M5-5, M5-6)
    /// Counts the live events added on top, so the page knows to redraw.
    @Default(0) int liveCount,
    @Default(false) bool reconnecting,
  }) = _FeedState;
}
