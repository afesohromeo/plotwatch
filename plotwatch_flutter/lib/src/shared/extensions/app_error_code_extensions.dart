import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The localized message for each server error code (`_standards/14` §2.6).
/// The switch is exhaustive: a new code fails to compile until it has a key.
extension AppErrorCodeMessage on AppErrorCode {
  String message(AppLocalizations l10n) => switch (this) {
    AppErrorCode.permissionDenied => l10n.errorPermissionDenied,
    AppErrorCode.invalidFullName => l10n.errorInvalidFullName,
    AppErrorCode.invalidCountryCode => l10n.errorInvalidCountryCode,
    AppErrorCode.invalidLocale => l10n.errorInvalidLocale,
    AppErrorCode.projectNotFound => l10n.errorProjectNotFound,
    AppErrorCode.invalidProjectName => l10n.errorInvalidProjectName,
    AppErrorCode.invalidProjectDescription =>
      l10n.errorInvalidProjectDescription,
    AppErrorCode.invalidCurrencyCode => l10n.errorInvalidCurrencyCode,
    AppErrorCode.invalidProjectDates => l10n.errorInvalidProjectDates,
    AppErrorCode.invalidStatusTransition => l10n.errorInvalidStatusTransition,
    AppErrorCode.invalidSiteLocation => l10n.errorInvalidSiteLocation,
    AppErrorCode.invalidSiteRadius => l10n.errorInvalidSiteRadius,
    AppErrorCode.invitationNotFound => l10n.errorInvitationNotFound,
    AppErrorCode.invitationExpired => l10n.errorInvitationExpired,
    AppErrorCode.invitationUsed => l10n.errorInvitationUsed,
    AppErrorCode.invalidInvitationRole => l10n.errorInvalidInvitationRole,
    AppErrorCode.alreadyMember => l10n.errorAlreadyMember,
    AppErrorCode.cannotRemoveOwner => l10n.errorCannotRemoveOwner,
    AppErrorCode.memberNotFound => l10n.errorMemberNotFound,
    AppErrorCode.siteProposalNotFound => l10n.errorSiteProposalNotFound,
    AppErrorCode.siteProposalNotPending => l10n.errorSiteProposalNotPending,
    AppErrorCode.siteAccuracyTooLow => l10n.errorSiteAccuracyTooLow,
    AppErrorCode.siteMockLocation => l10n.errorSiteMockLocation,
    AppErrorCode.textTooLong => l10n.errorTextTooLong,
    AppErrorCode.authInvalidCredentials => l10n.errorAuthInvalidCredentials,
    AppErrorCode.authTooManyAttempts => l10n.errorAuthTooManyAttempts,
    AppErrorCode.authRequestExpired => l10n.errorAuthRequestExpired,
    AppErrorCode.authRequestInvalid => l10n.errorAuthRequestInvalid,
    AppErrorCode.authPasswordPolicy => l10n.errorAuthPasswordPolicy,
    AppErrorCode.authUserBlocked => l10n.errorAuthUserBlocked,
    AppErrorCode.authUnknown => l10n.errorAuthUnknown,
  };
}
