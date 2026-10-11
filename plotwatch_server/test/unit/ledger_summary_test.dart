import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:plotwatch_server/src/services/ledger_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

// Plan: doc/04f-m6-ledger.md, M6-7 and M6-8 (LED-04, LED-05, AC-5).
void main() {
  final someone = UuidValue.fromString('00000000-0000-4000-8000-000000000001');
  final day = DateTime.utc(2026, 10, 11);
  var nextId = 1;

  Stage stage(int id, String name, int budget) => Stage(
    id: id,
    projectId: 1,
    orderIndex: id,
    name: name,
    budgetMinor: budget,
    status: StageStatus.inProgress,
    createdAt: day,
    updatedAt: day,
  );

  LedgerEntry release(int amount, {int? stageId, int? reverses}) => LedgerEntry(
    id: nextId++,
    projectId: 1,
    stageId: stageId,
    kind: LedgerEntryKind.release,
    amountMinor: amount,
    occurredOn: day,
    recordedBy: someone,
    method: ReleaseMethod.mobileMoney,
    reversesId: reverses,
    createdAt: day,
  );

  LedgerEntry expense(
    int amount, {
    int? stageId,
    bool receipt = false,
    int? reverses,
  }) => LedgerEntry(
    id: nextId++,
    projectId: 1,
    stageId: stageId,
    kind: LedgerEntryKind.expense,
    amountMinor: amount,
    occurredOn: day,
    recordedBy: someone,
    category: ExpenseCategory.materials,
    description: 'Cement',
    receiptPath: receipt ? 'projects/1/receipts/r.jpg' : null,
    receiptSha256: receipt ? 'a' * 64 : null,
    reversesId: reverses,
    createdAt: day,
  );

  final stages = [stage(1, 'Foundation', 600000), stage(2, 'Walls', 400000)];

  test('Given AC-5 then released, spent, with receipt and unaccounted are '
      'exact, per stage and for the project', () {
    final summary = LedgerService.summarize(
      stages: stages,
      entries: [
        release(500000, stageId: 2),
        expense(300000, stageId: 2, receipt: true),
        expense(50000, stageId: 2),
      ],
    );

    final walls = summary.stages.last;
    expect(walls.releasedMinor, 500000);
    expect(walls.spentMinor, 350000);
    expect(walls.spentWithReceiptMinor, 300000);
    expect(walls.unaccountedMinor, 200000);
    expect(walls.remainingMinor, -100000);
    expect(summary.total.budgetMinor, 1000000);
    expect(summary.total.unaccountedMinor, 200000);
    expect(summary.total.remainingMinor, 500000);
    expect(summary.stages.first.releasedMinor, 0);
    expect(summary.unassigned, isNull);
    // 200,000 is 40 % of 500,000: above 20 % (LED-05).
    expect(summary.unaccountedAlert, isTrue);
  });

  test('Given reversals then they count by their sign, a reversed receipt '
      'included', () {
    final withReceipt = expense(300000, stageId: 1, receipt: true);
    final wrongRelease = release(900000, stageId: 1);
    final summary = LedgerService.summarize(
      stages: stages,
      entries: [
        release(400000, stageId: 1),
        wrongRelease,
        release(-900000, stageId: 1, reverses: wrongRelease.id),
        withReceipt,
        expense(-300000, stageId: 1, reverses: withReceipt.id),
        expense(380000, stageId: 1, receipt: true),
      ],
    );

    final foundation = summary.stages.first;
    expect(foundation.releasedMinor, 400000);
    expect(foundation.spentMinor, 380000);
    expect(foundation.spentWithReceiptMinor, 380000);
    expect(foundation.unaccountedMinor, 20000);
    expect(summary.unaccountedAlert, isFalse);
  });

  test('Given entries without a stage then they show in their own line and '
      'in the total only', () {
    final summary = LedgerService.summarize(
      stages: stages,
      entries: [release(100000), expense(20000, stageId: 1)],
    );

    expect(summary.unassigned?.releasedMinor, 100000);
    expect(summary.unassigned?.budgetMinor, 0);
    expect(summary.stages.first.spentMinor, 20000);
    expect(summary.total.releasedMinor, 100000);
    expect(summary.total.spentMinor, 20000);
  });

  test('Given nothing released then there is no alert', () {
    final summary = LedgerService.summarize(stages: stages, entries: []);

    expect(summary.total.releasedMinor, 0);
    expect(summary.unaccountedAlert, isFalse);
  });

  group('Given drafts', () {
    final now = DateTime.utc(2026, 10, 11, 9);

    test('then amounts must be positive and within the limit', () {
      for (final amount in [0, -5, LedgerService.maxAmountMinor + 1]) {
        expect(
          () => LedgerService.validateRelease(
            ReleaseDraft(
              amountMinor: amount,
              occurredOn: now,
              method: ReleaseMethod.cash,
            ),
            now: now,
          ),
          throwsA(isA<AppException>()),
        );
      }
    });

    test('then a date after tomorrow is refused and the day is kept at UTC '
        'midnight', () {
      final ok = LedgerService.validateRelease(
        ReleaseDraft(
          amountMinor: 1,
          occurredOn: DateTime.utc(2026, 10, 12, 15),
          method: ReleaseMethod.cash,
          reference: '  TX123 ',
          note: '   ',
        ),
        now: now,
      );
      expect(ok.occurredOn, DateTime.utc(2026, 10, 12));
      expect(ok.reference, 'TX123');
      expect(ok.note, isNull);

      expect(
        () => LedgerService.validateRelease(
          ReleaseDraft(
            amountMinor: 1,
            occurredOn: DateTime.utc(2026, 10, 13),
            method: ReleaseMethod.cash,
          ),
          now: now,
        ),
        throwsA(isA<AppException>()),
      );
    });

    test('then an expense needs a description, and a receipt comes with its '
        'hash', () {
      ExpenseDraft draft({String text = 'Cement', String? path, String? hash}) =>
          ExpenseDraft(
            amountMinor: 1,
            occurredOn: now,
            category: ExpenseCategory.materials,
            description: text,
            receiptPath: path,
            receiptSha256: hash,
          );

      expect(
        () => LedgerService.validateExpense(draft(text: '  '), now: now),
        throwsA(isA<AppException>()),
      );
      expect(
        () => LedgerService.validateExpense(draft(path: 'p'), now: now),
        throwsA(isA<AppException>()),
      );
      expect(
        () =>
            LedgerService.validateExpense(draft(path: 'p', hash: 'x'), now: now),
        throwsA(isA<AppException>()),
      );
      expect(
        LedgerService.validateExpense(
          draft(path: 'p', hash: 'A' * 64),
          now: now,
        ).receiptSha256,
        'a' * 64,
      );
    });

    test('then a reversal needs a reason', () {
      expect(
        () => LedgerService.validateReason('  '),
        throwsA(isA<AppException>()),
      );
      expect(LedgerService.validateReason(' Typo '), 'Typo');
    });
  });
}
