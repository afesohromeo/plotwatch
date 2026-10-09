import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'live_service.dart';
import 'people_service.dart';
import 'permission_service.dart';

/// A project's activity feed: pages and the live stream, each event with
/// the name of who did it (FEED-01–03, 05; doc/04e M5-5, M5-7).
class FeedService {
  const FeedService();

  static const _people = PeopleService();
  static const _permissions = PermissionService();
  static const maxPageSize = 50;

  /// Newest first, older than [beforeId] (`_standards/14` §3.3).
  Future<ActivityPage> list(
    Session session,
    int projectId, {
    required int? beforeId,
    required int pageSize,
  }) async {
    final events = await ActivityEvent.db.find(
      session,
      where: (t) => beforeId == null
          ? t.projectId.equals(projectId)
          : t.projectId.equals(projectId) & (t.id < beforeId),
      orderBy: (t) => t.id.desc(),
      limit: pageSize.clamp(1, maxPageSize),
    );
    return ActivityPage(items: await _entries(session, events));
  }

  /// The missed events, then the new ones (M5-5). The membership is checked
  /// again on every wake-up, so a removed member's stream ends (MEMB-08).
  Stream<ActivityEntry> watch(
    Session session,
    int projectId, {
    required int? afterId,
  }) => LiveService.watch<ActivityEntry>(
    session,
    channel: LiveService.projectChannel(projectId),
    afterId: afterId,
    currentMaxId: () async =>
        (await ActivityEvent.db.findFirstRow(
          session,
          where: (t) => t.projectId.equals(projectId),
          orderBy: (t) => t.id.desc(),
        ))?.id ??
        0,
    fetch: (floorId, lastId, since) async => _entries(
      session,
      await ActivityEvent.db.find(
        session,
        where: (t) =>
            t.projectId.equals(projectId) &
            (t.id > floorId) &
            ((t.id > lastId) | (t.createdAt >= since)),
        orderBy: (t) => t.id,
      ),
    ),
    idOf: (entry) => entry.event.id!,
    check: () async {
      await _permissions.require(
        session,
        projectId,
        ProjectAction.viewProject,
      );
    },
  );

  Future<List<ActivityEntry>> _entries(
    Session session,
    List<ActivityEvent> events,
  ) async {
    final names = await _people.names(session, {
      for (final event in events) event.actorId,
    });
    return [
      for (final event in events)
        ActivityEntry(event: event, actorName: names[event.actorId]),
    ];
  }
}
