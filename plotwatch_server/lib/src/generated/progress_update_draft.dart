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
import 'package:serverpod/serverpod.dart' as _is;
import 'weather.dart' as _ifjsehv5;

/// What the site manager enters for an update. Immutable: a value object
/// compared by its fields (==).
@_is.immutable
abstract class ProgressUpdateDraft
    implements _is.SerializableModel, _is.ProtocolSerialization {
  const ProgressUpdateDraft._({
    required this.text,
    this.stageId,
    this.workersCount,
    this.weather,
    this.issues,
  });

  const factory ProgressUpdateDraft({
    required String text,
    int? stageId,
    int? workersCount,
    _ifjsehv5.Weather? weather,
    String? issues,
  }) = _ProgressUpdateDraftImpl;

  factory ProgressUpdateDraft.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProgressUpdateDraft(
      text: jsonSerialization['text'] as String,
      stageId: jsonSerialization['stageId'] as int?,
      workersCount: jsonSerialization['workersCount'] as int?,
      weather: jsonSerialization['weather'] == null
          ? null
          : _ifjsehv5.Weather.fromJson(
              (jsonSerialization['weather'] as String),
            ),
      issues: jsonSerialization['issues'] as String?,
    );
  }

  final String text;

  final int? stageId;

  final int? workersCount;

  final _ifjsehv5.Weather? weather;

  final String? issues;

  /// Returns a shallow copy of this [ProgressUpdateDraft]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ProgressUpdateDraft copyWith({
    String? text,
    int? stageId,
    int? workersCount,
    _ifjsehv5.Weather? weather,
    String? issues,
  });
  @override
  bool operator ==(Object other) {
    return identical(
          other,
          this,
        ) ||
        other.runtimeType == runtimeType &&
            other is ProgressUpdateDraft &&
            (identical(
                  other.text,
                  text,
                ) ||
                other.text == text) &&
            (identical(
                  other.stageId,
                  stageId,
                ) ||
                other.stageId == stageId) &&
            (identical(
                  other.workersCount,
                  workersCount,
                ) ||
                other.workersCount == workersCount) &&
            (identical(
                  other.weather,
                  weather,
                ) ||
                other.weather == weather) &&
            (identical(
                  other.issues,
                  issues,
                ) ||
                other.issues == issues);
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      text,
      stageId,
      workersCount,
      weather,
      issues,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProgressUpdateDraft',
      'text': text,
      if (stageId != null) 'stageId': stageId,
      if (workersCount != null) 'workersCount': workersCount,
      if (weather != null) 'weather': weather?.toJson(),
      if (issues != null) 'issues': issues,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProgressUpdateDraft',
      'text': text,
      if (stageId != null) 'stageId': stageId,
      if (workersCount != null) 'workersCount': workersCount,
      if (weather != null) 'weather': weather?.toJson(),
      if (issues != null) 'issues': issues,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProgressUpdateDraftImpl extends ProgressUpdateDraft {
  const _ProgressUpdateDraftImpl({
    required String text,
    int? stageId,
    int? workersCount,
    _ifjsehv5.Weather? weather,
    String? issues,
  }) : super._(
         text: text,
         stageId: stageId,
         workersCount: workersCount,
         weather: weather,
         issues: issues,
       );

  /// Returns a shallow copy of this [ProgressUpdateDraft]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ProgressUpdateDraft copyWith({
    String? text,
    Object? stageId = _Undefined,
    Object? workersCount = _Undefined,
    Object? weather = _Undefined,
    Object? issues = _Undefined,
  }) {
    return ProgressUpdateDraft(
      text: text ?? this.text,
      stageId: stageId is int? ? stageId : this.stageId,
      workersCount: workersCount is int? ? workersCount : this.workersCount,
      weather: weather is _ifjsehv5.Weather? ? weather : this.weather,
      issues: issues is String? ? issues : this.issues,
    );
  }
}
