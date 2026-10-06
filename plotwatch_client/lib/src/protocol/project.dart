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
import 'project_status.dart' as _iqsxbscs;
import 'project_type.dart' as _irluonl0;

/// A construction project (PROJ). The owner is the `ProjectMember` with role
/// `owner` (decision M2-2).
abstract class Project
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Project._({
    this.id,
    required this.name,
    this.description,
    required this.type,
    required this.status,
    required this.currencyCode,
    this.plannedStart,
    this.plannedEnd,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Project({
    int? id,
    required String name,
    String? description,
    required _irluonl0.ProjectType type,
    required _iqsxbscs.ProjectStatus status,
    required String currencyCode,
    DateTime? plannedStart,
    DateTime? plannedEnd,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ProjectImpl;

  factory Project.fromJson(Map<String, dynamic> jsonSerialization) {
    return Project(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      type: _irluonl0.ProjectType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      status: _iqsxbscs.ProjectStatus.fromJson(
        (jsonSerialization['status'] as String),
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
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String? description;

  _irluonl0.ProjectType type;

  _iqsxbscs.ProjectStatus status;

  /// ISO 4217, e.g. XAF. Locked once ledger entries exist (PROJ-04, M6).
  String currencyCode;

  DateTime? plannedStart;

  DateTime? plannedEnd;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Project]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Project copyWith({
    int? id,
    String? name,
    String? description,
    _irluonl0.ProjectType? type,
    _iqsxbscs.ProjectStatus? status,
    String? currencyCode,
    DateTime? plannedStart,
    DateTime? plannedEnd,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Project',
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      'type': type.toJson(),
      'status': status.toJson(),
      'currencyCode': currencyCode,
      if (plannedStart != null) 'plannedStart': plannedStart?.toJson(),
      if (plannedEnd != null) 'plannedEnd': plannedEnd?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Project',
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      'type': type.toJson(),
      'status': status.toJson(),
      'currencyCode': currencyCode,
      if (plannedStart != null) 'plannedStart': plannedStart?.toJson(),
      if (plannedEnd != null) 'plannedEnd': plannedEnd?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProjectImpl extends Project {
  _ProjectImpl({
    int? id,
    required String name,
    String? description,
    required _irluonl0.ProjectType type,
    required _iqsxbscs.ProjectStatus status,
    required String currencyCode,
    DateTime? plannedStart,
    DateTime? plannedEnd,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         name: name,
         description: description,
         type: type,
         status: status,
         currencyCode: currencyCode,
         plannedStart: plannedStart,
         plannedEnd: plannedEnd,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Project]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Project copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    _irluonl0.ProjectType? type,
    _iqsxbscs.ProjectStatus? status,
    String? currencyCode,
    Object? plannedStart = _Undefined,
    Object? plannedEnd = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Project(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      type: type ?? this.type,
      status: status ?? this.status,
      currencyCode: currencyCode ?? this.currencyCode,
      plannedStart: plannedStart is DateTime?
          ? plannedStart
          : this.plannedStart,
      plannedEnd: plannedEnd is DateTime? ? plannedEnd : this.plannedEnd,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
