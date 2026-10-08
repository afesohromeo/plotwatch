import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/evidence_service.dart';
import '../services/permission_service.dart';

/// Captures (CAP, VER; doc/02 §9.1, doc/04d). Thin: sign-in → permission →
/// validate → one service call (`_standards/14` §4.2).
class EvidenceEndpoint extends Endpoint {
  static const _service = EvidenceService();
  static const _permissions = PermissionService();

  @override
  bool get requireLogin => true;

  /// The site manager sends a photo's hash and metadata; the server records
  /// its own time and answers with the upload description (M4-3).
  Future<EvidenceCommitResult> commit(
    Session session,
    int projectId,
    EvidenceCommit commit,
  ) async {
    final siteManager = await _permissions.require(
      session,
      projectId,
      ProjectAction.captureEvidence,
    );
    return _service.commit(
      session,
      siteManager,
      EvidenceService.validateCommit(commit),
    );
  }

  /// A new upload description for a capture still committed (retry).
  Future<String> uploadDescription(
    Session session,
    int projectId,
    int evidenceId,
  ) async {
    final siteManager = await _permissions.require(
      session,
      projectId,
      ProjectAction.captureEvidence,
    );
    return _service.uploadDescription(session, siteManager, evidenceId);
  }

  /// Checks the uploaded photo and gives the capture its badge (M4-6).
  Future<Evidence> finalize(
    Session session,
    int projectId,
    int evidenceId,
  ) async {
    final siteManager = await _permissions.require(
      session,
      projectId,
      ProjectAction.captureEvidence,
    );
    return _service.finalize(session, siteManager, evidenceId);
  }

  /// A stage's captures, newest first.
  Future<List<Evidence>> list(
    Session session,
    int projectId,
    int stageId,
  ) async {
    await _permissions.require(session, projectId, ProjectAction.viewProject);
    return _service.list(session, projectId, stageId);
  }

  Future<Evidence> get(Session session, int projectId, int evidenceId) async {
    await _permissions.require(session, projectId, ProjectAction.viewProject);
    return _service.get(session, projectId, evidenceId);
  }

  /// The photo or its thumbnail, through the server (decision M4-4).
  Future<ByteData> media(
    Session session,
    int projectId,
    int evidenceId,
    MediaVariant variant,
  ) async {
    await _permissions.require(session, projectId, ProjectAction.viewProject);
    return _service.media(session, projectId, evidenceId, variant);
  }

  /// The author withdraws a capture with a reason (CAP-09).
  Future<Evidence> retract(
    Session session,
    int projectId,
    int evidenceId,
    String reason,
  ) async {
    final siteManager = await _permissions.require(
      session,
      projectId,
      ProjectAction.captureEvidence,
    );
    return _service.retract(
      session,
      siteManager,
      evidenceId,
      EvidenceService.validateReason(reason),
    );
  }
}
