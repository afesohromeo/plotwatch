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
import 'checklist_item.dart' as _ifywsnp6;
import 'stage.dart' as _igkbma1f;

/// One stage with its checklist, as members see it (STG-08).
abstract class StageView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  StageView._({
    required this.stage,
    required this.items,
    required this.itemsCovered,
    this.latestEvidenceId,
  });

  factory StageView({
    required _igkbma1f.Stage stage,
    required List<_ifywsnp6.ChecklistItem> items,
    required int itemsCovered,
    int? latestEvidenceId,
  }) = _StageViewImpl;

  factory StageView.fromJson(Map<String, dynamic> jsonSerialization) {
    return StageView(
      stage: _irbavk3a.Protocol().deserialize<_igkbma1f.Stage>(
        jsonSerialization['stage'],
      ),
      items: _irbavk3a.Protocol().deserialize<List<_ifywsnp6.ChecklistItem>>(
        jsonSerialization['items'],
      ),
      itemsCovered: jsonSerialization['itemsCovered'] as int,
      latestEvidenceId: jsonSerialization['latestEvidenceId'] as int?,
    );
  }

  _igkbma1f.Stage stage;

  /// In order.
  List<_ifywsnp6.ChecklistItem> items;

  /// Items with at least one capture; 0 until captures exist (M4).
  int itemsCovered;

  /// The stage's latest finalized photo, filled in the plan (doc/05 §9).
  int? latestEvidenceId;

  /// Returns a shallow copy of this [StageView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StageView copyWith({
    _igkbma1f.Stage? stage,
    List<_ifywsnp6.ChecklistItem>? items,
    int? itemsCovered,
    int? latestEvidenceId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StageView',
      'stage': stage.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'itemsCovered': itemsCovered,
      if (latestEvidenceId != null) 'latestEvidenceId': latestEvidenceId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StageView',
      'stage': stage.toJsonForProtocol(),
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'itemsCovered': itemsCovered,
      if (latestEvidenceId != null) 'latestEvidenceId': latestEvidenceId,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StageViewImpl extends StageView {
  _StageViewImpl({
    required _igkbma1f.Stage stage,
    required List<_ifywsnp6.ChecklistItem> items,
    required int itemsCovered,
    int? latestEvidenceId,
  }) : super._(
         stage: stage,
         items: items,
         itemsCovered: itemsCovered,
         latestEvidenceId: latestEvidenceId,
       );

  /// Returns a shallow copy of this [StageView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StageView copyWith({
    _igkbma1f.Stage? stage,
    List<_ifywsnp6.ChecklistItem>? items,
    int? itemsCovered,
    Object? latestEvidenceId = _Undefined,
  }) {
    return StageView(
      stage: stage ?? this.stage.copyWith(),
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      itemsCovered: itemsCovered ?? this.itemsCovered,
      latestEvidenceId: latestEvidenceId is int?
          ? latestEvidenceId
          : this.latestEvidenceId,
    );
  }
}
