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
import 'project.dart' as _ifiazq2p;
import 'project_role.dart' as _i46wx1t7;

/// One row of the project list (PROJ-03).
abstract class ProjectSummary
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ProjectSummary._({
    required this.project,
    required this.myRole,
    required this.progressPercent,
  });

  factory ProjectSummary({
    required _ifiazq2p.Project project,
    required _i46wx1t7.ProjectRole myRole,
    required int progressPercent,
  }) = _ProjectSummaryImpl;

  factory ProjectSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProjectSummary(
      project: _immd62fm.Protocol().deserialize<_ifiazq2p.Project>(
        jsonSerialization['project'],
      ),
      myRole: _i46wx1t7.ProjectRole.fromJson(
        (jsonSerialization['myRole'] as String),
      ),
      progressPercent: jsonSerialization['progressPercent'] as int,
    );
  }

  _ifiazq2p.Project project;

  _i46wx1t7.ProjectRole myRole;

  /// 0–100, the budget-weighted share of approved stages (STG-09).
  int progressPercent;

  /// Returns a shallow copy of this [ProjectSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ProjectSummary copyWith({
    _ifiazq2p.Project? project,
    _i46wx1t7.ProjectRole? myRole,
    int? progressPercent,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProjectSummary',
      'project': project.toJson(),
      'myRole': myRole.toJson(),
      'progressPercent': progressPercent,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProjectSummary',
      'project': project.toJsonForProtocol(),
      'myRole': myRole.toJson(),
      'progressPercent': progressPercent,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ProjectSummaryImpl extends ProjectSummary {
  _ProjectSummaryImpl({
    required _ifiazq2p.Project project,
    required _i46wx1t7.ProjectRole myRole,
    required int progressPercent,
  }) : super._(
         project: project,
         myRole: myRole,
         progressPercent: progressPercent,
       );

  /// Returns a shallow copy of this [ProjectSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ProjectSummary copyWith({
    _ifiazq2p.Project? project,
    _i46wx1t7.ProjectRole? myRole,
    int? progressPercent,
  }) {
    return ProjectSummary(
      project: project ?? this.project.copyWith(),
      myRole: myRole ?? this.myRole,
      progressPercent: progressPercent ?? this.progressPercent,
    );
  }
}
