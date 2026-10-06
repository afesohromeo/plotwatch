import 'package:serverpod/serverpod.dart';
import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:plotwatch_server/src/services/permission_service.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Plan: doc/04b-m2-projects-site-members.md, group A (decision M2-5).
void main() {
  final ownerId = UuidValue.fromString('00000000-0000-4000-8000-000000000001');
  final siteManagerId = UuidValue.fromString(
    '00000000-0000-4000-8000-000000000002',
  );
  final removedId = UuidValue.fromString(
    '00000000-0000-4000-8000-000000000003',
  );
  final strangerId = UuidValue.fromString(
    '00000000-0000-4000-8000-000000000004',
  );

  withServerpod(
    'Given a project with an owner, a site manager and a removed member',
    (sessionBuilder, _) {
      const service = PermissionService();
      late int projectId;

      Session signedInAs(UuidValue userId) => sessionBuilder
          .copyWith(
            authentication: AuthenticationOverride.authenticationInfo(
              userId.uuid,
              {},
            ),
          )
          .build();

      setUp(() async {
        final session = sessionBuilder.build();
        final now = DateTime.now().toUtc();
        final project = await Project.db.insertRow(
          session,
          Project(
            name: 'House in Bafoussam',
            type: ProjectType.newHouse,
            status: ProjectStatus.active,
            currencyCode: 'XAF',
            createdAt: now,
            updatedAt: now,
          ),
        );
        projectId = project.id!;

        ProjectMember member(
          UuidValue userId,
          ProjectRole role, {
          MemberStatus status = MemberStatus.active,
        }) => ProjectMember(
          projectId: projectId,
          authUserId: userId,
          role: role,
          status: status,
          joinedAt: now,
          removedAt: status == MemberStatus.removed ? now : null,
        );
        await ProjectMember.db.insert(session, [
          member(ownerId, ProjectRole.owner),
          member(siteManagerId, ProjectRole.siteManager),
          member(
            removedId,
            ProjectRole.siteManager,
            status: MemberStatus.removed,
          ),
        ]);
      });

      test(
        'when the owner edits the project then their membership is returned',
        () async {
          final membership = await service.require(
            signedInAs(ownerId),
            projectId,
            ProjectAction.editProject,
          );

          expect(membership.authUserId, ownerId);
          expect(membership.role, ProjectRole.owner);
        },
      );

      test(
        'when the site manager edits the project then it is permissionDenied',
        () async {
          await expectLater(
            service.require(
              signedInAs(siteManagerId),
              projectId,
              ProjectAction.editProject,
            ),
            throwsA(_appException(AppErrorCode.permissionDenied)),
          );
        },
      );

      test(
        'when the site manager views the project then it is allowed',
        () async {
          final membership = await service.require(
            signedInAs(siteManagerId),
            projectId,
            ProjectAction.viewProject,
          );

          expect(membership.role, ProjectRole.siteManager);
        },
      );

      test(
        'when a non-member views the project then it is projectNotFound',
        () async {
          await expectLater(
            service.require(
              signedInAs(strangerId),
              projectId,
              ProjectAction.viewProject,
            ),
            throwsA(_appException(AppErrorCode.projectNotFound)),
          );
        },
      );

      test(
        'when a removed member views the project then it is projectNotFound',
        () async {
          await expectLater(
            service.require(
              signedInAs(removedId),
              projectId,
              ProjectAction.viewProject,
            ),
            throwsA(_appException(AppErrorCode.projectNotFound)),
          );
        },
      );

      test(
        'when the project does not exist then it is projectNotFound',
        () async {
          await expectLater(
            service.require(
              signedInAs(ownerId),
              projectId + 1000,
              ProjectAction.viewProject,
            ),
            throwsA(_appException(AppErrorCode.projectNotFound)),
          );
        },
      );
    },
  );
}

Matcher _appException(AppErrorCode code) =>
    isA<AppException>().having((e) => e.code, 'code', code);
