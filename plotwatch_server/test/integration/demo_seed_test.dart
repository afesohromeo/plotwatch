import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:plotwatch_server/src/seed/demo_seed.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Plan: doc/04g-m8-hardening.md, step 7 (the judges' demo project).
void main() {
  const password = 'Demo-Pass-2026';

  setUp(() {
    AuthServices.set(
      tokenManagerBuilders: [
        ServerSideSessionsConfig(sessionKeyHashPepper: 'test-pepper'),
      ],
      identityProviderBuilders: [
        EmailIdpConfig(secretHashPepper: 'test-pepper'),
      ],
    );
  });

  // Small stand-ins: the seed only needs files it can hash and thumbnail.
  final photo = Uint8List.fromList(
    img.encodeJpg(img.Image(width: 64, height: 48), quality: 80),
  );
  final receipt = Uint8List.fromList(List.generate(64, (i) => i));

  // The auth module's sign-in runs in a transaction of its own (rate
  // limiter), so the database is not rolled back.
  withServerpod(
    'Given an empty server',
    (sessionBuilder, endpoints) {
      final session = sessionBuilder.build();
      final now = DateTime.now().toUtc();

      DemoSeed seed() => DemoSeed(
        photo: (_) => photo,
        receipt: (_) => receipt,
        now: now,
      );

      test('when the demo is seeded twice then it tells its story once, '
          'and the three accounts can sign in', () async {
        expect(await seed().run(session, password: password), DemoSeedOutcome.created);
        expect(
          await seed().run(session, password: password),
          DemoSeedOutcome.alreadyThere,
        );

        final projects = await Project.db.find(
          session,
          where: (t) => t.name.equals(DemoSeed.projectName),
        );
        expect(projects, hasLength(1));
        final project = projects.single;
        expect(project.status, ProjectStatus.active);
        // Six weeks ago, not today.
        expect(
          now.difference(project.createdAt).inDays,
          inInclusiveRange(41, 42),
        );

        final stages = await Stage.db.find(
          session,
          where: (t) => t.projectId.equals(project.id!),
          orderBy: (t) => t.orderIndex,
        );
        expect([for (final stage in stages) stage.status], [
          StageStatus.approved,
          StageStatus.approved,
          StageStatus.submitted,
          StageStatus.notStarted,
          StageStatus.notStarted,
          StageStatus.notStarted,
        ]);

        final photos = await Evidence.db.find(
          session,
          where: (t) => t.projectId.equals(project.id!),
        );
        expect(photos, hasLength(8));
        expect(
          photos.where((e) => e.verificationLevel == VerificationLevel.verified),
          hasLength(7),
        );
        expect(
          photos.where(
            (e) => e.verificationLevel == VerificationLevel.partiallyVerified,
          ),
          hasLength(1),
        );

        // AC-5's numbers, and the unaccounted alert.
        final owner = await EmailAccount.db.findFirstRow(
          session,
          where: (t) => t.email.equals(DemoSeed.owner.email),
        );
        final summary = await endpoints.ledger.summary(
          sessionBuilder.copyWith(
            authentication: AuthenticationOverride.authenticationInfo(
              owner!.authUserId.uuid,
              {},
            ),
          ),
          project.id!,
        );
        expect(summary.total.releasedMinor, 47500000);
        expect(summary.total.spentMinor, 20650000);
        expect(summary.total.spentWithReceiptMinor, 14100000);
        expect(summary.unaccountedAlert, isTrue);

        for (final person in [
          DemoSeed.owner,
          DemoSeed.manager,
          DemoSeed.coFunder,
        ]) {
          final success = await endpoints.emailIdp.login(
            sessionBuilder,
            email: person.email,
            password: password,
          );
          expect(success.authUserId, isNotNull);
        }
      });
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );

  // On Cloud the photos were missing and the half-made project stayed
  // behind; the next start skipped it (developer, 2026-10-13).
  Future<List<Project>> demoProjects(Session session) => Project.db.find(
    session,
    where: (t) => t.name.equals(DemoSeed.projectName),
  );

  withServerpod(
    'Given a file missing on the server',
    (sessionBuilder, endpoints) {
      test('when the demo is seeded then it stops before writing anything', () async {
        final session = sessionBuilder.build();
        final seed = DemoSeed(
          photo: (name) => name == 'ground_floor_3.jpg'
              ? throw const FileSystemException('missing')
              : photo,
          receipt: (_) => receipt,
        );

        await expectLater(
          seed.run(session, password: password),
          throwsA(isA<FileSystemException>()),
        );
        expect(await demoProjects(session), isEmpty);
        expect(
          await EmailAccount.db.count(
            session,
            where: (t) => t.email.equals(DemoSeed.owner.email),
          ),
          0,
        );
      });
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );

  withServerpod(
    'Given a seed that fails halfway',
    (sessionBuilder, endpoints) {
      test('when it fails then no half-made project stays, and the next start '
          'seeds it all', () async {
        final session = sessionBuilder.build();
        var reads = 0;
        // The first reads are the up-front check; it fails at the third
        // photo of the story.
        final failing = DemoSeed(
          photo: (_) => ++reads > DemoSeed.photoFiles.length + 3
              ? throw StateError('disk error')
              : photo,
          receipt: (_) => receipt,
        );

        await expectLater(
          failing.run(session, password: password),
          throwsA(isA<StateError>()),
        );
        expect(await demoProjects(session), isEmpty);

        final seed = DemoSeed(photo: (_) => photo, receipt: (_) => receipt);
        expect(await seed.run(session, password: password), DemoSeedOutcome.created);
        expect(await demoProjects(session), hasLength(1));
      });
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );

  withServerpod(
    'Given an incomplete demo project left by an older seed',
    (sessionBuilder, endpoints) {
      test('when the server starts then it is replaced by the full story', () async {
        final session = sessionBuilder.build();
        final seed = DemoSeed(photo: (_) => photo, receipt: (_) => receipt);
        expect(await seed.run(session, password: password), DemoSeedOutcome.created);
        final first = (await demoProjects(session)).single;
        // What Cloud had: the project, without the story's last step.
        await Invitation.db.deleteWhere(
          session,
          where: (t) => t.projectId.equals(first.id!),
        );

        expect(await seed.run(session, password: password), DemoSeedOutcome.created);

        final projects = await demoProjects(session);
        expect(projects, hasLength(1));
        expect(projects.single.id, isNot(first.id));
      });
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );

  withServerpod(
    'Given two servers starting together, as during a Cloud rollout',
    (sessionBuilder, endpoints) {
      test('when both seed then only one tells the story', () async {
        DemoSeed seed() =>
            DemoSeed(photo: (_) => photo, receipt: (_) => receipt);

        final results = await Future.wait([
          seed().run(sessionBuilder.build(), password: password),
          seed().run(sessionBuilder.build(), password: password),
        ]);

        expect(
          results.where((outcome) => outcome == DemoSeedOutcome.created),
          hasLength(1),
        );
        expect(await demoProjects(sessionBuilder.build()), hasLength(1));
      });
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}
