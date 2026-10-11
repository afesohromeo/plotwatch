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

/// A ledger entry is a release or an expense (doc/04f M6-1).
enum LedgerEntryKind implements _is.SerializableModel {
  release,
  expense;

  static LedgerEntryKind fromJson(String name) {
    switch (name) {
      case 'release':
        return LedgerEntryKind.release;
      case 'expense':
        return LedgerEntryKind.expense;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "LedgerEntryKind"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
