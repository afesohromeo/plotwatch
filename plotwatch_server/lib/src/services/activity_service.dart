import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'live_service.dart';

/// Writes a project's activity feed (FEED) and wakes up the members' open
/// streams (doc/04e M5-5). Cross-cutting: any service may call it
/// (`_standards/14` §4.2).
class ActivityService {
  const ActivityService();

  Future<ActivityEvent> record(
    Session session, {
    required int projectId,
    required UuidValue actorId,
    required ActivityType type,
    required String targetType,
    int? targetId,
    Map<String, String>? payload,
    Transaction? transaction,
  }) async {
    final event = await ActivityEvent.db.insertRow(
      session,
      ActivityEvent(
        projectId: projectId,
        actorId: actorId,
        type: type,
        targetType: targetType,
        targetId: targetId,
        payload: payload,
        createdAt: DateTime.now().toUtc(),
      ),
      transaction: transaction,
    );
    await LiveService.signal(session, LiveService.projectChannel(projectId));
    return event;
  }
}
