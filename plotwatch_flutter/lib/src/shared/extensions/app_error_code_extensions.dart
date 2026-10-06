import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The localized message for each server error code (`_standards/14` §2.6).
/// The switch is exhaustive: a new code fails to compile until it has a key.
extension AppErrorCodeMessage on AppErrorCode {
  String message(AppLocalizations l10n) => switch (this) {
        AppErrorCode.permissionDenied => l10n.errorPermissionDenied,
        AppErrorCode.invalidFullName => l10n.errorInvalidFullName,
        AppErrorCode.invalidCountryCode => l10n.errorInvalidCountryCode,
        AppErrorCode.invalidLocale => l10n.errorInvalidLocale,
        AppErrorCode.authInvalidCredentials => l10n.errorAuthInvalidCredentials,
        AppErrorCode.authTooManyAttempts => l10n.errorAuthTooManyAttempts,
        AppErrorCode.authRequestExpired => l10n.errorAuthRequestExpired,
        AppErrorCode.authRequestInvalid => l10n.errorAuthRequestInvalid,
        AppErrorCode.authPasswordPolicy => l10n.errorAuthPasswordPolicy,
        AppErrorCode.authUserBlocked => l10n.errorAuthUserBlocked,
        AppErrorCode.authUnknown => l10n.errorAuthUnknown,
      };
}
