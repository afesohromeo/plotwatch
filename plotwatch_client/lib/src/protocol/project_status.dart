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

/// Project lifecycle (PROJ-05). A finished wizard creates `active`; `draft`
/// is kept for "finish the wizard later" (P1). Allowed transitions: decision
/// M2-4.
enum ProjectStatus implements _isc.SerializableModel {
  draft,
  active,
  paused,
  completed,
  archived;

  static ProjectStatus fromJson(String name) {
    switch (name) {
      case 'draft':
        return ProjectStatus.draft;
      case 'active':
        return ProjectStatus.active;
      case 'paused':
        return ProjectStatus.paused;
      case 'completed':
        return ProjectStatus.completed;
      case 'archived':
        return ProjectStatus.archived;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "ProjectStatus"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
