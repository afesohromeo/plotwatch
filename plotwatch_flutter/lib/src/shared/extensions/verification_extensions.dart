import 'package:flutter/painting.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The badge of a capture (VER-02, VER-03; doc/04d).
extension VerificationLevelX on VerificationLevel {
  String label(AppLocalizations l10n) => switch (this) {
    VerificationLevel.pending => l10n.verificationPending,
    VerificationLevel.verified => l10n.verificationVerified,
    VerificationLevel.partiallyVerified => l10n.verificationPartial,
    VerificationLevel.unverified => l10n.verificationUnverified,
  };

  /// Calm Ledger trust tones (doc/05-design-system.md).
  Color get color => switch (this) {
    VerificationLevel.pending => customColors.muted,
    VerificationLevel.verified => customColors.verified,
    VerificationLevel.partiallyVerified => customColors.partial,
    VerificationLevel.unverified => customColors.unverified,
  };
}

/// One check in the user's language, from the numbers the server sent
/// (decision M4-7).
extension VerificationCheckX on VerificationCheck {
  String title(AppLocalizations l10n) => switch (name) {
    VerificationCheckName.inAppCapture => l10n.checkInAppCaptureTitle,
    VerificationCheckName.locationPresent => l10n.checkLocationPresentTitle,
    VerificationCheckName.locationAccuracy => l10n.checkLocationAccuracyTitle,
    VerificationCheckName.insideSite => l10n.checkInsideSiteTitle,
    VerificationCheckName.notMockLocation => l10n.checkNotMockLocationTitle,
    VerificationCheckName.hashMatch => l10n.checkHashMatchTitle,
    VerificationCheckName.clockConsistency => l10n.checkClockConsistencyTitle,
    VerificationCheckName.promptCommit => l10n.checkPromptCommitTitle,
  };

  String explanation(AppLocalizations l10n) {
    final allowedM = _int('allowedM');
    final allowedMin = _minutes('allowedSeconds');
    return switch (name) {
      VerificationCheckName.inAppCapture =>
        passed ? l10n.checkInAppCapturePassed : l10n.checkInAppCaptureFailed,
      VerificationCheckName.locationPresent =>
        passed
            ? l10n.checkLocationPresentPassed
            : l10n.checkLocationPresentFailed,
      VerificationCheckName.locationAccuracy => switch (_int('accuracyM')) {
        null => l10n.checkLocationAccuracyUnknown,
        final accuracy =>
          passed
              ? l10n.checkLocationAccuracyPassed(accuracy, allowedM ?? 0)
              : l10n.checkLocationAccuracyFailed(accuracy, allowedM ?? 0),
      },
      VerificationCheckName.insideSite => switch (_int('distanceM')) {
        null => l10n.checkInsideSiteUnknown,
        final distance =>
          passed
              ? l10n.checkInsideSitePassed(distance, allowedM ?? 0)
              : l10n.checkInsideSiteFailed(distance, allowedM ?? 0),
      },
      VerificationCheckName.notMockLocation =>
        passed
            ? l10n.checkNotMockLocationPassed
            : l10n.checkNotMockLocationFailed,
      VerificationCheckName.hashMatch =>
        passed ? l10n.checkHashMatchPassed : l10n.checkHashMatchFailed,
      VerificationCheckName.clockConsistency =>
        passed
            ? l10n.checkClockConsistencyPassed(allowedMin ?? 0)
            : l10n.checkClockConsistencyFailed(
                _minutes('skewSeconds') ?? 0,
                allowedMin ?? 0,
              ),
      VerificationCheckName.promptCommit =>
        passed
            ? l10n.checkPromptCommitPassed(allowedMin ?? 0)
            : l10n.checkPromptCommitFailed(
                _minutes('delaySeconds') ?? 0,
                allowedMin ?? 0,
              ),
    };
  }

  int? _int(String key) => int.tryParse(details?[key] ?? '');

  /// Seconds in [details] as whole minutes, rounded.
  int? _minutes(String key) {
    final seconds = _int(key);
    return seconds == null ? null : (seconds / 60).round();
  }
}
