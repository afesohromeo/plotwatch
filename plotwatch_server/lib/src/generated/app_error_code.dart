/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

/// Error codes sent to the client inside [AppException].
///
/// The server never sends display text: the client maps each code to a
/// localized message (one ARB key per code, `_standards/14` §2).
/// Auth codes are set by the client's ApiErrorHandler from the auth module's
/// own exceptions (`_standards/14` §2.3.1).
enum AppErrorCode implements _is.SerializableModel {
  permissionDenied,
  invalidFullName,
  invalidCountryCode,
  invalidLocale,
  projectNotFound,
  invalidProjectName,
  invalidProjectDescription,
  invalidCurrencyCode,
  invalidProjectDates,
  invalidStatusTransition,
  invalidSiteLocation,
  invalidSiteRadius,
  invitationNotFound,
  invitationExpired,
  invitationUsed,
  invalidInvitationRole,
  alreadyMember,
  cannotRemoveOwner,
  memberNotFound,
  cannotChangeOwnerRole,
  invalidMemberRole,
  siteProposalNotFound,
  siteProposalNotPending,
  siteAccuracyTooLow,
  siteMockLocation,
  siteNotFound,
  stageNotFound,
  stageLocked,
  invalidStageName,
  invalidStageDescription,
  invalidBudget,
  invalidStageDates,
  invalidChecklistItem,
  tooManyStages,
  tooManyChecklistItems,
  invalidStageOrder,
  stagePlanNotEmpty,
  invalidStageTransition,
  projectNotActive,
  projectNotEditable,
  evidenceNotFound,
  checklistItemNotFound,
  evidenceNotCommitted,
  uploadMissing,
  evidenceFileTooLarge,
  invalidEvidenceMetadata,
  evidenceAlreadyRetracted,
  notYourCapture,
  checklistItemHasEvidence,
  checklistIncomplete,
  reviewCommentRequired,
  notificationNotFound,
  invalidProgressUpdate,
  updateNotFound,
  invalidLedgerEntry,
  ledgerEntryNotFound,
  alreadyReversed,
  alreadyConfirmed,
  notEntryAuthor,
  emailUsesGoogle,
  textTooLong,
  authInvalidCredentials,
  authTooManyAttempts,
  authRequestExpired,
  authRequestInvalid,
  authPasswordPolicy,
  authUserBlocked,
  authUnknown;

  static AppErrorCode fromJson(String name) {
    switch (name) {
      case 'permissionDenied':
        return AppErrorCode.permissionDenied;
      case 'invalidFullName':
        return AppErrorCode.invalidFullName;
      case 'invalidCountryCode':
        return AppErrorCode.invalidCountryCode;
      case 'invalidLocale':
        return AppErrorCode.invalidLocale;
      case 'projectNotFound':
        return AppErrorCode.projectNotFound;
      case 'invalidProjectName':
        return AppErrorCode.invalidProjectName;
      case 'invalidProjectDescription':
        return AppErrorCode.invalidProjectDescription;
      case 'invalidCurrencyCode':
        return AppErrorCode.invalidCurrencyCode;
      case 'invalidProjectDates':
        return AppErrorCode.invalidProjectDates;
      case 'invalidStatusTransition':
        return AppErrorCode.invalidStatusTransition;
      case 'invalidSiteLocation':
        return AppErrorCode.invalidSiteLocation;
      case 'invalidSiteRadius':
        return AppErrorCode.invalidSiteRadius;
      case 'invitationNotFound':
        return AppErrorCode.invitationNotFound;
      case 'invitationExpired':
        return AppErrorCode.invitationExpired;
      case 'invitationUsed':
        return AppErrorCode.invitationUsed;
      case 'invalidInvitationRole':
        return AppErrorCode.invalidInvitationRole;
      case 'alreadyMember':
        return AppErrorCode.alreadyMember;
      case 'cannotRemoveOwner':
        return AppErrorCode.cannotRemoveOwner;
      case 'memberNotFound':
        return AppErrorCode.memberNotFound;
      case 'cannotChangeOwnerRole':
        return AppErrorCode.cannotChangeOwnerRole;
      case 'invalidMemberRole':
        return AppErrorCode.invalidMemberRole;
      case 'siteProposalNotFound':
        return AppErrorCode.siteProposalNotFound;
      case 'siteProposalNotPending':
        return AppErrorCode.siteProposalNotPending;
      case 'siteAccuracyTooLow':
        return AppErrorCode.siteAccuracyTooLow;
      case 'siteMockLocation':
        return AppErrorCode.siteMockLocation;
      case 'siteNotFound':
        return AppErrorCode.siteNotFound;
      case 'stageNotFound':
        return AppErrorCode.stageNotFound;
      case 'stageLocked':
        return AppErrorCode.stageLocked;
      case 'invalidStageName':
        return AppErrorCode.invalidStageName;
      case 'invalidStageDescription':
        return AppErrorCode.invalidStageDescription;
      case 'invalidBudget':
        return AppErrorCode.invalidBudget;
      case 'invalidStageDates':
        return AppErrorCode.invalidStageDates;
      case 'invalidChecklistItem':
        return AppErrorCode.invalidChecklistItem;
      case 'tooManyStages':
        return AppErrorCode.tooManyStages;
      case 'tooManyChecklistItems':
        return AppErrorCode.tooManyChecklistItems;
      case 'invalidStageOrder':
        return AppErrorCode.invalidStageOrder;
      case 'stagePlanNotEmpty':
        return AppErrorCode.stagePlanNotEmpty;
      case 'invalidStageTransition':
        return AppErrorCode.invalidStageTransition;
      case 'projectNotActive':
        return AppErrorCode.projectNotActive;
      case 'projectNotEditable':
        return AppErrorCode.projectNotEditable;
      case 'evidenceNotFound':
        return AppErrorCode.evidenceNotFound;
      case 'checklistItemNotFound':
        return AppErrorCode.checklistItemNotFound;
      case 'evidenceNotCommitted':
        return AppErrorCode.evidenceNotCommitted;
      case 'uploadMissing':
        return AppErrorCode.uploadMissing;
      case 'evidenceFileTooLarge':
        return AppErrorCode.evidenceFileTooLarge;
      case 'invalidEvidenceMetadata':
        return AppErrorCode.invalidEvidenceMetadata;
      case 'evidenceAlreadyRetracted':
        return AppErrorCode.evidenceAlreadyRetracted;
      case 'notYourCapture':
        return AppErrorCode.notYourCapture;
      case 'checklistItemHasEvidence':
        return AppErrorCode.checklistItemHasEvidence;
      case 'checklistIncomplete':
        return AppErrorCode.checklistIncomplete;
      case 'reviewCommentRequired':
        return AppErrorCode.reviewCommentRequired;
      case 'notificationNotFound':
        return AppErrorCode.notificationNotFound;
      case 'invalidProgressUpdate':
        return AppErrorCode.invalidProgressUpdate;
      case 'updateNotFound':
        return AppErrorCode.updateNotFound;
      case 'invalidLedgerEntry':
        return AppErrorCode.invalidLedgerEntry;
      case 'ledgerEntryNotFound':
        return AppErrorCode.ledgerEntryNotFound;
      case 'alreadyReversed':
        return AppErrorCode.alreadyReversed;
      case 'alreadyConfirmed':
        return AppErrorCode.alreadyConfirmed;
      case 'notEntryAuthor':
        return AppErrorCode.notEntryAuthor;
      case 'emailUsesGoogle':
        return AppErrorCode.emailUsesGoogle;
      case 'textTooLong':
        return AppErrorCode.textTooLong;
      case 'authInvalidCredentials':
        return AppErrorCode.authInvalidCredentials;
      case 'authTooManyAttempts':
        return AppErrorCode.authTooManyAttempts;
      case 'authRequestExpired':
        return AppErrorCode.authRequestExpired;
      case 'authRequestInvalid':
        return AppErrorCode.authRequestInvalid;
      case 'authPasswordPolicy':
        return AppErrorCode.authPasswordPolicy;
      case 'authUserBlocked':
        return AppErrorCode.authUserBlocked;
      case 'authUnknown':
        return AppErrorCode.authUnknown;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "AppErrorCode"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
