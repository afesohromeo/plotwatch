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

  static String? projectName(String? value, AppLocalizations l10n) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return l10n.validateProjectNameRequired;
    if (name.length > maxProjectNameLength) {
      return l10n.validateProjectNameTooLong;
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
