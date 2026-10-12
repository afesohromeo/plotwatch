import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:image/image.dart' as img;
import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Plan: doc/04g-m8-hardening.md, step 1: the whole loop in one sequence,
// AC-1 to AC-5 (doc/03 §6), through the endpoints only.
void main() {
  final ownerId = UuidValue.fromString('00000000-0000-4000-8000-000000000001');
  final managerId = UuidValue.fromString(
    '00000000-0000-4000-8000-000000000002',
  );
  const siteLat = 5.4778;
  const siteLng = 10.4176;

  final photo = Uint8List.fromList(
    img.encodeJpg(img.Image(width: 640, height: 480), quality: 80),
  );
  final photoHash = sha256.convert(photo).toString();

  withServerpod('Given a funder abroad and a site manager on the plot', (
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
    final manager = signedInAs(managerId);

    test('when they go through the loop then every step holds and the '
        'ledger shows AC-5\'s numbers', () async {
      // AC-1: the project with its plan.
      final project = (await endpoints.project.create(
        owner,
        ProjectDetails(
          name: 'Maison Douala',
          type: ProjectType.newHouse,
          currencyCode: 'XAF',
        ),
        stages: [
          StageDraft(
            name: 'Walls',
            budgetMinor: 1000000,
            items: [ChecklistItemDraft(label: 'Wide shot', isRequired: true)],
          ),
        ],
      )).project;
      final projectId = project.id!;
      expect(project.status, ProjectStatus.draft);

      // AC-2: the site manager joins with the code.
      final invitation = await endpoints.membership.createInvitation(
        owner,
        projectId,
        ProjectRole.siteManager,
      );
      final member = await endpoints.membership.acceptInvitation(
        manager,
        invitation.code,
      );
      expect(member.role, ProjectRole.siteManager);

      // The site: proposed on the plot, validated by the owner.
      final proposal = await endpoints.site.propose(
        manager,
        projectId,
        lat: siteLat,
        lng: siteLng,
        accuracyM: 6,
        isMocked: false,
      );
      await endpoints.site.validate(
        owner,
        projectId,
        proposal.id!,
        radiusM: 50,
      );
      expect(
        (await endpoints.project.get(owner, projectId)).project.status,
        ProjectStatus.active,
      );

      // AC-3: a verified capture on the plot.
      final stage = (await endpoints.stage.plan(
        manager,
        projectId,
      )).stages.single;
      final commit = await endpoints.evidence.commit(
        manager,
        projectId,
        EvidenceCommit(
          stageId: stage.stage.id!,
          checklistItemId: stage.items.single.id!,
          sha256: photoHash,
          deviceCapturedAt: DateTime.now().toUtc(),
          lat: siteLat,
          lng: siteLng,
          accuracyM: 8,
          altitudeM: 700,
          isMockLocation: false,
          capturedInApp: true,
          deviceModel: 'Pixel 7',
          osVersion: 'Android 15',
          appVersion: '1.0.0',
        ),
      );
      await sessionBuilder.build().storage.storeFile(
        storageId: 'private',
        path: 'projects/$projectId/evidence/${commit.evidence.id}/photo.jpg',
        byteData: ByteData.sublistView(photo),
      );
      final evidence = await endpoints.evidence.finalize(
        manager,
        projectId,
        commit.evidence.id!,
      );
      expect(evidence.verificationLevel, VerificationLevel.verified);

      // AC-4: submitted, then approved.
      await endpoints.stage.submit(manager, projectId, stage.stage.id!);
      final approved = await endpoints.stage.review(
        owner,
        projectId,
        stage.stage.id!,
        ReviewDecision.approved,
      );
      expect(approved.stage.status, StageStatus.approved);

      // AC-5: a release, an expense with a receipt, one without.
      await endpoints.ledger.recordRelease(
        owner,
        projectId,
        ReleaseDraft(
          amountMinor: 500000,
          occurredOn: DateTime.now().toUtc(),
          method: ReleaseMethod.mobileMoney,
          stageId: stage.stage.id,
        ),
      );
      final upload = await endpoints.ledger.receiptUpload(manager, projectId);
      final receipt = Uint8List.fromList(List.generate(64, (i) => i));
      await sessionBuilder.build().storage.storeFile(
        storageId: 'private',
        path: upload.path,
        byteData: ByteData.sublistView(receipt),
      );
      for (final (amount, withReceipt) in [(300000, true), (50000, false)]) {
        await endpoints.ledger.recordExpense(
          manager,
          projectId,
          ExpenseDraft(
            amountMinor: amount,
            occurredOn: DateTime.now().toUtc(),
            category: ExpenseCategory.materials,
            description: 'Cement',
            stageId: stage.stage.id,
            receiptPath: withReceipt ? upload.path : null,
            receiptSha256: withReceipt
                ? sha256.convert(receipt).toString()
                : null,
          ),
        );
      }

      // The same numbers on both sides.
      for (final who in [owner, manager]) {
        final total = (await endpoints.ledger.summary(who, projectId)).total;
        expect(total.releasedMinor, 500000);
        expect(total.spentMinor, 350000);
        expect(total.spentWithReceiptMinor, 300000);
        expect(total.unaccountedMinor, 200000);
      }

      // And it all happened in the feed, newest first.
      final types = [
        for (final entry in (await endpoints.activity.list(
          owner,
          projectId,
          pageSize: 50,
        )).items)
          entry.event.type,
      ];
      expect(
        types,
        containsAllInOrder([
          ActivityType.expenseRecorded,
          ActivityType.fundReleased,
          ActivityType.stageApproved,
          ActivityType.stageSubmitted,
          ActivityType.evidenceCaptured,
          ActivityType.memberJoined,
          ActivityType.projectCreated,
        ]),
      );
    });
  });
}
