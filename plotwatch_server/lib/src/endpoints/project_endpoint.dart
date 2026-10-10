import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import '../services/permission_service.dart';
import '../services/project_service.dart';
import '../services/stage_service.dart';

/// Projects (PROJ-01–05). Thin: sign-in → permission → validate → one
/// service call (`_standards/14` §4.2).
class ProjectEndpoint extends Endpoint {
  static const _service = ProjectService();
  static const _permissions = PermissionService();

  @override
  bool get requireLogin => true;

  /// Any signed-in user can create a project and becomes its owner. The
  /// wizard sends the chosen template's [stages] with it, so the project and
  /// its plan are created together (decision M3-3). Nullable instead of a
  /// default value: see [list].
  Future<ProjectOverview> create(
    Session session,
    ProjectDetails details, {
    List<StageDraft>? stages,
  }) => _service.create(
    session,
    session.authenticated!.authUserId,
    ProjectService.validateDetails(details),
    stages: StageService.validatePlan(stages ?? []),
  );

  /// The caller's projects, a page at a time (`_standards/14` §3.1): only
  /// [status] when given, only names containing [search], ordered by
  /// [sort] (the latest activity first by default; doc/05 §9.4).
  /// Nullable instead of default values: the generated client makes a named
  /// parameter with a default required (Serverpod 4.0.3).
  Future<ProjectSummaryPage> list(
    Session session, {
    int? page,
    int? pageSize,
    ProjectStatus? status,
    String? search,
    ProjectSort? sort,
  }) => _service.list(
    session,
    session.authenticated!.authUserId,
    page: page ?? 0,
    pageSize: pageSize ?? 20,
    status: status,
    search: search,
    sort: sort ?? ProjectSort.recent,
  );

  Future<ProjectOverview> get(Session session, int projectId) async {
    final member = await _permissions.require(
      session,
      projectId,
      ProjectAction.viewProject,
    );
    return _service.get(session, member);
  }

  Future<ProjectOverview> update(
    Session session,
    int projectId,
    ProjectDetails details,
  ) async {
    final member = await _permissions.requireOpen(
      session,
      projectId,
      ProjectAction.editProject,
    );
    return _service.update(
      session,
      member,
      ProjectService.validateDetails(details),
    );
  }

  Future<ProjectOverview> setStatus(
    Session session,
    int projectId,
    ProjectStatus status,
  ) async {
    final member = await _permissions.require(
      session,
      projectId,
      ProjectAction.editProject,
    );
    return _service.setStatus(session, member, status);
  }
}
