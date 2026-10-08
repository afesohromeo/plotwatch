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
import 'package:serverpod_serialization/serverpod_serialization.dart' as _iss;
import 'checklist_item_draft.dart' as _iuwh2s2t;

/// A stage as the owner enters it, or as a template fills it in
/// (doc/04c M3-2 to M3-5). Immutable: a value object compared by its
/// fields (==), e.g. in BLoC events.
@_is.immutable
abstract class StageDraft
    implements _is.SerializableModel, _is.ProtocolSerialization {
  const StageDraft._({
    required this.name,
    this.description,
    required this.budgetMinor,
    this.plannedStart,
    this.plannedEnd,
    required this.items,
  });

  const factory StageDraft({
    required String name,
    String? description,
    required int budgetMinor,
    DateTime? plannedStart,
    DateTime? plannedEnd,
    required List<_iuwh2s2t.ChecklistItemDraft> items,
  }) = _StageDraftImpl;

  factory StageDraft.fromJson(Map<String, dynamic> jsonSerialization) {
    return StageDraft(
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      budgetMinor: jsonSerialization['budgetMinor'] as int,
      plannedStart: jsonSerialization['plannedStart'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['plannedStart'],
            ),
      plannedEnd: jsonSerialization['plannedEnd'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['plannedEnd']),
      items: _irbavk3a.Protocol()
          .deserialize<List<_iuwh2s2t.ChecklistItemDraft>>(
            jsonSerialization['items'],
          ),
    );
  }

  final String name;

  final String? description;

  final int budgetMinor;

  final DateTime? plannedStart;

  final DateTime? plannedEnd;

  /// In order; at most 30.
  final List<_iuwh2s2t.ChecklistItemDraft> items;

  /// Returns a shallow copy of this [StageDraft]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StageDraft copyWith({
    String? name,
    String? description,
    int? budgetMinor,
    DateTime? plannedStart,
    DateTime? plannedEnd,
    List<_iuwh2s2t.ChecklistItemDraft>? items,
  });
  @override
  bool operator ==(Object other) {
    return identical(
          other,
          this,
        ) ||
        other.runtimeType == runtimeType &&
            other is StageDraft &&
            (identical(
                  other.name,
                  name,
                ) ||
                other.name == name) &&
            (identical(
                  other.description,
                  description,
                ) ||
                other.description == description) &&
            (identical(
                  other.budgetMinor,
                  budgetMinor,
                ) ||
                other.budgetMinor == budgetMinor) &&
            (identical(
                  other.plannedStart,
                  plannedStart,
                ) ||
                other.plannedStart == plannedStart) &&
            (identical(
                  other.plannedEnd,
                  plannedEnd,
                ) ||
                other.plannedEnd == plannedEnd) &&
            const _iss.DeepCollectionEquality().equals(
              other.items,
              items,
            );
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      name,
      description,
      budgetMinor,
      plannedStart,
      plannedEnd,
      const _iss.DeepCollectionEquality().hash(items),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StageDraft',
      'name': name,
      if (description != null) 'description': description,
      'budgetMinor': budgetMinor,
      if (plannedStart != null) 'plannedStart': plannedStart?.toJson(),
      if (plannedEnd != null) 'plannedEnd': plannedEnd?.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StageDraft',
      'name': name,
      if (description != null) 'description': description,
      'budgetMinor': budgetMinor,
      if (plannedStart != null) 'plannedStart': plannedStart?.toJson(),
      if (plannedEnd != null) 'plannedEnd': plannedEnd?.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StageDraftImpl extends StageDraft {
  const _StageDraftImpl({
    required String name,
    String? description,
    required int budgetMinor,
    DateTime? plannedStart,
    DateTime? plannedEnd,
    required List<_iuwh2s2t.ChecklistItemDraft> items,
  }) : super._(
         name: name,
         description: description,
         budgetMinor: budgetMinor,
         plannedStart: plannedStart,
         plannedEnd: plannedEnd,
         items: items,
       );

  /// Returns a shallow copy of this [StageDraft]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StageDraft copyWith({
    String? name,
    Object? description = _Undefined,
    int? budgetMinor,
    Object? plannedStart = _Undefined,
    Object? plannedEnd = _Undefined,
    List<_iuwh2s2t.ChecklistItemDraft>? items,
  }) {
    return StageDraft(
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      budgetMinor: budgetMinor ?? this.budgetMinor,
      plannedStart: plannedStart is DateTime?
          ? plannedStart
          : this.plannedStart,
      plannedEnd: plannedEnd is DateTime? ? plannedEnd : this.plannedEnd,
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
    );
  }
}
