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
import 'project_summary.dart' as _ivxocntb;

/// A page of the caller's projects (`_standards/14` §3.1).
abstract class ProjectSummaryPage
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ProjectSummaryPage._({
    required this.items,
    required this.page,
    required this.pageSize,
  });

  factory ProjectSummaryPage({
    required List<_ivxocntb.ProjectSummary> items,
    required int page,
    required int pageSize,
  }) = _ProjectSummaryPageImpl;

  factory ProjectSummaryPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProjectSummaryPage(
      items: _irbavk3a.Protocol().deserialize<List<_ivxocntb.ProjectSummary>>(
        jsonSerialization['items'],
      ),
      page: jsonSerialization['page'] as int,
      pageSize: jsonSerialization['pageSize'] as int,
    );
  }

  List<_ivxocntb.ProjectSummary> items;

  int page;

  int pageSize;

  /// Returns a shallow copy of this [ProjectSummaryPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ProjectSummaryPage copyWith({
    List<_ivxocntb.ProjectSummary>? items,
    int? page,
    int? pageSize,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProjectSummaryPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'page': page,
      'pageSize': pageSize,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProjectSummaryPage',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'page': page,
      'pageSize': pageSize,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ProjectSummaryPageImpl extends ProjectSummaryPage {
  _ProjectSummaryPageImpl({
    required List<_ivxocntb.ProjectSummary> items,
    required int page,
    required int pageSize,
  }) : super._(
         items: items,
         page: page,
         pageSize: pageSize,
       );

  /// Returns a shallow copy of this [ProjectSummaryPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ProjectSummaryPage copyWith({
    List<_ivxocntb.ProjectSummary>? items,
    int? page,
    int? pageSize,
  }) {
    return ProjectSummaryPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
