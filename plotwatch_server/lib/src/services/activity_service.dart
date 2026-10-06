import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Writes a project's activity feed (FEED). Publishing to the members'
/// streams is added in M5. Cross-cutting: any service may call it
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
  }) {
    return ActivityEvent.db.insertRow(
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
  }
}
