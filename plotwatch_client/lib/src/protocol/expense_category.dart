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

/// What an expense was for (LED-03, doc/04f M6-4).
enum ExpenseCategory implements _isc.SerializableModel {
  materials,
  labour,
  transport,
  permits,
  equipment,
  other;

  static ExpenseCategory fromJson(String name) {
    switch (name) {
      case 'materials':
        return ExpenseCategory.materials;
      case 'labour':
        return ExpenseCategory.labour;
      case 'transport':
        return ExpenseCategory.transport;
      case 'permits':
        return ExpenseCategory.permits;
      case 'equipment':
        return ExpenseCategory.equipment;
      case 'other':
        return ExpenseCategory.other;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "ExpenseCategory"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
