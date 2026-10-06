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

/// Where the project is built: the centre and radius that captures are
/// checked against (SITE). One per project, created when the owner validates
/// the first proposal (decision M2-15).
abstract class Site
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Site._({
    this.id,
    required this.projectId,
    required this.centerLat,
    required this.centerLng,
    required this.plusCode,
    required this.radiusM,
    this.addressText,
    this.timezone,
    required this.validatedProposalId,
    required this.validatedBy,
    required this.validatedAt,
    required this.updatedAt,
  });

  factory Site({
    int? id,
    required int projectId,
    required double centerLat,
    required double centerLng,
    required String plusCode,
    required int radiusM,
    String? addressText,
    String? timezone,
    required int validatedProposalId,
    required _isc.UuidValue validatedBy,
    required DateTime validatedAt,
    required DateTime updatedAt,
  }) = _SiteImpl;

  factory Site.fromJson(Map<String, dynamic> jsonSerialization) {
    return Site(
      id: jsonSerialization['id'] as int?,
      projectId: jsonSerialization['projectId'] as int,
      centerLat: (jsonSerialization['centerLat'] as num).toDouble(),
      centerLng: (jsonSerialization['centerLng'] as num).toDouble(),
      plusCode: jsonSerialization['plusCode'] as String,
      radiusM: jsonSerialization['radiusM'] as int,
      addressText: jsonSerialization['addressText'] as String?,
      timezone: jsonSerialization['timezone'] as String?,
      validatedProposalId: jsonSerialization['validatedProposalId'] as int,
      validatedBy: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['validatedBy'],
      ),
      validatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['validatedAt'],
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

  double centerLat;

  double centerLng;

  /// 10-digit Plus Code, computed by the server from the centre.
  String plusCode;

  /// 10–500 m, set by the owner when validating (SITE-03, decision M2-16).
  int radiusM;

  String? addressText;

  /// IANA time zone; no UI in the MVP (decision M2-10).
  String? timezone;

  /// The proposal this location comes from.
  int validatedProposalId;

  _isc.UuidValue validatedBy;

  DateTime validatedAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Site]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Site copyWith({
    int? id,
    int? projectId,
    double? centerLat,
    double? centerLng,
    String? plusCode,
    int? radiusM,
    String? addressText,
    String? timezone,
    int? validatedProposalId,
    _isc.UuidValue? validatedBy,
    DateTime? validatedAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Site',
      if (id != null) 'id': id,
      'projectId': projectId,
      'centerLat': centerLat,
      'centerLng': centerLng,
      'plusCode': plusCode,
      'radiusM': radiusM,
      if (addressText != null) 'addressText': addressText,
      if (timezone != null) 'timezone': timezone,
      'validatedProposalId': validatedProposalId,
      'validatedBy': validatedBy.toJson(),
      'validatedAt': validatedAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Site',
      if (id != null) 'id': id,
      'projectId': projectId,
      'centerLat': centerLat,
      'centerLng': centerLng,
      'plusCode': plusCode,
      'radiusM': radiusM,
      if (addressText != null) 'addressText': addressText,
      if (timezone != null) 'timezone': timezone,
      'validatedProposalId': validatedProposalId,
      'validatedBy': validatedBy.toJson(),
      'validatedAt': validatedAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SiteImpl extends Site {
  _SiteImpl({
    int? id,
    required int projectId,
    required double centerLat,
    required double centerLng,
    required String plusCode,
    required int radiusM,
    String? addressText,
    String? timezone,
    required int validatedProposalId,
    required _isc.UuidValue validatedBy,
    required DateTime validatedAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         projectId: projectId,
         centerLat: centerLat,
         centerLng: centerLng,
         plusCode: plusCode,
         radiusM: radiusM,
         addressText: addressText,
         timezone: timezone,
         validatedProposalId: validatedProposalId,
         validatedBy: validatedBy,
         validatedAt: validatedAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Site]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Site copyWith({
    Object? id = _Undefined,
    int? projectId,
    double? centerLat,
    double? centerLng,
    String? plusCode,
    int? radiusM,
    Object? addressText = _Undefined,
    Object? timezone = _Undefined,
    int? validatedProposalId,
    _isc.UuidValue? validatedBy,
    DateTime? validatedAt,
    DateTime? updatedAt,
  }) {
    return Site(
      id: id is int? ? id : this.id,
      projectId: projectId ?? this.projectId,
      centerLat: centerLat ?? this.centerLat,
      centerLng: centerLng ?? this.centerLng,
      plusCode: plusCode ?? this.plusCode,
      radiusM: radiusM ?? this.radiusM,
      addressText: addressText is String? ? addressText : this.addressText,
      timezone: timezone is String? ? timezone : this.timezone,
      validatedProposalId: validatedProposalId ?? this.validatedProposalId,
      validatedBy: validatedBy ?? this.validatedBy,
      validatedAt: validatedAt ?? this.validatedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
