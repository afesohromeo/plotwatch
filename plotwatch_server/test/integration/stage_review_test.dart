import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Plan: doc/04e-m5-review-realtime.md, group A (decisions M5-2 to M5-4):
// submit, review, history and notifications. AC-4 cases are marked ★.
void main() {
  // withServerpod doesn't run lib/server.dart: the auth services (names for
  // the review history) are set here, as in membership_endpoint_test.
  setUp(() {
    AuthServices.set(
      tokenManagerBuilders: [
        ServerSideSessionsConfig(sessionKeyHashPepper: 'test-pepper'),
      ],
    );
  });

  withServerpod('Given an active project with a stage in progress', (
    sessionBuilder,
    endpoints,
  ) {
    late UuidValue ownerId;
    late UuidValue managerId;
    late UuidValue approverId;
    late UuidValue coFunderId;
    late UuidValue viewerId;
    late int projectId;
    late StageView stage;
    late int requiredItem;

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

    /// A finalized capture for [itemId], as M4 leaves it.
    Future<void> cover(int itemId, {bool retracted = false}) async {
      final now = DateTime.now().toUtc();
      await Evidence.db.insertRow(
        sessionBuilder.build(),
        Evidence(
          projectId: projectId,
          stageId: stage.stage.id!,
          checklistItemId: itemId,
          capturedBy: managerId,
          status: retracted
              ? EvidenceStatus.retracted
              : EvidenceStatus.finalized,
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
      );
    }

    Future<StageView> submit([UuidValue? by]) => endpoints.stage.submit(
      signedInAs(by ?? managerId),
      projectId,
      stage.stage.id!,
    );

    Future<StageView> review(
      ReviewDecision decision, {
      UuidValue? by,
      String? comment,
    }) => endpoints.stage.review(
      signedInAs(by ?? ownerId),
      projectId,
      stage.stage.id!,
      decision,
      comment: comment,
    );

    Future<List<AppNotification>> notificationsOf(UuidValue userId) =>
        AppNotification.db.find(
          sessionBuilder.build(),
          where: (t) => t.userId.equals(userId),
        );

    Future<int> events(ActivityType type) => ActivityEvent.db.count(
      sessionBuilder.build(),
      where: (t) => t.type.equals(type),
    );

    setUp(() async {
      ownerId = await createUser('Ada Lovelace');
      managerId = await createUser('Bob Mbarga');
      approverId = await createUser('Chloe Ndi');
      coFunderId = await createUser('Dan Fotso');
      viewerId = await createUser('Eve Tchio');
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
            items: [
              ChecklistItemDraft(label: 'Trenches', isRequired: true),
              ChecklistItemDraft(label: 'Detail', isRequired: false),
            ],
          ),
        ],
      )).project.id!;
      final session = sessionBuilder.build();
      final now = DateTime.now().toUtc();
      await ProjectMember.db.insert(session, [
        for (final (userId, role, canApprove) in [
          (managerId, ProjectRole.siteManager, false),
          (approverId, ProjectRole.coFunder, true),
          (coFunderId, ProjectRole.coFunder, false),
          (viewerId, ProjectRole.viewer, false),
        ])
          ProjectMember(
            projectId: projectId,
            authUserId: userId,
            role: role,
            canApprove: canApprove,
            status: MemberStatus.active,
            joinedAt: now,
          ),
      ]);
      final project = (await Project.db.findById(session, projectId))!;
      await Project.db.updateRow(
        session,
        project.copyWith(status: ProjectStatus.active),
      );
      stage = (await endpoints.stage.plan(
        signedInAs(ownerId),
        projectId,
      )).stages.single;
      requiredItem = stage.items[0].id!;
      await Stage.db.updateRow(
        session,
        stage.stage.copyWith(status: StageStatus.inProgress),
      );
    });

    group('when the site manager submits', () {
      test('★ with every required item covered then the stage is submitted '
          'and every approver is notified, not the others', () async {
        await cover(requiredItem);

        final submitted = await submit();

        expect(submitted.stage.status, StageStatus.submitted);
        expect(submitted.stage.submittedAt, isNotNull);
        expect(await events(ActivityType.stageSubmitted), 1);
        for (final userId in [ownerId, approverId]) {
          final received = await notificationsOf(userId);
          expect(received.single.type, NotificationType.stageSubmitted);
          expect(received.single.projectId, projectId);
          expect(received.single.payload?['stageName'], 'Foundation');
        }
        for (final userId in [managerId, coFunderId, viewerId]) {
          expect(await notificationsOf(userId), isEmpty);
        }
      });

      test(
        'with an optional item left empty then it is still accepted',
        () async {
          await cover(requiredItem);

          expect((await submit()).stage.status, StageStatus.submitted);
        },
      );

      test('with a required item uncovered then it throws '
          'checklistIncomplete', () async {
        await expectLater(
          submit(),
          throwsA(_appException(AppErrorCode.checklistIncomplete)),
        );
      });

      test('when the only capture was retracted then it throws '
          'checklistIncomplete', () async {
        await cover(requiredItem, retracted: true);

        await expectLater(
          submit(),
          throwsA(_appException(AppErrorCode.checklistIncomplete)),
        );
      });

      test('on a paused project then it throws projectNotActive', () async {
        await cover(requiredItem);
        final session = sessionBuilder.build();
        final project = (await Project.db.findById(session, projectId))!;
        await Project.db.updateRow(
          session,
          project.copyWith(status: ProjectStatus.paused),
        );

        await expectLater(
          submit(),
          throwsA(_appException(AppErrorCode.projectNotActive)),
        );
      });

      test('twice then it throws invalidStageTransition', () async {
        await cover(requiredItem);
        await submit();

        await expectLater(
          submit(),
          throwsA(_appException(AppErrorCode.invalidStageTransition)),
        );
      });
    });

    test('★ when the owner, a co-funder or a viewer submits then it throws '
        'permissionDenied', () async {
      await cover(requiredItem);

      for (final userId in [ownerId, approverId, viewerId]) {
        await expectLater(
          submit(userId),
          throwsA(_appException(AppErrorCode.permissionDenied)),
          reason: '$userId',
        );
      }
    });

    group('when the stage is submitted', () {
      setUp(() async {
        await cover(requiredItem);
        await submit();
      });

      test('★ and the owner approves then it is approved, the progress goes '
          'up and the site manager is notified', () async {
        final approved = await review(ReviewDecision.approved);
        final overview = await endpoints.project.get(
          signedInAs(viewerId),
          projectId,
        );

        expect(approved.stage.status, StageStatus.approved);
        expect(approved.stage.approvedBy, ownerId);
        expect(overview.progressPercent, 100);
        expect(
          (await notificationsOf(managerId)).single.type,
          NotificationType.stageApproved,
        );
        expect(await events(ActivityType.stageApproved), 1);
      });

      test(
        'and a co-funder allowed to approve approves then it is approved',
        () async {
          final approved = await review(
            ReviewDecision.approved,
            by: approverId,
          );

          expect(approved.stage.status, StageStatus.approved);
        },
      );

      test('★ and changes are requested with a comment then the stage goes '
          'back to the site manager with it', () async {
        final changed = await review(
          ReviewDecision.changesRequested,
          comment: 'Show the depth with a tape',
        );

        expect(changed.stage.status, StageStatus.changesRequested);
        final notified = (await notificationsOf(managerId)).single;
        expect(notified.type, NotificationType.stageChangesRequested);
        expect(notified.payload?['comment'], 'Show the depth with a tape');
      });

      test('and changes are requested without a comment then it throws '
          'reviewCommentRequired', () async {
        await expectLater(
          review(ReviewDecision.changesRequested, comment: '  '),
          throwsA(_appException(AppErrorCode.reviewCommentRequired)),
        );
      });

      test('★ and the site manager, a viewer or a co-funder without approval '
          'rights reviews then it throws permissionDenied', () async {
        for (final userId in [managerId, viewerId, coFunderId]) {
          await expectLater(
            review(ReviewDecision.approved, by: userId),
            throwsA(_appException(AppErrorCode.permissionDenied)),
            reason: '$userId',
          );
        }
      });

      test('then it refuses new captures and edits', () async {
        final session = sessionBuilder.build();
        expect(
          (await Stage.db.findById(session, stage.stage.id!))!.status,
          StageStatus.submitted,
        );
        await expectLater(
          endpoints.stage.update(
            signedInAs(ownerId),
            projectId,
            stage.stage.id!,
            StageDraft(name: 'Renamed', budgetMinor: 0, items: []),
          ),
          throwsA(_appException(AppErrorCode.stageLocked)),
        );
      });

      test('★ and after changes, new photos and a resubmission it is approved, '
          'and the history keeps every decision in order', () async {
        await review(
          ReviewDecision.changesRequested,
          comment: 'Too dark',
        );
        await cover(requiredItem);
        await submit();
        await review(ReviewDecision.approved, by: approverId);

        final history = await endpoints.stage.reviews(
          signedInAs(viewerId),
          projectId,
          stage.stage.id!,
        );

        expect(history.map((r) => r.review.decision), [
          ReviewDecision.changesRequested,
          ReviewDecision.approved,
        ]);
        expect(history.map((r) => r.reviewerName), [
          'Ada Lovelace',
          'Chloe Ndi',
        ]);
        expect(history.first.review.comment, 'Too dark');
      });
    });

    test('when a stage that isn\'t submitted is reviewed then it throws '
        'invalidStageTransition', () async {
      await expectLater(
        review(ReviewDecision.approved),
        throwsA(_appException(AppErrorCode.invalidStageTransition)),
      );
    });

    test(
      'when someone joins then the owner is notified, not the newcomer',
      () async {
        final joinerId = await createUser('Fay Ngo');
        final invitation = await endpoints.membership.createInvitation(
          signedInAs(ownerId),
          projectId,
          ProjectRole.viewer,
        );

        await endpoints.membership.acceptInvitation(
          signedInAs(joinerId),
          invitation.code,
        );

        final received = (await notificationsOf(ownerId)).single;
        expect(received.type, NotificationType.memberJoined);
        expect(received.payload?['memberName'], 'Fay Ngo');
        expect(await notificationsOf(joinerId), isEmpty);
      },
    );
  });
}

Matcher _appException(AppErrorCode code) =>
    isA<AppException>().having((e) => e.code, 'code', code);
