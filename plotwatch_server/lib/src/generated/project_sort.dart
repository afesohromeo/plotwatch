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

/// How the project list is ordered (doc/05 §9.4).
enum ProjectSort implements _is.SerializableModel {
  recent,
  name,
  progress;

  static ProjectSort fromJson(String name) {
    switch (name) {
      case 'recent':
        return ProjectSort.recent;
      case 'name':
        return ProjectSort.name;
      case 'progress':
        return ProjectSort.progress;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "ProjectSort"',
        );
    }
  }

  @override
  String toJson() => this.name;

  @override
  String toString() => this.name;
}
