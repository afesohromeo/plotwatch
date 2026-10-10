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
import 'package:plotwatch_server/src/generated/protocol.dart' as _irbavk3a;
import 'package:serverpod/serverpod.dart' as _is;
import 'project_member.dart' as _i7o7d07j;

/// A member as the members list shows them (MEMB-04).
abstract class MemberView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  MemberView._({
    required this.member,
    this.fullName,
    this.email,
    this.removedByName,
  });

  factory MemberView({
    required _i7o7d07j.ProjectMember member,
    String? fullName,
    String? email,
    String? removedByName,
  }) = _MemberViewImpl;

  factory MemberView.fromJson(Map<String, dynamic> jsonSerialization) {
    return MemberView(
      member: _irbavk3a.Protocol().deserialize<_i7o7d07j.ProjectMember>(
        jsonSerialization['member'],
      ),
      fullName: jsonSerialization['fullName'] as String?,
      email: jsonSerialization['email'] as String?,
      removedByName: jsonSerialization['removedByName'] as String?,
    );
  }

  _i7o7d07j.ProjectMember member;

  String? fullName;

  String? email;

  /// For a former member: who removed them (doc/04e C-2b).
  String? removedByName;

  /// Returns a shallow copy of this [MemberView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MemberView copyWith({
    _i7o7d07j.ProjectMember? member,
    String? fullName,
    String? email,
    String? removedByName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MemberView',
      'member': member.toJson(),
      if (fullName != null) 'fullName': fullName,
      if (email != null) 'email': email,
      if (removedByName != null) 'removedByName': removedByName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MemberView',
      'member': member.toJsonForProtocol(),
      if (fullName != null) 'fullName': fullName,
      if (email != null) 'email': email,
      if (removedByName != null) 'removedByName': removedByName,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MemberViewImpl extends MemberView {
  _MemberViewImpl({
    required _i7o7d07j.ProjectMember member,
    String? fullName,
    String? email,
    String? removedByName,
  }) : super._(
         member: member,
         fullName: fullName,
         email: email,
         removedByName: removedByName,
       );

  /// Returns a shallow copy of this [MemberView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MemberView copyWith({
    _i7o7d07j.ProjectMember? member,
    Object? fullName = _Undefined,
    Object? email = _Undefined,
    Object? removedByName = _Undefined,
  }) {
    return MemberView(
      member: member ?? this.member.copyWith(),
      fullName: fullName is String? ? fullName : this.fullName,
      email: email is String? ? email : this.email,
      removedByName: removedByName is String?
          ? removedByName
          : this.removedByName,
    );
  }
}
