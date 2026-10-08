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
import 'stage_status.dart' as _iblg1lql;

/// A milestone of the build with a budget, planned dates and a checklist of
/// required evidence (STG-01, doc/04c M3-4).
abstract class Stage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Stage._({
    this.id,
    required this.projectId,
    required this.orderIndex,
    required this.name,
    this.description,
    required this.budgetMinor,
    this.plannedStart,
    this.plannedEnd,
    required this.status,
    this.startedAt,
    this.submittedAt,
    this.approvedAt,
    this.approvedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Stage({
    int? id,
    required int projectId,
    required int orderIndex,
    required String name,
    String? description,
    required int budgetMinor,
    DateTime? plannedStart,
    DateTime? plannedEnd,
    required _iblg1lql.StageStatus status,
    DateTime? startedAt,
    DateTime? submittedAt,
    DateTime? approvedAt,
    _isc.UuidValue? approvedBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _StageImpl;

  factory Stage.fromJson(Map<String, dynamic> jsonSerialization) {
    return Stage(
      id: jsonSerialization['id'] as int?,
      projectId: jsonSerialization['projectId'] as int,
      orderIndex: jsonSerialization['orderIndex'] as int,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      budgetMinor: jsonSerialization['budgetMinor'] as int,
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
      status: _iblg1lql.StageStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      submittedAt: jsonSerialization['submittedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['submittedAt'],
            ),
      approvedAt: jsonSerialization['approvedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['approvedAt'],
            ),
      approvedBy: jsonSerialization['approvedBy'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['approvedBy'],
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

  int projectId;

  /// 0…n−1 without gaps within the project (decision M3-7).
  int orderIndex;

  /// 1–100 characters after trimming.
  String name;

  /// At most 1,000 characters; blank is saved as none.
  String? description;

  /// Minor units of the project currency, 0 to 10^15 (BUD-02).
  int budgetMinor;

  DateTime? plannedStart;

  /// On or after [plannedStart] when both are set.
  DateTime? plannedEnd;

  _iblg1lql.StageStatus status;

  DateTime? startedAt;

  /// Set by the review loop from M5 on.
  DateTime? submittedAt;

  DateTime? approvedAt;

  _isc.UuidValue? approvedBy;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Stage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Stage copyWith({
    int? id,
    int? projectId,
    int? orderIndex,
    String? name,
    String? description,
    int? budgetMinor,
    DateTime? plannedStart,
    DateTime? plannedEnd,
    _iblg1lql.StageStatus? status,
    DateTime? startedAt,
    DateTime? submittedAt,
    DateTime? approvedAt,
    _isc.UuidValue? approvedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Stage',
      if (id != null) 'id': id,
      'projectId': projectId,
      'orderIndex': orderIndex,
      'name': name,
      if (description != null) 'description': description,
      'budgetMinor': budgetMinor,
      if (plannedStart != null) 'plannedStart': plannedStart?.toJson(),
      if (plannedEnd != null) 'plannedEnd': plannedEnd?.toJson(),
      'status': status.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (submittedAt != null) 'submittedAt': submittedAt?.toJson(),
      if (approvedAt != null) 'approvedAt': approvedAt?.toJson(),
      if (approvedBy != null) 'approvedBy': approvedBy?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Stage',
      if (id != null) 'id': id,
      'projectId': projectId,
      'orderIndex': orderIndex,
      'name': name,
      if (description != null) 'description': description,
      'budgetMinor': budgetMinor,
      if (plannedStart != null) 'plannedStart': plannedStart?.toJson(),
      if (plannedEnd != null) 'plannedEnd': plannedEnd?.toJson(),
      'status': status.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (submittedAt != null) 'submittedAt': submittedAt?.toJson(),
      if (approvedAt != null) 'approvedAt': approvedAt?.toJson(),
      if (approvedBy != null) 'approvedBy': approvedBy?.toJson(),
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

class _StageImpl extends Stage {
  _StageImpl({
    int? id,
    required int projectId,
    required int orderIndex,
    required String name,
    String? description,
    required int budgetMinor,
    DateTime? plannedStart,
    DateTime? plannedEnd,
    required _iblg1lql.StageStatus status,
    DateTime? startedAt,
    DateTime? submittedAt,
    DateTime? approvedAt,
    _isc.UuidValue? approvedBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         projectId: projectId,
         orderIndex: orderIndex,
         name: name,
         description: description,
         budgetMinor: budgetMinor,
         plannedStart: plannedStart,
         plannedEnd: plannedEnd,
         status: status,
         startedAt: startedAt,
         submittedAt: submittedAt,
         approvedAt: approvedAt,
         approvedBy: approvedBy,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Stage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Stage copyWith({
    Object? id = _Undefined,
    int? projectId,
    int? orderIndex,
    String? name,
    Object? description = _Undefined,
    int? budgetMinor,
    Object? plannedStart = _Undefined,
    Object? plannedEnd = _Undefined,
    _iblg1lql.StageStatus? status,
    Object? startedAt = _Undefined,
    Object? submittedAt = _Undefined,
    Object? approvedAt = _Undefined,
    Object? approvedBy = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Stage(
      id: id is int? ? id : this.id,
      projectId: projectId ?? this.projectId,
      orderIndex: orderIndex ?? this.orderIndex,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      budgetMinor: budgetMinor ?? this.budgetMinor,
      plannedStart: plannedStart is DateTime?
          ? plannedStart
          : this.plannedStart,
      plannedEnd: plannedEnd is DateTime? ? plannedEnd : this.plannedEnd,
      status: status ?? this.status,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      submittedAt: submittedAt is DateTime? ? submittedAt : this.submittedAt,
      approvedAt: approvedAt is DateTime? ? approvedAt : this.approvedAt,
      approvedBy: approvedBy is _isc.UuidValue? ? approvedBy : this.approvedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
