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

/// A member's role on one project (doc/02 §3.1).
enum ProjectRole implements _is.SerializableModel {
  owner,
  coFunder,
  viewer,
  siteManager;

  static ProjectRole fromJson(String name) {
    switch (name) {
      case 'owner':
        return ProjectRole.owner;
      case 'coFunder':
        return ProjectRole.coFunder;
      case 'viewer':
        return ProjectRole.viewer;
      case 'siteManager':
        return ProjectRole.siteManager;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "ProjectRole"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
