import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Plan: doc/04c-m3-stages.md, group A (decisions M3-3 to M3-11): the owner
// plans the stages, everybody sees the plan, the site manager starts a stage.
void main() {
  final ownerId = UuidValue.fromString('00000000-0000-4000-8000-000000000001');
  final managerId = UuidValue.fromString(
    '00000000-0000-4000-8000-000000000002',
  );
  final coFunderId = UuidValue.fromString(
    '00000000-0000-4000-8000-000000000003',
  );
  final viewerId = UuidValue.fromString('00000000-0000-4000-8000-000000000004');
  final strangerId = UuidValue.fromString(
    '00000000-0000-4000-8000-000000000005',
  );

  final details = ProjectDetails(
    name: 'House in Bafoussam',
    type: ProjectType.newHouse,
    currencyCode: 'XAF',
  );

  StageDraft draft(
    String name, {
    int budgetMinor = 0,
    String? description,
    DateTime? plannedStart,
    DateTime? plannedEnd,
    List<ChecklistItemDraft>? items,
  }) => StageDraft(
    name: name,
    description: description,
    budgetMinor: budgetMinor,
    plannedStart: plannedStart,
    plannedEnd: plannedEnd,
    items:
        items ??
        [
          ChecklistItemDraft(label: 'Wide shot', isRequired: true),
          ChecklistItemDraft(label: 'Detail', isRequired: false),
        ],
  );

  withServerpod('Given a project with its members', (
    sessionBuilder,
    endpoints,
  ) {
    late int projectId;

    TestSessionBuilder signedInAs(UuidValue userId) => sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        userId.uuid,
        {},
      ),
    );

    final asOwner = signedInAs(ownerId);

    Future<StageView> addStage(String name, {int budgetMinor = 0}) =>
        endpoints.stage.create(
          asOwner,
          projectId,
          draft(name, budgetMinor: budgetMinor),
        );

    Future<void> setProjectStatus(ProjectStatus status) async {
      final session = sessionBuilder.build();
      final project = (await Project.db.findById(session, projectId))!;
      await Project.db.updateRow(session, project.copyWith(status: status));
    }

    Future<void> setStageStatus(int stageId, StageStatus status) async {
      final session = sessionBuilder.build();
      final stage = (await Stage.db.findById(session, stageId))!;
      await Stage.db.updateRow(session, stage.copyWith(status: status));
    }

    Future<List<AuditLog>> audits(String action) => AuditLog.db.find(
      sessionBuilder.build(),
      where: (t) => t.action.equals(action),
    );

    Future<List<ActivityEvent>> events(ActivityType type) =>
        ActivityEvent.db.find(
          sessionBuilder.build(),
          where: (t) => t.type.equals(type),
        );

    setUp(() async {
      projectId = (await endpoints.project.create(
        asOwner,
        details,
      )).project.id!;
      final now = DateTime.now().toUtc();
      await ProjectMember.db.insert(sessionBuilder.build(), [
        for (final (userId, role) in [
          (managerId, ProjectRole.siteManager),
          (coFunderId, ProjectRole.coFunder),
          (viewerId, ProjectRole.viewer),
        ])
          ProjectMember(
            projectId: projectId,
            authUserId: userId,
            role: role,
            canApprove: role == ProjectRole.coFunder,
            status: MemberStatus.active,
            joinedAt: now,
          ),
      ]);
    });

    group('when the owner adds a stage', () {
      test('then it is saved with its checklist, in order', () async {
        final first = await addStage('Foundation', budgetMinor: 1500000);
        final second = await addStage('Walls');

        expect(first.stage.orderIndex, 0);
        expect(second.stage.orderIndex, 1);
        expect(first.stage.status, StageStatus.notStarted);
        expect(first.stage.budgetMinor, 1500000);
        expect(first.items.map((i) => (i.label, i.isRequired, i.orderIndex)), [
          ('Wide shot', true, 0),
          ('Detail', false, 1),
        ]);
        expect(first.itemsCovered, 0);
      });

      test('then the change is audited and announced', () async {
        await addStage('Foundation');

        expect(await audits('stage.create'), hasLength(1));
        expect(await events(ActivityType.stagePlanChanged), hasLength(1));
      });

      test('with spaces around the name and a blank description then they '
          'are cleaned up', () async {
        final view = await endpoints.stage.create(
          asOwner,
          projectId,
          draft('  Roofing  ', description: '   '),
        );

        expect(view.stage.name, 'Roofing');
        expect(view.stage.description, isNull);
      });

      final invalid = <String, (StageDraft, AppErrorCode)>{
        'an empty name': (draft('  '), AppErrorCode.invalidStageName),
        'a 101-character name': (
          draft('x' * 101),
          AppErrorCode.invalidStageName,
        ),
        'a 1,001-character description': (
          draft('Walls', description: 'x' * 1001),
          AppErrorCode.invalidStageDescription,
        ),
        'a negative budget': (
          draft('Walls', budgetMinor: -1),
          AppErrorCode.invalidBudget,
        ),
        'a budget above 10^15': (
          draft('Walls', budgetMinor: 1000000000000001),
          AppErrorCode.invalidBudget,
        ),
        'an end before the start': (
          draft(
            'Walls',
            plannedStart: DateTime.utc(2026, 11, 2),
            plannedEnd: DateTime.utc(2026, 11, 1),
          ),
          AppErrorCode.invalidStageDates,
        ),
        'an empty checklist label': (
          draft(
            'Walls',
            items: [ChecklistItemDraft(label: ' ', isRequired: true)],
          ),
          AppErrorCode.invalidChecklistItem,
        ),
        'a 201-character checklist label': (
          draft(
            'Walls',
            items: [ChecklistItemDraft(label: 'x' * 201, isRequired: true)],
          ),
          AppErrorCode.invalidChecklistItem,
        ),
        '31 checklist items': (
          draft(
            'Walls',
            items: [
              for (var i = 0; i < 31; i++)
                ChecklistItemDraft(label: 'Item $i', isRequired: true),
            ],
          ),
          AppErrorCode.tooManyChecklistItems,
        ),
      };
      for (final MapEntry(key: what, value: (stageDraft, code))
          in invalid.entries) {
        test('with $what then it throws ${code.name}', () async {
          await expectLater(
            endpoints.stage.create(asOwner, projectId, stageDraft),
            throwsA(_appException(code)),
          );
        });
      }

      test('beyond 50 stages then it throws tooManyStages', () async {
        await endpoints.stage.createPlan(asOwner, projectId, [
          for (var i = 0; i < 50; i++) draft('Stage $i', items: []),
        ]);

        await expectLater(
          addStage('One more'),
          throwsA(_appException(AppErrorCode.tooManyStages)),
        );
      });

      test(
        'on a completed project then it throws projectNotEditable',
        () async {
          await setProjectStatus(ProjectStatus.completed);

          await expectLater(
            addStage('Late'),
            throwsA(_appException(AppErrorCode.projectNotEditable)),
          );
        },
      );
    });

    for (final (name, userId) in [
      ('the site manager', managerId),
      ('a co-funder', coFunderId),
      ('a viewer', viewerId),
    ]) {
      test('when $name adds, edits, reorders or deletes a stage then it '
          'throws permissionDenied', () async {
        final stage = (await addStage('Foundation')).stage;
        final caller = signedInAs(userId);
        final denied = throwsA(_appException(AppErrorCode.permissionDenied));

        await expectLater(
          endpoints.stage.create(caller, projectId, draft('Walls')),
          denied,
        );
        await expectLater(
          endpoints.stage.update(caller, projectId, stage.id!, draft('X')),
          denied,
        );
        await expectLater(
          endpoints.stage.reorder(caller, projectId, [stage.id!]),
          denied,
        );
        await expectLater(
          endpoints.stage.delete(caller, projectId, stage.id!),
          denied,
        );
        await expectLater(
          endpoints.stage.createPlan(caller, projectId, [draft('Walls')]),
          denied,
        );
      });
    }

    group('when a member reads the plan', () {
      test('then every member sees the stages in order, the total budget '
          'and the progress', () async {
        await addStage('Foundation', budgetMinor: 300);
        await addStage('Walls', budgetMinor: 700);

        for (final userId in [ownerId, managerId, coFunderId, viewerId]) {
          final plan = await endpoints.stage.plan(
            signedInAs(userId),
            projectId,
          );
          expect(plan.stages.map((v) => v.stage.name), ['Foundation', 'Walls']);
          expect(plan.budgetTotalMinor, 1000);
          expect(plan.progressPercent, 0);
        }
      });

      test('and the project overview and list carry the totals', () async {
        final stage = await addStage('Foundation', budgetMinor: 400);
        await addStage('Walls', budgetMinor: 600);
        await setStageStatus(stage.stage.id!, StageStatus.approved);

        final overview = await endpoints.project.get(asOwner, projectId);
        final list = await endpoints.project.list(asOwner);

        expect(overview.stageCount, 2);
        expect(overview.budgetTotalMinor, 1000);
        expect(overview.progressPercent, 40);
        expect(list.items.single.progressPercent, 40);
      });

      test('then one stage comes with its checklist', () async {
        final created = await addStage('Foundation');

        final view = await endpoints.stage.get(
          signedInAs(viewerId),
          projectId,
          created.stage.id!,
        );

        expect(view.stage.name, 'Foundation');
        expect(view.items, hasLength(2));
      });

      test('as a non-member then it throws projectNotFound', () async {
        await expectLater(
          endpoints.stage.plan(signedInAs(strangerId), projectId),
          throwsA(_appException(AppErrorCode.projectNotFound)),
        );
      });

      test(
        'of another project\'s stage then it throws stageNotFound',
        () async {
          final otherProject = (await endpoints.project.create(
            asOwner,
            details,
          )).project.id!;
          final foreign = await endpoints.stage.create(
            asOwner,
            otherProject,
            draft('Elsewhere'),
          );

          await expectLater(
            endpoints.stage.get(asOwner, projectId, foreign.stage.id!),
            throwsA(_appException(AppErrorCode.stageNotFound)),
          );
        },
      );
    });

    group('when the owner edits a stage', () {
      late StageView created;

      setUp(() async => created = await addStage('Foundation'));

      test('then the details change and existing checklist items keep their '
          'IDs, new ones are added and missing ones removed', () async {
        final kept = created.items.first;
        final updated = await endpoints.stage.update(
          asOwner,
          projectId,
          created.stage.id!,
          draft(
            'Foundation and footing',
            budgetMinor: 2000000,
            items: [
              ChecklistItemDraft(
                itemId: kept.id,
                label: 'Wide shot, all corners',
                isRequired: true,
              ),
              ChecklistItemDraft(label: 'Measuring tape', isRequired: true),
            ],
          ),
        );

        expect(updated.stage.name, 'Foundation and footing');
        expect(updated.stage.budgetMinor, 2000000);
        expect(updated.items.map((i) => i.label), [
          'Wide shot, all corners',
          'Measuring tape',
        ]);
        expect(updated.items.first.id, kept.id);
        expect(
          await ChecklistItem.db.findById(
            sessionBuilder.build(),
            created.items.last.id!,
          ),
          isNull,
        );
        final audit = (await audits('stage.update')).single;
        expect(audit.before?['budgetMinor'], '0');
        expect(audit.after?['budgetMinor'], '2000000');
      });

      test('in progress then it is allowed', () async {
        await setStageStatus(created.stage.id!, StageStatus.inProgress);

        final updated = await endpoints.stage.update(
          asOwner,
          projectId,
          created.stage.id!,
          draft('Foundation', budgetMinor: 10),
        );

        expect(updated.stage.budgetMinor, 10);
      });

      test('once submitted then it throws stageLocked', () async {
        await setStageStatus(created.stage.id!, StageStatus.submitted);

        await expectLater(
          endpoints.stage.update(
            asOwner,
            projectId,
            created.stage.id!,
            draft('Foundation'),
          ),
          throwsA(_appException(AppErrorCode.stageLocked)),
        );
      });

      test('with an item ID from another stage then it throws '
          'invalidChecklistItem', () async {
        final other = await addStage('Walls');

        await expectLater(
          endpoints.stage.update(
            asOwner,
            projectId,
            created.stage.id!,
            draft(
              'Foundation',
              items: [
                ChecklistItemDraft(
                  itemId: other.items.first.id,
                  label: 'Stolen',
                  isRequired: true,
                ),
              ],
            ),
          ),
          throwsA(_appException(AppErrorCode.invalidChecklistItem)),
        );
      });
    });

    group('when the owner reorders the stages', () {
      late List<int> ids;

      setUp(() async {
        ids = [
          for (final name in ['A', 'B', 'C']) (await addStage(name)).stage.id!,
        ];
      });

      test('then the indexes follow the new order without gaps', () async {
        final plan = await endpoints.stage.reorder(asOwner, projectId, [
          ids[2],
          ids[0],
          ids[1],
        ]);

        expect(plan.stages.map((v) => (v.stage.name, v.stage.orderIndex)), [
          ('C', 0),
          ('A', 1),
          ('B', 2),
        ]);
        expect(await audits('stage.reorder'), hasLength(1));
      });

      for (final (what, order) in [
        ('a missing stage', (List<int> ids) => [ids[0], ids[1]]),
        ('a repeated stage', (List<int> ids) => [ids[0], ids[0], ids[1]]),
        ('an unknown stage', (List<int> ids) => [...ids, 999999]),
      ]) {
        test('with $what then it throws invalidStageOrder', () async {
          await expectLater(
            endpoints.stage.reorder(asOwner, projectId, order(ids)),
            throwsA(_appException(AppErrorCode.invalidStageOrder)),
          );
        });
      }

      test('moving a submitted stage then it throws stageLocked', () async {
        await setStageStatus(ids[0], StageStatus.submitted);

        await expectLater(
          endpoints.stage.reorder(asOwner, projectId, [ids[1], ids[0], ids[2]]),
          throwsA(_appException(AppErrorCode.stageLocked)),
        );
      });
    });

    group('when the owner deletes a stage', () {
      test('then it is gone and the others close the gap', () async {
        final a = await addStage('A');
        final b = await addStage('B');
        await addStage('C');

        await endpoints.stage.delete(asOwner, projectId, b.stage.id!);
        final plan = await endpoints.stage.plan(asOwner, projectId);

        expect(plan.stages.map((v) => (v.stage.name, v.stage.orderIndex)), [
          ('A', 0),
          ('C', 1),
        ]);
        expect(
          await ChecklistItem.db.find(
            sessionBuilder.build(),
            where: (t) => t.stageId.equals(b.stage.id),
          ),
          isEmpty,
        );
        expect(a.stage.orderIndex, 0);
        expect(await audits('stage.delete'), hasLength(1));
      });

      test('that is in progress then it throws stageLocked', () async {
        final stage = await addStage('A');
        await setStageStatus(stage.stage.id!, StageStatus.inProgress);

        await expectLater(
          endpoints.stage.delete(asOwner, projectId, stage.stage.id!),
          throwsA(_appException(AppErrorCode.stageLocked)),
        );
      });
    });

    group('when the site manager starts a stage', () {
      late int stageId;

      setUp(() async => stageId = (await addStage('Foundation')).stage.id!);

      test('on an active project then it is in progress, audited and '
          'announced', () async {
        await setProjectStatus(ProjectStatus.active);

        final started = await endpoints.stage.start(
          signedInAs(managerId),
          projectId,
          stageId,
        );

        expect(started.stage.status, StageStatus.inProgress);
        expect(started.stage.startedAt, isNotNull);
        expect(await audits('stage.start'), hasLength(1));
        expect(await events(ActivityType.stageStarted), hasLength(1));
      });

      test('on a draft project then it throws projectNotActive', () async {
        await expectLater(
          endpoints.stage.start(signedInAs(managerId), projectId, stageId),
          throwsA(_appException(AppErrorCode.projectNotActive)),
        );
      });

      test('a second time then it throws invalidStageTransition', () async {
        await setProjectStatus(ProjectStatus.active);
        await endpoints.stage.start(signedInAs(managerId), projectId, stageId);

        await expectLater(
          endpoints.stage.start(signedInAs(managerId), projectId, stageId),
          throwsA(_appException(AppErrorCode.invalidStageTransition)),
        );
      });

      test('as the owner then it throws permissionDenied', () async {
        await setProjectStatus(ProjectStatus.active);

        await expectLater(
          endpoints.stage.start(asOwner, projectId, stageId),
          throwsA(_appException(AppErrorCode.permissionDenied)),
        );
      });
    });

    group('when the owner starts an empty project from a template', () {
      test('then every stage and item is created in order', () async {
        final plan = await endpoints.stage.createPlan(asOwner, projectId, [
          draft('Site preparation'),
          draft('Foundation'),
        ]);

        expect(plan.stages.map((v) => (v.stage.name, v.stage.orderIndex)), [
          ('Site preparation', 0),
          ('Foundation', 1),
        ]);
        expect(plan.stages.first.items, hasLength(2));
        expect(await audits('stage.createPlan'), hasLength(1));
      });

      test(
        'that already has stages then it throws stagePlanNotEmpty',
        () async {
          await addStage('Foundation');

          await expectLater(
            endpoints.stage.createPlan(asOwner, projectId, [draft('Walls')]),
            throwsA(_appException(AppErrorCode.stagePlanNotEmpty)),
          );
        },
      );
    });
  });

  // AC-1: the wizard creates the project and its stage plan in one request.
  withServerpod('Given the create project wizard', (sessionBuilder, endpoints) {
    final asOwner = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        ownerId.uuid,
        {},
      ),
    );

    test('when a template\'s stages are sent then the project comes with '
        'them', () async {
      final overview = await endpoints.project.create(
        asOwner,
        details,
        stages: [draft('Site preparation'), draft('Foundation')],
      );
      final plan = await endpoints.stage.plan(asOwner, overview.project.id!);

      expect(overview.project.status, ProjectStatus.draft);
      expect(overview.stageCount, 2);
      expect(plan.stages.map((v) => v.stage.name), [
        'Site preparation',
        'Foundation',
      ]);
    });

    test('when one stage is invalid then nothing is created', () async {
      await expectLater(
        endpoints.project.create(
          asOwner,
          details,
          stages: [draft('Site preparation'), draft('')],
        ),
        throwsA(_appException(AppErrorCode.invalidStageName)),
      );

      final session = sessionBuilder.build();
      expect(await Project.db.count(session), 0);
      expect(await ProjectMember.db.count(session), 0);
    });
  });
}

Matcher _appException(AppErrorCode code) =>
    isA<AppException>().having((e) => e.code, 'code', code);
