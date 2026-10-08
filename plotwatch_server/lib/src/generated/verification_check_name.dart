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

/// Checks V1–V8 of doc/02 §8.2 (doc/04d M4-6).
enum VerificationCheckName implements _is.SerializableModel {
  inAppCapture,
  locationPresent,
  locationAccuracy,
  insideSite,
  notMockLocation,
  hashMatch,
  clockConsistency,
  promptCommit;

  static VerificationCheckName fromJson(String name) {
    switch (name) {
      case 'inAppCapture':
        return VerificationCheckName.inAppCapture;
      case 'locationPresent':
        return VerificationCheckName.locationPresent;
      case 'locationAccuracy':
        return VerificationCheckName.locationAccuracy;
      case 'insideSite':
        return VerificationCheckName.insideSite;
      case 'notMockLocation':
        return VerificationCheckName.notMockLocation;
      case 'hashMatch':
        return VerificationCheckName.hashMatch;
      case 'clockConsistency':
        return VerificationCheckName.clockConsistency;
      case 'promptCommit':
        return VerificationCheckName.promptCommit;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "VerificationCheckName"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
