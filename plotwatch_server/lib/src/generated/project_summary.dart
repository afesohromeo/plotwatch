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
import 'project.dart' as _ifiazq2p;
import 'project_role.dart' as _i46wx1t7;
import 'stage_brief.dart' as _is1lynby;
import 'verification_level.dart' as _i5zqa56i;

/// One row of the project list (PROJ-03).
abstract class ProjectSummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ProjectSummary._({
    required this.project,
    required this.myRole,
    required this.progressPercent,
    bool? myCanApprove,
    this.stages,
    int? budgetTotalMinor,
    this.latestEvidenceId,
    this.latestEvidenceLevel,
  }) : myCanApprove = myCanApprove ?? false,
       budgetTotalMinor = budgetTotalMinor ?? 0;

  factory ProjectSummary({
    required _ifiazq2p.Project project,
    required _i46wx1t7.ProjectRole myRole,
    required int progressPercent,
    bool? myCanApprove,
    List<_is1lynby.StageBrief>? stages,
    int? budgetTotalMinor,
    int? latestEvidenceId,
    _i5zqa56i.VerificationLevel? latestEvidenceLevel,
  }) = _ProjectSummaryImpl;

  factory ProjectSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProjectSummary(
      project: _irbavk3a.Protocol().deserialize<_ifiazq2p.Project>(
        jsonSerialization['project'],
      ),
      myRole: _i46wx1t7.ProjectRole.fromJson(
        (jsonSerialization['myRole'] as String),
      ),
      progressPercent: jsonSerialization['progressPercent'] as int,
      myCanApprove: jsonSerialization['myCanApprove'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['myCanApprove']),
      stages: jsonSerialization['stages'] == null
          ? null
          : _irbavk3a.Protocol().deserialize<List<_is1lynby.StageBrief>>(
              jsonSerialization['stages'],
            ),
      budgetTotalMinor: jsonSerialization['budgetTotalMinor'] as int?,
      latestEvidenceId: jsonSerialization['latestEvidenceId'] as int?,
      latestEvidenceLevel: jsonSerialization['latestEvidenceLevel'] == null
          ? null
          : _i5zqa56i.VerificationLevel.fromJson(
              (jsonSerialization['latestEvidenceLevel'] as String),
            ),
    );
  }

  _ifiazq2p.Project project;

  _i46wx1t7.ProjectRole myRole;

  /// 0–100, the budget-weighted share of approved stages (STG-09).
  int progressPercent;

  /// Whether the caller may approve stages, for "waiting for your review"
  /// (doc/05 §9).
  bool myCanApprove;

  /// The stages in plan order, for the card's stage bar.
  List<_is1lynby.StageBrief>? stages;

  /// Sum of the stage budgets: with none, progress is the stage count.
  int budgetTotalMinor;

  /// The project's latest finalized photo, the card's cover.
  int? latestEvidenceId;

  /// Its badge, shown on the cover.
  _i5zqa56i.VerificationLevel? latestEvidenceLevel;

  /// Returns a shallow copy of this [ProjectSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ProjectSummary copyWith({
    _ifiazq2p.Project? project,
    _i46wx1t7.ProjectRole? myRole,
    int? progressPercent,
    bool? myCanApprove,
    List<_is1lynby.StageBrief>? stages,
    int? budgetTotalMinor,
    int? latestEvidenceId,
    _i5zqa56i.VerificationLevel? latestEvidenceLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProjectSummary',
      'project': project.toJson(),
      'myRole': myRole.toJson(),
      'progressPercent': progressPercent,
      'myCanApprove': myCanApprove,
      if (stages != null)
        'stages': stages?.toJson(valueToJson: (v) => v.toJson()),
      'budgetTotalMinor': budgetTotalMinor,
      if (latestEvidenceId != null) 'latestEvidenceId': latestEvidenceId,
      if (latestEvidenceLevel != null)
        'latestEvidenceLevel': latestEvidenceLevel?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProjectSummary',
      'project': project.toJsonForProtocol(),
      'myRole': myRole.toJson(),
      'progressPercent': progressPercent,
      'myCanApprove': myCanApprove,
      if (stages != null)
        'stages': stages?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'budgetTotalMinor': budgetTotalMinor,
      if (latestEvidenceId != null) 'latestEvidenceId': latestEvidenceId,
      if (latestEvidenceLevel != null)
        'latestEvidenceLevel': latestEvidenceLevel?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProjectSummaryImpl extends ProjectSummary {
  _ProjectSummaryImpl({
    required _ifiazq2p.Project project,
    required _i46wx1t7.ProjectRole myRole,
    required int progressPercent,
    bool? myCanApprove,
    List<_is1lynby.StageBrief>? stages,
    int? budgetTotalMinor,
    int? latestEvidenceId,
    _i5zqa56i.VerificationLevel? latestEvidenceLevel,
  }) : super._(
         project: project,
         myRole: myRole,
         progressPercent: progressPercent,
         myCanApprove: myCanApprove,
         stages: stages,
         budgetTotalMinor: budgetTotalMinor,
         latestEvidenceId: latestEvidenceId,
         latestEvidenceLevel: latestEvidenceLevel,
       );

  /// Returns a shallow copy of this [ProjectSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ProjectSummary copyWith({
    _ifiazq2p.Project? project,
    _i46wx1t7.ProjectRole? myRole,
    int? progressPercent,
    bool? myCanApprove,
    Object? stages = _Undefined,
    int? budgetTotalMinor,
    Object? latestEvidenceId = _Undefined,
    Object? latestEvidenceLevel = _Undefined,
  }) {
    return ProjectSummary(
      project: project ?? this.project.copyWith(),
      myRole: myRole ?? this.myRole,
      progressPercent: progressPercent ?? this.progressPercent,
      myCanApprove: myCanApprove ?? this.myCanApprove,
      stages: stages is List<_is1lynby.StageBrief>?
          ? stages
          : this.stages?.map((e0) => e0.copyWith()).toList(),
      budgetTotalMinor: budgetTotalMinor ?? this.budgetTotalMinor,
      latestEvidenceId: latestEvidenceId is int?
          ? latestEvidenceId
          : this.latestEvidenceId,
      latestEvidenceLevel: latestEvidenceLevel is _i5zqa56i.VerificationLevel?
          ? latestEvidenceLevel
          : this.latestEvidenceLevel,
    );
  }
}
