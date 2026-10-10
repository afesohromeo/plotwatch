part of 'feed_bloc.dart';

@freezed
sealed class FeedEvent with _$FeedEvent {
  /// Fetches the events older than [pageKey] (the last loaded ID; 0 for the
  /// newest), `_standards/14` §3.3. The first page also starts the live
  /// stream.
  ///
  /// Only [types] and [stageId]'s events when given, the live ones too
  /// (doc/05 §9.5).
  const factory FeedEvent.fetchActivity({
    required int projectId,
    @Default(0) int pageKey,
    List<ActivityType>? types,
    int? stageId,
    int? size,
  }) = _FetchActivity;

  const factory FeedEvent.refreshActivity() = _RefreshActivity;

  /// From the live stream: a new event, or a change in the connection
  /// (doc/04e M5-6).
  const factory FeedEvent.liveUpdateReceived(LiveUpdate<ActivityEntry> update) =
      _LiveUpdateReceived;
}
