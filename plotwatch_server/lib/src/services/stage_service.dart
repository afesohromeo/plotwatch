import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'activity_service.dart';
import 'audit_service.dart';

/// A project's stage plan: stages with a budget, planned dates and a
/// checklist (STG-01–09, BUD-01–02; doc/04c). Callers check permissions
/// first with `PermissionService`. Every change locks the project row, so
/// two edits of the same plan never interleave their order indexes.
class StageService {
  const StageService();

  static const _audit = AuditService();
  static const _activity = ActivityService();

  static const maxStages = 50;
  static const maxItems = 30;
  static const maxNameLength = 100;
  static const maxDescriptionLength = 1000;
  static const maxLabelLength = 200;
  static const maxBudgetMinor = 1000000000000000;

  /// Statuses in which the owner may still edit or move a stage (STG-02).
  static const _editable = {StageStatus.notStarted, StageStatus.inProgress};

  /// Project statuses in which the plan can't change (decision M3-6).
  static const _closedProjects = {
    ProjectStatus.completed,
    ProjectStatus.archived,
  };

  /// Returns [draft] cleaned up (trimmed texts, blank description as none),
  /// or throws [AppException] when a value is invalid (decisions M3-4, M3-5).
  static StageDraft validateDraft(StageDraft draft) {
    final name = draft.name.trim();
    if (name.isEmpty || name.length > maxNameLength) {
      throw AppException(code: AppErrorCode.invalidStageName);
    }
    final description = draft.description?.trim();
    if (description != null && description.length > maxDescriptionLength) {
      throw AppException(code: AppErrorCode.invalidStageDescription);
    }
    if (draft.budgetMinor < 0 || draft.budgetMinor > maxBudgetMinor) {
      throw AppException(code: AppErrorCode.invalidBudget);
    }
    final start = draft.plannedStart;
    final end = draft.plannedEnd;
    if (start != null && end != null && end.isBefore(start)) {
      throw AppException(code: AppErrorCode.invalidStageDates);
    }
    if (draft.items.length > maxItems) {
      throw AppException(code: AppErrorCode.tooManyChecklistItems);
    }
    final items = [
      for (final item in draft.items) item.copyWith(label: item.label.trim()),
    ];
    if (items.any((i) => i.label.isEmpty || i.label.length > maxLabelLength)) {
      throw AppException(code: AppErrorCode.invalidChecklistItem);
    }
    return draft.copyWith(
      name: name,
      description: (description?.isEmpty ?? true) ? null : description,
      items: items,
    );
  }

  /// Validates a whole plan, e.g. a template's stages (decision M3-3).
  static List<StageDraft> validatePlan(List<StageDraft> stages) {
    if (stages.length > maxStages) {
      throw AppException(code: AppErrorCode.tooManyStages);
    }
    return [for (final stage in stages) validateDraft(stage)];
  }

  /// The budget-weighted share of approved stages, 0–100; every stage weighs
  /// the same when all budgets are 0 (STG-09, decision M3-10).
  static int progressPercent(List<Stage> stages) {
    if (stages.isEmpty) return 0;
    final total = stages.fold<int>(0, (sum, s) => sum + s.budgetMinor);
    final approved = stages.where((s) => s.status == StageStatus.approved);
    if (total == 0) return approved.length * 100 ~/ stages.length;
    final approvedBudget = approved.fold<int>(
      0,
      (sum, s) => sum + s.budgetMinor,
    );
    return approvedBudget * 100 ~/ total;
  }

  static int budgetTotal(List<Stage> stages) =>
      stages.fold<int>(0, (sum, s) => sum + s.budgetMinor);

  /// The stages of [projectId] in order, with their checklists.
  Future<StagePlan> plan(
    Session session,
    int projectId, {
    Transaction? transaction,
  }) async {
    final stages = await _stages(session, projectId, transaction);
    final items = await _itemsOf(
      session,
      {for (final s in stages) s.id!},
      transaction,
    );
    return StagePlan(
      stages: [
        for (final stage in stages)
          StageView(
            stage: stage,
            items: items[stage.id] ?? [],
            itemsCovered: 0,
          ),
      ],
      budgetTotalMinor: budgetTotal(stages),
      progressPercent: progressPercent(stages),
    );
  }

  Future<StageView> get(Session session, int projectId, int stageId) async {
    final stage = await _stage(session, projectId, stageId, null);
    return _view(session, stage, null);
  }

  /// The stages of several projects, for the project list's progress.
  Future<Map<int, List<Stage>>> stagesByProject(
    Session session,
    Set<int> projectIds,
  ) async {
    if (projectIds.isEmpty) return {};
    final stages = await Stage.db.find(
      session,
      where: (t) => t.projectId.inSet(projectIds),
    );
    final byProject = <int, List<Stage>>{};
    for (final stage in stages) {
      byProject.putIfAbsent(stage.projectId, () => []).add(stage);
    }
    return byProject;
  }

  /// Fills an empty project's plan, e.g. from a template (decision M3-3).
  Future<StagePlan> createPlan(
    Session session,
    ProjectMember owner,
    List<StageDraft> stages,
  ) {
    return session.db.transaction((transaction) async {
      await _plannableProject(session, owner.projectId, transaction);
      final count = await Stage.db.count(
        session,
        where: (t) => t.projectId.equals(owner.projectId),
        transaction: transaction,
      );
      if (count > 0) {
        throw AppException(code: AppErrorCode.stagePlanNotEmpty);
      }
      await insertPlan(
        session,
        owner.projectId,
        owner.authUserId,
        stages,
        transaction,
      );
      return plan(session, owner.projectId, transaction: transaction);
    });
  }

  /// Inserts validated [stages] into an empty plan and records it; used by
  /// [createPlan] and by project creation (one transaction, M3-3).
  Future<void> insertPlan(
    Session session,
    int projectId,
    UuidValue actorId,
    List<StageDraft> stages,
    Transaction transaction,
  ) async {
    if (stages.isEmpty) return;
    for (final (index, draft) in stages.indexed) {
      await _insert(session, projectId, index, draft, transaction);
    }
    await _audit.record(
      session,
      actorId: actorId,
      projectId: projectId,
      action: 'stage.createPlan',
      entityType: 'project',
      entityId: projectId,
      after: {'stageCount': '${stages.length}'},
      transaction: transaction,
    );
    await _activity.record(
      session,
      projectId: projectId,
      actorId: actorId,
      type: ActivityType.stagePlanChanged,
      targetType: 'project',
      targetId: projectId,
      payload: {'stageCount': '${stages.length}'},
      transaction: transaction,
    );
  }

  /// Adds a stage at the end of the plan.
  Future<StageView> create(
    Session session,
    ProjectMember owner,
    StageDraft draft,
  ) {
    return session.db.transaction((transaction) async {
      await _plannableProject(session, owner.projectId, transaction);
      final count = await Stage.db.count(
        session,
        where: (t) => t.projectId.equals(owner.projectId),
        transaction: transaction,
      );
      if (count >= maxStages) {
        throw AppException(code: AppErrorCode.tooManyStages);
      }
      final stage = await _insert(
        session,
        owner.projectId,
        count,
        draft,
        transaction,
      );
      await _record(
        session,
        owner,
        'stage.create',
        stage,
        after: _auditFields(stage),
        transaction: transaction,
      );
      return _view(session, stage, transaction);
    });
  }

  /// Saves the details and the checklist: existing items keep their IDs,
  /// new ones are added, missing ones are deleted (decision M3-5).
  Future<StageView> update(
    Session session,
    ProjectMember owner,
    int stageId,
    StageDraft draft,
  ) {
    return session.db.transaction((transaction) async {
      await _plannableProject(session, owner.projectId, transaction);
      final before = await _stage(
        session,
        owner.projectId,
        stageId,
        transaction,
      );
      if (!_editable.contains(before.status)) {
        throw AppException(code: AppErrorCode.stageLocked);
      }
      final existing = await ChecklistItem.db.find(
        session,
        where: (t) => t.stageId.equals(stageId),
        transaction: transaction,
      );
      final existingIds = {for (final i in existing) i.id!};
      final sentIds = [
        for (final item in draft.items)
          if (item.itemId != null) item.itemId!,
      ];
      if (sentIds.toSet().length != sentIds.length ||
          !existingIds.containsAll(sentIds)) {
        throw AppException(code: AppErrorCode.invalidChecklistItem);
      }
      final removed = existing.where((i) => !sentIds.contains(i.id)).toList();
      if (removed.isNotEmpty) {
        await ChecklistItem.db.delete(
          session,
          removed,
          transaction: transaction,
        );
      }
      final byId = {for (final i in existing) i.id!: i};
      for (final (index, item) in draft.items.indexed) {
        final current = byId[item.itemId];
        if (current == null) {
          await ChecklistItem.db.insertRow(
            session,
            ChecklistItem(
              stageId: stageId,
              orderIndex: index,
              label: item.label,
              isRequired: item.isRequired,
            ),
            transaction: transaction,
          );
        } else {
          await ChecklistItem.db.updateRow(
            session,
            current.copyWith(
              orderIndex: index,
              label: item.label,
              isRequired: item.isRequired,
            ),
            transaction: transaction,
          );
        }
      }
      final after = await Stage.db.updateRow(
        session,
        before.copyWith(
          name: draft.name,
          description: draft.description,
          budgetMinor: draft.budgetMinor,
          plannedStart: draft.plannedStart,
          plannedEnd: draft.plannedEnd,
          updatedAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );
      await _record(
        session,
        owner,
        'stage.update',
        after,
        before: _auditFields(before, itemCount: existing.length),
        after: _auditFields(after, itemCount: draft.items.length),
        transaction: transaction,
      );
      return _view(session, after, transaction);
    });
  }

  /// Deletes a stage that hasn't started (decision M3-6) and closes the gap.
  Future<void> delete(Session session, ProjectMember owner, int stageId) {
    return session.db.transaction((transaction) async {
      await _plannableProject(session, owner.projectId, transaction);
      final stage = await _stage(
        session,
        owner.projectId,
        stageId,
        transaction,
      );
      if (stage.status != StageStatus.notStarted) {
        throw AppException(code: AppErrorCode.stageLocked);
      }
      await Stage.db.deleteRow(session, stage, transaction: transaction);
      final rest = await _stages(session, owner.projectId, transaction);
      await _renumber(session, rest, transaction);
      await _record(
        session,
        owner,
        'stage.delete',
        stage,
        before: _auditFields(stage),
        transaction: transaction,
      );
    });
  }

  /// Puts the stages in the order of [stageIds], which must name every stage
  /// of the project once (decision M3-7). Locked stages can't move.
  Future<StagePlan> reorder(
    Session session,
    ProjectMember owner,
    List<int> stageIds,
  ) {
    return session.db.transaction((transaction) async {
      await _plannableProject(session, owner.projectId, transaction);
      final stages = await _stages(session, owner.projectId, transaction);
      final byId = {for (final s in stages) s.id!: s};
      if (stageIds.length != stages.length ||
          stageIds.toSet().length != stageIds.length ||
          !stageIds.every(byId.containsKey)) {
        throw AppException(code: AppErrorCode.invalidStageOrder);
      }
      final ordered = [for (final id in stageIds) byId[id]!];
      for (final (index, stage) in ordered.indexed) {
        if (stage.orderIndex != index && !_editable.contains(stage.status)) {
          throw AppException(code: AppErrorCode.stageLocked);
        }
      }
      await _renumber(session, ordered, transaction);
      await _audit.record(
        session,
        actorId: owner.authUserId,
        projectId: owner.projectId,
        action: 'stage.reorder',
        entityType: 'project',
        entityId: owner.projectId,
        before: {'order': stages.map((s) => s.id).join(',')},
        after: {'order': stageIds.join(',')},
        transaction: transaction,
      );
      await _activity.record(
        session,
        projectId: owner.projectId,
        actorId: owner.authUserId,
        type: ActivityType.stagePlanChanged,
        targetType: 'project',
        targetId: owner.projectId,
        transaction: transaction,
      );
      return plan(session, owner.projectId, transaction: transaction);
    });
  }

  /// `not_started → in_progress` by the site manager, on an active project
  /// only (STG-06, decision M3-8).
  Future<StageView> start(
    Session session,
    ProjectMember siteManager,
    int stageId,
  ) {
    return session.db.transaction((transaction) async {
      final project = await _lockedProject(
        session,
        siteManager.projectId,
        transaction,
      );
      if (project.status != ProjectStatus.active) {
        throw AppException(code: AppErrorCode.projectNotActive);
      }
      final before = await _stage(
        session,
        siteManager.projectId,
        stageId,
        transaction,
      );
      if (before.status != StageStatus.notStarted) {
        throw AppException(code: AppErrorCode.invalidStageTransition);
      }
      final now = DateTime.now().toUtc();
      final after = await Stage.db.updateRow(
        session,
        before.copyWith(
          status: StageStatus.inProgress,
          startedAt: now,
          updatedAt: now,
        ),
        transaction: transaction,
      );
      await _record(
        session,
        siteManager,
        'stage.start',
        after,
        before: {'status': before.status.name},
        after: {'status': after.status.name},
        type: ActivityType.stageStarted,
        transaction: transaction,
      );
      return _view(session, after, transaction);
    });
  }

  Future<Stage> _insert(
    Session session,
    int projectId,
    int orderIndex,
    StageDraft draft,
    Transaction transaction,
  ) async {
    final now = DateTime.now().toUtc();
    final stage = await Stage.db.insertRow(
      session,
      Stage(
        projectId: projectId,
        orderIndex: orderIndex,
        name: draft.name,
        description: draft.description,
        budgetMinor: draft.budgetMinor,
        plannedStart: draft.plannedStart,
        plannedEnd: draft.plannedEnd,
        status: StageStatus.notStarted,
        createdAt: now,
        updatedAt: now,
      ),
      transaction: transaction,
    );
    if (draft.items.isNotEmpty) {
      await ChecklistItem.db.insert(session, [
        for (final (index, item) in draft.items.indexed)
          ChecklistItem(
            stageId: stage.id!,
            orderIndex: index,
            label: item.label,
            isRequired: item.isRequired,
          ),
      ], transaction: transaction);
    }
    return stage;
  }

  /// Gives [ordered] the indexes 0…n−1, writing only the rows that change.
  Future<void> _renumber(
    Session session,
    List<Stage> ordered,
    Transaction transaction,
  ) async {
    for (final (index, stage) in ordered.indexed) {
      if (stage.orderIndex == index) continue;
      await Stage.db.updateRow(
        session,
        stage.copyWith(orderIndex: index),
        transaction: transaction,
      );
    }
  }

  /// The project, locked for this transaction, if its plan can change.
  Future<Project> _plannableProject(
    Session session,
    int projectId,
    Transaction transaction,
  ) async {
    final project = await _lockedProject(session, projectId, transaction);
    if (_closedProjects.contains(project.status)) {
      throw AppException(code: AppErrorCode.projectNotEditable);
    }
    return project;
  }

  Future<Project> _lockedProject(
    Session session,
    int projectId,
    Transaction transaction,
  ) async => (await Project.db.findById(
    session,
    projectId,
    lockMode: LockMode.forUpdate,
    transaction: transaction,
  ))!;

  /// The stage if it belongs to [projectId], or `stageNotFound`.
  Future<Stage> _stage(
    Session session,
    int projectId,
    int stageId,
    Transaction? transaction,
  ) async {
    final stage = await Stage.db.findFirstRow(
      session,
      where: (t) => t.id.equals(stageId) & t.projectId.equals(projectId),
      transaction: transaction,
    );
    if (stage == null) throw AppException(code: AppErrorCode.stageNotFound);
    return stage;
  }

  Future<List<Stage>> _stages(
    Session session,
    int projectId,
    Transaction? transaction,
  ) => Stage.db.find(
    session,
    where: (t) => t.projectId.equals(projectId),
    orderBy: (t) => t.orderIndex,
    transaction: transaction,
  );

  Future<Map<int, List<ChecklistItem>>> _itemsOf(
    Session session,
    Set<int> stageIds,
    Transaction? transaction,
  ) async {
    if (stageIds.isEmpty) return {};
    final items = await ChecklistItem.db.find(
      session,
      where: (t) => t.stageId.inSet(stageIds),
      orderBy: (t) => t.orderIndex,
      transaction: transaction,
    );
    final byStage = <int, List<ChecklistItem>>{};
    for (final item in items) {
      byStage.putIfAbsent(item.stageId, () => []).add(item);
    }
    return byStage;
  }

  Future<StageView> _view(
    Session session,
    Stage stage,
    Transaction? transaction,
  ) async {
    final items = await _itemsOf(session, {stage.id!}, transaction);
    return StageView(
      stage: stage,
      items: items[stage.id] ?? [],
      itemsCovered: 0,
    );
  }

  /// One audit entry and one activity event per change (AUD-01, FEED).
  Future<void> _record(
    Session session,
    ProjectMember actor,
    String action,
    Stage stage, {
    Map<String, String>? before,
    Map<String, String>? after,
    ActivityType type = ActivityType.stagePlanChanged,
    required Transaction transaction,
  }) async {
    await _audit.record(
      session,
      actorId: actor.authUserId,
      projectId: actor.projectId,
      action: action,
      entityType: 'stage',
      entityId: stage.id,
      before: before,
      after: after,
      transaction: transaction,
    );
    await _activity.record(
      session,
      projectId: actor.projectId,
      actorId: actor.authUserId,
      type: type,
      targetType: 'stage',
      targetId: stage.id,
      payload: {'name': stage.name},
      transaction: transaction,
    );
  }

  static Map<String, String> _auditFields(Stage stage, {int? itemCount}) => {
    'name': stage.name,
    'description': ?stage.description,
    'budgetMinor': '${stage.budgetMinor}',
    'plannedStart': ?stage.plannedStart?.toIso8601String(),
    'plannedEnd': ?stage.plannedEnd?.toIso8601String(),
    'status': stage.status.name,
    'orderIndex': '${stage.orderIndex}',
    if (itemCount != null) 'itemCount': '$itemCount',
  };
}
