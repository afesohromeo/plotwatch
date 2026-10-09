import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Form field validators. Each returns the localized message, or `null` when
/// the value is valid. The password and name rules mirror the server's
/// (auth module default policy; decision M1-2), so most errors are caught
/// before a request is sent.
class Validators {
  Validators._();

  static const minPasswordLength = 8;
  static const maxFullNameLength = 100;
  static final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? email(String? value, AppLocalizations l10n) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return l10n.validateEmailRequired;
    if (!_email.hasMatch(email)) return l10n.validateEmailInvalid;
    return null;
  }

  static String? password(String? value, AppLocalizations l10n) {
    final password = value ?? '';
    if (password.isEmpty) return l10n.validatePasswordRequired;
    if (password.trim() != password) return l10n.validatePasswordSpaces;
    if (password.length < minPasswordLength) {
      return l10n.validatePasswordTooShort;
    }
    return null;
  }

  /// Second password field: must be filled and equal to [password].
  static String? confirmPassword(
    String? value,
    String password,
    AppLocalizations l10n,
  ) {
    final confirmation = value ?? '';
    if (confirmation.isEmpty) return l10n.validateConfirmPasswordRequired;
    if (confirmation != password) return l10n.validatePasswordMismatch;
    return null;
  }

  static String? code(String? value, AppLocalizations l10n) {
    if ((value?.trim() ?? '').isEmpty) return l10n.validateCodeRequired;
    return null;
  }

  static String? fullName(String? value, AppLocalizations l10n) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return l10n.validateNameRequired;
    if (name.length > maxFullNameLength) return l10n.validateNameTooLong;
    return null;
  }

  // Project rules mirror the server's ProjectService.validateDetails.
  static const maxProjectNameLength = 100;
  static const maxProjectDescriptionLength = 1000;
  static const maxStageNameLength = 100;
  static const maxChecklistLabelLength = 200;
  static const maxChecklistItems = 30;

  static String? projectName(String? value, AppLocalizations l10n) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return l10n.validateProjectNameRequired;
    if (name.length > maxProjectNameLength) {
      return l10n.validateProjectNameTooLong;
    }
    return null;
  }

  /// Mirrors `StageService.validateDraft` (doc/04c M3-4).
  static String? stageName(String? value, AppLocalizations l10n) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return l10n.validateStageNameRequired;
    if (name.length > maxStageNameLength) return l10n.validateStageNameTooLong;
    return null;
  }

  /// Mirrors `StageService.validateDraft` (doc/04c M3-5).
  static String? checklistLabel(String? value, AppLocalizations l10n) {
    final label = value?.trim() ?? '';
    if (label.isEmpty) return l10n.validateChecklistLabelRequired;
    if (label.length > maxChecklistLabelLength) {
      return l10n.validateChecklistLabelTooLong;
    }
    return null;
  }

  /// The server normalises and checks the code itself (decision M2-6).
  static String? invitationCode(String? value, AppLocalizations l10n) {
    if ((value?.trim() ?? '').isEmpty) {
      return l10n.validateInvitationCodeRequired;
    }
    return null;
  }

  // Progress update rules mirror the server's UpdateService.validateDraft
  // (doc/04e M5-9 b).
  static const maxUpdateTextLength = 2000;
  static const maxUpdateIssuesLength = 1000;
  static const maxWorkersCount = 999;

  static String? updateText(String? value, AppLocalizations l10n) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return l10n.validateUpdateTextRequired;
    if (text.length > maxUpdateTextLength) {
      return l10n.validateUpdateTextTooLong;
    }
    return null;
  }

  /// Optional: a whole number from 0 to 999.
  static String? workersCount(String? value, AppLocalizations l10n) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;
    final count = int.tryParse(text);
    if (count == null || count < 0 || count > maxWorkersCount) {
      return l10n.validateWorkersCount;
    }
    return null;
  }

  /// Optional: only the length is checked.
  static String? updateIssues(String? value, AppLocalizations l10n) {
    if ((value?.trim() ?? '').length > maxUpdateIssuesLength) {
      return l10n.validateUpdateIssuesTooLong;
    }
    return null;
  }

  /// Optional: only the length is checked.
  static String? projectDescription(String? value, AppLocalizations l10n) {
    if ((value?.trim() ?? '').length > maxProjectDescriptionLength) {
      return l10n.validateDescriptionTooLong;
    }
    return null;
  }
}
