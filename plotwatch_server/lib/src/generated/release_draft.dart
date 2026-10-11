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
import 'release_method.dart' as _izc06igq;

/// What a funder enters for a release (LED-01). Immutable: compared by its
/// fields.
@_is.immutable
abstract class ReleaseDraft
    implements _is.SerializableModel, _is.ProtocolSerialization {
  const ReleaseDraft._({
    required this.amountMinor,
    required this.occurredOn,
    required this.method,
    this.reference,
    this.stageId,
    this.note,
  });

  const factory ReleaseDraft({
    required int amountMinor,
    required DateTime occurredOn,
    required _izc06igq.ReleaseMethod method,
    String? reference,
    int? stageId,
    String? note,
  }) = _ReleaseDraftImpl;

  factory ReleaseDraft.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReleaseDraft(
      amountMinor: jsonSerialization['amountMinor'] as int,
      occurredOn: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredOn'],
      ),
      method: _izc06igq.ReleaseMethod.fromJson(
        (jsonSerialization['method'] as String),
      ),
      reference: jsonSerialization['reference'] as String?,
      stageId: jsonSerialization['stageId'] as int?,
      note: jsonSerialization['note'] as String?,
    );
  }

  final int amountMinor;

  final DateTime occurredOn;

  final _izc06igq.ReleaseMethod method;

  final String? reference;

  final int? stageId;

  final String? note;

  /// Returns a shallow copy of this [ReleaseDraft]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ReleaseDraft copyWith({
    int? amountMinor,
    DateTime? occurredOn,
    _izc06igq.ReleaseMethod? method,
    String? reference,
    int? stageId,
    String? note,
  });
  @override
  bool operator ==(Object other) {
    return identical(
          other,
          this,
        ) ||
        other.runtimeType == runtimeType &&
            other is ReleaseDraft &&
            (identical(
                  other.amountMinor,
                  amountMinor,
                ) ||
                other.amountMinor == amountMinor) &&
            (identical(
                  other.occurredOn,
                  occurredOn,
                ) ||
                other.occurredOn == occurredOn) &&
            (identical(
                  other.method,
                  method,
                ) ||
                other.method == method) &&
            (identical(
                  other.reference,
                  reference,
                ) ||
                other.reference == reference) &&
            (identical(
                  other.stageId,
                  stageId,
                ) ||
                other.stageId == stageId) &&
            (identical(
                  other.note,
                  note,
                ) ||
                other.note == note);
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      amountMinor,
      occurredOn,
      method,
      reference,
      stageId,
      note,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReleaseDraft',
      'amountMinor': amountMinor,
      'occurredOn': occurredOn.toJson(),
      'method': method.toJson(),
      if (reference != null) 'reference': reference,
      if (stageId != null) 'stageId': stageId,
      if (note != null) 'note': note,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReleaseDraft',
      'amountMinor': amountMinor,
      'occurredOn': occurredOn.toJson(),
      'method': method.toJson(),
      if (reference != null) 'reference': reference,
      if (stageId != null) 'stageId': stageId,
      if (note != null) 'note': note,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReleaseDraftImpl extends ReleaseDraft {
  const _ReleaseDraftImpl({
    required int amountMinor,
    required DateTime occurredOn,
    required _izc06igq.ReleaseMethod method,
    String? reference,
    int? stageId,
    String? note,
  }) : super._(
         amountMinor: amountMinor,
         occurredOn: occurredOn,
         method: method,
         reference: reference,
         stageId: stageId,
         note: note,
       );

  /// Returns a shallow copy of this [ReleaseDraft]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ReleaseDraft copyWith({
    int? amountMinor,
    DateTime? occurredOn,
    _izc06igq.ReleaseMethod? method,
    Object? reference = _Undefined,
    Object? stageId = _Undefined,
    Object? note = _Undefined,
  }) {
    return ReleaseDraft(
      amountMinor: amountMinor ?? this.amountMinor,
      occurredOn: occurredOn ?? this.occurredOn,
      method: method ?? this.method,
      reference: reference is String? ? reference : this.reference,
      stageId: stageId is int? ? stageId : this.stageId,
      note: note is String? ? note : this.note,
    );
  }
}
