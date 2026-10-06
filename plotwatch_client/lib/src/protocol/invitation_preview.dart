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
import 'project_role.dart' as _i46wx1t7;

/// What someone sees before accepting an invitation (MEMB-03).
abstract class InvitationPreview
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  InvitationPreview._({
    required this.projectName,
    required this.role,
    required this.canApprove,
    this.inviterName,
    required this.expiresAt,
  });

  factory InvitationPreview({
    required String projectName,
    required _i46wx1t7.ProjectRole role,
    required bool canApprove,
    String? inviterName,
    required DateTime expiresAt,
  }) = _InvitationPreviewImpl;

  factory InvitationPreview.fromJson(Map<String, dynamic> jsonSerialization) {
    return InvitationPreview(
      projectName: jsonSerialization['projectName'] as String,
      role: _i46wx1t7.ProjectRole.fromJson(
        (jsonSerialization['role'] as String),
      ),
      canApprove: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['canApprove'],
      ),
      inviterName: jsonSerialization['inviterName'] as String?,
      expiresAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  String projectName;

  _i46wx1t7.ProjectRole role;

  bool canApprove;

  /// Null when the inviter has no name in their profile.
  String? inviterName;

  DateTime expiresAt;

  /// Returns a shallow copy of this [InvitationPreview]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  InvitationPreview copyWith({
    String? projectName,
    _i46wx1t7.ProjectRole? role,
    bool? canApprove,
    String? inviterName,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InvitationPreview',
      'projectName': projectName,
      'role': role.toJson(),
      'canApprove': canApprove,
      if (inviterName != null) 'inviterName': inviterName,
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InvitationPreview',
      'projectName': projectName,
      'role': role.toJson(),
      'canApprove': canApprove,
      if (inviterName != null) 'inviterName': inviterName,
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InvitationPreviewImpl extends InvitationPreview {
  _InvitationPreviewImpl({
    required String projectName,
    required _i46wx1t7.ProjectRole role,
    required bool canApprove,
    String? inviterName,
    required DateTime expiresAt,
  }) : super._(
         projectName: projectName,
         role: role,
         canApprove: canApprove,
         inviterName: inviterName,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [InvitationPreview]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  InvitationPreview copyWith({
    String? projectName,
    _i46wx1t7.ProjectRole? role,
    bool? canApprove,
    Object? inviterName = _Undefined,
    DateTime? expiresAt,
  }) {
    return InvitationPreview(
      projectName: projectName ?? this.projectName,
      role: role ?? this.role,
      canApprove: canApprove ?? this.canApprove,
      inviterName: inviterName is String? ? inviterName : this.inviterName,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}
