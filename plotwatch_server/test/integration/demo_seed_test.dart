import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:plotwatch_server/src/seed/demo_seed.dart';
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
        expect(await seed().run(session, password: password), isTrue);
        expect(await seed().run(session, password: password), isFalse);

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
}
