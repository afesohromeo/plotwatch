import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Plan: doc/04b-m2-projects-site-members.md, group B (decisions M2-3, M2-4).
void main() {
  final ownerId = UuidValue.fromString('00000000-0000-4000-8000-000000000001');
  final otherId = UuidValue.fromString('00000000-0000-4000-8000-000000000002');

  final details = ProjectDetails(
    name: '  House in Bafoussam ',
    description: 'Four bedrooms, one floor',
    type: ProjectType.newHouse,
    currencyCode: 'XAF',
    plannedStart: DateTime.utc(2026, 11, 1),
    plannedEnd: DateTime.utc(2027, 6, 30),
  );

  withServerpod('Given the project endpoint', (sessionBuilder, endpoints) {
    TestSessionBuilder signedInAs(UuidValue userId) => sessionBuilder.copyWith(
          authentication:
              AuthenticationOverride.authenticationInfo(userId.uuid, {}),
        );

    Future<ProjectMember> addMember(
      int projectId,
      UuidValue userId,
      ProjectRole role, {
      MemberStatus status = MemberStatus.active,
    }) =>
        ProjectMember.db.insertRow(
          sessionBuilder.build(),
          ProjectMember(
            projectId: projectId,
            authUserId: userId,
            role: role,
            status: status,
            joinedAt: DateTime.now().toUtc(),
          ),
        );

    Future<void> setStatusInDatabase(int projectId, ProjectStatus status) async {
      final session = sessionBuilder.build();
      final project = await Project.db.findById(session, projectId);
      await Project.db.updateRow(session, project!.copyWith(status: status));
    }

    group('when a project is created', () {
      test('then the caller is its owner and it is a draft without a site',
          () async {
        final overview =
            await endpoints.project.create(signedInAs(ownerId), details);

        expect(overview.project.name, 'House in Bafoussam');
        expect(overview.project.status, ProjectStatus.draft);
        expect(overview.site, isNull);
        expect(overview.myRole, ProjectRole.owner);
        final members = await ProjectMember.db.find(
          sessionBuilder.build(),
          where: (t) => t.projectId.equals(overview.project.id),
        );
        expect(members, hasLength(1));
        expect(members.single.authUserId, ownerId);
        expect(members.single.role, ProjectRole.owner);
        expect(members.single.status, MemberStatus.active);
      });

      test('then one audit entry and one projectCreated event are written',
          () async {
        final overview =
            await endpoints.project.create(signedInAs(ownerId), details);
        final session = sessionBuilder.build();

        final audit = await AuditLog.db.find(session,
            where: (t) => t.projectId.equals(overview.project.id));
        expect(audit, hasLength(1));
        expect(audit.single.action, 'project.create');
        expect(audit.single.actorId, ownerId);
        expect(audit.single.after?['name'], 'House in Bafoussam');
        final events = await ActivityEvent.db.find(session,
            where: (t) => t.projectId.equals(overview.project.id));
        expect(events.map((e) => e.type), [ActivityType.projectCreated]);
      });

      test('without signing in then it is refused', () async {
        await expectLater(
          endpoints.project.create(
            sessionBuilder.copyWith(
                authentication: AuthenticationOverride.unauthenticated()),
            details,
          ),
          throwsA(isA<ServerpodUnauthenticatedException>()),
        );
      });

      final invalid = {
        'a blank name': (
          details.copyWith(name: '   '),
          AppErrorCode.invalidProjectName
        ),
        'a name of 101 characters': (
          details.copyWith(name: 'x' * 101),
          AppErrorCode.invalidProjectName
        ),
        'a description of 1,001 characters': (
          details.copyWith(description: 'x' * 1001),
          AppErrorCode.invalidProjectDescription
        ),
        'an unknown currency': (
          details.copyWith(currencyCode: 'XYZ'),
          AppErrorCode.invalidCurrencyCode
        ),
        'a lower-case currency': (
          details.copyWith(currencyCode: 'xaf'),
          AppErrorCode.invalidCurrencyCode
        ),
        'an end before the start': (
          details.copyWith(plannedEnd: DateTime.utc(2026, 10, 31)),
          AppErrorCode.invalidProjectDates
        ),
      };
      for (final MapEntry(key: name, value: (input, code)) in invalid.entries) {
        test('with $name then it throws ${code.name} and nothing is created',
            () async {
          await expectLater(
            endpoints.project.create(signedInAs(ownerId), input),
            throwsA(_appException(code)),
          );
          expect(await Project.db.count(sessionBuilder.build()), 0);
        });
      }
    });

    group('when projects are listed', () {
      late List<int> ownerProjects;

      setUp(() async {
        ownerProjects = [
          for (final name in ['First', 'Second', 'Third'])
            (await endpoints.project
                    .create(signedInAs(ownerId), details.copyWith(name: name)))
                .project
                .id!,
        ];
        await endpoints.project
            .create(signedInAs(otherId), details.copyWith(name: 'Other own'));
        await addMember(ownerProjects[0], otherId, ProjectRole.siteManager);
        await addMember(ownerProjects[1], otherId, ProjectRole.viewer,
            status: MemberStatus.removed);
      });

      test(
          'then each user sees only their active memberships, with their '
          'role, newest first', () async {
        final page = await endpoints.project.list(signedInAs(otherId));

        expect(
          page.items.map((s) => (s.project.name, s.myRole)),
          [('Other own', ProjectRole.owner), ('First', ProjectRole.siteManager)],
        );
        expect(page.items.map((s) => s.progressPercent), everyElement(0));
      });

      test('then the list is split into pages', () async {
        final first =
            await endpoints.project.list(signedInAs(ownerId), pageSize: 2);
        final second = await endpoints.project
            .list(signedInAs(ownerId), page: 1, pageSize: 2);

        expect(first.items.map((s) => s.project.name), ['Third', 'Second']);
        expect(second.items.map((s) => s.project.name), ['First']);
        expect(second.page, 1);
        expect(second.pageSize, 2);
      });
    });

    group('when a project is fetched', () {
      late int projectId;

      setUp(() async {
        projectId = (await endpoints.project.create(signedInAs(ownerId), details))
            .project
            .id!;
      });

      test('by a member then it returns the project with their role',
          () async {
        await addMember(projectId, otherId, ProjectRole.siteManager);

        final overview =
            await endpoints.project.get(signedInAs(otherId), projectId);

        expect(overview.project.id, projectId);
        expect(overview.myRole, ProjectRole.siteManager);
      });

      test('by a non-member then it throws projectNotFound', () async {
        await expectLater(
          endpoints.project.get(signedInAs(otherId), projectId),
          throwsA(_appException(AppErrorCode.projectNotFound)),
        );
      });
    });

    group('when a project is updated', () {
      late int projectId;

      setUp(() async {
        projectId = (await endpoints.project.create(signedInAs(ownerId), details))
            .project
            .id!;
      });

      test('by the owner then it is saved, audited and announced', () async {
        final updated = await endpoints.project.update(
          signedInAs(ownerId),
          projectId,
          details.copyWith(name: 'Bigger house', description: null),
        );
        final session = sessionBuilder.build();

        expect(updated.project.name, 'Bigger house');
        expect(updated.project.description, isNull);
        expect((await Project.db.findById(session, projectId))!.name,
            'Bigger house');
        final audit = await AuditLog.db.findFirstRow(session,
            where: (t) => t.action.equals('project.update'));
        expect(audit!.before?['name'], 'House in Bafoussam');
        expect(audit.after?['name'], 'Bigger house');
        final events = await ActivityEvent.db.find(session,
            where: (t) => t.type.equals(ActivityType.projectUpdated));
        expect(events, hasLength(1));
      });

      for (final role in [
        ProjectRole.coFunder,
        ProjectRole.viewer,
        ProjectRole.siteManager,
      ]) {
        test('by a ${role.name} then it throws permissionDenied', () async {
          await addMember(projectId, otherId, role);

          await expectLater(
            endpoints.project.update(signedInAs(otherId), projectId, details),
            throwsA(_appException(AppErrorCode.permissionDenied)),
          );
        });
      }

      test('with a blank name then it throws invalidProjectName', () async {
        await expectLater(
          endpoints.project.update(
              signedInAs(ownerId), projectId, details.copyWith(name: ' ')),
          throwsA(_appException(AppErrorCode.invalidProjectName)),
        );
      });
    });

    group('when the status is changed', () {
      late int projectId;

      setUp(() async {
        projectId = (await endpoints.project.create(signedInAs(ownerId), details))
            .project
            .id!;
      });

      const allowed = [
        (ProjectStatus.active, ProjectStatus.paused),
        (ProjectStatus.paused, ProjectStatus.active),
        (ProjectStatus.active, ProjectStatus.completed),
        (ProjectStatus.paused, ProjectStatus.completed),
        (ProjectStatus.completed, ProjectStatus.archived),
      ];
      for (final (from, to) in allowed) {
        test('from ${from.name} to ${to.name} then it is saved and announced',
            () async {
          await setStatusInDatabase(projectId, from);

          final updated = await endpoints.project
              .setStatus(signedInAs(ownerId), projectId, to);

          expect(updated.project.status, to);
          final events = await ActivityEvent.db.find(sessionBuilder.build(),
              where: (t) => t.type.equals(ActivityType.projectStatusChanged));
          expect(events.single.payload?['status'], to.name);
        });
      }

      const refused = [
        // A draft becomes active only when its site is validated (M2-4).
        (ProjectStatus.draft, ProjectStatus.active),
        (ProjectStatus.draft, ProjectStatus.paused),
        (ProjectStatus.active, ProjectStatus.draft),
        (ProjectStatus.active, ProjectStatus.archived),
        (ProjectStatus.active, ProjectStatus.active),
        (ProjectStatus.completed, ProjectStatus.active),
        (ProjectStatus.archived, ProjectStatus.active),
      ];
      for (final (from, to) in refused) {
        test('from ${from.name} to ${to.name} then it throws '
            'invalidStatusTransition', () async {
          await setStatusInDatabase(projectId, from);

          await expectLater(
            endpoints.project.setStatus(signedInAs(ownerId), projectId, to),
            throwsA(_appException(AppErrorCode.invalidStatusTransition)),
          );
        });
      }

      test('by a site manager then it throws permissionDenied', () async {
        await setStatusInDatabase(projectId, ProjectStatus.active);
        await addMember(projectId, otherId, ProjectRole.siteManager);

        await expectLater(
          endpoints.project
              .setStatus(signedInAs(otherId), projectId, ProjectStatus.paused),
          throwsA(_appException(AppErrorCode.permissionDenied)),
        );
      });
    });
  });
}

Matcher _appException(AppErrorCode code) =>
    isA<AppException>().having((e) => e.code, 'code', code);
