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
import 'project_type.dart' as _irluonl0;

/// What the owner enters to create or edit a project (PROJ-01, PROJ-04).
/// Immutable: a value object compared by its fields (==), e.g. in BLoC
/// events.
@_isc.immutable
abstract class ProjectDetails
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  const ProjectDetails._({
    required this.name,
    this.description,
    required this.type,
    required this.currencyCode,
    this.plannedStart,
    this.plannedEnd,
  });

  const factory ProjectDetails({
    required String name,
    String? description,
    required _irluonl0.ProjectType type,
    required String currencyCode,
    DateTime? plannedStart,
    DateTime? plannedEnd,
  }) = _ProjectDetailsImpl;

  factory ProjectDetails.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProjectDetails(
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      type: _irluonl0.ProjectType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      currencyCode: jsonSerialization['currencyCode'] as String,
      plannedStart: jsonSerialization['plannedStart'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['plannedStart'],
            ),
      plannedEnd: jsonSerialization['plannedEnd'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['plannedEnd'],
            ),
    );
  }

  /// 1–100 characters after trimming.
  final String name;

  /// At most 1,000 characters; blank is saved as none.
  final String? description;

  final _irluonl0.ProjectType type;

  /// ISO 4217 code from the supported list.
  final String currencyCode;

  final DateTime? plannedStart;

  /// On or after [plannedStart] when both are set.
  final DateTime? plannedEnd;

  /// Returns a shallow copy of this [ProjectDetails]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ProjectDetails copyWith({
    String? name,
    String? description,
    _irluonl0.ProjectType? type,
    String? currencyCode,
    DateTime? plannedStart,
    DateTime? plannedEnd,
  });
  @override
  bool operator ==(Object other) {
    return identical(
          other,
          this,
        ) ||
        other.runtimeType == runtimeType &&
            other is ProjectDetails &&
            (identical(
                  other.name,
                  name,
                ) ||
                other.name == name) &&
            (identical(
                  other.description,
                  description,
                ) ||
                other.description == description) &&
            (identical(
                  other.type,
                  type,
                ) ||
                other.type == type) &&
            (identical(
                  other.currencyCode,
                  currencyCode,
                ) ||
                other.currencyCode == currencyCode) &&
            (identical(
                  other.plannedStart,
                  plannedStart,
                ) ||
                other.plannedStart == plannedStart) &&
            (identical(
                  other.plannedEnd,
                  plannedEnd,
                ) ||
                other.plannedEnd == plannedEnd);
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      name,
      description,
      type,
      currencyCode,
      plannedStart,
      plannedEnd,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProjectDetails',
      'name': name,
      if (description != null) 'description': description,
      'type': type.toJson(),
      'currencyCode': currencyCode,
      if (plannedStart != null) 'plannedStart': plannedStart?.toJson(),
      if (plannedEnd != null) 'plannedEnd': plannedEnd?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProjectDetails',
      'name': name,
      if (description != null) 'description': description,
      'type': type.toJson(),
      'currencyCode': currencyCode,
      if (plannedStart != null) 'plannedStart': plannedStart?.toJson(),
      if (plannedEnd != null) 'plannedEnd': plannedEnd?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProjectDetailsImpl extends ProjectDetails {
  const _ProjectDetailsImpl({
    required String name,
    String? description,
    required _irluonl0.ProjectType type,
    required String currencyCode,
    DateTime? plannedStart,
    DateTime? plannedEnd,
  }) : super._(
         name: name,
         description: description,
         type: type,
         currencyCode: currencyCode,
         plannedStart: plannedStart,
         plannedEnd: plannedEnd,
       );

  /// Returns a shallow copy of this [ProjectDetails]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ProjectDetails copyWith({
    String? name,
    Object? description = _Undefined,
    _irluonl0.ProjectType? type,
    String? currencyCode,
    Object? plannedStart = _Undefined,
    Object? plannedEnd = _Undefined,
  }) {
    return ProjectDetails(
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      type: type ?? this.type,
      currencyCode: currencyCode ?? this.currencyCode,
      plannedStart: plannedStart is DateTime?
          ? plannedStart
          : this.plannedStart,
      plannedEnd: plannedEnd is DateTime? ? plannedEnd : this.plannedEnd,
    );
  }
}
