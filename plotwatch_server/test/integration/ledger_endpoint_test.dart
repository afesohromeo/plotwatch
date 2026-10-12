import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Plan: doc/04f-m6-ledger.md, group A and B (LED-01–04, 06; AC-5).
void main() {
  final ownerId = UuidValue.fromString('00000000-0000-4000-8000-000000000001');
  final managerId = UuidValue.fromString(
    '00000000-0000-4000-8000-000000000002',
  );
  final coFunderId = UuidValue.fromString(
    '00000000-0000-4000-8000-000000000003',
  );
  final viewerId = UuidValue.fromString('00000000-0000-4000-8000-000000000004');

  withServerpod('Given a project with a site manager, a co-funder and a '
      'viewer', (sessionBuilder, endpoints) {
    TestSessionBuilder signedInAs(UuidValue userId) => sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        userId.uuid,
        {},
      ),
    );
    final owner = signedInAs(ownerId);
    final manager = signedInAs(managerId);
    final coFunder = signedInAs(coFunderId);
    final viewer = signedInAs(viewerId);

    late int projectId;
    late int wallsId;
    final today = DateTime.now().toUtc();

    ReleaseDraft release(int amount, {int? stageId}) => ReleaseDraft(
      amountMinor: amount,
      occurredOn: today,
      method: ReleaseMethod.mobileMoney,
      reference: 'TX-1',
      stageId: stageId,
    );

    ExpenseDraft expense(
      int amount, {
      int? stageId,
      String? path,
      String? hash,
    }) => ExpenseDraft(
      amountMinor: amount,
      occurredOn: today,
      category: ExpenseCategory.materials,
      description: 'Cement',
      vendor: 'Quincaillerie Akwa',
      stageId: stageId,
      receiptPath: path,
      receiptSha256: hash,
    );

    /// A receipt photo stored where the app would have uploaded it.
    Future<(String, String)> storedReceipt() async {
      final upload = await endpoints.ledger.receiptUpload(manager, projectId);
      final bytes = Uint8List.fromList(List.generate(64, (i) => i));
      await sessionBuilder.build().storage.storeFile(
        storageId: 'private',
        path: upload.path,
        byteData: ByteData.sublistView(bytes),
      );
      return (upload.path, sha256.convert(bytes).toString());
    }

    setUp(() async {
      projectId = (await endpoints.project.create(
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
            items: [ChecklistItemDraft(label: 'Shot', isRequired: true)],
          ),
        ],
      )).project.id!;
      wallsId = (await endpoints.stage.plan(
        owner,
        projectId,
      )).stages.single.stage.id!;
      final session = sessionBuilder.build();
      for (final (id, role, canApprove) in [
        (managerId, ProjectRole.siteManager, false),
        (coFunderId, ProjectRole.coFunder, false),
        (viewerId, ProjectRole.viewer, false),
      ]) {
        await ProjectMember.db.insertRow(
          session,
          ProjectMember(
            projectId: projectId,
            authUserId: id,
            role: role,
            canApprove: canApprove,
            status: MemberStatus.active,
            joinedAt: DateTime.now().toUtc(),
          ),
        );
      }
    });

    test('when AC-5 is played then the summary shows its numbers for '
        'everyone', () async {
      await endpoints.ledger.recordRelease(
        owner,
        projectId,
        release(500000, stageId: wallsId),
      );
      final (path, hash) = await storedReceipt();
      await endpoints.ledger.recordExpense(
        manager,
        projectId,
        expense(300000, stageId: wallsId, path: path, hash: hash),
      );
      await endpoints.ledger.recordExpense(
        manager,
        projectId,
        expense(50000, stageId: wallsId),
      );

      for (final who in [owner, manager, viewer]) {
        final total = (await endpoints.ledger.summary(who, projectId)).total;
        expect(total.releasedMinor, 500000);
        expect(total.spentMinor, 350000);
        expect(total.spentWithReceiptMinor, 300000);
        expect(total.unaccountedMinor, 200000);
        expect(total.remainingMinor, 500000);
      }
    });

    test('when the wrong role records then it is refused', () async {
      for (final call in [
        () => endpoints.ledger.recordRelease(manager, projectId, release(1)),
        () => endpoints.ledger.recordRelease(coFunder, projectId, release(1)),
        () => endpoints.ledger.recordRelease(viewer, projectId, release(1)),
        () => endpoints.ledger.recordExpense(owner, projectId, expense(1)),
        () => endpoints.ledger.recordExpense(viewer, projectId, expense(1)),
      ]) {
        await expectLater(
          call(),
          throwsA(_appException(AppErrorCode.permissionDenied)),
        );
      }
    });

    test('when a co-funder may approve then they can record a release',
        () async {
      final session = sessionBuilder.build();
      final member = await ProjectMember.db.findFirstRow(
        session,
        where: (t) =>
            t.projectId.equals(projectId) & t.authUserId.equals(coFunderId),
      );
      await ProjectMember.db.updateRow(
        session,
        member!.copyWith(canApprove: true),
      );

      final entry = await endpoints.ledger.recordRelease(
        coFunder,
        projectId,
        release(1000),
      );
      expect(entry.kind, LedgerEntryKind.release);
    });

    test('when the receipt does not match its hash then the expense is '
        'refused', () async {
      final (path, _) = await storedReceipt();

      await expectLater(
        endpoints.ledger.recordExpense(
          manager,
          projectId,
          expense(1000, path: path, hash: 'b' * 64),
        ),
        throwsA(_appException(AppErrorCode.invalidLedgerEntry)),
      );
      await expectLater(
        endpoints.ledger.recordExpense(
          manager,
          projectId,
          expense(
            1000,
            path: 'projects/999/receipts/x.jpg',
            hash: 'b' * 64,
          ),
        ),
        throwsA(_appException(AppErrorCode.invalidLedgerEntry)),
      );
    });

    test('when a release is confirmed then it is once, by the site manager',
        () async {
      final entry = await endpoints.ledger.recordRelease(
        owner,
        projectId,
        release(1000),
      );

      await expectLater(
        endpoints.ledger.confirmRelease(owner, projectId, entry.id!),
        throwsA(_appException(AppErrorCode.permissionDenied)),
      );
      final confirmed = await endpoints.ledger.confirmRelease(
        manager,
        projectId,
        entry.id!,
      );
      expect(confirmed.confirmedBy, managerId);
      expect(confirmed.confirmedAt, isNotNull);
      await expectLater(
        endpoints.ledger.confirmRelease(manager, projectId, entry.id!),
        throwsA(_appException(AppErrorCode.alreadyConfirmed)),
      );
    });

    test('when an entry is reversed then only by its recorder, once, and '
        'both stay listed', () async {
      final entry = await endpoints.ledger.recordExpense(
        manager,
        projectId,
        expense(30000, stageId: wallsId),
      );

      await expectLater(
        endpoints.ledger.reverse(owner, projectId, entry.id!, 'Typo'),
        throwsA(_appException(AppErrorCode.permissionDenied)),
      );
      final reversal = await endpoints.ledger.reverse(
        manager,
        projectId,
        entry.id!,
        'Typo: it was 300,000',
      );
      expect(reversal.amountMinor, -30000);
      expect(reversal.reversesId, entry.id);
      expect(reversal.note, 'Typo: it was 300,000');
      await expectLater(
        endpoints.ledger.reverse(manager, projectId, entry.id!, 'Again'),
        throwsA(_appException(AppErrorCode.alreadyReversed)),
      );
      await expectLater(
        endpoints.ledger.reverse(manager, projectId, reversal.id!, 'Undo'),
        throwsA(_appException(AppErrorCode.invalidLedgerEntry)),
      );

      final items = (await endpoints.ledger.list(viewer, projectId)).items;
      expect(items.map((e) => e.id), [reversal.id, entry.id]);
      expect(items.last.reversedById, reversal.id);
      expect(items.last.reversalReason, 'Typo: it was 300,000');
      final summary = await endpoints.ledger.summary(owner, projectId);
      expect(summary.total.spentMinor, 0);
    });

    test('when the list is filtered then only that kind and stage come, '
        'page by page', () async {
      final a = await endpoints.ledger.recordRelease(
        owner,
        projectId,
        release(1, stageId: wallsId),
      );
      await endpoints.ledger.recordExpense(manager, projectId, expense(2));
      final b = await endpoints.ledger.recordRelease(
        owner,
        projectId,
        release(3),
      );
      final c = await endpoints.ledger.recordRelease(
        owner,
        projectId,
        release(4, stageId: wallsId),
      );

      Future<List<int?>> ids({
        LedgerEntryKind? kind,
        int? stageId,
        int? beforeId,
        int? pageSize,
      }) async => [
        for (final e in (await endpoints.ledger.list(
          viewer,
          projectId,
          kind: kind,
          stageId: stageId,
          beforeId: beforeId,
          pageSize: pageSize,
        )).items)
          e.id,
      ];

      expect(await ids(kind: LedgerEntryKind.release), [c.id, b.id, a.id]);
      expect(await ids(stageId: wallsId), [c.id, a.id]);
      expect(
        await ids(kind: LedgerEntryKind.release, pageSize: 2),
        [c.id, b.id],
      );
      expect(
        await ids(kind: LedgerEntryKind.release, beforeId: b.id),
        [a.id],
      );
    });

    test('when an entry is written then the feed and the other side hear of '
        'it', () async {
      final entry = await endpoints.ledger.recordRelease(
        owner,
        projectId,
        release(500000, stageId: wallsId),
      );

      final feed = (await endpoints.activity.list(owner, projectId)).items;
      expect(feed.first.event.type, ActivityType.fundReleased);
      expect(feed.first.event.stageId, wallsId);
      final notifications = (await endpoints.notification.list(
        manager,
      )).items;
      expect(notifications.first.type, NotificationType.fundReleased);
      expect(notifications.first.payload?['entryId'], '${entry.id}');
      expect(notifications.first.payload?['amountMinor'], '500000');
    });

    test('when an expense comes after its stage was approved then it is '
        'marked, before it is not', () async {
      final before = await endpoints.ledger.recordExpense(
        manager,
        projectId,
        expense(1000, stageId: wallsId),
      );
      final session = sessionBuilder.build();
      final stage = await Stage.db.findById(session, wallsId);
      await Stage.db.updateRow(
        session,
        stage!.copyWith(
          status: StageStatus.approved,
          approvedAt: DateTime.now().toUtc(),
        ),
      );
      final after = await endpoints.ledger.recordExpense(
        manager,
        projectId,
        expense(2000, stageId: wallsId),
      );

      final items = {
        for (final e in (await endpoints.ledger.list(owner, projectId)).items)
          e.id: e,
      };
      expect(items[after.id]?.afterApproval, isTrue);
      expect(items[before.id]?.afterApproval, isFalse);
    });

    test('when the project is completed then nothing more is recorded',
        () async {
      final session = sessionBuilder.build();
      final project = await Project.db.findById(session, projectId);
      await Project.db.updateRow(
        session,
        project!.copyWith(status: ProjectStatus.completed),
      );

      await expectLater(
        endpoints.ledger.recordRelease(owner, projectId, release(1)),
        throwsA(_appException(AppErrorCode.projectNotEditable)),
      );
      expect(
        (await endpoints.ledger.summary(viewer, projectId)).total.releasedMinor,
        0,
      );
    });
  });
}

Matcher _appException(AppErrorCode code) =>
    isA<AppException>().having((e) => e.code, 'code', code);
