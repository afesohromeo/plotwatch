import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../helpers/helpers.dart';

// Plan: doc/04e-m5-review-realtime.md, fix M5-F2: 2 of 4 stages approved
// read "100% approved" when the other two had no budget.
void main() {
  final l10n = setUpTestLocalization();

  test('Given stages with budgets then the budget share and the stage count '
      'are both shown', () {
    expect(
      progressLine(
        l10n,
        percent: 100,
        approved: 2,
        total: 4,
        budgetTotalMinor: 500000,
      ),
      l10n.progressBudgetAndStages(100, 2, 4),
    );
  });

  test('Given no budget at all then only the stage count is shown', () {
    expect(
      progressLine(
        l10n,
        percent: 50,
        approved: 2,
        total: 4,
        budgetTotalMinor: 0,
      ),
      l10n.progressStagesOnly(2, 4),
    );
  });
}
