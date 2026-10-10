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
import 'stage_status.dart' as _iblg1lql;

/// A stage in short, in plan order: the project list's and the project
/// page's stage bar and "waiting for your review" (doc/05 §9).
abstract class StageBrief
    implements _is.SerializableModel, _is.ProtocolSerialization {
  StageBrief._({
    required this.id,
    required this.name,
    required this.status,
    int? budgetMinor,
  }) : budgetMinor = budgetMinor ?? 0;

  factory StageBrief({
    required int id,
    required String name,
    required _iblg1lql.StageStatus status,
    int? budgetMinor,
  }) = _StageBriefImpl;

  factory StageBrief.fromJson(Map<String, dynamic> jsonSerialization) {
    return StageBrief(
      id: jsonSerialization['id'] as int,
      name: jsonSerialization['name'] as String,
      status: _iblg1lql.StageStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      budgetMinor: jsonSerialization['budgetMinor'] as int?,
    );
  }

  int id;

  String name;

  _iblg1lql.StageStatus status;

  /// In minor units, for the web stage table.
  int budgetMinor;

  /// Returns a shallow copy of this [StageBrief]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StageBrief copyWith({
    int? id,
    String? name,
    _iblg1lql.StageStatus? status,
    int? budgetMinor,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StageBrief',
      'id': id,
      'name': name,
      'status': status.toJson(),
      'budgetMinor': budgetMinor,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StageBrief',
      'id': id,
      'name': name,
      'status': status.toJson(),
      'budgetMinor': budgetMinor,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _StageBriefImpl extends StageBrief {
  _StageBriefImpl({
    required int id,
    required String name,
    required _iblg1lql.StageStatus status,
    int? budgetMinor,
  }) : super._(
         id: id,
         name: name,
         status: status,
         budgetMinor: budgetMinor,
       );

  /// Returns a shallow copy of this [StageBrief]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StageBrief copyWith({
    int? id,
    String? name,
    _iblg1lql.StageStatus? status,
    int? budgetMinor,
  }) {
    return StageBrief(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      budgetMinor: budgetMinor ?? this.budgetMinor,
    );
  }
}
