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
import 'package:plotwatch_client/src/protocol/protocol.dart' as _immd62fm;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'evidence_status.dart' as _itwc15qq;
import 'verification_check.dart' as _i92h88x8;
import 'verification_level.dart' as _i5zqa56i;

/// A photo taken in the app for a stage's checklist item, with what the
/// phone recorded and what the server checked (CAP, VER; doc/02 §7.2,
/// doc/04d). Never edited after finalize; only retracted (CAP-09).
abstract class Evidence
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Evidence._({
    this.id,
    required this.projectId,
    required this.stageId,
    required this.checklistItemId,
    required this.capturedBy,
    this.capturedByName,
    this.capturedByFormer,
    required this.status,
    required this.sha256,
    required this.photoPath,
    this.thumbPath,
    this.fileSizeBytes,
    required this.deviceCapturedAt,
    required this.serverCommittedAt,
    this.finalizedAt,
    this.lat,
    this.lng,
    this.accuracyM,
    this.altitudeM,
    this.isMockLocation,
    required this.capturedInApp,
    this.distanceFromSiteM,
    required this.deviceModel,
    required this.osVersion,
    required this.appVersion,
    required this.verificationLevel,
    this.checks,
    this.caption,
    this.retractedAt,
    this.retractedReason,
  });

  factory Evidence({
    int? id,
    required int projectId,
    required int stageId,
    required int checklistItemId,
    required _isc.UuidValue capturedBy,
    String? capturedByName,
    bool? capturedByFormer,
    required _itwc15qq.EvidenceStatus status,
    required String sha256,
    required String photoPath,
    String? thumbPath,
    int? fileSizeBytes,
    required DateTime deviceCapturedAt,
    required DateTime serverCommittedAt,
    DateTime? finalizedAt,
    double? lat,
    double? lng,
    double? accuracyM,
    double? altitudeM,
    bool? isMockLocation,
    required bool capturedInApp,
    double? distanceFromSiteM,
    required String deviceModel,
    required String osVersion,
    required String appVersion,
    required _i5zqa56i.VerificationLevel verificationLevel,
    List<_i92h88x8.VerificationCheck>? checks,
    String? caption,
    DateTime? retractedAt,
    String? retractedReason,
  }) = _EvidenceImpl;

  factory Evidence.fromJson(Map<String, dynamic> jsonSerialization) {
    return Evidence(
      id: jsonSerialization['id'] as int?,
      projectId: jsonSerialization['projectId'] as int,
      stageId: jsonSerialization['stageId'] as int,
      checklistItemId: jsonSerialization['checklistItemId'] as int,
      capturedBy: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['capturedBy'],
      ),
      capturedByName: jsonSerialization['capturedByName'] as String?,
      capturedByFormer: jsonSerialization['capturedByFormer'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['capturedByFormer'],
            ),
      status: _itwc15qq.EvidenceStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      sha256: jsonSerialization['sha256'] as String,
      photoPath: jsonSerialization['photoPath'] as String,
      thumbPath: jsonSerialization['thumbPath'] as String?,
      fileSizeBytes: jsonSerialization['fileSizeBytes'] as int?,
      deviceCapturedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['deviceCapturedAt'],
      ),
      serverCommittedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['serverCommittedAt'],
      ),
      finalizedAt: jsonSerialization['finalizedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['finalizedAt'],
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
      distanceFromSiteM: (jsonSerialization['distanceFromSiteM'] as num?)
          ?.toDouble(),
      deviceModel: jsonSerialization['deviceModel'] as String,
      osVersion: jsonSerialization['osVersion'] as String,
      appVersion: jsonSerialization['appVersion'] as String,
      verificationLevel: _i5zqa56i.VerificationLevel.fromJson(
        (jsonSerialization['verificationLevel'] as String),
      ),
      checks: jsonSerialization['checks'] == null
          ? null
          : _immd62fm.Protocol().deserialize<List<_i92h88x8.VerificationCheck>>(
              jsonSerialization['checks'],
            ),
      caption: jsonSerialization['caption'] as String?,
      retractedAt: jsonSerialization['retractedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['retractedAt'],
            ),
      retractedReason: jsonSerialization['retractedReason'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int projectId;

  /// Restrict: a stage or item with captures can't disappear (M4-15).
  int stageId;

  int checklistItemId;

  _isc.UuidValue capturedBy;

  /// Who took it, filled when one capture is read (doc/04e C-2d).
  String? capturedByName;

  /// True when they are no longer a member.
  bool? capturedByFormer;

  _itwc15qq.EvidenceStatus status;

  /// The committed hash (lower case).
  String sha256;

  String photoPath;

  String? thumbPath;

  /// Of the stored photo, set at finalize.
  int? fileSizeBytes;

  DateTime deviceCapturedAt;

  /// Trusted: the server's clock at commit.
  DateTime serverCommittedAt;

  DateTime? finalizedAt;

  double? lat;

  double? lng;

  double? accuracyM;

  double? altitudeM;

  bool? isMockLocation;

  bool capturedInApp;

  /// Computed by the server from the site centre.
  double? distanceFromSiteM;

  String deviceModel;

  String osVersion;

  String appVersion;

  _i5zqa56i.VerificationLevel verificationLevel;

  List<_i92h88x8.VerificationCheck>? checks;

  String? caption;

  DateTime? retractedAt;

  String? retractedReason;

  /// Returns a shallow copy of this [Evidence]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Evidence copyWith({
    int? id,
    int? projectId,
    int? stageId,
    int? checklistItemId,
    _isc.UuidValue? capturedBy,
    String? capturedByName,
    bool? capturedByFormer,
    _itwc15qq.EvidenceStatus? status,
    String? sha256,
    String? photoPath,
    String? thumbPath,
    int? fileSizeBytes,
    DateTime? deviceCapturedAt,
    DateTime? serverCommittedAt,
    DateTime? finalizedAt,
    double? lat,
    double? lng,
    double? accuracyM,
    double? altitudeM,
    bool? isMockLocation,
    bool? capturedInApp,
    double? distanceFromSiteM,
    String? deviceModel,
    String? osVersion,
    String? appVersion,
    _i5zqa56i.VerificationLevel? verificationLevel,
    List<_i92h88x8.VerificationCheck>? checks,
    String? caption,
    DateTime? retractedAt,
    String? retractedReason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Evidence',
      if (id != null) 'id': id,
      'projectId': projectId,
      'stageId': stageId,
      'checklistItemId': checklistItemId,
      'capturedBy': capturedBy.toJson(),
      if (capturedByName != null) 'capturedByName': capturedByName,
      if (capturedByFormer != null) 'capturedByFormer': capturedByFormer,
      'status': status.toJson(),
      'sha256': sha256,
      'photoPath': photoPath,
      if (thumbPath != null) 'thumbPath': thumbPath,
      if (fileSizeBytes != null) 'fileSizeBytes': fileSizeBytes,
      'deviceCapturedAt': deviceCapturedAt.toJson(),
      'serverCommittedAt': serverCommittedAt.toJson(),
      if (finalizedAt != null) 'finalizedAt': finalizedAt?.toJson(),
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (accuracyM != null) 'accuracyM': accuracyM,
      if (altitudeM != null) 'altitudeM': altitudeM,
      if (isMockLocation != null) 'isMockLocation': isMockLocation,
      'capturedInApp': capturedInApp,
      if (distanceFromSiteM != null) 'distanceFromSiteM': distanceFromSiteM,
      'deviceModel': deviceModel,
      'osVersion': osVersion,
      'appVersion': appVersion,
      'verificationLevel': verificationLevel.toJson(),
      if (checks != null)
        'checks': checks?.toJson(valueToJson: (v) => v.toJson()),
      if (caption != null) 'caption': caption,
      if (retractedAt != null) 'retractedAt': retractedAt?.toJson(),
      if (retractedReason != null) 'retractedReason': retractedReason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Evidence',
      if (id != null) 'id': id,
      'projectId': projectId,
      'stageId': stageId,
      'checklistItemId': checklistItemId,
      'capturedBy': capturedBy.toJson(),
      if (capturedByName != null) 'capturedByName': capturedByName,
      if (capturedByFormer != null) 'capturedByFormer': capturedByFormer,
      'status': status.toJson(),
      'sha256': sha256,
      'photoPath': photoPath,
      if (thumbPath != null) 'thumbPath': thumbPath,
      if (fileSizeBytes != null) 'fileSizeBytes': fileSizeBytes,
      'deviceCapturedAt': deviceCapturedAt.toJson(),
      'serverCommittedAt': serverCommittedAt.toJson(),
      if (finalizedAt != null) 'finalizedAt': finalizedAt?.toJson(),
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (accuracyM != null) 'accuracyM': accuracyM,
      if (altitudeM != null) 'altitudeM': altitudeM,
      if (isMockLocation != null) 'isMockLocation': isMockLocation,
      'capturedInApp': capturedInApp,
      if (distanceFromSiteM != null) 'distanceFromSiteM': distanceFromSiteM,
      'deviceModel': deviceModel,
      'osVersion': osVersion,
      'appVersion': appVersion,
      'verificationLevel': verificationLevel.toJson(),
      if (checks != null)
        'checks': checks?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (caption != null) 'caption': caption,
      if (retractedAt != null) 'retractedAt': retractedAt?.toJson(),
      if (retractedReason != null) 'retractedReason': retractedReason,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EvidenceImpl extends Evidence {
  _EvidenceImpl({
    int? id,
    required int projectId,
    required int stageId,
    required int checklistItemId,
    required _isc.UuidValue capturedBy,
    String? capturedByName,
    bool? capturedByFormer,
    required _itwc15qq.EvidenceStatus status,
    required String sha256,
    required String photoPath,
    String? thumbPath,
    int? fileSizeBytes,
    required DateTime deviceCapturedAt,
    required DateTime serverCommittedAt,
    DateTime? finalizedAt,
    double? lat,
    double? lng,
    double? accuracyM,
    double? altitudeM,
    bool? isMockLocation,
    required bool capturedInApp,
    double? distanceFromSiteM,
    required String deviceModel,
    required String osVersion,
    required String appVersion,
    required _i5zqa56i.VerificationLevel verificationLevel,
    List<_i92h88x8.VerificationCheck>? checks,
    String? caption,
    DateTime? retractedAt,
    String? retractedReason,
  }) : super._(
         id: id,
         projectId: projectId,
         stageId: stageId,
         checklistItemId: checklistItemId,
         capturedBy: capturedBy,
         capturedByName: capturedByName,
         capturedByFormer: capturedByFormer,
         status: status,
         sha256: sha256,
         photoPath: photoPath,
         thumbPath: thumbPath,
         fileSizeBytes: fileSizeBytes,
         deviceCapturedAt: deviceCapturedAt,
         serverCommittedAt: serverCommittedAt,
         finalizedAt: finalizedAt,
         lat: lat,
         lng: lng,
         accuracyM: accuracyM,
         altitudeM: altitudeM,
         isMockLocation: isMockLocation,
         capturedInApp: capturedInApp,
         distanceFromSiteM: distanceFromSiteM,
         deviceModel: deviceModel,
         osVersion: osVersion,
         appVersion: appVersion,
         verificationLevel: verificationLevel,
         checks: checks,
         caption: caption,
         retractedAt: retractedAt,
         retractedReason: retractedReason,
       );

  /// Returns a shallow copy of this [Evidence]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Evidence copyWith({
    Object? id = _Undefined,
    int? projectId,
    int? stageId,
    int? checklistItemId,
    _isc.UuidValue? capturedBy,
    Object? capturedByName = _Undefined,
    Object? capturedByFormer = _Undefined,
    _itwc15qq.EvidenceStatus? status,
    String? sha256,
    String? photoPath,
    Object? thumbPath = _Undefined,
    Object? fileSizeBytes = _Undefined,
    DateTime? deviceCapturedAt,
    DateTime? serverCommittedAt,
    Object? finalizedAt = _Undefined,
    Object? lat = _Undefined,
    Object? lng = _Undefined,
    Object? accuracyM = _Undefined,
    Object? altitudeM = _Undefined,
    Object? isMockLocation = _Undefined,
    bool? capturedInApp,
    Object? distanceFromSiteM = _Undefined,
    String? deviceModel,
    String? osVersion,
    String? appVersion,
    _i5zqa56i.VerificationLevel? verificationLevel,
    Object? checks = _Undefined,
    Object? caption = _Undefined,
    Object? retractedAt = _Undefined,
    Object? retractedReason = _Undefined,
  }) {
    return Evidence(
      id: id is int? ? id : this.id,
      projectId: projectId ?? this.projectId,
      stageId: stageId ?? this.stageId,
      checklistItemId: checklistItemId ?? this.checklistItemId,
      capturedBy: capturedBy ?? this.capturedBy,
      capturedByName: capturedByName is String?
          ? capturedByName
          : this.capturedByName,
      capturedByFormer: capturedByFormer is bool?
          ? capturedByFormer
          : this.capturedByFormer,
      status: status ?? this.status,
      sha256: sha256 ?? this.sha256,
      photoPath: photoPath ?? this.photoPath,
      thumbPath: thumbPath is String? ? thumbPath : this.thumbPath,
      fileSizeBytes: fileSizeBytes is int? ? fileSizeBytes : this.fileSizeBytes,
      deviceCapturedAt: deviceCapturedAt ?? this.deviceCapturedAt,
      serverCommittedAt: serverCommittedAt ?? this.serverCommittedAt,
      finalizedAt: finalizedAt is DateTime? ? finalizedAt : this.finalizedAt,
      lat: lat is double? ? lat : this.lat,
      lng: lng is double? ? lng : this.lng,
      accuracyM: accuracyM is double? ? accuracyM : this.accuracyM,
      altitudeM: altitudeM is double? ? altitudeM : this.altitudeM,
      isMockLocation: isMockLocation is bool?
          ? isMockLocation
          : this.isMockLocation,
      capturedInApp: capturedInApp ?? this.capturedInApp,
      distanceFromSiteM: distanceFromSiteM is double?
          ? distanceFromSiteM
          : this.distanceFromSiteM,
      deviceModel: deviceModel ?? this.deviceModel,
      osVersion: osVersion ?? this.osVersion,
      appVersion: appVersion ?? this.appVersion,
      verificationLevel: verificationLevel ?? this.verificationLevel,
      checks: checks is List<_i92h88x8.VerificationCheck>?
          ? checks
          : this.checks?.map((e0) => e0.copyWith()).toList(),
      caption: caption is String? ? caption : this.caption,
      retractedAt: retractedAt is DateTime? ? retractedAt : this.retractedAt,
      retractedReason: retractedReason is String?
          ? retractedReason
          : this.retractedReason,
    );
  }
}
