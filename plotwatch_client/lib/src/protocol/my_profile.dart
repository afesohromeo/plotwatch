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

/// What the app shows on the profile screen: the auth module's name and
/// email plus our [UserSettings] (no table).
abstract class MyProfile
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MyProfile._({
    this.fullName,
    this.email,
    this.countryCode,
    required this.locale,
  });

  factory MyProfile({
    String? fullName,
    String? email,
    String? countryCode,
    required String locale,
  }) = _MyProfileImpl;

  factory MyProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return MyProfile(
      fullName: jsonSerialization['fullName'] as String?,
      email: jsonSerialization['email'] as String?,
      countryCode: jsonSerialization['countryCode'] as String?,
      locale: jsonSerialization['locale'] as String,
    );
  }

  String? fullName;

  String? email;

  String? countryCode;

  String locale;

  /// Returns a shallow copy of this [MyProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MyProfile copyWith({
    String? fullName,
    String? email,
    String? countryCode,
    String? locale,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MyProfile',
      if (fullName != null) 'fullName': fullName,
      if (email != null) 'email': email,
      if (countryCode != null) 'countryCode': countryCode,
      'locale': locale,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MyProfile',
      if (fullName != null) 'fullName': fullName,
      if (email != null) 'email': email,
      if (countryCode != null) 'countryCode': countryCode,
      'locale': locale,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MyProfileImpl extends MyProfile {
  _MyProfileImpl({
    String? fullName,
    String? email,
    String? countryCode,
    required String locale,
  }) : super._(
         fullName: fullName,
         email: email,
         countryCode: countryCode,
         locale: locale,
       );

  /// Returns a shallow copy of this [MyProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MyProfile copyWith({
    Object? fullName = _Undefined,
    Object? email = _Undefined,
    Object? countryCode = _Undefined,
    String? locale,
  }) {
    return MyProfile(
      fullName: fullName is String? ? fullName : this.fullName,
      email: email is String? ? email : this.email,
      countryCode: countryCode is String? ? countryCode : this.countryCode,
      locale: locale ?? this.locale,
    );
  }
}
