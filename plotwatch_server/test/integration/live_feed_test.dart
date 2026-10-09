import 'dart:async';

import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:plotwatch_server/src/services/activity_service.dart';
import 'package:plotwatch_server/src/services/live_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Plan: doc/04e-m5-review-realtime.md, group B (decisions M5-4, M5-5):
// pages of the feed and of notifications, and live streams that catch up
// without gaps or duplicates (AC-6, marked ★).
void main() {
  final ownerId = UuidValue.fromString('00000000-0000-4000-8000-000000000001');
  final managerId = UuidValue.fromString(
    '00000000-0000-4000-8000-000000000002',
  );
  final strangerId = UuidValue.fromString(
    '00000000-0000-4000-8000-000000000005',
  );

  // Fast ticks so the tests don't wait 3 s each time.
  setUpAll(() => LiveService.tick = const Duration(milliseconds: 100));
  tearDownAll(() => LiveService.tick = LiveService.defaultTick);

  /// Waits until [condition] holds, or fails after [timeout].
  Future<void> until(
    bool Function() condition, {
    Duration timeout = const Duration(seconds: 5),
  }) async {
    final deadline = DateTime.now().add(timeout);
    while (!condition()) {
      if (DateTime.now().isAfter(deadline)) {
        fail('Condition not met within $timeout');
      }
      await Future<void>.delayed(const Duration(milliseconds: 20));
    }
  }

  // Streams and concurrent transactions need committed data.
  withServerpod(
    'Given a project and its feed',
    (sessionBuilder, endpoints) {
      late int projectId;

      TestSessionBuilder signedInAs(UuidValue userId) =>
          sessionBuilder.copyWith(
            authentication: AuthenticationOverride.authenticationInfo(
              userId.uuid,
              {},
            ),
          );

      /// An activity event written as the services write them.
      Future<ActivityEvent> record(String name, {Transaction? transaction}) =>
          const ActivityService().record(
            sessionBuilder.build(),
            projectId: projectId,
            actorId: ownerId,
            type: ActivityType.projectUpdated,
            targetType: 'project',
            targetId: projectId,
            payload: {'name': name},
            transaction: transaction,
          );

      setUp(() async {
        projectId = (await endpoints.project.create(
          signedInAs(ownerId),
          ProjectDetails(
            name: 'House in Bafoussam',
            type: ProjectType.newHouse,
            currencyCode: 'XAF',
          ),
        )).project.id!;
        await ProjectMember.db.insertRow(
          sessionBuilder.build(),
          ProjectMember(
            projectId: projectId,
            authUserId: managerId,
            role: ProjectRole.siteManager,
            status: MemberStatus.active,
            joinedAt: DateTime.now().toUtc(),
          ),
        );
      });

      test('when the feed is paged then pages follow each other without '
          'overlap, newest first', () async {
        for (var i = 0; i < 4; i++) {
          await record('event $i');
        }

        final first = await endpoints.activity.list(
          signedInAs(managerId),
          projectId,
          pageSize: 3,
        );
        final second = await endpoints.activity.list(
          signedInAs(managerId),
          projectId,
          beforeId: first.items.last.event.id,
          pageSize: 3,
        );
        final ids = [
          for (final entry in [...first.items, ...second.items])
            entry.event.id!,
        ];

        expect(first.items, hasLength(3));
        expect(ids.toSet(), hasLength(ids.length));
        expect(ids, [...ids]..sort((a, b) => b.compareTo(a)));
        // Project creation wrote one event, plus the four above.
        expect(ids, hasLength(5));
      });

      test('★ when a member watches from an event then the missed events '
          'come first, oldest first, then the new ones, each once', () async {
        final seen = await record('seen');
        final missed1 = await record('missed 1');
        final missed2 = await record('missed 2');
        final received = <int>[];
        final subscription = endpoints.activity
            .watch(signedInAs(managerId), projectId, afterId: seen.id)
            .listen((entry) => received.add(entry.event.id!));
        await until(() => received.length == 2);

        final live = await record('live');
        await until(() => received.length == 3);
        await Future<void>.delayed(const Duration(milliseconds: 400));
        await subscription.cancel();

        expect(received, [missed1.id, missed2.id, live.id]);
      });

      test('★ when an event commits after a newer one then it still arrives, '
          'once', () async {
        final received = <int>[];
        final subscription = endpoints.activity
            .watch(signedInAs(managerId), projectId)
            .listen((entry) => received.add(entry.event.id!));
        await Future<void>.delayed(const Duration(milliseconds: 300));
        final initial = received.length;

        // A slow transaction takes an ID, a quick one takes the next ID and
        // commits first: the stream sees the newer event before the older.
        final release = Completer<void>();
        late ActivityEvent slow;
        final slowDone = sessionBuilder.build().db.transaction((tx) async {
          slow = await record('slow', transaction: tx);
          await release.future;
        });
        await Future<void>.delayed(const Duration(milliseconds: 50));
        final quick = await record('quick');
        await until(() => received.contains(quick.id));
        release.complete();
        await slowDone;
        await until(() => received.contains(slow.id));
        await Future<void>.delayed(const Duration(milliseconds: 400));
        await subscription.cancel();

        expect(slow.id! < quick.id!, isTrue);
        expect(received.sublist(initial), unorderedEquals([quick.id, slow.id]));
        expect(received.toSet(), hasLength(received.length));
      });

      test(
        'when a non-member watches then it fails with projectNotFound',
        () async {
          await expectLater(
            endpoints.activity.watch(signedInAs(strangerId), projectId).first,
            throwsA(_appException(AppErrorCode.projectNotFound)),
          );
        },
      );

      test('when a member is removed while watching then the stream ends '
          'with projectNotFound', () async {
        final errors = <Object>[];
        final subscription = endpoints.activity
            .watch(signedInAs(managerId), projectId)
            .listen((_) {}, onError: errors.add);
        await Future<void>.delayed(const Duration(milliseconds: 200));

        final session = sessionBuilder.build();
        final member = (await ProjectMember.db.findFirstRow(
          session,
          // This file keeps data between tests: the membership of this
          // project, not of an earlier one.
          where: (t) =>
              t.authUserId.equals(managerId) & t.projectId.equals(projectId),
        ))!;
        await ProjectMember.db.updateRow(
          session,
          member.copyWith(status: MemberStatus.removed),
        );
        await until(() => errors.isNotEmpty);
        await subscription.cancel();

        // The test tools then report the closed connection as a second error.
        expect(errors.first, _appException(AppErrorCode.projectNotFound));
      });

      group('when notifications are read', () {
        // This file keeps data between tests: start each from no
        // notifications.
        setUp(() async {
          await AppNotification.db.deleteWhere(
            sessionBuilder.build(),
            where: (t) => t.id > 0,
          );
        });

        Future<AppNotification> notify(UuidValue userId, String name) =>
            AppNotification.db.insertRow(
              sessionBuilder.build(),
              AppNotification(
                userId: userId,
                projectId: projectId,
                type: NotificationType.stageSubmitted,
                payload: {'stageName': name},
                createdAt: DateTime.now().toUtc(),
              ),
            );

        test('then each user sees only theirs, newest first, with the unread '
            'count', () async {
          final older = await notify(ownerId, 'A');
          final newer = await notify(ownerId, 'B');
          await notify(managerId, 'C');

          final page = await endpoints.notification.list(signedInAs(ownerId));

          expect(page.items.map((n) => n.id), [newer.id, older.id]);
          expect(page.unreadCount, 2);
        });

        test('then marking one, then all, read lowers the count', () async {
          final one = await notify(ownerId, 'A');
          await notify(ownerId, 'B');

          await endpoints.notification.markRead(signedInAs(ownerId), one.id!);
          expect(
            await endpoints.notification.unreadCount(signedInAs(ownerId)),
            1,
          );
          await endpoints.notification.markAllRead(signedInAs(ownerId));
          expect(
            await endpoints.notification.unreadCount(signedInAs(ownerId)),
            0,
          );
        });

        test('then marking someone else\'s notification throws '
            'notificationNotFound', () async {
          final theirs = await notify(managerId, 'C');

          await expectLater(
            endpoints.notification.markRead(signedInAs(ownerId), theirs.id!),
            throwsA(_appException(AppErrorCode.notificationNotFound)),
          );
        });

        test(
          '★ then a user watching gets only their own new ones, once',
          () async {
            final received = <int>[];
            final subscription = endpoints.notification
                .watch(signedInAs(ownerId))
                .listen((n) => received.add(n.id!));
            await Future<void>.delayed(const Duration(milliseconds: 200));

            final mine = await notify(ownerId, 'A');
            await notify(managerId, 'B');
            await until(() => received.contains(mine.id));
            await Future<void>.delayed(const Duration(milliseconds: 400));
            await subscription.cancel();

            expect(received, [mine.id]);
          },
        );
      });
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}

Matcher _appException(AppErrorCode code) =>
    isA<AppException>().having((e) => e.code, 'code', code);
