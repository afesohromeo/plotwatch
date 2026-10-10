import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Plan: doc/04e-m5-review-realtime.md, fix C: a completed or archived
// project is read-only (C-1, C-2, C-4), and a removed member's actions stay
// in the project's history, with their name (C-2a to C-2d).
void main() {
  // withServerpod doesn't run lib/server.dart: the auth services (names)
  // are set here, as in stage_review_test.
  setUp(() {
    AuthServices.set(
      tokenManagerBuilders: [
        ServerSideSessionsConfig(sessionKeyHashPepper: 'test-pepper'),
      ],
    );
  });

  withServerpod('Given an active project with its members', (
    sessionBuilder,
    endpoints,
  ) {
    late UuidValue ownerId;
    late UuidValue managerId;
    late UuidValue approverId;
    late UuidValue outsiderId;
    late int projectId;
    late int stageId;
    late int managerMemberId;

    TestSessionBuilder signedInAs(UuidValue userId) => sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        userId.uuid,
        {},
      ),
    );

    Future<UuidValue> createUser(String fullName) async {
      final session = sessionBuilder.build();
      final user = await AuthServices.instance.authUsers.create(session);
      await AuthServices.instance.userProfiles.createUserProfile(
        session,
        user.id,
        UserProfileData(
          fullName: fullName,
          email: '${fullName.split(' ').first.toLowerCase()}@example.com',
        ),
      );
      return user.id;
    }

    Future<void> setStatus(ProjectStatus status) async {
      final session = sessionBuilder.build();
      final project = (await Project.db.findById(session, projectId))!;
      await Project.db.updateRow(session, project.copyWith(status: status));
    }

    setUp(() async {
      ownerId = await createUser('Ada Lovelace');
      managerId = await createUser('Bob Mbarga');
      approverId = await createUser('Chloe Ndi');
      outsiderId = await createUser('Dan Fotso');
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
            budgetMinor: 1000,
            items: [ChecklistItemDraft(label: 'Trenches', isRequired: true)],
          ),
        ],
      )).project.id!;
      final session = sessionBuilder.build();
      final now = DateTime.now().toUtc();
      final members = await ProjectMember.db.insert(session, [
        ProjectMember(
          projectId: projectId,
          authUserId: managerId,
          role: ProjectRole.siteManager,
          status: MemberStatus.active,
          joinedAt: now,
        ),
        ProjectMember(
          projectId: projectId,
          authUserId: approverId,
          role: ProjectRole.coFunder,
          canApprove: true,
          status: MemberStatus.active,
          joinedAt: now,
        ),
      ]);
      managerMemberId = members.first.id!;
      stageId = (await endpoints.stage.plan(
        signedInAs(ownerId),
        projectId,
      )).stages.single.stage.id!;
      await setStatus(ProjectStatus.active);
    });

    group('when it is completed (C-1)', () {
      late Invitation pending;

      setUp(() async {
        pending = await endpoints.membership.createInvitation(
          signedInAs(ownerId),
          projectId,
          ProjectRole.viewer,
        );
        await setStatus(ProjectStatus.completed);
      });

      final refused = <String, Future<Object?> Function()>{};
      setUp(() {
        refused
          ..clear()
          ..addAll({
            'the owner edits the details': () => endpoints.project.update(
              signedInAs(ownerId),
              projectId,
              ProjectDetails(
                name: 'Renamed',
                type: ProjectType.newHouse,
                currencyCode: 'XAF',
              ),
            ),
            'the site manager proposes a location': () =>
                endpoints.site.propose(
                  signedInAs(managerId),
                  projectId,
                  lat: 5.4778,
                  lng: 10.4176,
                  accuracyM: 8,
                  isMocked: false,
                ),
            'the owner validates a proposal': () => endpoints.site.validate(
              signedInAs(ownerId),
              projectId,
              1,
              radiusM: 50,
            ),
            'the owner rejects a proposal': () => endpoints.site.reject(
              signedInAs(ownerId),
              projectId,
              1,
            ),
            'the owner edits the site': () => endpoints.site.update(
              signedInAs(ownerId),
              projectId,
              radiusM: 60,
            ),
            'the owner invites someone': () =>
                endpoints.membership.createInvitation(
                  signedInAs(ownerId),
                  projectId,
                  ProjectRole.viewer,
                ),
            'the owner changes a role': () => endpoints.membership.changeRole(
              signedInAs(ownerId),
              projectId,
              managerMemberId,
              ProjectRole.viewer,
            ),
            'someone accepts an earlier invitation': () => endpoints.membership
                .acceptInvitation(signedInAs(outsiderId), pending.code),
            'the site manager posts an update': () =>
                endpoints.progressUpdate.create(
                  signedInAs(managerId),
                  projectId,
                  ProgressUpdateDraft(text: 'Paint done'),
                ),
            'an approver reviews a stage': () => endpoints.stage.review(
              signedInAs(approverId),
              projectId,
              stageId,
              ReviewDecision.approved,
            ),
          });
      });

      test('then every change is refused with projectNotEditable', () async {
        for (final MapEntry(key: what, value: call) in refused.entries) {
          await expectLater(
            call(),
            throwsA(_appException(AppErrorCode.projectNotEditable)),
            reason: what,
          );
        }
      });

      test('then members can still read it', () async {
        final overview = await endpoints.project.get(
          signedInAs(managerId),
          projectId,
        );

        expect(overview.project.status, ProjectStatus.completed);
      });

      test('(C-2) then the owner can still remove a member and cancel an '
          'invitation', () async {
        await endpoints.membership.removeMember(
          signedInAs(ownerId),
          projectId,
          managerMemberId,
        );
        await endpoints.membership.cancelInvitation(
          signedInAs(ownerId),
          projectId,
          pending.id!,
        );

        final members = await endpoints.membership.listMembers(
          signedInAs(ownerId),
          projectId,
        );
        expect(
          members.map((m) => m.member.authUserId),
          isNot(contains(managerId)),
        );
      });

      test('(C-4) then the owner can reopen it', () async {
        final reopened = await endpoints.project.setStatus(
          signedInAs(ownerId),
          projectId,
          ProjectStatus.active,
        );

        expect(reopened.project.status, ProjectStatus.active);
      });
    });

    group('when it is archived', () {
      setUp(() => setStatus(ProjectStatus.archived));

      test('then changes are refused too', () async {
        await expectLater(
          endpoints.site.update(signedInAs(ownerId), projectId, radiusM: 60),
          throwsA(_appException(AppErrorCode.projectNotEditable)),
        );
      });

      test('(C-4) then it cannot be reopened', () async {
        await expectLater(
          endpoints.project.setStatus(
            signedInAs(ownerId),
            projectId,
            ProjectStatus.active,
          ),
          throwsA(_appException(AppErrorCode.invalidStatusTransition)),
        );
      });
    });

    group('when the site manager is removed after working on it', () {
      late int evidenceId;
      late int updateId;

      setUp(() async {
        final session = sessionBuilder.build();
        final now = DateTime.now().toUtc();
        final plan = await endpoints.stage.plan(signedInAs(ownerId), projectId);
        evidenceId = (await Evidence.db.insertRow(
          session,
          Evidence(
            projectId: projectId,
            stageId: stageId,
            checklistItemId: plan.stages.single.items.single.id!,
            capturedBy: managerId,
            status: EvidenceStatus.finalized,
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
          ),
        )).id!;
        await SiteProposal.db.insertRow(
          session,
          SiteProposal(
            projectId: projectId,
            proposedBy: managerId,
            lat: 5.4778,
            lng: 10.4176,
            accuracyM: 8,
            proposedAt: now,
            status: SiteProposalStatus.pending,
          ),
        );
        updateId = (await endpoints.progressUpdate.create(
          signedInAs(managerId),
          projectId,
          ProgressUpdateDraft(text: 'Trenches dug'),
        )).id!;
        await endpoints.membership.removeMember(
          signedInAs(ownerId),
          projectId,
          managerMemberId,
        );
      });

      test('(C-2a, C-2d) then their photo, proposal and update stay, with '
          'their name and "former member"', () async {
        final photo = await endpoints.evidence.get(
          signedInAs(ownerId),
          projectId,
          evidenceId,
        );
        final proposal = (await endpoints.site.listProposals(
          signedInAs(ownerId),
          projectId,
        )).single;
        final update = await endpoints.progressUpdate.get(
          signedInAs(ownerId),
          projectId,
          updateId,
        );

        expect(photo.capturedBy, managerId);
        expect(photo.capturedByName, 'Bob Mbarga');
        expect(photo.capturedByFormer, isTrue);
        expect(proposal.proposedByName, 'Bob Mbarga');
        expect(proposal.proposedByFormer, isTrue);
        expect(update.authorName, 'Bob Mbarga');
        expect(update.authorFormer, isTrue);
        final theirEvents = await ActivityEvent.db.count(
          sessionBuilder.build(),
          where: (t) => t.actorId.equals(managerId),
        );
        expect(theirEvents, greaterThan(0));
      });

      test('(C-2d) then a current member is not marked former', () async {
        // The owner can propose a location too (doc/04b G-12).
        final mine = await endpoints.site.propose(
          signedInAs(ownerId),
          projectId,
          lat: 5.4778,
          lng: 10.4176,
          accuracyM: 8,
          isMocked: false,
        );
        final listed = await endpoints.site.listProposals(
          signedInAs(ownerId),
          projectId,
        );

        final owners = listed.firstWhere((p) => p.id == mine.id);
        expect(owners.proposedByName, 'Ada Lovelace');
        expect(owners.proposedByFormer, isFalse);
      });

      test('(C-2b) then they are listed as a former member, with who '
          'removed them', () async {
        final former = await endpoints.membership.listFormerMembers(
          signedInAs(approverId),
          projectId,
        );
        final current = await endpoints.membership.listMembers(
          signedInAs(approverId),
          projectId,
        );

        expect(former.single.fullName, 'Bob Mbarga');
        expect(former.single.member.status, MemberStatus.removed);
        expect(former.single.member.removedAt, isNotNull);
        expect(former.single.removedByName, 'Ada Lovelace');
        expect(current.map((m) => m.fullName), isNot(contains('Bob Mbarga')));
      });

      test('(C-2c) then the feed event names them', () async {
        final removed = await ActivityEvent.db.findFirstRow(
          sessionBuilder.build(),
          where: (t) => t.type.equals(ActivityType.memberRemoved),
        );

        expect(removed?.payload?['memberName'], 'Bob Mbarga');
        expect(removed?.payload?['role'], ProjectRole.siteManager.name);
      });
    });
  });
}

Matcher _appException(AppErrorCode code) =>
    isA<AppException>().having((e) => e.code, 'code', code);
