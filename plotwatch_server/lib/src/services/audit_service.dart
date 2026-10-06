import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Writes the append-only audit log (AUD-01). Nothing updates or deletes an
/// entry. Cross-cutting: any service may call it (`_standards/14` §4.2).
class AuditService {
  const AuditService();

  Future<void> record(
    Session session, {
    required UuidValue actorId,
    required int? projectId,
    required String action,
    required String entityType,
    int? entityId,
    Map<String, String>? before,
    Map<String, String>? after,
    Transaction? transaction,
  }) async {
    await AuditLog.db.insertRow(
      session,
      AuditLog(
        actorId: actorId,
        projectId: projectId,
        action: action,
        entityType: entityType,
        entityId: entityId,
        before: before,
        after: after,
        createdAt: DateTime.now().toUtc(),
      ),
      transaction: transaction,
    );
  }
}
