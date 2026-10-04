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

/// App settings of a signed-in user. Name and email live in the auth
/// module's own profile (decision M1-1, doc/04a-m1-foundation.md).
abstract class UserSettings
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  UserSettings._({
    this.id,
    required this.authUserId,
    this.countryCode,
    required this.locale,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserSettings({
    int? id,
    required _isc.UuidValue authUserId,
    String? countryCode,
    required String locale,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserSettingsImpl;

  factory UserSettings.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserSettings(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      countryCode: jsonSerialization['countryCode'] as String?,
      locale: jsonSerialization['locale'] as String,
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

  /// The auth module's user ID (`session.authenticated!.authUserId`).
  _isc.UuidValue authUserId;

  /// ISO 3166-1 alpha-2, upper case (e.g. CM); null when not set.
  String? countryCode;

  /// `en` or `fr`.
  String locale;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [UserSettings]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  UserSettings copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? countryCode,
    String? locale,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserSettings',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (countryCode != null) 'countryCode': countryCode,
      'locale': locale,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserSettings',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (countryCode != null) 'countryCode': countryCode,
      'locale': locale,
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

class _UserSettingsImpl extends UserSettings {
  _UserSettingsImpl({
    int? id,
    required _isc.UuidValue authUserId,
    String? countryCode,
    required String locale,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         countryCode: countryCode,
         locale: locale,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [UserSettings]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  UserSettings copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    Object? countryCode = _Undefined,
    String? locale,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserSettings(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      countryCode: countryCode is String? ? countryCode : this.countryCode,
      locale: locale ?? this.locale,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
