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
