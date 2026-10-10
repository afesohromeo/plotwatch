import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'activity_service.dart';
import 'audit_service.dart';
import 'stage_service.dart';

/// Projects: creation, the caller's list, details and status (PROJ-01–05).
/// Callers check permissions first with `PermissionService`.
class ProjectService {
  const ProjectService();

  static const _audit = AuditService();
  static const _activity = ActivityService();
  static const _stages = StageService();

  static const maxNameLength = 100;
  static const maxDescriptionLength = 1000;
  static const maxPageSize = 50;

  /// ISO 4217 codes a project can use (decision M2-13); mirrored in the app.
  static const supportedCurrencies = {
    'XAF', 'XOF', 'NGN', 'GHS', 'KES', 'UGX', 'TZS', 'RWF', 'CDF', 'GNF', //
    'ZAR', 'MAD', 'EGP', 'ETB', 'EUR', 'USD', 'GBP', 'CAD', 'CHF',
  };

  /// Status changes the owner may make (decision M2-4). `draft → active`
  /// happens only when the first site location is validated.
  static const _transitions = <ProjectStatus, Set<ProjectStatus>>{
    ProjectStatus.active: {ProjectStatus.paused, ProjectStatus.completed},
    ProjectStatus.paused: {ProjectStatus.active, ProjectStatus.completed},
    // Reopened after a mistake (doc/04e C-4); archived is final.
    ProjectStatus.completed: {ProjectStatus.archived, ProjectStatus.active},
  };

  /// Returns [details] cleaned up (trimmed name, blank description as none),
  /// or throws [AppException] when a value is invalid.
  static ProjectDetails validateDetails(ProjectDetails details) {
    final name = details.name.trim();
    if (name.isEmpty || name.length > maxNameLength) {
      throw AppException(code: AppErrorCode.invalidProjectName);
    }
    final description = details.description?.trim();
    if (description != null && description.length > maxDescriptionLength) {
      throw AppException(code: AppErrorCode.invalidProjectDescription);
    }
    if (!supportedCurrencies.contains(details.currencyCode)) {
      throw AppException(code: AppErrorCode.invalidCurrencyCode);
    }
    final start = details.plannedStart;
    final end = details.plannedEnd;
    if (start != null && end != null && end.isBefore(start)) {
      throw AppException(code: AppErrorCode.invalidProjectDates);
    }
    return details.copyWith(
      name: name,
      description: (description?.isEmpty ?? true) ? null : description,
    );
  }

  /// Creates the project, its owner membership and its validated [stages]
  /// in one transaction (decisions M2-3, M3-3). The project starts as a
  /// draft without a site.
  Future<ProjectOverview> create(
    Session session,
    UuidValue ownerId,
    ProjectDetails details, {
    List<StageDraft> stages = const [],
  }) {
    return session.db.transaction((transaction) async {
      final now = DateTime.now().toUtc();
      final project = await Project.db.insertRow(
        session,
        Project(
          name: details.name,
          description: details.description,
          type: details.type,
          status: ProjectStatus.draft,
          currencyCode: details.currencyCode,
          plannedStart: details.plannedStart,
          plannedEnd: details.plannedEnd,
          createdAt: now,
          updatedAt: now,
        ),
        transaction: transaction,
      );
      final owner = await ProjectMember.db.insertRow(
        session,
        ProjectMember(
          projectId: project.id!,
          authUserId: ownerId,
          role: ProjectRole.owner,
          status: MemberStatus.active,
          joinedAt: now,
        ),
        transaction: transaction,
      );
      await _audit.record(
        session,
        actorId: ownerId,
        projectId: project.id,
        action: 'project.create',
        entityType: 'project',
        entityId: project.id,
        after: _auditFields(project),
        transaction: transaction,
      );
      await _activity.record(
        session,
        projectId: project.id!,
        actorId: ownerId,
        type: ActivityType.projectCreated,
        targetType: 'project',
        targetId: project.id,
        payload: {'name': project.name},
        transaction: transaction,
      );
      await _stages.insertPlan(
        session,
        project.id!,
        ownerId,
        stages,
        transaction,
      );
      return _overview(session, project, owner, transaction: transaction);
    });
  }

  /// The projects [userId] is an active member of, most recently updated
  /// first.
  Future<ProjectSummaryPage> list(
    Session session,
    UuidValue userId, {
    required int page,
    required int pageSize,
    ProjectStatus? status,
    String? search,
    ProjectSort sort = ProjectSort.recent,
  }) async {
    final safePage = page < 0 ? 0 : page;
    final safeSize = pageSize.clamp(1, maxPageSize);
    final memberships = await ProjectMember.db.find(
      session,
      where: (t) =>
          t.authUserId.equals(userId) & t.status.equals(MemberStatus.active),
    );
    final roles = {for (final m in memberships) m.projectId: m.role};
    final canApprove = {
      for (final m in memberships) m.projectId: m.canApprove,
    };
    final term = search?.trim() ?? '';
    final List<Project> projects;
    final Map<int, List<Stage>> stages;
    if (roles.isEmpty) {
      projects = [];
      stages = {};
    } else if (sort == ProjectSort.name) {
      projects = await Project.db.find(
        session,
        where: (t) => _listFilter(t, roles.keys.toSet(), status, term),
        orderByList: (t) => [t.name.asc(), t.id.desc()],
        limit: safeSize,
        offset: safePage * safeSize,
      );
      stages = await _stages.stagesByProject(session, {
        for (final p in projects) p.id!,
      });
    } else {
      // Ordered here, not in SQL: a user is in tens of projects, not
      // thousands, and progress is computed from the stages.
      final all = await Project.db.find(
        session,
        where: (t) => _listFilter(t, roles.keys.toSet(), status, term),
      );
      final ids = {for (final p in all) p.id!};
      final allStages = sort == ProjectSort.progress
          ? await _stages.stagesByProject(session, ids)
          : <int, List<Stage>>{};
      final key = sort == ProjectSort.progress
          ? {
              for (final id in ids)
                id: StageService.progressPercent(allStages[id] ?? []),
            }
          : await _latestActivity(session, ids);
      // Highest first; the newest project breaks a tie.
      all.sort((a, b) {
        final byKey = (key[b.id] ?? 0).compareTo(key[a.id] ?? 0);
        return byKey != 0 ? byKey : b.id!.compareTo(a.id!);
      });
      projects = all.skip(safePage * safeSize).take(safeSize).toList();
      stages = sort == ProjectSort.progress
          ? allStages
          : await _stages.stagesByProject(session, {
              for (final p in projects) p.id!,
            });
    }
    final projectIds = {for (final p in projects) p.id!};
    // Each project's latest finalized photo, the card's cover (doc/05 §9).
    final photos = projectIds.isEmpty
        ? <Evidence>[]
        : await Evidence.db.find(
            session,
            where: (t) =>
                t.projectId.inSet(projectIds) &
                t.status.equals(EvidenceStatus.finalized),
            orderBy: (t) => t.id.desc(),
          );
    final latestPhoto = <int, Evidence>{};
    for (final photo in photos) {
      latestPhoto.putIfAbsent(photo.projectId, () => photo);
    }
    return ProjectSummaryPage(
      items: [
        for (final project in projects)
          ProjectSummary(
            project: project,
            myRole: roles[project.id]!,
            progressPercent: StageService.progressPercent(
              stages[project.id] ?? [],
            ),
            myCanApprove: canApprove[project.id] ?? false,
            budgetTotalMinor: StageService.budgetTotal(
              stages[project.id] ?? [],
            ),
            stages: StageService.briefs(stages[project.id] ?? []),
            latestEvidenceId: latestPhoto[project.id]?.id,
            latestEvidenceLevel: latestPhoto[project.id]?.verificationLevel,
          ),
      ],
      page: safePage,
      pageSize: safeSize,
    );
  }

  /// The caller's projects, narrowed to [status] and to names containing
  /// [term], whatever their case (doc/05 §9.4).
  static Expression _listFilter(
    ProjectTable t,
    Set<int> ids,
    ProjectStatus? status,
    String term,
  ) {
    var where = t.id.inSet(ids);
    if (status != null) where &= t.status.equals(status);
    if (term.isNotEmpty) where &= t.name.ilike('%${escapeLike(term)}%');
    return where;
  }

  /// [term] with the LIKE wildcards taken literally: "50%" finds "50%".
  static String escapeLike(String term) =>
      term.replaceAllMapped(RegExp(r'[\\%_]'), (m) => '\\${m[0]}');

  /// Each project's newest activity event ID, for the "recent" order: one
  /// indexed lookup per project (activity_event_project_idx).
  Future<Map<int, int>> _latestActivity(Session session, Set<int> ids) async {
    final latest = await Future.wait([
      for (final id in ids)
        ActivityEvent.db.findFirstRow(
          session,
          where: (t) => t.projectId.equals(id),
          orderBy: (t) => t.id.desc(),
        ),
    ]);
    return {
      for (final event in latest)
        if (event != null) event.projectId: event.id!,
    };
  }

  Future<ProjectOverview> get(Session session, ProjectMember member) async {
    final project = await Project.db.findById(session, member.projectId);
    return _overview(session, project!, member);
  }

  /// Saves validated [details]; audited with before and after values.
  Future<ProjectOverview> update(
    Session session,
    ProjectMember member,
    ProjectDetails details,
  ) {
    return session.db.transaction((transaction) async {
      final before = (await Project.db.findById(
        session,
        member.projectId,
        transaction: transaction,
      ))!;
      final after = await Project.db.updateRow(
        session,
        before.copyWith(
          name: details.name,
          description: details.description,
          type: details.type,
          currencyCode: details.currencyCode,
          plannedStart: details.plannedStart,
          plannedEnd: details.plannedEnd,
          updatedAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );
      await _recordChange(
        session,
        member,
        before,
        after,
        action: 'project.update',
        type: ActivityType.projectUpdated,
        payload: {'name': after.name},
        transaction: transaction,
      );
      return _overview(session, after, member, transaction: transaction);
    });
  }

  /// Changes the status along the allowed transitions (decision M2-4).
  Future<ProjectOverview> setStatus(
    Session session,
    ProjectMember member,
    ProjectStatus status,
  ) {
    return session.db.transaction((transaction) async {
      final before = (await Project.db.findById(
        session,
        member.projectId,
        transaction: transaction,
      ))!;
      if (!(_transitions[before.status]?.contains(status) ?? false)) {
        throw AppException(code: AppErrorCode.invalidStatusTransition);
      }
      final after = await Project.db.updateRow(
        session,
        before.copyWith(status: status, updatedAt: DateTime.now().toUtc()),
        transaction: transaction,
      );
      await _recordChange(
        session,
        member,
        before,
        after,
        action: 'project.setStatus',
        type: ActivityType.projectStatusChanged,
        payload: {'status': status.name},
        transaction: transaction,
      );
      return _overview(session, after, member, transaction: transaction);
    });
  }

  Future<void> _recordChange(
    Session session,
    ProjectMember member,
    Project before,
    Project after, {
    required String action,
    required ActivityType type,
    required Map<String, String> payload,
    required Transaction transaction,
  }) async {
    await _audit.record(
      session,
      actorId: member.authUserId,
      projectId: after.id,
      action: action,
      entityType: 'project',
      entityId: after.id,
      before: _auditFields(before),
      after: _auditFields(after),
      transaction: transaction,
    );
    await _activity.record(
      session,
      projectId: after.id!,
      actorId: member.authUserId,
      type: type,
      targetType: 'project',
      targetId: after.id,
      payload: payload,
      transaction: transaction,
    );
  }

  Future<ProjectOverview> _overview(
    Session session,
    Project project,
    ProjectMember member, {
    Transaction? transaction,
  }) async {
    final site = await Site.db.findFirstRow(
      session,
      where: (t) => t.projectId.equals(project.id),
      transaction: transaction,
    );
    // A new proposal supersedes the pending one, so there is at most one.
    final pendingProposal = await SiteProposal.db.findFirstRow(
      session,
      where: (t) =>
          t.projectId.equals(project.id) &
          t.status.equals(SiteProposalStatus.pending),
      transaction: transaction,
    );
    final stages = await Stage.db.find(
      session,
      where: (t) => t.projectId.equals(project.id),
      transaction: transaction,
    );
    return ProjectOverview(
      project: project,
      site: site,
      myRole: member.role,
      myCanApprove: member.canApprove,
      pendingSiteProposal: pendingProposal,
      stageCount: stages.length,
      budgetTotalMinor: StageService.budgetTotal(stages),
      progressPercent: StageService.progressPercent(stages),
      approvedStageCount: stages
          .where((s) => s.status == StageStatus.approved)
          .length,
      stages: StageService.briefs(stages),
    );
  }

  static Map<String, String> _auditFields(Project project) => {
    'name': project.name,
    if (project.description != null) 'description': project.description!,
    'type': project.type.name,
    'status': project.status.name,
    'currencyCode': project.currencyCode,
    if (project.plannedStart != null)
      'plannedStart': project.plannedStart!.toIso8601String(),
    if (project.plannedEnd != null)
      'plannedEnd': project.plannedEnd!.toIso8601String(),
  };
}
