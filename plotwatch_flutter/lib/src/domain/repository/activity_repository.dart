import 'dart:developer';

import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// A project's activity feed: pages keyed by the last ID and the live
/// stream that reconnects by itself (`_standards/14` §3.3; doc/04e M5-6,
/// M5-7). Errors are logged and rethrown (RULE-012).
class ActivityRepository {
  ActivityRepository({
    ActivityApiProvider? apiProvider,
    this._backoff = liveBackoff,
  }) : _apiProvider = apiProvider ?? ActivityApiProvider();

  final ActivityApiProvider _apiProvider;
  final Duration Function(int attempt) _backoff;

  /// The events older than [beforeId] (the newest without it), newest
  /// first; only [types] and [stageId]'s when given (doc/05 §9.5).
  Future<PaginatedList<ActivityEntry>> fetchActivity(
    int projectId, {
    int? beforeId,
    required int size,
    List<ActivityType>? types,
    int? stageId,
  }) async {
    try {
      final page = await _apiProvider.list(
        projectId,
        beforeId: beforeId,
        pageSize: size,
        types: types,
        stageId: stageId,
      );
      return PaginatedList(
        content: page.items,
        pagination: Pagination(size: size),
      );
    } catch (e) {
      log('Error fetching activity: $e');
      rethrow;
    }
  }

  /// The events after [afterId] as they happen, reconnecting after a drop.
  Stream<LiveUpdate<ActivityEntry>> watchActivity(
    int projectId, {
    int? afterId,
  }) => reconnectingStream(
    subscribe: (lastId) => _apiProvider.watch(projectId, afterId: lastId),
    idOf: (entry) => entry.event.id!,
    afterId: afterId,
    backoff: _backoff,
  );
}
