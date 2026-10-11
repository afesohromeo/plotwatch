import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../helpers/helpers.dart';

// Plan: doc/04f-m6-ledger.md, groups D and E: the ledger through
// `client.ledger`, the receipt uploaded first (M6-5 a).
void main() {
  late MockLedgerApiProvider apiProvider;
  late LedgerRepository repository;

  final draft = ExpenseDraft(
    amountMinor: 300000,
    occurredOn: DateTime.utc(2026, 10, 11),
    category: ExpenseCategory.materials,
    description: 'Cement',
  );

  setUpAll(() => registerFallbackValue(draft));
  setUp(() {
    apiProvider = MockLedgerApiProvider();
    repository = LedgerRepository(apiProvider: apiProvider);
  });

  test('Given an expense without a receipt then it is recorded as it is', () {
    final saved = testExpense(receipt: false);
    when(
      () => apiProvider.recordExpense(1, draft),
    ).thenAnswer((_) async => saved);

    expect(repository.recordExpense(1, draft), completion(saved));
    verifyNever(() => apiProvider.receiptUpload(any()));
  });

  test('Given a receipt then it is uploaded first and the expense carries '
      'its path and SHA-256', () async {
    final bytes = Uint8List.fromList([1, 2, 3]);
    when(() => apiProvider.receiptUpload(1)).thenAnswer(
      (_) async => ReceiptUpload(
        path: 'projects/1/receipts/r.jpg',
        uploadDescription: 'desc',
      ),
    );
    when(() => apiProvider.upload('desc', bytes)).thenAnswer((_) async => true);
    when(
      () => apiProvider.recordExpense(1, any()),
    ).thenAnswer((_) async => testExpense());

    await repository.recordExpense(1, draft, receipt: bytes);

    final sent =
        verify(() => apiProvider.recordExpense(1, captureAny())).captured.single
            as ExpenseDraft;
    expect(sent.receiptPath, 'projects/1/receipts/r.jpg');
    expect(sent.receiptSha256, sha256Hex(bytes));
  });

  test('Given the upload is refused then nothing is recorded', () async {
    final bytes = Uint8List.fromList([1, 2, 3]);
    when(() => apiProvider.receiptUpload(1)).thenAnswer(
      (_) async => ReceiptUpload(path: 'p', uploadDescription: 'desc'),
    );
    when(
      () => apiProvider.upload('desc', bytes),
    ).thenAnswer((_) async => false);

    await expectLater(
      repository.recordExpense(1, draft, receipt: bytes),
      throwsA(isA<UploadException>()),
    );
    verifyNever(() => apiProvider.recordExpense(any(), any()));
  });

  test('Given a page request then the filters are sent and the items '
      'returned', () async {
    when(
      () => apiProvider.list(
        1,
        beforeId: 9,
        pageSize: 20,
        kind: LedgerEntryKind.expense,
        stageId: 2,
      ),
    ).thenAnswer((_) async => LedgerPage(items: [testExpense()]));

    final page = await repository.fetchEntries(
      1,
      beforeId: 9,
      size: 20,
      kind: LedgerEntryKind.expense,
      stageId: 2,
    );

    expect(page.content.single.id, 2);
  });
}
