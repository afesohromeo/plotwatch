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

/// Where a stage is in its review cycle (STG-05, doc/02 §10.1). M3 uses
/// notStarted and inProgress; the review states come in M5.
enum StageStatus implements _is.SerializableModel {
  notStarted,
  inProgress,
  submitted,
  changesRequested,
  approved;

  static StageStatus fromJson(String name) {
    switch (name) {
      case 'notStarted':
        return StageStatus.notStarted;
      case 'inProgress':
        return StageStatus.inProgress;
      case 'submitted':
        return StageStatus.submitted;
      case 'changesRequested':
        return StageStatus.changesRequested;
      case 'approved':
        return StageStatus.approved;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "StageStatus"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
