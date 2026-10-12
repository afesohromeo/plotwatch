import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Plan: doc/04g-m8-hardening.md, step 6: account deletion deletes the
// person, not the shared history.
void main() {
  setUp(() {
    AuthServices.set(
      tokenManagerBuilders: [
        ServerSideSessionsConfig(sessionKeyHashPepper: 'test-pepper'),
      ],
    );
  });

  withServerpod('Given a user who wants to delete their account', (
    sessionBuilder,
    endpoints,
  ) {
    final session = sessionBuilder.build();

    TestSessionBuilder signedInAs(UuidValue userId) => sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        userId.uuid,
        {},
      ),
    );

    Future<UuidValue> createUser(String name) async {
      final user = await AuthServices.instance.authUsers.create(session);
      await AuthServices.instance.userProfiles.createUserProfile(
        session,
        user.id,
        UserProfileData(fullName: name, email: '$name@example.com'),
      );
      return user.id;
    }

    Future<int> createProject(UuidValue ownerId, String name) async =>
        (await endpoints.project.create(
          signedInAs(ownerId),
          ProjectDetails(
            name: name,
            type: ProjectType.newHouse,
            currencyCode: 'XAF',
          ),
        )).project.id!;

    Future<UuidValue> joinAsManager(UuidValue ownerId, int projectId) async {
      final managerId = await createUser('bob');
      final invitation = await endpoints.membership.createInvitation(
        signedInAs(ownerId),
        projectId,
        ProjectRole.siteManager,
      );
      await endpoints.membership.acceptInvitation(
        signedInAs(managerId),
        invitation.code,
      );
      return managerId;
    }

    Future<void> setStatus(int projectId, ProjectStatus status) async {
      final project = (await Project.db.findById(session, projectId))!;
      await Project.db.updateRow(session, project.copyWith(status: status));
    }

    Future<ProjectMember?> membership(int projectId, UuidValue userId) =>
        ProjectMember.db.findFirstRow(
          session,
          where: (t) =>
              t.projectId.equals(projectId) & t.authUserId.equals(userId),
        );

    test('when they are alone in their project then the project and the '
        'account are deleted', () async {
      final ownerId = await createUser('ada');
      final projectId = await createProject(ownerId, 'Solo house');
      await endpoints.profile.updateMe(
        signedInAs(ownerId),
        fullName: 'Ada',
        locale: 'fr',
      );

      await endpoints.account.deleteMe(signedInAs(ownerId));

      expect(await Project.db.findById(session, projectId), isNull);
      expect(await AuthUser.db.findById(session, ownerId), isNull);
      expect(
        await UserSettings.db.findFirstRow(
          session,
          where: (t) => t.authUserId.equals(ownerId),
        ),
        isNull,
      );
    });

    test('when they own an active project with other members then deletion '
        'is blocked, with its name', () async {
      final ownerId = await createUser('grace');
      final projectId = await createProject(ownerId, 'Maison Douala');
      await joinAsManager(ownerId, projectId);

      expect(
        await endpoints.account.deletionBlockers(signedInAs(ownerId)),
        ['Maison Douala'],
      );
      await expectLater(
        endpoints.account.deleteMe(signedInAs(ownerId)),
        throwsA(
          isA<AppException>().having(
            (e) => e.code,
            'code',
            AppErrorCode.accountOwnsSharedProjects,
          ),
        ),
      );
      expect(await AuthUser.db.findById(session, ownerId), isNotNull);
    });

    test('when their shared project is archived then it is kept for the '
        'others, and their membership is marked removed', () async {
      final ownerId = await createUser('linus');
      final projectId = await createProject(ownerId, 'Duplex');
      final managerId = await joinAsManager(ownerId, projectId);
      await setStatus(projectId, ProjectStatus.archived);

      expect(
        await endpoints.account.deletionBlockers(signedInAs(ownerId)),
        isEmpty,
      );
      await endpoints.account.deleteMe(signedInAs(ownerId));

      expect(await Project.db.findById(session, projectId), isNotNull);
      expect(
        (await membership(projectId, ownerId))?.status,
        MemberStatus.removed,
      );
      expect(
        (await membership(projectId, managerId))?.status,
        MemberStatus.active,
      );
    });

    test('when a site manager leaves then what they recorded stays in the '
        'shared ledger', () async {
      final ownerId = await createUser('margaret');
      final projectId = await createProject(ownerId, 'Villa');
      final managerId = await joinAsManager(ownerId, projectId);
      await endpoints.ledger.recordExpense(
        signedInAs(managerId),
        projectId,
        ExpenseDraft(
          amountMinor: 50000,
          occurredOn: DateTime.now().toUtc(),
          category: ExpenseCategory.transport,
          description: 'Sand',
        ),
      );

      await endpoints.account.deleteMe(signedInAs(managerId));

      expect(await AuthUser.db.findById(session, managerId), isNull);
      expect(
        (await membership(projectId, managerId))?.status,
        MemberStatus.removed,
      );
      final entries = await LedgerEntry.db.find(
        session,
        where: (t) => t.projectId.equals(projectId),
      );
      expect(entries.single.recordedBy, managerId);
    });

    test('without signing in then it throws unauthenticated', () async {
      await expectLater(
        endpoints.account.deleteMe(
          sessionBuilder.copyWith(
            authentication: AuthenticationOverride.unauthenticated(),
          ),
        ),
        throwsA(isA<ServerpodUnauthenticatedException>()),
      );
    });
  });
}
