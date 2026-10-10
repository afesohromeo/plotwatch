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
import 'weather.dart' as _ifjsehv5;

/// The site manager's news from the site, without photos for now
/// (UPD-01, doc/04e M5-9 b).
abstract class ProgressUpdate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ProgressUpdate._({
    this.id,
    required this.projectId,
    this.stageId,
    required this.authorId,
    this.authorName,
    this.authorFormer,
    required this.text,
    this.workersCount,
    this.weather,
    this.issues,
    required this.createdAt,
  });

  factory ProgressUpdate({
    int? id,
    required int projectId,
    int? stageId,
    required _isc.UuidValue authorId,
    String? authorName,
    bool? authorFormer,
    required String text,
    int? workersCount,
    _ifjsehv5.Weather? weather,
    String? issues,
    required DateTime createdAt,
  }) = _ProgressUpdateImpl;

  factory ProgressUpdate.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProgressUpdate(
      id: jsonSerialization['id'] as int?,
      projectId: jsonSerialization['projectId'] as int,
      stageId: jsonSerialization['stageId'] as int?,
      authorId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authorId'],
      ),
      authorName: jsonSerialization['authorName'] as String?,
      authorFormer: jsonSerialization['authorFormer'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['authorFormer']),
      text: jsonSerialization['text'] as String,
      workersCount: jsonSerialization['workersCount'] as int?,
      weather: jsonSerialization['weather'] == null
          ? null
          : _ifjsehv5.Weather.fromJson(
              (jsonSerialization['weather'] as String),
            ),
      issues: jsonSerialization['issues'] as String?,
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

  int? stageId;

  _isc.UuidValue authorId;

  /// Filled when one update is read (doc/04e C-2d).
  String? authorName;

  /// True when they are no longer a member.
  bool? authorFormer;

  /// 1–2,000 characters.
  String text;

  /// 0–999.
  int? workersCount;

  _ifjsehv5.Weather? weather;

  /// At most 1,000 characters.
  String? issues;

  DateTime createdAt;

  /// Returns a shallow copy of this [ProgressUpdate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ProgressUpdate copyWith({
    int? id,
    int? projectId,
    int? stageId,
    _isc.UuidValue? authorId,
    String? authorName,
    bool? authorFormer,
    String? text,
    int? workersCount,
    _ifjsehv5.Weather? weather,
    String? issues,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProgressUpdate',
      if (id != null) 'id': id,
      'projectId': projectId,
      if (stageId != null) 'stageId': stageId,
      'authorId': authorId.toJson(),
      if (authorName != null) 'authorName': authorName,
      if (authorFormer != null) 'authorFormer': authorFormer,
      'text': text,
      if (workersCount != null) 'workersCount': workersCount,
      if (weather != null) 'weather': weather?.toJson(),
      if (issues != null) 'issues': issues,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProgressUpdate',
      if (id != null) 'id': id,
      'projectId': projectId,
      if (stageId != null) 'stageId': stageId,
      'authorId': authorId.toJson(),
      if (authorName != null) 'authorName': authorName,
      if (authorFormer != null) 'authorFormer': authorFormer,
      'text': text,
      if (workersCount != null) 'workersCount': workersCount,
      if (weather != null) 'weather': weather?.toJson(),
      if (issues != null) 'issues': issues,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProgressUpdateImpl extends ProgressUpdate {
  _ProgressUpdateImpl({
    int? id,
    required int projectId,
    int? stageId,
    required _isc.UuidValue authorId,
    String? authorName,
    bool? authorFormer,
    required String text,
    int? workersCount,
    _ifjsehv5.Weather? weather,
    String? issues,
    required DateTime createdAt,
  }) : super._(
         id: id,
         projectId: projectId,
         stageId: stageId,
         authorId: authorId,
         authorName: authorName,
         authorFormer: authorFormer,
         text: text,
         workersCount: workersCount,
         weather: weather,
         issues: issues,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ProgressUpdate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ProgressUpdate copyWith({
    Object? id = _Undefined,
    int? projectId,
    Object? stageId = _Undefined,
    _isc.UuidValue? authorId,
    Object? authorName = _Undefined,
    Object? authorFormer = _Undefined,
    String? text,
    Object? workersCount = _Undefined,
    Object? weather = _Undefined,
    Object? issues = _Undefined,
    DateTime? createdAt,
  }) {
    return ProgressUpdate(
      id: id is int? ? id : this.id,
      projectId: projectId ?? this.projectId,
      stageId: stageId is int? ? stageId : this.stageId,
      authorId: authorId ?? this.authorId,
      authorName: authorName is String? ? authorName : this.authorName,
      authorFormer: authorFormer is bool? ? authorFormer : this.authorFormer,
      text: text ?? this.text,
      workersCount: workersCount is int? ? workersCount : this.workersCount,
      weather: weather is _ifjsehv5.Weather? ? weather : this.weather,
      issues: issues is String? ? issues : this.issues,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
