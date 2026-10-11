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
import 'expense_category.dart' as _iy8yxm42;

/// What the site manager enters for an expense (LED-03). The receipt was
/// uploaded first, to [receiptPath] (doc/04f M6-5 a). Immutable.
@_isc.immutable
abstract class ExpenseDraft
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  const ExpenseDraft._({
    required this.amountMinor,
    required this.occurredOn,
    required this.category,
    required this.description,
    this.vendor,
    this.stageId,
    this.receiptPath,
    this.receiptSha256,
  });

  const factory ExpenseDraft({
    required int amountMinor,
    required DateTime occurredOn,
    required _iy8yxm42.ExpenseCategory category,
    required String description,
    String? vendor,
    int? stageId,
    String? receiptPath,
    String? receiptSha256,
  }) = _ExpenseDraftImpl;

  factory ExpenseDraft.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExpenseDraft(
      amountMinor: jsonSerialization['amountMinor'] as int,
      occurredOn: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredOn'],
      ),
      category: _iy8yxm42.ExpenseCategory.fromJson(
        (jsonSerialization['category'] as String),
      ),
      description: jsonSerialization['description'] as String,
      vendor: jsonSerialization['vendor'] as String?,
      stageId: jsonSerialization['stageId'] as int?,
      receiptPath: jsonSerialization['receiptPath'] as String?,
      receiptSha256: jsonSerialization['receiptSha256'] as String?,
    );
  }

  final int amountMinor;

  final DateTime occurredOn;

  final _iy8yxm42.ExpenseCategory category;

  final String description;

  final String? vendor;

  final int? stageId;

  final String? receiptPath;

  final String? receiptSha256;

  /// Returns a shallow copy of this [ExpenseDraft]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ExpenseDraft copyWith({
    int? amountMinor,
    DateTime? occurredOn,
    _iy8yxm42.ExpenseCategory? category,
    String? description,
    String? vendor,
    int? stageId,
    String? receiptPath,
    String? receiptSha256,
  });
  @override
  bool operator ==(Object other) {
    return identical(
          other,
          this,
        ) ||
        other.runtimeType == runtimeType &&
            other is ExpenseDraft &&
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
                  other.category,
                  category,
                ) ||
                other.category == category) &&
            (identical(
                  other.description,
                  description,
                ) ||
                other.description == description) &&
            (identical(
                  other.vendor,
                  vendor,
                ) ||
                other.vendor == vendor) &&
            (identical(
                  other.stageId,
                  stageId,
                ) ||
                other.stageId == stageId) &&
            (identical(
                  other.receiptPath,
                  receiptPath,
                ) ||
                other.receiptPath == receiptPath) &&
            (identical(
                  other.receiptSha256,
                  receiptSha256,
                ) ||
                other.receiptSha256 == receiptSha256);
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      amountMinor,
      occurredOn,
      category,
      description,
      vendor,
      stageId,
      receiptPath,
      receiptSha256,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExpenseDraft',
      'amountMinor': amountMinor,
      'occurredOn': occurredOn.toJson(),
      'category': category.toJson(),
      'description': description,
      if (vendor != null) 'vendor': vendor,
      if (stageId != null) 'stageId': stageId,
      if (receiptPath != null) 'receiptPath': receiptPath,
      if (receiptSha256 != null) 'receiptSha256': receiptSha256,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExpenseDraft',
      'amountMinor': amountMinor,
      'occurredOn': occurredOn.toJson(),
      'category': category.toJson(),
      'description': description,
      if (vendor != null) 'vendor': vendor,
      if (stageId != null) 'stageId': stageId,
      if (receiptPath != null) 'receiptPath': receiptPath,
      if (receiptSha256 != null) 'receiptSha256': receiptSha256,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExpenseDraftImpl extends ExpenseDraft {
  const _ExpenseDraftImpl({
    required int amountMinor,
    required DateTime occurredOn,
    required _iy8yxm42.ExpenseCategory category,
    required String description,
    String? vendor,
    int? stageId,
    String? receiptPath,
    String? receiptSha256,
  }) : super._(
         amountMinor: amountMinor,
         occurredOn: occurredOn,
         category: category,
         description: description,
         vendor: vendor,
         stageId: stageId,
         receiptPath: receiptPath,
         receiptSha256: receiptSha256,
       );

  /// Returns a shallow copy of this [ExpenseDraft]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ExpenseDraft copyWith({
    int? amountMinor,
    DateTime? occurredOn,
    _iy8yxm42.ExpenseCategory? category,
    String? description,
    Object? vendor = _Undefined,
    Object? stageId = _Undefined,
    Object? receiptPath = _Undefined,
    Object? receiptSha256 = _Undefined,
  }) {
    return ExpenseDraft(
      amountMinor: amountMinor ?? this.amountMinor,
      occurredOn: occurredOn ?? this.occurredOn,
      category: category ?? this.category,
      description: description ?? this.description,
      vendor: vendor is String? ? vendor : this.vendor,
      stageId: stageId is int? ? stageId : this.stageId,
      receiptPath: receiptPath is String? ? receiptPath : this.receiptPath,
      receiptSha256: receiptSha256 is String?
          ? receiptSha256
          : this.receiptSha256,
    );
  }
}
