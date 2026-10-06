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
import 'member_status.dart' as _iolegqnm;
import 'project_role.dart' as _i46wx1t7;

/// A user's membership of a project. Users are referenced by the auth user
/// ID (decision M1-1).
abstract class ProjectMember
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ProjectMember._({
    this.id,
    required this.projectId,
    required this.authUserId,
    required this.role,
    bool? canApprove,
    required this.status,
    required this.joinedAt,
    this.removedAt,
  }) : canApprove = canApprove ?? false;

  factory ProjectMember({
    int? id,
    required int projectId,
    required _isc.UuidValue authUserId,
    required _i46wx1t7.ProjectRole role,
    bool? canApprove,
    required _iolegqnm.MemberStatus status,
    required DateTime joinedAt,
    DateTime? removedAt,
  }) = _ProjectMemberImpl;

  factory ProjectMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProjectMember(
      id: jsonSerialization['id'] as int?,
      projectId: jsonSerialization['projectId'] as int,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      role: _i46wx1t7.ProjectRole.fromJson(
        (jsonSerialization['role'] as String),
      ),
      canApprove: jsonSerialization['canApprove'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['canApprove']),
      status: _iolegqnm.MemberStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      joinedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
      removedAt: jsonSerialization['removedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['removedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int projectId;

  _isc.UuidValue authUserId;

  _i46wx1t7.ProjectRole role;

  /// Approval rights; only meaningful for co-funders (doc/02 §3.2).
  bool canApprove;

  _iolegqnm.MemberStatus status;

  DateTime joinedAt;

  DateTime? removedAt;

  /// Returns a shallow copy of this [ProjectMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ProjectMember copyWith({
    int? id,
    int? projectId,
    _isc.UuidValue? authUserId,
    _i46wx1t7.ProjectRole? role,
    bool? canApprove,
    _iolegqnm.MemberStatus? status,
    DateTime? joinedAt,
    DateTime? removedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProjectMember',
      if (id != null) 'id': id,
      'projectId': projectId,
      'authUserId': authUserId.toJson(),
      'role': role.toJson(),
      'canApprove': canApprove,
      'status': status.toJson(),
      'joinedAt': joinedAt.toJson(),
      if (removedAt != null) 'removedAt': removedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProjectMember',
      if (id != null) 'id': id,
      'projectId': projectId,
      'authUserId': authUserId.toJson(),
      'role': role.toJson(),
      'canApprove': canApprove,
      'status': status.toJson(),
      'joinedAt': joinedAt.toJson(),
      if (removedAt != null) 'removedAt': removedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProjectMemberImpl extends ProjectMember {
  _ProjectMemberImpl({
    int? id,
    required int projectId,
    required _isc.UuidValue authUserId,
    required _i46wx1t7.ProjectRole role,
    bool? canApprove,
    required _iolegqnm.MemberStatus status,
    required DateTime joinedAt,
    DateTime? removedAt,
  }) : super._(
         id: id,
         projectId: projectId,
         authUserId: authUserId,
         role: role,
         canApprove: canApprove,
         status: status,
         joinedAt: joinedAt,
         removedAt: removedAt,
       );

  /// Returns a shallow copy of this [ProjectMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ProjectMember copyWith({
    Object? id = _Undefined,
    int? projectId,
    _isc.UuidValue? authUserId,
    _i46wx1t7.ProjectRole? role,
    bool? canApprove,
    _iolegqnm.MemberStatus? status,
    DateTime? joinedAt,
    Object? removedAt = _Undefined,
  }) {
    return ProjectMember(
      id: id is int? ? id : this.id,
      projectId: projectId ?? this.projectId,
      authUserId: authUserId ?? this.authUserId,
      role: role ?? this.role,
      canApprove: canApprove ?? this.canApprove,
      status: status ?? this.status,
      joinedAt: joinedAt ?? this.joinedAt,
      removedAt: removedAt is DateTime? ? removedAt : this.removedAt,
    );
  }
}
