import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:plotwatch_server/src/services/activity_service.dart';
import 'package:plotwatch_server/src/services/project_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Plan: doc/05-design-system.md §9.4, step 5: lists that grow can be
// searched, filtered and sorted, on the server for the paged ones.
void main() {
  final ownerId = UuidValue.fromString('00000000-0000-4000-8000-000000000001');
  final otherId = UuidValue.fromString('00000000-0000-4000-8000-000000000002');

  test('Given a search term with LIKE wildcards then they are taken '
      'literally', () {
    expect(ProjectService.escapeLike('50%_a\\b'), r'50\%\_a\\b');
  });

  test('Given activity targets then the stage is the target stage or the '
      'one the payload names', () {
    expect(ActivityService.stageOf('stage', 7, null), 7);
    expect(ActivityService.stageOf('evidence', 3, {'stageId': '9'}), 9);
    expect(ActivityService.stageOf('project', 1, {'name': 'x'}), isNull);
  });

  withServerpod('Given a user in four projects', (sessionBuilder, endpoints) {
    TestSessionBuilder signedInAs(UuidValue userId) => sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        userId.uuid,
        {},
      ),
    );
    final owner = signedInAs(ownerId);

    late Map<String, int> ids;

    Future<int> create(String name, {int stages = 0}) async =>
        (await endpoints.project.create(
          owner,
          ProjectDetails(
            name: name,
            type: ProjectType.newHouse,
            currencyCode: 'XAF',
          ),
          stages: [
            for (var i = 0; i < stages; i++)
              StageDraft(
                name: 'Stage $i',
                budgetMinor: 0,
                items: [ChecklistItemDraft(label: 'Shot', isRequired: true)],
              ),
          ],
        )).project.id!;

    setUp(() async {
      ids = {
        'Bafoussam house': await create('Bafoussam house', stages: 2),
        'Douala duplex': await create('Douala duplex', stages: 4),
        'Kribi villa': await create('Kribi villa', stages: 1),
        'Shop 50% done': await create('Shop 50% done'),
      };
      final session = sessionBuilder.build();
      // Douala: 1 of 4 approved (25 %); Kribi: 1 of 1 (100 %).
      for (final name in ['Douala duplex', 'Kribi villa']) {
        final first = (await Stage.db.find(
          session,
          where: (t) => t.projectId.equals(ids[name]!),
          orderBy: (t) => t.orderIndex,
        )).first;
        await Stage.db.updateRow(
          session,
          first.copyWith(status: StageStatus.approved),
        );
      }
      // Set directly: a project without a site can't leave draft.
      for (final (name, status) in [
        ('Bafoussam house', ProjectStatus.active),
        ('Douala duplex', ProjectStatus.active),
        ('Kribi villa', ProjectStatus.paused),
      ]) {
        final project = await Project.db.findById(session, ids[name]!);
        await Project.db.updateRow(session, project!.copyWith(status: status));
      }
      // Kribi, then Bafoussam, are the latest touched.
      await const ActivityService().record(
        session,
        projectId: ids['Kribi villa']!,
        actorId: ownerId,
        type: ActivityType.projectStatusChanged,
        targetType: 'project',
        targetId: ids['Kribi villa'],
      );
      await endpoints.project.update(
        owner,
        ids['Bafoussam house']!,
        ProjectDetails(
          name: 'Bafoussam house',
          description: 'Two floors',
          type: ProjectType.newHouse,
          currencyCode: 'XAF',
        ),
      );
    });

    Future<List<String>> names({
      ProjectStatus? status,
      String? search,
      ProjectSort? sort,
      int? page,
      int? pageSize,
    }) async => [
      for (final summary in (await endpoints.project.list(
        owner,
        status: status,
        search: search,
        sort: sort,
        page: page,
        pageSize: pageSize,
      )).items)
        summary.project.name,
    ];

    test(
      'when nothing is chosen then the latest activity comes first',
      () async {
        expect(await names(), [
          'Bafoussam house',
          'Kribi villa',
          'Shop 50% done',
          'Douala duplex',
        ]);
      },
    );

    test('when a status is chosen then only those projects come', () async {
      expect(await names(status: ProjectStatus.paused), ['Kribi villa']);
    });

    test('when searching then names containing the term come, whatever '
        'the case, and % is not a wildcard', () async {
      expect(await names(search: 'DUPLEX'), ['Douala duplex']);
      expect(await names(search: '  house '), ['Bafoussam house']);
      expect(await names(search: '50%'), ['Shop 50% done']);
      expect(await names(search: '%'), ['Shop 50% done']);
    });

    test('when sorted by name then they come in alphabetical order', () async {
      expect(await names(sort: ProjectSort.name), [
        'Bafoussam house',
        'Douala duplex',
        'Kribi villa',
        'Shop 50% done',
      ]);
    });

    test(
      'when sorted by progress then the furthest along comes first',
      () async {
        expect(await names(sort: ProjectSort.progress), [
          'Kribi villa',
          'Douala duplex',
          'Shop 50% done',
          'Bafoussam house',
        ]);
      },
    );

    test(
      'when filtered and paged then the pages split the filtered list',
      () async {
        expect(
          await names(sort: ProjectSort.name, page: 1, pageSize: 2),
          ['Kribi villa', 'Shop 50% done'],
        );
        expect(
          await names(sort: ProjectSort.progress, page: 1, pageSize: 3),
          ['Bafoussam house'],
        );
        expect(
          await names(status: ProjectStatus.active, page: 1, pageSize: 1),
          ['Douala duplex'],
        );
      },
    );

    test('when another user lists then they see none of them', () async {
      final items = (await endpoints.project.list(
        signedInAs(otherId),
        search: 'house',
      )).items;
      expect(items, isEmpty);
    });
  });

  withServerpod('Given a project feed with stage events', (
    sessionBuilder,
    endpoints,
  ) {
    TestSessionBuilder signedInAs(UuidValue userId) => sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        userId.uuid,
        {},
      ),
    );
    final owner = signedInAs(ownerId);
    late int projectId;
    late List<int> stageIds;

    Future<ActivityEvent> record(
      ActivityType type,
      String targetType, {
      int? targetId,
      Map<String, String>? payload,
    }) => const ActivityService().record(
      sessionBuilder.build(),
      projectId: projectId,
      actorId: ownerId,
      type: type,
      targetType: targetType,
      targetId: targetId,
      payload: payload,
    );

    setUp(() async {
      projectId = (await endpoints.project.create(
        owner,
        ProjectDetails(
          name: 'House in Bafoussam',
          type: ProjectType.newHouse,
          currencyCode: 'XAF',
        ),
        stages: [
          for (final name in ['Foundation', 'Walls'])
            StageDraft(
              name: name,
              budgetMinor: 0,
              items: [ChecklistItemDraft(label: 'Shot', isRequired: true)],
            ),
        ],
      )).project.id!;
      stageIds = [
        for (final view in (await endpoints.stage.plan(
          owner,
          projectId,
        )).stages)
          view.stage.id!,
      ];
    });

    Future<List<ActivityType>> types({
      List<ActivityType>? types,
      int? stageId,
      int? beforeId,
      int? pageSize,
    }) async => [
      for (final entry in (await endpoints.activity.list(
        owner,
        projectId,
        types: types,
        stageId: stageId,
        beforeId: beforeId,
        pageSize: pageSize,
      )).items)
        entry.event.type,
    ];

    test('when an event is recorded then its stage is stored', () async {
      final started = await record(
        ActivityType.stageStarted,
        'stage',
        targetId: stageIds.first,
      );
      final photo = await record(
        ActivityType.evidenceCaptured,
        'evidence',
        targetId: 99,
        payload: {'stageId': '${stageIds.last}'},
      );

      expect(started.stageId, stageIds.first);
      expect(photo.stageId, stageIds.last);
    });

    test('when kinds are chosen then only those events come', () async {
      await record(ActivityType.stageStarted, 'stage', targetId: stageIds[0]);
      await record(
        ActivityType.evidenceCaptured,
        'evidence',
        payload: {'stageId': '${stageIds[0]}'},
      );
      await record(ActivityType.memberJoined, 'member');

      expect(
        await types(
          types: [ActivityType.evidenceCaptured, ActivityType.memberJoined],
        ),
        [ActivityType.memberJoined, ActivityType.evidenceCaptured],
      );
      // An empty choice filters nothing.
      expect(await types(types: []), hasLength(greaterThan(3)));
    });

    test('when a stage is chosen then only its events come, and pages '
        'follow the filtered list', () async {
      await record(ActivityType.stageStarted, 'stage', targetId: stageIds[0]);
      final mine = await record(
        ActivityType.evidenceCaptured,
        'evidence',
        payload: {'stageId': '${stageIds[0]}'},
      );
      await record(ActivityType.stageStarted, 'stage', targetId: stageIds[1]);
      await record(
        ActivityType.stageSubmitted,
        'stage',
        targetId: stageIds[0],
      );

      expect(await types(stageId: stageIds[0]), [
        ActivityType.stageSubmitted,
        ActivityType.evidenceCaptured,
        ActivityType.stageStarted,
      ]);
      expect(await types(stageId: stageIds[0], beforeId: mine.id), [
        ActivityType.stageStarted,
      ]);
      expect(
        await types(
          stageId: stageIds[0],
          types: [ActivityType.evidenceCaptured],
        ),
        [ActivityType.evidenceCaptured],
      );
    });
  });

  withServerpod('Given read and unread notifications', (
    sessionBuilder,
    endpoints,
  ) {
    final owner = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        ownerId.uuid,
        {},
      ),
    );

    Future<AppNotification> notify(String name, {bool read = false}) =>
        AppNotification.db.insertRow(
          sessionBuilder.build(),
          AppNotification(
            userId: ownerId,
            type: NotificationType.stageSubmitted,
            payload: {'stageName': name},
            readAt: read ? DateTime.now().toUtc() : null,
            createdAt: DateTime.now().toUtc(),
          ),
        );

    test('when only the unread are asked then the read ones are left out, '
        'with the same unread count', () async {
      final a = await notify('A');
      await notify('B', read: true);
      final c = await notify('C');

      final unread = await endpoints.notification.list(owner, unreadOnly: true);
      final all = await endpoints.notification.list(owner);

      expect(unread.items.map((n) => n.id), [c.id, a.id]);
      expect(unread.unreadCount, 2);
      expect(all.items, hasLength(3));
      expect(
        (await endpoints.notification.list(
          owner,
          unreadOnly: true,
          beforeId: c.id,
        )).items.map((n) => n.id),
        [a.id],
      );
    });
  });
}
