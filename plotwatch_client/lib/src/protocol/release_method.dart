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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// How a fund release reached the site (LED-01, doc/04f M6-2).
enum ReleaseMethod implements _isc.SerializableModel {
  bankTransfer,
  mobileMoney,
  cash,
  withdrawnBySiteManager,
  other;

  static ReleaseMethod fromJson(String name) {
    switch (name) {
      case 'bankTransfer':
        return ReleaseMethod.bankTransfer;
      case 'mobileMoney':
        return ReleaseMethod.mobileMoney;
      case 'cash':
        return ReleaseMethod.cash;
      case 'withdrawnBySiteManager':
        return ReleaseMethod.withdrawnBySiteManager;
      case 'other':
        return ReleaseMethod.other;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "ReleaseMethod"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
