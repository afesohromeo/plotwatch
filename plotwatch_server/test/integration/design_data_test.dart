import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Plan: doc/05-design-system.md §9, group DP-C: the stages in short, the
// latest photo and the right to approve, for the redrawn screens.
void main() {
  final ownerId = UuidValue.fromString('00000000-0000-4000-8000-000000000001');
  final approverId = UuidValue.fromString(
    '00000000-0000-4000-8000-000000000003',
  );

  withServerpod('Given a project with two stages and a photo', (
    sessionBuilder,
    endpoints,
  ) {
    late int projectId;
    late List<StageView> views;
    late int photoId;

    TestSessionBuilder signedInAs(UuidValue userId) => sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        userId.uuid,
        {},
      ),
    );

    setUp(() async {
      projectId = (await endpoints.project.create(
        signedInAs(ownerId),
        ProjectDetails(
          name: 'House in Bafoussam',
          type: ProjectType.newHouse,
          currencyCode: 'XAF',
        ),
        stages: [
          StageDraft(
            name: 'Foundation',
            budgetMinor: 0,
            items: [ChecklistItemDraft(label: 'Trenches', isRequired: true)],
          ),
          StageDraft(
            name: 'Walls',
            budgetMinor: 0,
            items: [ChecklistItemDraft(label: 'Wide shot', isRequired: true)],
          ),
        ],
      )).project.id!;
      final session = sessionBuilder.build();
      final now = DateTime.now().toUtc();
      await ProjectMember.db.insertRow(
        session,
        ProjectMember(
          projectId: projectId,
          authUserId: approverId,
          role: ProjectRole.coFunder,
          canApprove: true,
          status: MemberStatus.active,
          joinedAt: now,
        ),
      );
      views = (await endpoints.stage.plan(
        signedInAs(ownerId),
        projectId,
      )).stages;
      await Stage.db.updateRow(
        session,
        views.first.stage.copyWith(status: StageStatus.approved),
      );
      Evidence photo(EvidenceStatus status) => Evidence(
        projectId: projectId,
        stageId: views.last.stage.id!,
        checklistItemId: views.last.items.single.id!,
        capturedBy: ownerId,
        status: status,
        sha256: 'a' * 64,
        photoPath: 'p',
        deviceCapturedAt: now,
        serverCommittedAt: now,
        finalizedAt: now,
        capturedInApp: true,
        deviceModel: 'Pixel 7',
        osVersion: 'Android 15',
        appVersion: '1.0.0',
        verificationLevel: VerificationLevel.verified,
      );
      photoId = (await Evidence.db.insertRow(
        session,
        photo(EvidenceStatus.finalized),
      )).id!;
      // A later capture that was withdrawn is not the cover.
      await Evidence.db.insertRow(session, photo(EvidenceStatus.retracted));
    });

    test('then the project list gives each card its stages in order, its '
        'latest photo and whether the caller may approve', () async {
      final owner = (await endpoints.project.list(
        signedInAs(ownerId),
      )).items.single;
      final approver = (await endpoints.project.list(
        signedInAs(approverId),
      )).items.single;

      expect(owner.stages?.map((s) => (s.name, s.status)), [
        ('Foundation', StageStatus.approved),
        ('Walls', StageStatus.notStarted),
      ]);
      expect(owner.latestEvidenceId, photoId);
      expect(owner.latestEvidenceLevel, VerificationLevel.verified);
      expect(owner.budgetTotalMinor, 0);
      expect(owner.myCanApprove, isFalse);
      expect(approver.myCanApprove, isTrue);
    });

    test('then the project page gives its stages in order', () async {
      final overview = await endpoints.project.get(
        signedInAs(ownerId),
        projectId,
      );

      expect(overview.stages?.map((s) => s.name), ['Foundation', 'Walls']);
      expect(overview.stages?.first.id, views.first.stage.id);
    });

    test('then the plan gives each stage its latest photo', () async {
      final plan = await endpoints.stage.plan(signedInAs(ownerId), projectId);

      expect(plan.stages.first.latestEvidenceId, isNull);
      expect(plan.stages.last.latestEvidenceId, photoId);
    });
  });
}
