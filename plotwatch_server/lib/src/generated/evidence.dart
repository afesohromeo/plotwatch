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
import 'evidence_status.dart' as _itwc15qq;
import 'verification_check.dart' as _i92h88x8;
import 'verification_level.dart' as _i5zqa56i;

/// A photo taken in the app for a stage's checklist item, with what the
/// phone recorded and what the server checked (CAP, VER; doc/02 §7.2,
/// doc/04d). Never edited after finalize; only retracted (CAP-09).
abstract class Evidence
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    required _is.UuidValue capturedBy,
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
      capturedBy: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['capturedBy'],
      ),
      capturedByName: jsonSerialization['capturedByName'] as String?,
      capturedByFormer: jsonSerialization['capturedByFormer'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['capturedByFormer'],
            ),
      status: _itwc15qq.EvidenceStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      sha256: jsonSerialization['sha256'] as String,
      photoPath: jsonSerialization['photoPath'] as String,
      thumbPath: jsonSerialization['thumbPath'] as String?,
      fileSizeBytes: jsonSerialization['fileSizeBytes'] as int?,
      deviceCapturedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['deviceCapturedAt'],
      ),
      serverCommittedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['serverCommittedAt'],
      ),
      finalizedAt: jsonSerialization['finalizedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['finalizedAt'],
            ),
      lat: (jsonSerialization['lat'] as num?)?.toDouble(),
      lng: (jsonSerialization['lng'] as num?)?.toDouble(),
      accuracyM: (jsonSerialization['accuracyM'] as num?)?.toDouble(),
      altitudeM: (jsonSerialization['altitudeM'] as num?)?.toDouble(),
      isMockLocation: jsonSerialization['isMockLocation'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isMockLocation']),
      capturedInApp: _is.BoolJsonExtension.fromJson(
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
          : _irbavk3a.Protocol().deserialize<List<_i92h88x8.VerificationCheck>>(
              jsonSerialization['checks'],
            ),
      caption: jsonSerialization['caption'] as String?,
      retractedAt: jsonSerialization['retractedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['retractedAt'],
            ),
      retractedReason: jsonSerialization['retractedReason'] as String?,
    );
  }

  static final t = EvidenceTable();

  static const db = EvidenceRepository._();

  @override
  int? id;

  int projectId;

  /// Restrict: a stage or item with captures can't disappear (M4-15).
  int stageId;

  int checklistItemId;

  _is.UuidValue capturedBy;

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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Evidence]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Evidence copyWith({
    int? id,
    int? projectId,
    int? stageId,
    int? checklistItemId,
    _is.UuidValue? capturedBy,
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

  static EvidenceInclude include() {
    return EvidenceInclude._();
  }

  static EvidenceIncludeList includeList({
    _is.WhereExpressionBuilder<EvidenceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EvidenceTable>? orderBy,
    _is.OrderByListBuilder<EvidenceTable>? orderByList,
    EvidenceInclude? include,
  }) {
    return EvidenceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Evidence.t),
      orderByList: orderByList?.call(Evidence.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EvidenceImpl extends Evidence {
  _EvidenceImpl({
    int? id,
    required int projectId,
    required int stageId,
    required int checklistItemId,
    required _is.UuidValue capturedBy,
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
  @_is.useResult
  @override
  Evidence copyWith({
    Object? id = _Undefined,
    int? projectId,
    int? stageId,
    int? checklistItemId,
    _is.UuidValue? capturedBy,
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

class EvidenceUpdateTable extends _is.UpdateTable<EvidenceTable> {
  EvidenceUpdateTable(super.table);

  _is.ColumnValue<int, int> projectId(int value) => _is.ColumnValue(
    table.projectId,
    value,
  );

  _is.ColumnValue<int, int> stageId(int value) => _is.ColumnValue(
    table.stageId,
    value,
  );

  _is.ColumnValue<int, int> checklistItemId(int value) => _is.ColumnValue(
    table.checklistItemId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> capturedBy(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.capturedBy,
    value,
  );

  _is.ColumnValue<_itwc15qq.EvidenceStatus, _itwc15qq.EvidenceStatus> status(
    _itwc15qq.EvidenceStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> sha256(String value) => _is.ColumnValue(
    table.sha256,
    value,
  );

  _is.ColumnValue<String, String> photoPath(String value) => _is.ColumnValue(
    table.photoPath,
    value,
  );

  _is.ColumnValue<String, String> thumbPath(String? value) => _is.ColumnValue(
    table.thumbPath,
    value,
  );

  _is.ColumnValue<int, int> fileSizeBytes(int? value) => _is.ColumnValue(
    table.fileSizeBytes,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> deviceCapturedAt(DateTime value) =>
      _is.ColumnValue(
        table.deviceCapturedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> serverCommittedAt(DateTime value) =>
      _is.ColumnValue(
        table.serverCommittedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> finalizedAt(DateTime? value) =>
      _is.ColumnValue(
        table.finalizedAt,
        value,
      );

  _is.ColumnValue<double, double> lat(double? value) => _is.ColumnValue(
    table.lat,
    value,
  );

  _is.ColumnValue<double, double> lng(double? value) => _is.ColumnValue(
    table.lng,
    value,
  );

  _is.ColumnValue<double, double> accuracyM(double? value) => _is.ColumnValue(
    table.accuracyM,
    value,
  );

  _is.ColumnValue<double, double> altitudeM(double? value) => _is.ColumnValue(
    table.altitudeM,
    value,
  );

  _is.ColumnValue<bool, bool> isMockLocation(bool? value) => _is.ColumnValue(
    table.isMockLocation,
    value,
  );

  _is.ColumnValue<bool, bool> capturedInApp(bool value) => _is.ColumnValue(
    table.capturedInApp,
    value,
  );

  _is.ColumnValue<double, double> distanceFromSiteM(double? value) =>
      _is.ColumnValue(
        table.distanceFromSiteM,
        value,
      );

  _is.ColumnValue<String, String> deviceModel(String value) => _is.ColumnValue(
    table.deviceModel,
    value,
  );

  _is.ColumnValue<String, String> osVersion(String value) => _is.ColumnValue(
    table.osVersion,
    value,
  );

  _is.ColumnValue<String, String> appVersion(String value) => _is.ColumnValue(
    table.appVersion,
    value,
  );

  _is.ColumnValue<_i5zqa56i.VerificationLevel, _i5zqa56i.VerificationLevel>
  verificationLevel(_i5zqa56i.VerificationLevel value) => _is.ColumnValue(
    table.verificationLevel,
    value,
  );

  _is.ColumnValue<
    List<_i92h88x8.VerificationCheck>,
    List<_i92h88x8.VerificationCheck>
  >
  checks(List<_i92h88x8.VerificationCheck>? value) => _is.ColumnValue(
    table.checks,
    value,
  );

  _is.ColumnValue<String, String> caption(String? value) => _is.ColumnValue(
    table.caption,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> retractedAt(DateTime? value) =>
      _is.ColumnValue(
        table.retractedAt,
        value,
      );

  _is.ColumnValue<String, String> retractedReason(String? value) =>
      _is.ColumnValue(
        table.retractedReason,
        value,
      );
}

class EvidenceTable extends _is.Table<int?> {
  EvidenceTable({super.tableRelation}) : super(tableName: 'evidence') {
    updateTable = EvidenceUpdateTable(this);
    projectId = _is.ColumnInt(
      'projectId',
      this,
    );
    stageId = _is.ColumnInt(
      'stageId',
      this,
    );
    checklistItemId = _is.ColumnInt(
      'checklistItemId',
      this,
    );
    capturedBy = _is.ColumnUuid(
      'capturedBy',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    sha256 = _is.ColumnString(
      'sha256',
      this,
    );
    photoPath = _is.ColumnString(
      'photoPath',
      this,
    );
    thumbPath = _is.ColumnString(
      'thumbPath',
      this,
    );
    fileSizeBytes = _is.ColumnInt(
      'fileSizeBytes',
      this,
    );
    deviceCapturedAt = _is.ColumnDateTime(
      'deviceCapturedAt',
      this,
    );
    serverCommittedAt = _is.ColumnDateTime(
      'serverCommittedAt',
      this,
    );
    finalizedAt = _is.ColumnDateTime(
      'finalizedAt',
      this,
    );
    lat = _is.ColumnDouble(
      'lat',
      this,
    );
    lng = _is.ColumnDouble(
      'lng',
      this,
    );
    accuracyM = _is.ColumnDouble(
      'accuracyM',
      this,
    );
    altitudeM = _is.ColumnDouble(
      'altitudeM',
      this,
    );
    isMockLocation = _is.ColumnBool(
      'isMockLocation',
      this,
    );
    capturedInApp = _is.ColumnBool(
      'capturedInApp',
      this,
    );
    distanceFromSiteM = _is.ColumnDouble(
      'distanceFromSiteM',
      this,
    );
    deviceModel = _is.ColumnString(
      'deviceModel',
      this,
    );
    osVersion = _is.ColumnString(
      'osVersion',
      this,
    );
    appVersion = _is.ColumnString(
      'appVersion',
      this,
    );
    verificationLevel = _is.ColumnEnum(
      'verificationLevel',
      this,
      _is.EnumSerialization.byName,
    );
    checks = _is.ColumnSerializable<List<_i92h88x8.VerificationCheck>>(
      'checks',
      this,
    );
    caption = _is.ColumnString(
      'caption',
      this,
    );
    retractedAt = _is.ColumnDateTime(
      'retractedAt',
      this,
    );
    retractedReason = _is.ColumnString(
      'retractedReason',
      this,
    );
  }

  late final EvidenceUpdateTable updateTable;

  late final _is.ColumnInt projectId;

  /// Restrict: a stage or item with captures can't disappear (M4-15).
  late final _is.ColumnInt stageId;

  late final _is.ColumnInt checklistItemId;

  late final _is.ColumnUuid capturedBy;

  late final _is.ColumnEnum<_itwc15qq.EvidenceStatus> status;

  /// The committed hash (lower case).
  late final _is.ColumnString sha256;

  late final _is.ColumnString photoPath;

  late final _is.ColumnString thumbPath;

  /// Of the stored photo, set at finalize.
  late final _is.ColumnInt fileSizeBytes;

  late final _is.ColumnDateTime deviceCapturedAt;

  /// Trusted: the server's clock at commit.
  late final _is.ColumnDateTime serverCommittedAt;

  late final _is.ColumnDateTime finalizedAt;

  late final _is.ColumnDouble lat;

  late final _is.ColumnDouble lng;

  late final _is.ColumnDouble accuracyM;

  late final _is.ColumnDouble altitudeM;

  late final _is.ColumnBool isMockLocation;

  late final _is.ColumnBool capturedInApp;

  /// Computed by the server from the site centre.
  late final _is.ColumnDouble distanceFromSiteM;

  late final _is.ColumnString deviceModel;

  late final _is.ColumnString osVersion;

  late final _is.ColumnString appVersion;

  late final _is.ColumnEnum<_i5zqa56i.VerificationLevel> verificationLevel;

  late final _is.ColumnSerializable<List<_i92h88x8.VerificationCheck>> checks;

  late final _is.ColumnString caption;

  late final _is.ColumnDateTime retractedAt;

  late final _is.ColumnString retractedReason;

  @override
  List<_is.Column> get columns => [
    id,
    projectId,
    stageId,
    checklistItemId,
    capturedBy,
    status,
    sha256,
    photoPath,
    thumbPath,
    fileSizeBytes,
    deviceCapturedAt,
    serverCommittedAt,
    finalizedAt,
    lat,
    lng,
    accuracyM,
    altitudeM,
    isMockLocation,
    capturedInApp,
    distanceFromSiteM,
    deviceModel,
    osVersion,
    appVersion,
    verificationLevel,
    checks,
    caption,
    retractedAt,
    retractedReason,
  ];
}

class EvidenceInclude extends _is.IncludeObject {
  EvidenceInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Evidence.t;
}

class EvidenceIncludeList extends _is.IncludeList {
  EvidenceIncludeList._({
    _is.WhereExpressionBuilder<EvidenceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Evidence.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Evidence.t;
}

class EvidenceRepository {
  const EvidenceRepository._();

  /// Returns a list of [Evidence]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Evidence>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EvidenceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EvidenceTable>? orderBy,
    _is.OrderByListBuilder<EvidenceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Evidence>(
      where: where?.call(Evidence.t),
      orderBy: orderBy?.call(Evidence.t),
      orderByList: orderByList?.call(Evidence.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Evidence] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Evidence?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EvidenceTable>? where,
    int? offset,
    _is.OrderByBuilder<EvidenceTable>? orderBy,
    _is.OrderByListBuilder<EvidenceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Evidence>(
      where: where?.call(Evidence.t),
      orderBy: orderBy?.call(Evidence.t),
      orderByList: orderByList?.call(Evidence.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Evidence] by its [id] or null if no such row exists.
  Future<Evidence?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Evidence>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Evidence]s in the list and returns the inserted rows.
  ///
  /// The returned [Evidence]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Evidence>> insert(
    _is.DatabaseSession session,
    List<Evidence> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Evidence>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Evidence] and returns the inserted row.
  ///
  /// The returned [Evidence] will have its `id` field set.
  Future<Evidence> insertRow(
    _is.DatabaseSession session,
    Evidence row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Evidence>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Evidence]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Evidence]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Evidence>> upsert(
    _is.DatabaseSession session,
    List<Evidence> rows, {
    required _is.ColumnSelections<EvidenceTable> conflictColumns,
    _is.ColumnSelections<EvidenceTable>? updateColumns,
    _is.WhereExpressionBuilder<EvidenceTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Evidence>(
      rows,
      conflictColumns: conflictColumns(Evidence.t),
      updateColumns: updateColumns?.call(Evidence.t),
      updateWhere: updateWhere?.call(Evidence.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Evidence] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Evidence] will have its `id` field set.
  Future<Evidence?> upsertRow(
    _is.DatabaseSession session,
    Evidence row, {
    required _is.ColumnSelections<EvidenceTable> conflictColumns,
    _is.ColumnSelections<EvidenceTable>? updateColumns,
    _is.WhereExpressionBuilder<EvidenceTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Evidence>(
      row,
      conflictColumns: conflictColumns(Evidence.t),
      updateColumns: updateColumns?.call(Evidence.t),
      updateWhere: updateWhere?.call(Evidence.t),
      transaction: transaction,
    );
  }

  /// Updates all [Evidence]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Evidence>> update(
    _is.DatabaseSession session,
    List<Evidence> rows, {
    _is.ColumnSelections<EvidenceTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Evidence>(
      rows,
      columns: columns?.call(Evidence.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Evidence]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Evidence> updateRow(
    _is.DatabaseSession session,
    Evidence row, {
    _is.ColumnSelections<EvidenceTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Evidence>(
      row,
      columns: columns?.call(Evidence.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Evidence] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Evidence?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<EvidenceUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Evidence>(
      id,
      columnValues: columnValues(Evidence.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Evidence]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Evidence>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EvidenceUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<EvidenceTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EvidenceTable>? orderBy,
    _is.OrderByListBuilder<EvidenceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Evidence>(
      columnValues: columnValues(Evidence.t.updateTable),
      where: where(Evidence.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Evidence.t),
      orderByList: orderByList?.call(Evidence.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Evidence]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Evidence>> delete(
    _is.DatabaseSession session,
    List<Evidence> rows, {
    _is.OrderByBuilder<EvidenceTable>? orderBy,
    _is.OrderByListBuilder<EvidenceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Evidence>(
      rows,
      orderBy: orderBy?.call(Evidence.t),
      orderByList: orderByList?.call(Evidence.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Evidence].
  Future<Evidence> deleteRow(
    _is.DatabaseSession session,
    Evidence row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Evidence>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Evidence>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EvidenceTable> where,
    _is.OrderByBuilder<EvidenceTable>? orderBy,
    _is.OrderByListBuilder<EvidenceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Evidence>(
      where: where(Evidence.t),
      orderBy: orderBy?.call(Evidence.t),
      orderByList: orderByList?.call(Evidence.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EvidenceTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Evidence>(
      where: where?.call(Evidence.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Evidence] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EvidenceTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Evidence>(
      where: where(Evidence.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
