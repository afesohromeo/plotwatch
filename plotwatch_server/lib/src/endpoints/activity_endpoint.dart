import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/feed_service.dart';
import '../services/permission_service.dart';

/// A project's activity feed: pages and a live stream with catch-up
/// (FEED-01–03, 05; doc/04e M5-5, M5-7). Thin: sign-in → permission → one
/// service call (`_standards/14` §4.2).
class ActivityEndpoint extends Endpoint {
  static const _service = FeedService();
  static const _permissions = PermissionService();

  @override
  bool get requireLogin => true;

  /// Newest first, older than [beforeId] (`_standards/14` §3.3), only
  /// the [types] given and only [stageId]'s events when given (doc/05
  /// §9.4). Nullable instead of default values: see `ProjectEndpoint.list`.
  Future<ActivityPage> list(
    Session session,
    int projectId, {
    int? beforeId,
    int? pageSize,
    List<ActivityType>? types,
    int? stageId,
  }) async {
    await _permissions.require(session, projectId, ProjectAction.viewProject);
    return _service.list(
      session,
      projectId,
      beforeId: beforeId,
      pageSize: pageSize ?? 20,
      types: types,
      stageId: stageId,
    );
  }

  /// The events after [afterId], then the new ones as they happen. Without
  /// [afterId], only the new ones.
  Stream<ActivityEntry> watch(
    Session session,
    int projectId, {
    int? afterId,
  }) => _service.watch(session, projectId, afterId: afterId);
}
