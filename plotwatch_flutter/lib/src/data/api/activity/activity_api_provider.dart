import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// A project's activity feed (`client.activity`, FEED-01–03; doc/04e M5-7).
class ActivityApiProvider {
  Client get _client => ApiProvider().client;

  /// [types] and [stageId]: doc/05 §9.5.
  Future<ActivityPage> list(
    int projectId, {
    int? beforeId,
    int? pageSize,
    List<ActivityType>? types,
    int? stageId,
  }) async {
    try {
      return await _client.activity.list(
        projectId,
        beforeId: beforeId,
        pageSize: pageSize,
        types: types,
        stageId: stageId,
      );
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  /// The events after [afterId], then the new ones as they happen.
  Stream<ActivityEntry> watch(int projectId, {int? afterId}) => _client.activity
      .watch(projectId, afterId: afterId)
      .transform(ApiErrorHandler.streamErrors());
}
