import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/permission_service.dart';
import '../services/stage_service.dart';

/// The stage plan (STG-01–09, BUD-01–02; doc/04c). Thin: sign-in →
/// permission → validate → one service call (`_standards/14` §4.2).
class StageEndpoint extends Endpoint {
  static const _service = StageService();
  static const _permissions = PermissionService();

  @override
  bool get requireLogin => true;

  /// The stages in order, the total budget and the progress.
  Future<StagePlan> plan(Session session, int projectId) async {
    await _permissions.require(session, projectId, ProjectAction.viewProject);
    return _service.plan(session, projectId);
  }

  Future<StageView> get(Session session, int projectId, int stageId) async {
    await _permissions.require(session, projectId, ProjectAction.viewProject);
    return _service.get(session, projectId, stageId);
  }

  /// Fills an empty plan, e.g. from a template (decision M3-3).
  Future<StagePlan> createPlan(
    Session session,
    int projectId,
    List<StageDraft> stages,
  ) async {
    final owner = await _permissions.require(
      session,
      projectId,
      ProjectAction.manageStages,
    );
    return _service.createPlan(
      session,
      owner,
      StageService.validatePlan(stages),
    );
  }

  Future<StageView> create(
    Session session,
    int projectId,
    StageDraft draft,
  ) async {
    final owner = await _permissions.require(
      session,
      projectId,
      ProjectAction.manageStages,
    );
    return _service.create(session, owner, StageService.validateDraft(draft));
  }

  Future<StageView> update(
    Session session,
    int projectId,
    int stageId,
    StageDraft draft,
  ) async {
    final owner = await _permissions.require(
      session,
      projectId,
      ProjectAction.manageStages,
    );
    return _service.update(
      session,
      owner,
      stageId,
      StageService.validateDraft(draft),
    );
  }

  Future<void> delete(Session session, int projectId, int stageId) async {
    final owner = await _permissions.require(
      session,
      projectId,
      ProjectAction.manageStages,
    );
    return _service.delete(session, owner, stageId);
  }

  /// [stageIds] lists every stage of the project once, in the new order.
  Future<StagePlan> reorder(
    Session session,
    int projectId,
    List<int> stageIds,
  ) async {
    final owner = await _permissions.require(
      session,
      projectId,
      ProjectAction.manageStages,
    );
    return _service.reorder(session, owner, stageIds);
  }

  /// The site manager starts work on a stage (STG-06).
  Future<StageView> start(Session session, int projectId, int stageId) async {
    final siteManager = await _permissions.require(
      session,
      projectId,
      ProjectAction.startStage,
    );
    return _service.start(session, siteManager, stageId);
  }
}
