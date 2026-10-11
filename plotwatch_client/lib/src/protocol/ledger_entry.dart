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
import 'ledger_entry_kind.dart' as _i2lcu4mb;
import 'release_method.dart' as _izc06igq;

/// One line of a project's ledger: a fund release recorded by a funder or
/// an expense recorded by the site manager (LED-01, LED-03; doc/04f M6-1).
/// Never updated except to confirm a release; a mistake is corrected by a
/// reversal entry with the negative amount (LED-06).
abstract class LedgerEntry
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LedgerEntry._({
    this.id,
    required this.projectId,
    this.stageId,
    required this.kind,
    required this.amountMinor,
    required this.occurredOn,
    required this.recordedBy,
    this.method,
    this.reference,
    this.confirmedBy,
    this.confirmedAt,
    this.category,
    this.description,
    this.vendor,
    this.receiptPath,
    this.receiptSha256,
    this.note,
    this.reversesId,
    required this.createdAt,
    this.recordedByName,
    this.recordedByFormer,
    this.reversedById,
    this.reversalReason,
  });

  factory LedgerEntry({
    int? id,
    required int projectId,
    int? stageId,
    required _i2lcu4mb.LedgerEntryKind kind,
    required int amountMinor,
    required DateTime occurredOn,
    required _isc.UuidValue recordedBy,
    _izc06igq.ReleaseMethod? method,
    String? reference,
    _isc.UuidValue? confirmedBy,
    DateTime? confirmedAt,
    _iy8yxm42.ExpenseCategory? category,
    String? description,
    String? vendor,
    String? receiptPath,
    String? receiptSha256,
    String? note,
    int? reversesId,
    required DateTime createdAt,
    String? recordedByName,
    bool? recordedByFormer,
    int? reversedById,
    String? reversalReason,
  }) = _LedgerEntryImpl;

  factory LedgerEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return LedgerEntry(
      id: jsonSerialization['id'] as int?,
      projectId: jsonSerialization['projectId'] as int,
      stageId: jsonSerialization['stageId'] as int?,
      kind: _i2lcu4mb.LedgerEntryKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      amountMinor: jsonSerialization['amountMinor'] as int,
      occurredOn: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredOn'],
      ),
      recordedBy: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['recordedBy'],
      ),
      method: jsonSerialization['method'] == null
          ? null
          : _izc06igq.ReleaseMethod.fromJson(
              (jsonSerialization['method'] as String),
            ),
      reference: jsonSerialization['reference'] as String?,
      confirmedBy: jsonSerialization['confirmedBy'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['confirmedBy'],
            ),
      confirmedAt: jsonSerialization['confirmedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['confirmedAt'],
            ),
      category: jsonSerialization['category'] == null
          ? null
          : _iy8yxm42.ExpenseCategory.fromJson(
              (jsonSerialization['category'] as String),
            ),
      description: jsonSerialization['description'] as String?,
      vendor: jsonSerialization['vendor'] as String?,
      receiptPath: jsonSerialization['receiptPath'] as String?,
      receiptSha256: jsonSerialization['receiptSha256'] as String?,
      note: jsonSerialization['note'] as String?,
      reversesId: jsonSerialization['reversesId'] as int?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      recordedByName: jsonSerialization['recordedByName'] as String?,
      recordedByFormer: jsonSerialization['recordedByFormer'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['recordedByFormer'],
            ),
      reversedById: jsonSerialization['reversedById'] as int?,
      reversalReason: jsonSerialization['reversalReason'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int projectId;

  int? stageId;

  _i2lcu4mb.LedgerEntryKind kind;

  /// Minor units of the project currency; negative only in a reversal.
  int amountMinor;

  /// The day it happened (UTC midnight), not in the future.
  DateTime occurredOn;

  _isc.UuidValue recordedBy;

  /// Release: how it was sent, its reference, the site manager's
  /// confirmation (LED-02).
  _izc06igq.ReleaseMethod? method;

  String? reference;

  _isc.UuidValue? confirmedBy;

  DateTime? confirmedAt;

  /// Expense: what for, from whom, the receipt photo (doc/04f M6-5 a).
  _iy8yxm42.ExpenseCategory? category;

  String? description;

  String? vendor;

  String? receiptPath;

  String? receiptSha256;

  /// A release's note, or a reversal's reason.
  String? note;

  /// The entry this one reverses.
  int? reversesId;

  DateTime createdAt;

  /// Filled when entries are read.
  String? recordedByName;

  bool? recordedByFormer;

  /// The reversal of this entry, if any.
  int? reversedById;

  String? reversalReason;

  /// Returns a shallow copy of this [LedgerEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LedgerEntry copyWith({
    int? id,
    int? projectId,
    int? stageId,
    _i2lcu4mb.LedgerEntryKind? kind,
    int? amountMinor,
    DateTime? occurredOn,
    _isc.UuidValue? recordedBy,
    _izc06igq.ReleaseMethod? method,
    String? reference,
    _isc.UuidValue? confirmedBy,
    DateTime? confirmedAt,
    _iy8yxm42.ExpenseCategory? category,
    String? description,
    String? vendor,
    String? receiptPath,
    String? receiptSha256,
    String? note,
    int? reversesId,
    DateTime? createdAt,
    String? recordedByName,
    bool? recordedByFormer,
    int? reversedById,
    String? reversalReason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LedgerEntry',
      if (id != null) 'id': id,
      'projectId': projectId,
      if (stageId != null) 'stageId': stageId,
      'kind': kind.toJson(),
      'amountMinor': amountMinor,
      'occurredOn': occurredOn.toJson(),
      'recordedBy': recordedBy.toJson(),
      if (method != null) 'method': method?.toJson(),
      if (reference != null) 'reference': reference,
      if (confirmedBy != null) 'confirmedBy': confirmedBy?.toJson(),
      if (confirmedAt != null) 'confirmedAt': confirmedAt?.toJson(),
      if (category != null) 'category': category?.toJson(),
      if (description != null) 'description': description,
      if (vendor != null) 'vendor': vendor,
      if (receiptPath != null) 'receiptPath': receiptPath,
      if (receiptSha256 != null) 'receiptSha256': receiptSha256,
      if (note != null) 'note': note,
      if (reversesId != null) 'reversesId': reversesId,
      'createdAt': createdAt.toJson(),
      if (recordedByName != null) 'recordedByName': recordedByName,
      if (recordedByFormer != null) 'recordedByFormer': recordedByFormer,
      if (reversedById != null) 'reversedById': reversedById,
      if (reversalReason != null) 'reversalReason': reversalReason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LedgerEntry',
      if (id != null) 'id': id,
      'projectId': projectId,
      if (stageId != null) 'stageId': stageId,
      'kind': kind.toJson(),
      'amountMinor': amountMinor,
      'occurredOn': occurredOn.toJson(),
      'recordedBy': recordedBy.toJson(),
      if (method != null) 'method': method?.toJson(),
      if (reference != null) 'reference': reference,
      if (confirmedBy != null) 'confirmedBy': confirmedBy?.toJson(),
      if (confirmedAt != null) 'confirmedAt': confirmedAt?.toJson(),
      if (category != null) 'category': category?.toJson(),
      if (description != null) 'description': description,
      if (vendor != null) 'vendor': vendor,
      if (receiptPath != null) 'receiptPath': receiptPath,
      if (receiptSha256 != null) 'receiptSha256': receiptSha256,
      if (note != null) 'note': note,
      if (reversesId != null) 'reversesId': reversesId,
      'createdAt': createdAt.toJson(),
      if (recordedByName != null) 'recordedByName': recordedByName,
      if (recordedByFormer != null) 'recordedByFormer': recordedByFormer,
      if (reversedById != null) 'reversedById': reversedById,
      if (reversalReason != null) 'reversalReason': reversalReason,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LedgerEntryImpl extends LedgerEntry {
  _LedgerEntryImpl({
    int? id,
    required int projectId,
    int? stageId,
    required _i2lcu4mb.LedgerEntryKind kind,
    required int amountMinor,
    required DateTime occurredOn,
    required _isc.UuidValue recordedBy,
    _izc06igq.ReleaseMethod? method,
    String? reference,
    _isc.UuidValue? confirmedBy,
    DateTime? confirmedAt,
    _iy8yxm42.ExpenseCategory? category,
    String? description,
    String? vendor,
    String? receiptPath,
    String? receiptSha256,
    String? note,
    int? reversesId,
    required DateTime createdAt,
    String? recordedByName,
    bool? recordedByFormer,
    int? reversedById,
    String? reversalReason,
  }) : super._(
         id: id,
         projectId: projectId,
         stageId: stageId,
         kind: kind,
         amountMinor: amountMinor,
         occurredOn: occurredOn,
         recordedBy: recordedBy,
         method: method,
         reference: reference,
         confirmedBy: confirmedBy,
         confirmedAt: confirmedAt,
         category: category,
         description: description,
         vendor: vendor,
         receiptPath: receiptPath,
         receiptSha256: receiptSha256,
         note: note,
         reversesId: reversesId,
         createdAt: createdAt,
         recordedByName: recordedByName,
         recordedByFormer: recordedByFormer,
         reversedById: reversedById,
         reversalReason: reversalReason,
       );

  /// Returns a shallow copy of this [LedgerEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LedgerEntry copyWith({
    Object? id = _Undefined,
    int? projectId,
    Object? stageId = _Undefined,
    _i2lcu4mb.LedgerEntryKind? kind,
    int? amountMinor,
    DateTime? occurredOn,
    _isc.UuidValue? recordedBy,
    Object? method = _Undefined,
    Object? reference = _Undefined,
    Object? confirmedBy = _Undefined,
    Object? confirmedAt = _Undefined,
    Object? category = _Undefined,
    Object? description = _Undefined,
    Object? vendor = _Undefined,
    Object? receiptPath = _Undefined,
    Object? receiptSha256 = _Undefined,
    Object? note = _Undefined,
    Object? reversesId = _Undefined,
    DateTime? createdAt,
    Object? recordedByName = _Undefined,
    Object? recordedByFormer = _Undefined,
    Object? reversedById = _Undefined,
    Object? reversalReason = _Undefined,
  }) {
    return LedgerEntry(
      id: id is int? ? id : this.id,
      projectId: projectId ?? this.projectId,
      stageId: stageId is int? ? stageId : this.stageId,
      kind: kind ?? this.kind,
      amountMinor: amountMinor ?? this.amountMinor,
      occurredOn: occurredOn ?? this.occurredOn,
      recordedBy: recordedBy ?? this.recordedBy,
      method: method is _izc06igq.ReleaseMethod? ? method : this.method,
      reference: reference is String? ? reference : this.reference,
      confirmedBy: confirmedBy is _isc.UuidValue?
          ? confirmedBy
          : this.confirmedBy,
      confirmedAt: confirmedAt is DateTime? ? confirmedAt : this.confirmedAt,
      category: category is _iy8yxm42.ExpenseCategory?
          ? category
          : this.category,
      description: description is String? ? description : this.description,
      vendor: vendor is String? ? vendor : this.vendor,
      receiptPath: receiptPath is String? ? receiptPath : this.receiptPath,
      receiptSha256: receiptSha256 is String?
          ? receiptSha256
          : this.receiptSha256,
      note: note is String? ? note : this.note,
      reversesId: reversesId is int? ? reversesId : this.reversesId,
      createdAt: createdAt ?? this.createdAt,
      recordedByName: recordedByName is String?
          ? recordedByName
          : this.recordedByName,
      recordedByFormer: recordedByFormer is bool?
          ? recordedByFormer
          : this.recordedByFormer,
      reversedById: reversedById is int? ? reversedById : this.reversedById,
      reversalReason: reversalReason is String?
          ? reversalReason
          : this.reversalReason,
    );
  }
}
