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

/// A checklist item as the owner enters it (doc/04c M3-5). Immutable: a
/// value object compared by its fields (==).
@_isc.immutable
abstract class ChecklistItemDraft
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  const ChecklistItemDraft._({
    this.itemId,
    required this.label,
    required this.isRequired,
  });

  const factory ChecklistItemDraft({
    int? itemId,
    required String label,
    required bool isRequired,
  }) = _ChecklistItemDraftImpl;

  factory ChecklistItemDraft.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChecklistItemDraft(
      itemId: jsonSerialization['itemId'] as int?,
      label: jsonSerialization['label'] as String,
      isRequired: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isRequired'],
      ),
    );
  }

  /// The existing item's ID, which it keeps; none for a new item.
  final int? itemId;

  final String label;

  final bool isRequired;

  /// Returns a shallow copy of this [ChecklistItemDraft]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ChecklistItemDraft copyWith({
    int? itemId,
    String? label,
    bool? isRequired,
  });
  @override
  bool operator ==(Object other) {
    return identical(
          other,
          this,
        ) ||
        other.runtimeType == runtimeType &&
            other is ChecklistItemDraft &&
            (identical(
                  other.itemId,
                  itemId,
                ) ||
                other.itemId == itemId) &&
            (identical(
                  other.label,
                  label,
                ) ||
                other.label == label) &&
            (identical(
                  other.isRequired,
                  isRequired,
                ) ||
                other.isRequired == isRequired);
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      itemId,
      label,
      isRequired,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChecklistItemDraft',
      if (itemId != null) 'itemId': itemId,
      'label': label,
      'isRequired': isRequired,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChecklistItemDraft',
      if (itemId != null) 'itemId': itemId,
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

class _ChecklistItemDraftImpl extends ChecklistItemDraft {
  const _ChecklistItemDraftImpl({
    int? itemId,
    required String label,
    required bool isRequired,
  }) : super._(
         itemId: itemId,
         label: label,
         isRequired: isRequired,
       );

  /// Returns a shallow copy of this [ChecklistItemDraft]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ChecklistItemDraft copyWith({
    Object? itemId = _Undefined,
    String? label,
    bool? isRequired,
  }) {
    return ChecklistItemDraft(
      itemId: itemId is int? ? itemId : this.itemId,
      label: label ?? this.label,
      isRequired: isRequired ?? this.isRequired,
    );
  }
}
