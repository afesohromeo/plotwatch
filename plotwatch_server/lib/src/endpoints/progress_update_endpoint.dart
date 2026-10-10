import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/permission_service.dart';
import '../services/update_service.dart';

/// The site manager's progress updates (UPD-01, UPD-02; doc/04e M5-9 b).
/// Thin: sign-in → permission → validate → one service call
/// (`_standards/14` §4.2).
class ProgressUpdateEndpoint extends Endpoint {
  static const _service = UpdateService();
  static const _permissions = PermissionService();

  @override
  bool get requireLogin => true;

  Future<ProgressUpdate> create(
    Session session,
    int projectId,
    ProgressUpdateDraft draft,
  ) async {
    final siteManager = await _permissions.requireOpen(
      session,
      projectId,
      ProjectAction.postUpdates,
    );
    return _service.create(
      session,
      siteManager,
      UpdateService.validateDraft(draft),
    );
  }

  Future<ProgressUpdate> get(
    Session session,
    int projectId,
    int updateId,
  ) async {
    await _permissions.require(session, projectId, ProjectAction.viewProject);
    return _service.get(session, projectId, updateId);
  }
}
