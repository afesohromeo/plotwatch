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

/// What the phone sends when a photo is taken (CAP-03, CAP-05, CAP-06).
/// Immutable: a value object compared by its fields (==).
@_isc.immutable
abstract class EvidenceCommit
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  const EvidenceCommit._({
    required this.stageId,
    required this.checklistItemId,
    required this.sha256,
    required this.deviceCapturedAt,
    this.lat,
    this.lng,
    this.accuracyM,
    this.altitudeM,
    this.isMockLocation,
    required this.capturedInApp,
    required this.deviceModel,
    required this.osVersion,
    required this.appVersion,
    this.caption,
  });

  const factory EvidenceCommit({
    required int stageId,
    required int checklistItemId,
    required String sha256,
    required DateTime deviceCapturedAt,
    double? lat,
    double? lng,
    double? accuracyM,
    double? altitudeM,
    bool? isMockLocation,
    required bool capturedInApp,
    required String deviceModel,
    required String osVersion,
    required String appVersion,
    String? caption,
  }) = _EvidenceCommitImpl;

  factory EvidenceCommit.fromJson(Map<String, dynamic> jsonSerialization) {
    return EvidenceCommit(
      stageId: jsonSerialization['stageId'] as int,
      checklistItemId: jsonSerialization['checklistItemId'] as int,
      sha256: jsonSerialization['sha256'] as String,
      deviceCapturedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['deviceCapturedAt'],
      ),
      lat: (jsonSerialization['lat'] as num?)?.toDouble(),
      lng: (jsonSerialization['lng'] as num?)?.toDouble(),
      accuracyM: (jsonSerialization['accuracyM'] as num?)?.toDouble(),
      altitudeM: (jsonSerialization['altitudeM'] as num?)?.toDouble(),
      isMockLocation: jsonSerialization['isMockLocation'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['isMockLocation'],
            ),
      capturedInApp: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['capturedInApp'],
      ),
      deviceModel: jsonSerialization['deviceModel'] as String,
      osVersion: jsonSerialization['osVersion'] as String,
      appVersion: jsonSerialization['appVersion'] as String,
      caption: jsonSerialization['caption'] as String?,
    );
  }

  final int stageId;

  final int checklistItemId;

  /// SHA-256 of the exact bytes that will be uploaded, 64 hex characters
  /// (decision M4-2).
  final String sha256;

  /// From the phone; not trusted on its own (checks V7, V8).
  final DateTime deviceCapturedAt;

  /// No fix is allowed: the capture is then not verified (M4-8).
  final double? lat;

  final double? lng;

  final double? accuracyM;

  final double? altitudeM;

  /// Android only.
  final bool? isMockLocation;

  /// The app attests the photo came from its own camera (check V1).
  final bool capturedInApp;

  final String deviceModel;

  final String osVersion;

  final String appVersion;

  /// At most 500 characters.
  final String? caption;

  /// Returns a shallow copy of this [EvidenceCommit]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EvidenceCommit copyWith({
    int? stageId,
    int? checklistItemId,
    String? sha256,
    DateTime? deviceCapturedAt,
    double? lat,
    double? lng,
    double? accuracyM,
    double? altitudeM,
    bool? isMockLocation,
    bool? capturedInApp,
    String? deviceModel,
    String? osVersion,
    String? appVersion,
    String? caption,
  });
  @override
  bool operator ==(Object other) {
    return identical(
          other,
          this,
        ) ||
        other.runtimeType == runtimeType &&
            other is EvidenceCommit &&
            (identical(
                  other.stageId,
                  stageId,
                ) ||
                other.stageId == stageId) &&
            (identical(
                  other.checklistItemId,
                  checklistItemId,
                ) ||
                other.checklistItemId == checklistItemId) &&
            (identical(
                  other.sha256,
                  sha256,
                ) ||
                other.sha256 == sha256) &&
            (identical(
                  other.deviceCapturedAt,
                  deviceCapturedAt,
                ) ||
                other.deviceCapturedAt == deviceCapturedAt) &&
            (identical(
                  other.lat,
                  lat,
                ) ||
                other.lat == lat) &&
            (identical(
                  other.lng,
                  lng,
                ) ||
                other.lng == lng) &&
            (identical(
                  other.accuracyM,
                  accuracyM,
                ) ||
                other.accuracyM == accuracyM) &&
            (identical(
                  other.altitudeM,
                  altitudeM,
                ) ||
                other.altitudeM == altitudeM) &&
            (identical(
                  other.isMockLocation,
                  isMockLocation,
                ) ||
                other.isMockLocation == isMockLocation) &&
            (identical(
                  other.capturedInApp,
                  capturedInApp,
                ) ||
                other.capturedInApp == capturedInApp) &&
            (identical(
                  other.deviceModel,
                  deviceModel,
                ) ||
                other.deviceModel == deviceModel) &&
            (identical(
                  other.osVersion,
                  osVersion,
                ) ||
                other.osVersion == osVersion) &&
            (identical(
                  other.appVersion,
                  appVersion,
                ) ||
                other.appVersion == appVersion) &&
            (identical(
                  other.caption,
                  caption,
                ) ||
                other.caption == caption);
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      stageId,
      checklistItemId,
      sha256,
      deviceCapturedAt,
      lat,
      lng,
      accuracyM,
      altitudeM,
      isMockLocation,
      capturedInApp,
      deviceModel,
      osVersion,
      appVersion,
      caption,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EvidenceCommit',
      'stageId': stageId,
      'checklistItemId': checklistItemId,
      'sha256': sha256,
      'deviceCapturedAt': deviceCapturedAt.toJson(),
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (accuracyM != null) 'accuracyM': accuracyM,
      if (altitudeM != null) 'altitudeM': altitudeM,
      if (isMockLocation != null) 'isMockLocation': isMockLocation,
      'capturedInApp': capturedInApp,
      'deviceModel': deviceModel,
      'osVersion': osVersion,
      'appVersion': appVersion,
      if (caption != null) 'caption': caption,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EvidenceCommit',
      'stageId': stageId,
      'checklistItemId': checklistItemId,
      'sha256': sha256,
      'deviceCapturedAt': deviceCapturedAt.toJson(),
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (accuracyM != null) 'accuracyM': accuracyM,
      if (altitudeM != null) 'altitudeM': altitudeM,
      if (isMockLocation != null) 'isMockLocation': isMockLocation,
      'capturedInApp': capturedInApp,
      'deviceModel': deviceModel,
      'osVersion': osVersion,
      'appVersion': appVersion,
      if (caption != null) 'caption': caption,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EvidenceCommitImpl extends EvidenceCommit {
  const _EvidenceCommitImpl({
    required int stageId,
    required int checklistItemId,
    required String sha256,
    required DateTime deviceCapturedAt,
    double? lat,
    double? lng,
    double? accuracyM,
    double? altitudeM,
    bool? isMockLocation,
    required bool capturedInApp,
    required String deviceModel,
    required String osVersion,
    required String appVersion,
    String? caption,
  }) : super._(
         stageId: stageId,
         checklistItemId: checklistItemId,
         sha256: sha256,
         deviceCapturedAt: deviceCapturedAt,
         lat: lat,
         lng: lng,
         accuracyM: accuracyM,
         altitudeM: altitudeM,
         isMockLocation: isMockLocation,
         capturedInApp: capturedInApp,
         deviceModel: deviceModel,
         osVersion: osVersion,
         appVersion: appVersion,
         caption: caption,
       );

  /// Returns a shallow copy of this [EvidenceCommit]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EvidenceCommit copyWith({
    int? stageId,
    int? checklistItemId,
    String? sha256,
    DateTime? deviceCapturedAt,
    Object? lat = _Undefined,
    Object? lng = _Undefined,
    Object? accuracyM = _Undefined,
    Object? altitudeM = _Undefined,
    Object? isMockLocation = _Undefined,
    bool? capturedInApp,
    String? deviceModel,
    String? osVersion,
    String? appVersion,
    Object? caption = _Undefined,
  }) {
    return EvidenceCommit(
      stageId: stageId ?? this.stageId,
      checklistItemId: checklistItemId ?? this.checklistItemId,
      sha256: sha256 ?? this.sha256,
      deviceCapturedAt: deviceCapturedAt ?? this.deviceCapturedAt,
      lat: lat is double? ? lat : this.lat,
      lng: lng is double? ? lng : this.lng,
      accuracyM: accuracyM is double? ? accuracyM : this.accuracyM,
      altitudeM: altitudeM is double? ? altitudeM : this.altitudeM,
      isMockLocation: isMockLocation is bool?
          ? isMockLocation
          : this.isMockLocation,
      capturedInApp: capturedInApp ?? this.capturedInApp,
      deviceModel: deviceModel ?? this.deviceModel,
      osVersion: osVersion ?? this.osVersion,
      appVersion: appVersion ?? this.appVersion,
      caption: caption is String? ? caption : this.caption,
    );
  }
}
