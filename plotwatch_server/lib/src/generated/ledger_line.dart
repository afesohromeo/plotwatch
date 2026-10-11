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

/// The money of one stage, of the entries without a stage, or of the whole
/// project (LED-04, doc/04f M6-7).
abstract class LedgerLine
    implements _is.SerializableModel, _is.ProtocolSerialization {
  LedgerLine._({
    this.stageId,
    this.stageName,
    required this.budgetMinor,
    required this.releasedMinor,
    required this.spentMinor,
    required this.spentWithReceiptMinor,
    required this.unaccountedMinor,
    required this.remainingMinor,
  });

  factory LedgerLine({
    int? stageId,
    String? stageName,
    required int budgetMinor,
    required int releasedMinor,
    required int spentMinor,
    required int spentWithReceiptMinor,
    required int unaccountedMinor,
    required int remainingMinor,
  }) = _LedgerLineImpl;

  factory LedgerLine.fromJson(Map<String, dynamic> jsonSerialization) {
    return LedgerLine(
      stageId: jsonSerialization['stageId'] as int?,
      stageName: jsonSerialization['stageName'] as String?,
      budgetMinor: jsonSerialization['budgetMinor'] as int,
      releasedMinor: jsonSerialization['releasedMinor'] as int,
      spentMinor: jsonSerialization['spentMinor'] as int,
      spentWithReceiptMinor: jsonSerialization['spentWithReceiptMinor'] as int,
      unaccountedMinor: jsonSerialization['unaccountedMinor'] as int,
      remainingMinor: jsonSerialization['remainingMinor'] as int,
    );
  }

  /// None for the project's total and for the entries without a stage.
  int? stageId;

  String? stageName;

  int budgetMinor;

  int releasedMinor;

  int spentMinor;

  int spentWithReceiptMinor;

  /// Released − spent with receipt.
  int unaccountedMinor;

  /// Budget − released.
  int remainingMinor;

  /// Returns a shallow copy of this [LedgerLine]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LedgerLine copyWith({
    int? stageId,
    String? stageName,
    int? budgetMinor,
    int? releasedMinor,
    int? spentMinor,
    int? spentWithReceiptMinor,
    int? unaccountedMinor,
    int? remainingMinor,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LedgerLine',
      if (stageId != null) 'stageId': stageId,
      if (stageName != null) 'stageName': stageName,
      'budgetMinor': budgetMinor,
      'releasedMinor': releasedMinor,
      'spentMinor': spentMinor,
      'spentWithReceiptMinor': spentWithReceiptMinor,
      'unaccountedMinor': unaccountedMinor,
      'remainingMinor': remainingMinor,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LedgerLine',
      if (stageId != null) 'stageId': stageId,
      if (stageName != null) 'stageName': stageName,
      'budgetMinor': budgetMinor,
      'releasedMinor': releasedMinor,
      'spentMinor': spentMinor,
      'spentWithReceiptMinor': spentWithReceiptMinor,
      'unaccountedMinor': unaccountedMinor,
      'remainingMinor': remainingMinor,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LedgerLineImpl extends LedgerLine {
  _LedgerLineImpl({
    int? stageId,
    String? stageName,
    required int budgetMinor,
    required int releasedMinor,
    required int spentMinor,
    required int spentWithReceiptMinor,
    required int unaccountedMinor,
    required int remainingMinor,
  }) : super._(
         stageId: stageId,
         stageName: stageName,
         budgetMinor: budgetMinor,
         releasedMinor: releasedMinor,
         spentMinor: spentMinor,
         spentWithReceiptMinor: spentWithReceiptMinor,
         unaccountedMinor: unaccountedMinor,
         remainingMinor: remainingMinor,
       );

  /// Returns a shallow copy of this [LedgerLine]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LedgerLine copyWith({
    Object? stageId = _Undefined,
    Object? stageName = _Undefined,
    int? budgetMinor,
    int? releasedMinor,
    int? spentMinor,
    int? spentWithReceiptMinor,
    int? unaccountedMinor,
    int? remainingMinor,
  }) {
    return LedgerLine(
      stageId: stageId is int? ? stageId : this.stageId,
      stageName: stageName is String? ? stageName : this.stageName,
      budgetMinor: budgetMinor ?? this.budgetMinor,
      releasedMinor: releasedMinor ?? this.releasedMinor,
      spentMinor: spentMinor ?? this.spentMinor,
      spentWithReceiptMinor:
          spentWithReceiptMinor ?? this.spentWithReceiptMinor,
      unaccountedMinor: unaccountedMinor ?? this.unaccountedMinor,
      remainingMinor: remainingMinor ?? this.remainingMinor,
    );
  }
}
