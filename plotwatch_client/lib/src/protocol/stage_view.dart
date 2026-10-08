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
import 'checklist_item.dart' as _ifywsnp6;
import 'stage.dart' as _igkbma1f;

/// One stage with its checklist, as members see it (STG-08).
abstract class StageView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StageView._({
    required this.stage,
    required this.items,
    required this.itemsCovered,
  });

  factory StageView({
    required _igkbma1f.Stage stage,
    required List<_ifywsnp6.ChecklistItem> items,
    required int itemsCovered,
  }) = _StageViewImpl;

  factory StageView.fromJson(Map<String, dynamic> jsonSerialization) {
    return StageView(
      stage: _immd62fm.Protocol().deserialize<_igkbma1f.Stage>(
        jsonSerialization['stage'],
      ),
      items: _immd62fm.Protocol().deserialize<List<_ifywsnp6.ChecklistItem>>(
        jsonSerialization['items'],
      ),
      itemsCovered: jsonSerialization['itemsCovered'] as int,
    );
  }

  _igkbma1f.Stage stage;

  /// In order.
  List<_ifywsnp6.ChecklistItem> items;

  /// Items with at least one capture; 0 until captures exist (M4).
  int itemsCovered;

  /// Returns a shallow copy of this [StageView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StageView copyWith({
    _igkbma1f.Stage? stage,
    List<_ifywsnp6.ChecklistItem>? items,
    int? itemsCovered,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StageView',
      'stage': stage.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'itemsCovered': itemsCovered,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StageView',
      'stage': stage.toJsonForProtocol(),
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'itemsCovered': itemsCovered,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _StageViewImpl extends StageView {
  _StageViewImpl({
    required _igkbma1f.Stage stage,
    required List<_ifywsnp6.ChecklistItem> items,
    required int itemsCovered,
  }) : super._(
         stage: stage,
         items: items,
         itemsCovered: itemsCovered,
       );

  /// Returns a shallow copy of this [StageView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StageView copyWith({
    _igkbma1f.Stage? stage,
    List<_ifywsnp6.ChecklistItem>? items,
    int? itemsCovered,
  }) {
    return StageView(
      stage: stage ?? this.stage.copyWith(),
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      itemsCovered: itemsCovered ?? this.itemsCovered,
    );
  }
}
