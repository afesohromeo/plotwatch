import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Plan: doc/04e-m5-review-realtime.md, group C (decision M5-9 b): the site
// manager posts progress updates without photos; they appear in the feed.
void main() {
  final ownerId = UuidValue.fromString('00000000-0000-4000-8000-000000000001');
  final managerId = UuidValue.fromString(
    '00000000-0000-4000-8000-000000000002',
  );
  final viewerId = UuidValue.fromString('00000000-0000-4000-8000-000000000004');

  withServerpod('Given a project with a site manager', (
    sessionBuilder,
    endpoints,
  ) {
    late int projectId;
    late int stageId;

    TestSessionBuilder signedInAs(UuidValue userId) => sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        userId.uuid,
        {},
      ),
    );

    ProgressUpdateDraft draft({
      String text = 'Trenches dug on the north side',
      int? stageId,
      int? workersCount,
      Weather? weather,
      String? issues,
    }) => ProgressUpdateDraft(
      text: text,
      stageId: stageId,
      workersCount: workersCount,
      weather: weather,
      issues: issues,
    );

    setUp(() async {
      final overview = await endpoints.project.create(
        signedInAs(ownerId),
        ProjectDetails(
          name: 'House in Bafoussam',
          type: ProjectType.newHouse,
          currencyCode: 'XAF',
        ),
        stages: [
          StageDraft(name: 'Foundation', budgetMinor: 0, items: []),
        ],
      );
      projectId = overview.project.id!;
      stageId = (await endpoints.stage.plan(
        signedInAs(ownerId),
        projectId,
      )).stages.single.stage.id!;
      final now = DateTime.now().toUtc();
      await ProjectMember.db.insert(sessionBuilder.build(), [
        for (final (userId, role) in [
          (managerId, ProjectRole.siteManager),
          (viewerId, ProjectRole.viewer),
        ])
          ProjectMember(
            projectId: projectId,
            authUserId: userId,
            role: role,
            status: MemberStatus.active,
            joinedAt: now,
          ),
      ]);
    });

    test('when the site manager posts an update with every field then it is '
        'saved, announced in the feed, and members can read it', () async {
      final posted = await endpoints.progressUpdate.create(
        signedInAs(managerId),
        projectId,
        draft(
          text: '  Trenches dug  ',
          stageId: stageId,
          workersCount: 6,
          weather: Weather.rain,
          issues: 'Cement arrives late',
        ),
      );
      final read = await endpoints.progressUpdate.get(
        signedInAs(viewerId),
        projectId,
        posted.id!,
      );

      expect(read.text, 'Trenches dug');
      expect(read.stageId, stageId);
      expect(read.workersCount, 6);
      expect(read.weather, Weather.rain);
      expect(read.issues, 'Cement arrives late');
      expect(read.authorId, managerId);
      final events = await ActivityEvent.db.find(
        sessionBuilder.build(),
        where: (t) => t.type.equals(ActivityType.progressUpdatePosted),
      );
      expect(events.single.targetId, posted.id);
      expect(events.single.payload?['excerpt'], 'Trenches dug');
    });

    test('when an update has only text then it is saved', () async {
      final posted = await endpoints.progressUpdate.create(
        signedInAs(managerId),
        projectId,
        draft(),
      );

      expect(posted.stageId, isNull);
      expect(posted.weather, isNull);
    });

    for (final (what, bad) in <(String, ProgressUpdateDraft Function())>[
      ('empty text', () => draft(text: '  ')),
      ('text of 2,001 characters', () => draft(text: 'x' * 2001)),
      ('-1 workers', () => draft(workersCount: -1)),
      ('1,000 workers', () => draft(workersCount: 1000)),
      ('issues of 1,001 characters', () => draft(issues: 'x' * 1001)),
    ]) {
      test(
        'when an update has $what then it throws invalidProgressUpdate',
        () async {
          await expectLater(
            endpoints.progressUpdate.create(
              signedInAs(managerId),
              projectId,
              bad(),
            ),
            throwsA(_appException(AppErrorCode.invalidProgressUpdate)),
          );
        },
      );
    }

    test(
      'when the owner or a viewer posts then it throws permissionDenied',
      () async {
        for (final userId in [ownerId, viewerId]) {
          await expectLater(
            endpoints.progressUpdate.create(
              signedInAs(userId),
              projectId,
              draft(),
            ),
            throwsA(_appException(AppErrorCode.permissionDenied)),
          );
        }
      },
    );

    test('when the stage belongs to another project then it throws '
        'stageNotFound', () async {
      final other = await endpoints.project.create(
        signedInAs(ownerId),
        ProjectDetails(
          name: 'Other',
          type: ProjectType.newHouse,
          currencyCode: 'XAF',
        ),
        stages: [StageDraft(name: 'Walls', budgetMinor: 0, items: [])],
      );
      final foreignStage = (await endpoints.stage.plan(
        signedInAs(ownerId),
        other.project.id!,
      )).stages.single.stage.id!;

      await expectLater(
        endpoints.progressUpdate.create(
          signedInAs(managerId),
          projectId,
          draft(stageId: foreignStage),
        ),
        throwsA(_appException(AppErrorCode.stageNotFound)),
      );
    });
  });
}

Matcher _appException(AppErrorCode code) =>
    isA<AppException>().having((e) => e.code, 'code', code);
