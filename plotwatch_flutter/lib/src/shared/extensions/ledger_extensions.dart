import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// How a release reached the site (LED-01).
extension ReleaseMethodX on ReleaseMethod {
  String label(AppLocalizations l10n) => switch (this) {
    ReleaseMethod.bankTransfer => l10n.methodBankTransfer,
    ReleaseMethod.mobileMoney => l10n.methodMobileMoney,
    ReleaseMethod.cash => l10n.methodCash,
    ReleaseMethod.withdrawnBySiteManager => l10n.methodWithdrawn,
    ReleaseMethod.other => l10n.methodOther,
  };
}

/// What an expense was for (LED-03).
extension ExpenseCategoryX on ExpenseCategory {
  String label(AppLocalizations l10n) => switch (this) {
    ExpenseCategory.materials => l10n.categoryMaterials,
    ExpenseCategory.labour => l10n.categoryLabour,
    ExpenseCategory.transport => l10n.categoryTransport,
    ExpenseCategory.permits => l10n.categoryPermits,
    ExpenseCategory.equipment => l10n.categoryEquipment,
    ExpenseCategory.other => l10n.categoryOther,
  };
}

/// How an entry reads in the list and on its page (doc/04f M6-10).
extension LedgerEntryX on LedgerEntry {
  bool get isRelease => kind == LedgerEntryKind.release;

  /// A correction of an earlier entry (LED-06).
  bool get isReversal => reversesId != null;

  /// Corrected by a later entry.
  bool get isReversed => reversedById != null;

  bool get hasReceipt => receiptPath != null;

  /// "Release", "Expense" or "Reversal": the entry page's title.
  String kindLabel(AppLocalizations l10n) => isReversal
      ? l10n.entryReversal
      : isRelease
      ? l10n.entryRelease
      : l10n.entryExpense;

  /// "Mobile money · TX-4471", "Materials · Quincaillerie Akwa".
  String title(AppLocalizations l10n) {
    final parts = isRelease
        ? [?method?.label(l10n), ?reference]
        : [?category?.label(l10n), ?vendor];
    return parts.isEmpty ? kindLabel(l10n) : parts.join(' · ');
  }

  /// The amount as it moves the money: a release in, an expense out; a
  /// reversal the other way. "+500,000", "−300,000".
  String signed(String currencyCode) {
    final amount = formatMoneyInput(amountMinor.abs(), currencyCode);
    final inward = isRelease == amountMinor > 0;
    return '${inward ? '+' : '−'}$amount';
  }

  IconData get icon => isReversal
      ? Icons.undo_rounded
      : isRelease
      ? Icons.north_rounded
      : Icons.receipt_long_outlined;
}
