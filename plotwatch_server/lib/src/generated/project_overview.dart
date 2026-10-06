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
import 'site.dart' as _iz8v5x4v;

/// One project as a member sees it: details, validated site and their role.
abstract class ProjectOverview
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ProjectOverview._({
    required this.project,
    this.site,
    required this.myRole,
    required this.myCanApprove,
  });

  factory ProjectOverview({
    required _ifiazq2p.Project project,
    _iz8v5x4v.Site? site,
    required _i46wx1t7.ProjectRole myRole,
    required bool myCanApprove,
  }) = _ProjectOverviewImpl;

  factory ProjectOverview.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProjectOverview(
      project: _irbavk3a.Protocol().deserialize<_ifiazq2p.Project>(
        jsonSerialization['project'],
      ),
      site: jsonSerialization['site'] == null
          ? null
          : _irbavk3a.Protocol().deserialize<_iz8v5x4v.Site>(
              jsonSerialization['site'],
            ),
      myRole: _i46wx1t7.ProjectRole.fromJson(
        (jsonSerialization['myRole'] as String),
      ),
      myCanApprove: _is.BoolJsonExtension.fromJson(
        jsonSerialization['myCanApprove'],
      ),
    );
  }

  _ifiazq2p.Project project;

  /// Null until the owner validates a location (decision M2-15).
  _iz8v5x4v.Site? site;

  _i46wx1t7.ProjectRole myRole;

  bool myCanApprove;

  /// Returns a shallow copy of this [ProjectOverview]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ProjectOverview copyWith({
    _ifiazq2p.Project? project,
    _iz8v5x4v.Site? site,
    _i46wx1t7.ProjectRole? myRole,
    bool? myCanApprove,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProjectOverview',
      'project': project.toJson(),
      if (site != null) 'site': site?.toJson(),
      'myRole': myRole.toJson(),
      'myCanApprove': myCanApprove,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProjectOverview',
      'project': project.toJsonForProtocol(),
      if (site != null) 'site': site?.toJsonForProtocol(),
      'myRole': myRole.toJson(),
      'myCanApprove': myCanApprove,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProjectOverviewImpl extends ProjectOverview {
  _ProjectOverviewImpl({
    required _ifiazq2p.Project project,
    _iz8v5x4v.Site? site,
    required _i46wx1t7.ProjectRole myRole,
    required bool myCanApprove,
  }) : super._(
         project: project,
         site: site,
         myRole: myRole,
         myCanApprove: myCanApprove,
       );

  /// Returns a shallow copy of this [ProjectOverview]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ProjectOverview copyWith({
    _ifiazq2p.Project? project,
    Object? site = _Undefined,
    _i46wx1t7.ProjectRole? myRole,
    bool? myCanApprove,
  }) {
    return ProjectOverview(
      project: project ?? this.project.copyWith(),
      site: site is _iz8v5x4v.Site? ? site : this.site?.copyWith(),
      myRole: myRole ?? this.myRole,
      myCanApprove: myCanApprove ?? this.myCanApprove,
    );
  }
}
