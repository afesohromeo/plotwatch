import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Plan: doc/04b-m2-projects-site-members.md, group C (decisions M2-6, M2-7).
// AC-2 cases are marked ★.
void main() {
  final details = ProjectDetails(
    name: 'House in Bafoussam',
    type: ProjectType.newHouse,
    currencyCode: 'XAF',
  );

  // `withServerpod` doesn't run lib/server.dart, so the auth services are set
  // here (names and emails come from the auth module's profiles).
  setUp(() {
    AuthServices.set(
      tokenManagerBuilders: [
        ServerSideSessionsConfig(sessionKeyHashPepper: 'test-pepper'),
      ],
    );
  });

  withServerpod('Given a project and its owner', (sessionBuilder, endpoints) {
    late UuidValue ownerId;
    late UuidValue joinerId;
    late int projectId;

    TestSessionBuilder signedInAs(UuidValue userId) => sessionBuilder.copyWith(
          authentication:
              AuthenticationOverride.authenticationInfo(userId.uuid, {}),
        );

    Future<UuidValue> createUser(String fullName, String email) async {
      final session = sessionBuilder.build();
      final user = await AuthServices.instance.authUsers.create(session);
      await AuthServices.instance.userProfiles.createUserProfile(
        session,
        user.id,
        UserProfileData(fullName: fullName, email: email),
      );
      return user.id;
    }

    Future<Invitation> invite(ProjectRole role, {bool canApprove = false}) =>
        endpoints.membership.createInvitation(
          signedInAs(ownerId),
          projectId,
          role,
          canApprove: canApprove,
        );

    setUp(() async {
      ownerId = await createUser('Ada Lovelace', 'ada@example.com');
      joinerId = await createUser('Bob Mbarga', 'bob@example.com');
      projectId = (await endpoints.project.create(signedInAs(ownerId), details))
          .project
          .id!;
    });

    group('when the owner creates an invitation', () {
      test('★ then it has an 8-character code and expires in 7 days',
          () async {
        final before = DateTime.now().toUtc();

        final invitation = await invite(ProjectRole.siteManager);

        expect(invitation.code, matches(RegExp(r'^[2-9A-HJKMNP-Z]{8}$')));
        expect(invitation.status, InvitationStatus.pending);
        expect(
          invitation.expiresAt.difference(before).inMinutes,
          closeTo(7 * 24 * 60, 1),
        );
      });

      test('for the owner role then it throws invalidInvitationRole', () async {
        await expectLater(
          invite(ProjectRole.owner),
          throwsA(_appException(AppErrorCode.invalidInvitationRole)),
        );
      });

      test('for a co-funder who can approve then the flag is kept', () async {
        final invitation = await invite(ProjectRole.coFunder, canApprove: true);

        expect(invitation.canApprove, isTrue);
      });

      test('for a site manager then the approval flag is ignored', () async {
        final invitation =
            await invite(ProjectRole.siteManager, canApprove: true);

        expect(invitation.canApprove, isFalse);
      });

      test('★ by a member who is not the owner then it throws permissionDenied',
          () async {
        final invitation = await invite(ProjectRole.coFunder);
        await endpoints.membership
            .acceptInvitation(signedInAs(joinerId), invitation.code);

        await expectLater(
          endpoints.membership.createInvitation(
              signedInAs(joinerId), projectId, ProjectRole.viewer),
          throwsA(_appException(AppErrorCode.permissionDenied)),
        );
      });
    });

    group('when someone uses a code', () {
      test('to preview it then they see the project, role and inviter',
          () async {
        final invitation = await invite(ProjectRole.siteManager);

        final preview = await endpoints.membership
            .previewInvitation(signedInAs(joinerId), invitation.code);

        expect(preview.projectName, 'House in Bafoussam');
        expect(preview.role, ProjectRole.siteManager);
        expect(preview.inviterName, 'Ada Lovelace');
      });

      test('★ to join then they become an active member with that role',
          () async {
        final invitation = await invite(ProjectRole.siteManager);

        final member = await endpoints.membership
            .acceptInvitation(signedInAs(joinerId), invitation.code);

        expect(member.authUserId, joinerId);
        expect(member.role, ProjectRole.siteManager);
        expect(member.status, MemberStatus.active);
        final overview =
            await endpoints.project.get(signedInAs(joinerId), projectId);
        expect(overview.myRole, ProjectRole.siteManager);
        final events = await ActivityEvent.db.find(sessionBuilder.build(),
            where: (t) => t.type.equals(ActivityType.memberJoined));
        expect(events, hasLength(1));
      });

      test('in lower case with a hyphen then it is accepted', () async {
        final code = (await invite(ProjectRole.viewer)).code;
        final typed =
            '${code.substring(0, 4)}-${code.substring(4)}'.toLowerCase();

        final member = await endpoints.membership
            .acceptInvitation(signedInAs(joinerId), ' $typed ');

        expect(member.role, ProjectRole.viewer);
      });

      test('★ that was already used then it throws invitationUsed', () async {
        final code = (await invite(ProjectRole.siteManager)).code;
        await endpoints.membership.acceptInvitation(signedInAs(joinerId), code);
        final thirdId = await createUser('Chantal Ngo', 'chantal@example.com');

        await expectLater(
          endpoints.membership.acceptInvitation(signedInAs(thirdId), code),
          throwsA(_appException(AppErrorCode.invitationUsed)),
        );
      });

      test('★ that has expired then it throws invitationExpired', () async {
        final invitation = await invite(ProjectRole.siteManager);
        await Invitation.db.updateRow(
          sessionBuilder.build(),
          invitation.copyWith(
            expiresAt: DateTime.now().toUtc().subtract(const Duration(minutes: 1)),
          ),
        );

        await expectLater(
          endpoints.membership
              .acceptInvitation(signedInAs(joinerId), invitation.code),
          throwsA(_appException(AppErrorCode.invitationExpired)),
        );
        await expectLater(
          endpoints.membership
              .previewInvitation(signedInAs(joinerId), invitation.code),
          throwsA(_appException(AppErrorCode.invitationExpired)),
        );
      });

      test('that does not exist then it throws invitationNotFound', () async {
        await expectLater(
          endpoints.membership
              .acceptInvitation(signedInAs(joinerId), 'ABCDEFGH'),
          throwsA(_appException(AppErrorCode.invitationNotFound)),
        );
      });

      test('that was cancelled then it throws invitationUsed', () async {
        final invitation = await invite(ProjectRole.siteManager);
        await endpoints.membership.cancelInvitation(
            signedInAs(ownerId), projectId, invitation.id!);

        await expectLater(
          endpoints.membership
              .acceptInvitation(signedInAs(joinerId), invitation.code),
          throwsA(_appException(AppErrorCode.invitationUsed)),
        );
      });

      test(
          'while already a member then it throws alreadyMember and the code '
          'stays usable', () async {
        final invitation = await invite(ProjectRole.viewer);

        await expectLater(
          endpoints.membership
              .acceptInvitation(signedInAs(ownerId), invitation.code),
          throwsA(_appException(AppErrorCode.alreadyMember)),
        );
        final stored = await Invitation.db
            .findById(sessionBuilder.build(), invitation.id!);
        expect(stored!.status, InvitationStatus.pending);
      });

      test('after being removed then they can join again', () async {
        final first = await endpoints.membership.acceptInvitation(
            signedInAs(joinerId), (await invite(ProjectRole.viewer)).code);
        await endpoints.membership
            .removeMember(signedInAs(ownerId), projectId, first.id!);

        final again = await endpoints.membership.acceptInvitation(
            signedInAs(joinerId), (await invite(ProjectRole.siteManager)).code);

        expect(again.role, ProjectRole.siteManager);
        expect(again.status, MemberStatus.active);
      });
    });

    group('when the owner manages the project', () {
      test('then pending invitations are listed and can be cancelled',
          () async {
        final kept = await invite(ProjectRole.siteManager);
        final cancelled = await invite(ProjectRole.viewer);

        await endpoints.membership.cancelInvitation(
            signedInAs(ownerId), projectId, cancelled.id!);
        final pending = await endpoints.membership
            .listInvitations(signedInAs(ownerId), projectId);

        expect(pending.map((i) => i.id), [kept.id]);
      });

      test('then members are listed with their name and email', () async {
        await endpoints.membership.acceptInvitation(
            signedInAs(joinerId), (await invite(ProjectRole.siteManager)).code);

        final members = await endpoints.membership
            .listMembers(signedInAs(joinerId), projectId);

        expect(
          members.map((m) => (m.fullName, m.email, m.member.role)),
          containsAll([
            ('Ada Lovelace', 'ada@example.com', ProjectRole.owner),
            ('Bob Mbarga', 'bob@example.com', ProjectRole.siteManager),
          ]),
        );
      });

      test('then a removed member loses access immediately', () async {
        final member = await endpoints.membership.acceptInvitation(
            signedInAs(joinerId), (await invite(ProjectRole.siteManager)).code);

        await endpoints.membership
            .removeMember(signedInAs(ownerId), projectId, member.id!);

        await expectLater(
          endpoints.project.get(signedInAs(joinerId), projectId),
          throwsA(_appException(AppErrorCode.projectNotFound)),
        );
        final members = await endpoints.membership
            .listMembers(signedInAs(ownerId), projectId);
        expect(members.map((m) => m.member.authUserId), [ownerId]);
        final events = await ActivityEvent.db.find(sessionBuilder.build(),
            where: (t) => t.type.equals(ActivityType.memberRemoved));
        expect(events, hasLength(1));
      });

      test('then the owner cannot be removed', () async {
        final owner = (await endpoints.membership
                .listMembers(signedInAs(ownerId), projectId))
            .single
            .member;

        await expectLater(
          endpoints.membership
              .removeMember(signedInAs(ownerId), projectId, owner.id!),
          throwsA(_appException(AppErrorCode.cannotRemoveOwner)),
        );
      });

      test('then removing someone who is not a member throws memberNotFound',
          () async {
        await expectLater(
          endpoints.membership
              .removeMember(signedInAs(ownerId), projectId, 999999),
          throwsA(_appException(AppErrorCode.memberNotFound)),
        );
      });

      test('then a site manager cannot remove members or cancel invitations',
          () async {
        final invitation = await invite(ProjectRole.viewer);
        final manager = await endpoints.membership.acceptInvitation(
            signedInAs(joinerId), (await invite(ProjectRole.siteManager)).code);

        await expectLater(
          endpoints.membership
              .removeMember(signedInAs(joinerId), projectId, manager.id!),
          throwsA(_appException(AppErrorCode.permissionDenied)),
        );
        await expectLater(
          endpoints.membership.cancelInvitation(
              signedInAs(joinerId), projectId, invitation.id!),
          throwsA(_appException(AppErrorCode.permissionDenied)),
        );
      });
    });
  });

  // Two people accepting the same code at the same moment must not both join
  // (the find-or-create lesson of M1). Concurrent transactions need the
  // database without automatic rollback.
  withServerpod(
    'Given one invitation and two users accepting it at the same time',
    (sessionBuilder, endpoints) {
      test('then exactly one of them joins', () async {
        TestSessionBuilder signedInAs(UuidValue userId) =>
            sessionBuilder.copyWith(
              authentication:
                  AuthenticationOverride.authenticationInfo(userId.uuid, {}),
            );
        final ownerId =
            UuidValue.fromString('00000000-0000-4000-8000-0000000000a1');
        final users = [
          UuidValue.fromString('00000000-0000-4000-8000-0000000000a2'),
          UuidValue.fromString('00000000-0000-4000-8000-0000000000a3'),
        ];
        final projectId =
            (await endpoints.project.create(signedInAs(ownerId), details))
                .project
                .id!;
        final code = (await endpoints.membership.createInvitation(
                signedInAs(ownerId), projectId, ProjectRole.siteManager))
            .code;

        final results = await Future.wait([
          for (final user in users)
            endpoints.membership
                .acceptInvitation(signedInAs(user), code)
                .then<Object>((member) => member, onError: (Object e) => e),
        ]);

        expect(results.whereType<ProjectMember>(), hasLength(1));
        expect(
          results.whereType<AppException>().map((e) => e.code),
          [AppErrorCode.invitationUsed],
        );
      });
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}

Matcher _appException(AppErrorCode code) =>
    isA<AppException>().having((e) => e.code, 'code', code);
