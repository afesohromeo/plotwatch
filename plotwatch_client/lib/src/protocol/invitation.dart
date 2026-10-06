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
import 'invitation_status.dart' as _ifbgrtog;
import 'project_role.dart' as _i46wx1t7;

/// An invitation to join a project with a role (MEMB-01, 02).
abstract class Invitation
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Invitation._({
    this.id,
    required this.projectId,
    required this.role,
    bool? canApprove,
    required this.code,
    required this.status,
    required this.expiresAt,
    required this.createdBy,
    this.acceptedBy,
    required this.createdAt,
  }) : canApprove = canApprove ?? false;

  factory Invitation({
    int? id,
    required int projectId,
    required _i46wx1t7.ProjectRole role,
    bool? canApprove,
    required String code,
    required _ifbgrtog.InvitationStatus status,
    required DateTime expiresAt,
    required _isc.UuidValue createdBy,
    _isc.UuidValue? acceptedBy,
    required DateTime createdAt,
  }) = _InvitationImpl;

  factory Invitation.fromJson(Map<String, dynamic> jsonSerialization) {
    return Invitation(
      id: jsonSerialization['id'] as int?,
      projectId: jsonSerialization['projectId'] as int,
      role: _i46wx1t7.ProjectRole.fromJson(
        (jsonSerialization['role'] as String),
      ),
      canApprove: jsonSerialization['canApprove'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['canApprove']),
      code: jsonSerialization['code'] as String,
      status: _ifbgrtog.InvitationStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      expiresAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      createdBy: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['createdBy'],
      ),
      acceptedBy: jsonSerialization['acceptedBy'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['acceptedBy'],
            ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int projectId;

  _i46wx1t7.ProjectRole role;

  bool canApprove;

  /// 8 characters, stored without the hyphen (decision M2-6).
  String code;

  _ifbgrtog.InvitationStatus status;

  DateTime expiresAt;

  _isc.UuidValue createdBy;

  _isc.UuidValue? acceptedBy;

  DateTime createdAt;

  /// Returns a shallow copy of this [Invitation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Invitation copyWith({
    int? id,
    int? projectId,
    _i46wx1t7.ProjectRole? role,
    bool? canApprove,
    String? code,
    _ifbgrtog.InvitationStatus? status,
    DateTime? expiresAt,
    _isc.UuidValue? createdBy,
    _isc.UuidValue? acceptedBy,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Invitation',
      if (id != null) 'id': id,
      'projectId': projectId,
      'role': role.toJson(),
      'canApprove': canApprove,
      'code': code,
      'status': status.toJson(),
      'expiresAt': expiresAt.toJson(),
      'createdBy': createdBy.toJson(),
      if (acceptedBy != null) 'acceptedBy': acceptedBy?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Invitation',
      if (id != null) 'id': id,
      'projectId': projectId,
      'role': role.toJson(),
      'canApprove': canApprove,
      'code': code,
      'status': status.toJson(),
      'expiresAt': expiresAt.toJson(),
      'createdBy': createdBy.toJson(),
      if (acceptedBy != null) 'acceptedBy': acceptedBy?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InvitationImpl extends Invitation {
  _InvitationImpl({
    int? id,
    required int projectId,
    required _i46wx1t7.ProjectRole role,
    bool? canApprove,
    required String code,
    required _ifbgrtog.InvitationStatus status,
    required DateTime expiresAt,
    required _isc.UuidValue createdBy,
    _isc.UuidValue? acceptedBy,
    required DateTime createdAt,
  }) : super._(
         id: id,
         projectId: projectId,
         role: role,
         canApprove: canApprove,
         code: code,
         status: status,
         expiresAt: expiresAt,
         createdBy: createdBy,
         acceptedBy: acceptedBy,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Invitation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Invitation copyWith({
    Object? id = _Undefined,
    int? projectId,
    _i46wx1t7.ProjectRole? role,
    bool? canApprove,
    String? code,
    _ifbgrtog.InvitationStatus? status,
    DateTime? expiresAt,
    _isc.UuidValue? createdBy,
    Object? acceptedBy = _Undefined,
    DateTime? createdAt,
  }) {
    return Invitation(
      id: id is int? ? id : this.id,
      projectId: projectId ?? this.projectId,
      role: role ?? this.role,
      canApprove: canApprove ?? this.canApprove,
      code: code ?? this.code,
      status: status ?? this.status,
      expiresAt: expiresAt ?? this.expiresAt,
      createdBy: createdBy ?? this.createdBy,
      acceptedBy: acceptedBy is _isc.UuidValue? ? acceptedBy : this.acceptedBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
