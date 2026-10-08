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

/// One piece of evidence a stage requires (STG-04, doc/04c M3-5). Its ID
/// stays stable when the stage is edited, because captures attach to it
/// from M4 on.
abstract class ChecklistItem
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ChecklistItem._({
    this.id,
    required this.stageId,
    required this.orderIndex,
    required this.label,
    required this.isRequired,
  });

  factory ChecklistItem({
    int? id,
    required int stageId,
    required int orderIndex,
    required String label,
    required bool isRequired,
  }) = _ChecklistItemImpl;

  factory ChecklistItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChecklistItem(
      id: jsonSerialization['id'] as int?,
      stageId: jsonSerialization['stageId'] as int,
      orderIndex: jsonSerialization['orderIndex'] as int,
      label: jsonSerialization['label'] as String,
      isRequired: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isRequired'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int stageId;

  /// 0…n−1 within the stage.
  int orderIndex;

  /// 1–200 characters after trimming.
  String label;

  bool isRequired;

  /// Returns a shallow copy of this [ChecklistItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ChecklistItem copyWith({
    int? id,
    int? stageId,
    int? orderIndex,
    String? label,
    bool? isRequired,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChecklistItem',
      if (id != null) 'id': id,
      'stageId': stageId,
      'orderIndex': orderIndex,
      'label': label,
      'isRequired': isRequired,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChecklistItem',
      if (id != null) 'id': id,
      'stageId': stageId,
      'orderIndex': orderIndex,
      'label': label,
      'isRequired': isRequired,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChecklistItemImpl extends ChecklistItem {
  _ChecklistItemImpl({
    int? id,
    required int stageId,
    required int orderIndex,
    required String label,
    required bool isRequired,
  }) : super._(
         id: id,
         stageId: stageId,
         orderIndex: orderIndex,
         label: label,
         isRequired: isRequired,
       );

  /// Returns a shallow copy of this [ChecklistItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ChecklistItem copyWith({
    Object? id = _Undefined,
    int? stageId,
    int? orderIndex,
    String? label,
    bool? isRequired,
  }) {
    return ChecklistItem(
      id: id is int? ? id : this.id,
      stageId: stageId ?? this.stageId,
      orderIndex: orderIndex ?? this.orderIndex,
      label: label ?? this.label,
      isRequired: isRequired ?? this.isRequired,
    );
  }
}
