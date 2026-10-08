import 'package:flutter/painting.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Localized label and chip tone of a stage status (`_standards/14` §1.3,
/// doc/04c M3-11).
extension StageStatusX on StageStatus {
  String label(AppLocalizations l10n) => switch (this) {
    StageStatus.notStarted => l10n.stageStatusNotStarted,
    StageStatus.inProgress => l10n.stageStatusInProgress,
    StageStatus.submitted => l10n.stageStatusSubmitted,
    StageStatus.changesRequested => l10n.stageStatusChangesRequested,
    StageStatus.approved => l10n.stageStatusApproved,
  };

  /// Calm Ledger tones (doc/05-design-system.md): waiting is muted, work is
  /// the brand colour, a decision pending is the accent, done is verified.
  Color get color => switch (this) {
    StageStatus.notStarted => customColors.muted,
    StageStatus.inProgress => customColors.primary,
    StageStatus.submitted => customColors.accent,
    StageStatus.changesRequested => customColors.partial,
    StageStatus.approved => customColors.verified,
  };

  /// The owner may still edit, reorder or delete it (decision M3-6).
  bool get isEditable =>
      this == StageStatus.notStarted || this == StageStatus.inProgress;
}
