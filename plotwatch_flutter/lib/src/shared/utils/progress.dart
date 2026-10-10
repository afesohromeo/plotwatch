import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The project's progress in words (STG-09, doc/04e M5-F2): the
/// budget-weighted percentage with the stage count beside it, so stages
/// without a budget don't make it look done. Without any budget the
/// percentage is the stage count itself, so only the count is shown.
String progressLine(
  AppLocalizations l10n, {
  required int percent,
  required int approved,
  required int total,
  required int budgetTotalMinor,
}) => budgetTotalMinor > 0
    ? l10n.progressBudgetAndStages(percent, approved, total)
    : l10n.progressStagesOnly(approved, total);
