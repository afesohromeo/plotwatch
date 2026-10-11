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
import 'expense_category.dart' as _iy8yxm42;
import 'ledger_entry_kind.dart' as _i2lcu4mb;
import 'release_method.dart' as _izc06igq;

/// One line of a project's ledger: a fund release recorded by a funder or
/// an expense recorded by the site manager (LED-01, LED-03; doc/04f M6-1).
/// Never updated except to confirm a release; a mistake is corrected by a
/// reversal entry with the negative amount (LED-06).
abstract class LedgerEntry
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    required _is.UuidValue recordedBy,
    _izc06igq.ReleaseMethod? method,
    String? reference,
    _is.UuidValue? confirmedBy,
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
      occurredOn: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredOn'],
      ),
      recordedBy: _is.UuidValueJsonExtension.fromJson(
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
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['confirmedBy'],
            ),
      confirmedAt: jsonSerialization['confirmedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
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
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      recordedByName: jsonSerialization['recordedByName'] as String?,
      recordedByFormer: jsonSerialization['recordedByFormer'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['recordedByFormer'],
            ),
      reversedById: jsonSerialization['reversedById'] as int?,
      reversalReason: jsonSerialization['reversalReason'] as String?,
    );
  }

  static final t = LedgerEntryTable();

  static const db = LedgerEntryRepository._();

  @override
  int? id;

  int projectId;

  int? stageId;

  _i2lcu4mb.LedgerEntryKind kind;

  /// Minor units of the project currency; negative only in a reversal.
  int amountMinor;

  /// The day it happened (UTC midnight), not in the future.
  DateTime occurredOn;

  _is.UuidValue recordedBy;

  /// Release: how it was sent, its reference, the site manager's
  /// confirmation (LED-02).
  _izc06igq.ReleaseMethod? method;

  String? reference;

  _is.UuidValue? confirmedBy;

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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [LedgerEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LedgerEntry copyWith({
    int? id,
    int? projectId,
    int? stageId,
    _i2lcu4mb.LedgerEntryKind? kind,
    int? amountMinor,
    DateTime? occurredOn,
    _is.UuidValue? recordedBy,
    _izc06igq.ReleaseMethod? method,
    String? reference,
    _is.UuidValue? confirmedBy,
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

  static LedgerEntryInclude include() {
    return LedgerEntryInclude._();
  }

  static LedgerEntryIncludeList includeList({
    _is.WhereExpressionBuilder<LedgerEntryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LedgerEntryTable>? orderBy,
    _is.OrderByListBuilder<LedgerEntryTable>? orderByList,
    LedgerEntryInclude? include,
  }) {
    return LedgerEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LedgerEntry.t),
      orderByList: orderByList?.call(LedgerEntry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
    required _is.UuidValue recordedBy,
    _izc06igq.ReleaseMethod? method,
    String? reference,
    _is.UuidValue? confirmedBy,
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
  @_is.useResult
  @override
  LedgerEntry copyWith({
    Object? id = _Undefined,
    int? projectId,
    Object? stageId = _Undefined,
    _i2lcu4mb.LedgerEntryKind? kind,
    int? amountMinor,
    DateTime? occurredOn,
    _is.UuidValue? recordedBy,
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
      confirmedBy: confirmedBy is _is.UuidValue?
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

class LedgerEntryUpdateTable extends _is.UpdateTable<LedgerEntryTable> {
  LedgerEntryUpdateTable(super.table);

  _is.ColumnValue<int, int> projectId(int value) => _is.ColumnValue(
    table.projectId,
    value,
  );

  _is.ColumnValue<int, int> stageId(int? value) => _is.ColumnValue(
    table.stageId,
    value,
  );

  _is.ColumnValue<_i2lcu4mb.LedgerEntryKind, _i2lcu4mb.LedgerEntryKind> kind(
    _i2lcu4mb.LedgerEntryKind value,
  ) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<int, int> amountMinor(int value) => _is.ColumnValue(
    table.amountMinor,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> occurredOn(DateTime value) =>
      _is.ColumnValue(
        table.occurredOn,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> recordedBy(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.recordedBy,
    value,
  );

  _is.ColumnValue<_izc06igq.ReleaseMethod, _izc06igq.ReleaseMethod> method(
    _izc06igq.ReleaseMethod? value,
  ) => _is.ColumnValue(
    table.method,
    value,
  );

  _is.ColumnValue<String, String> reference(String? value) => _is.ColumnValue(
    table.reference,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> confirmedBy(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.confirmedBy,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> confirmedAt(DateTime? value) =>
      _is.ColumnValue(
        table.confirmedAt,
        value,
      );

  _is.ColumnValue<_iy8yxm42.ExpenseCategory, _iy8yxm42.ExpenseCategory>
  category(_iy8yxm42.ExpenseCategory? value) => _is.ColumnValue(
    table.category,
    value,
  );

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<String, String> vendor(String? value) => _is.ColumnValue(
    table.vendor,
    value,
  );

  _is.ColumnValue<String, String> receiptPath(String? value) => _is.ColumnValue(
    table.receiptPath,
    value,
  );

  _is.ColumnValue<String, String> receiptSha256(String? value) =>
      _is.ColumnValue(
        table.receiptSha256,
        value,
      );

  _is.ColumnValue<String, String> note(String? value) => _is.ColumnValue(
    table.note,
    value,
  );

  _is.ColumnValue<int, int> reversesId(int? value) => _is.ColumnValue(
    table.reversesId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class LedgerEntryTable extends _is.Table<int?> {
  LedgerEntryTable({super.tableRelation}) : super(tableName: 'ledger_entry') {
    updateTable = LedgerEntryUpdateTable(this);
    projectId = _is.ColumnInt(
      'projectId',
      this,
    );
    stageId = _is.ColumnInt(
      'stageId',
      this,
    );
    kind = _is.ColumnEnum(
      'kind',
      this,
      _is.EnumSerialization.byName,
    );
    amountMinor = _is.ColumnInt(
      'amountMinor',
      this,
    );
    occurredOn = _is.ColumnDateTime(
      'occurredOn',
      this,
    );
    recordedBy = _is.ColumnUuid(
      'recordedBy',
      this,
    );
    method = _is.ColumnEnum(
      'method',
      this,
      _is.EnumSerialization.byName,
    );
    reference = _is.ColumnString(
      'reference',
      this,
    );
    confirmedBy = _is.ColumnUuid(
      'confirmedBy',
      this,
    );
    confirmedAt = _is.ColumnDateTime(
      'confirmedAt',
      this,
    );
    category = _is.ColumnEnum(
      'category',
      this,
      _is.EnumSerialization.byName,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    vendor = _is.ColumnString(
      'vendor',
      this,
    );
    receiptPath = _is.ColumnString(
      'receiptPath',
      this,
    );
    receiptSha256 = _is.ColumnString(
      'receiptSha256',
      this,
    );
    note = _is.ColumnString(
      'note',
      this,
    );
    reversesId = _is.ColumnInt(
      'reversesId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final LedgerEntryUpdateTable updateTable;

  late final _is.ColumnInt projectId;

  late final _is.ColumnInt stageId;

  late final _is.ColumnEnum<_i2lcu4mb.LedgerEntryKind> kind;

  /// Minor units of the project currency; negative only in a reversal.
  late final _is.ColumnInt amountMinor;

  /// The day it happened (UTC midnight), not in the future.
  late final _is.ColumnDateTime occurredOn;

  late final _is.ColumnUuid recordedBy;

  /// Release: how it was sent, its reference, the site manager's
  /// confirmation (LED-02).
  late final _is.ColumnEnum<_izc06igq.ReleaseMethod> method;

  late final _is.ColumnString reference;

  late final _is.ColumnUuid confirmedBy;

  late final _is.ColumnDateTime confirmedAt;

  /// Expense: what for, from whom, the receipt photo (doc/04f M6-5 a).
  late final _is.ColumnEnum<_iy8yxm42.ExpenseCategory> category;

  late final _is.ColumnString description;

  late final _is.ColumnString vendor;

  late final _is.ColumnString receiptPath;

  late final _is.ColumnString receiptSha256;

  /// A release's note, or a reversal's reason.
  late final _is.ColumnString note;

  /// The entry this one reverses.
  late final _is.ColumnInt reversesId;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    projectId,
    stageId,
    kind,
    amountMinor,
    occurredOn,
    recordedBy,
    method,
    reference,
    confirmedBy,
    confirmedAt,
    category,
    description,
    vendor,
    receiptPath,
    receiptSha256,
    note,
    reversesId,
    createdAt,
  ];
}

class LedgerEntryInclude extends _is.IncludeObject {
  LedgerEntryInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => LedgerEntry.t;
}

class LedgerEntryIncludeList extends _is.IncludeList {
  LedgerEntryIncludeList._({
    _is.WhereExpressionBuilder<LedgerEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LedgerEntry.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => LedgerEntry.t;
}

class LedgerEntryRepository {
  const LedgerEntryRepository._();

  /// Returns a list of [LedgerEntry]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<LedgerEntry>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LedgerEntryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LedgerEntryTable>? orderBy,
    _is.OrderByListBuilder<LedgerEntryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LedgerEntry>(
      where: where?.call(LedgerEntry.t),
      orderBy: orderBy?.call(LedgerEntry.t),
      orderByList: orderByList?.call(LedgerEntry.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LedgerEntry] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<LedgerEntry?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LedgerEntryTable>? where,
    int? offset,
    _is.OrderByBuilder<LedgerEntryTable>? orderBy,
    _is.OrderByListBuilder<LedgerEntryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LedgerEntry>(
      where: where?.call(LedgerEntry.t),
      orderBy: orderBy?.call(LedgerEntry.t),
      orderByList: orderByList?.call(LedgerEntry.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LedgerEntry] by its [id] or null if no such row exists.
  Future<LedgerEntry?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LedgerEntry>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LedgerEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [LedgerEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LedgerEntry>> insert(
    _is.DatabaseSession session,
    List<LedgerEntry> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<LedgerEntry>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [LedgerEntry] and returns the inserted row.
  ///
  /// The returned [LedgerEntry] will have its `id` field set.
  Future<LedgerEntry> insertRow(
    _is.DatabaseSession session,
    LedgerEntry row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<LedgerEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [LedgerEntry]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [LedgerEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LedgerEntry>> upsert(
    _is.DatabaseSession session,
    List<LedgerEntry> rows, {
    required _is.ColumnSelections<LedgerEntryTable> conflictColumns,
    _is.ColumnSelections<LedgerEntryTable>? updateColumns,
    _is.WhereExpressionBuilder<LedgerEntryTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<LedgerEntry>(
      rows,
      conflictColumns: conflictColumns(LedgerEntry.t),
      updateColumns: updateColumns?.call(LedgerEntry.t),
      updateWhere: updateWhere?.call(LedgerEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [LedgerEntry] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [LedgerEntry] will have its `id` field set.
  Future<LedgerEntry?> upsertRow(
    _is.DatabaseSession session,
    LedgerEntry row, {
    required _is.ColumnSelections<LedgerEntryTable> conflictColumns,
    _is.ColumnSelections<LedgerEntryTable>? updateColumns,
    _is.WhereExpressionBuilder<LedgerEntryTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<LedgerEntry>(
      row,
      conflictColumns: conflictColumns(LedgerEntry.t),
      updateColumns: updateColumns?.call(LedgerEntry.t),
      updateWhere: updateWhere?.call(LedgerEntry.t),
      transaction: transaction,
    );
  }

  /// Updates all [LedgerEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LedgerEntry>> update(
    _is.DatabaseSession session,
    List<LedgerEntry> rows, {
    _is.ColumnSelections<LedgerEntryTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<LedgerEntry>(
      rows,
      columns: columns?.call(LedgerEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [LedgerEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LedgerEntry> updateRow(
    _is.DatabaseSession session,
    LedgerEntry row, {
    _is.ColumnSelections<LedgerEntryTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<LedgerEntry>(
      row,
      columns: columns?.call(LedgerEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LedgerEntry] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LedgerEntry?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<LedgerEntryUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<LedgerEntry>(
      id,
      columnValues: columnValues(LedgerEntry.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LedgerEntry]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LedgerEntry>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<LedgerEntryUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<LedgerEntryTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LedgerEntryTable>? orderBy,
    _is.OrderByListBuilder<LedgerEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<LedgerEntry>(
      columnValues: columnValues(LedgerEntry.t.updateTable),
      where: where(LedgerEntry.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LedgerEntry.t),
      orderByList: orderByList?.call(LedgerEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [LedgerEntry]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LedgerEntry>> delete(
    _is.DatabaseSession session,
    List<LedgerEntry> rows, {
    _is.OrderByBuilder<LedgerEntryTable>? orderBy,
    _is.OrderByListBuilder<LedgerEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<LedgerEntry>(
      rows,
      orderBy: orderBy?.call(LedgerEntry.t),
      orderByList: orderByList?.call(LedgerEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [LedgerEntry].
  Future<LedgerEntry> deleteRow(
    _is.DatabaseSession session,
    LedgerEntry row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LedgerEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LedgerEntry>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LedgerEntryTable> where,
    _is.OrderByBuilder<LedgerEntryTable>? orderBy,
    _is.OrderByListBuilder<LedgerEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<LedgerEntry>(
      where: where(LedgerEntry.t),
      orderBy: orderBy?.call(LedgerEntry.t),
      orderByList: orderByList?.call(LedgerEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LedgerEntryTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<LedgerEntry>(
      where: where?.call(LedgerEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LedgerEntry] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LedgerEntryTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LedgerEntry>(
      where: where(LedgerEntry.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
