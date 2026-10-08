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

/// One piece of evidence a stage requires (STG-04, doc/04c M3-5). Its ID
/// stays stable when the stage is edited, because captures attach to it
/// from M4 on.
abstract class ChecklistItem
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
      isRequired: _is.BoolJsonExtension.fromJson(
        jsonSerialization['isRequired'],
      ),
    );
  }

  static final t = ChecklistItemTable();

  static const db = ChecklistItemRepository._();

  @override
  int? id;

  int stageId;

  /// 0…n−1 within the stage.
  int orderIndex;

  /// 1–200 characters after trimming.
  String label;

  bool isRequired;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ChecklistItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static ChecklistItemInclude include() {
    return ChecklistItemInclude._();
  }

  static ChecklistItemIncludeList includeList({
    _is.WhereExpressionBuilder<ChecklistItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChecklistItemTable>? orderBy,
    _is.OrderByListBuilder<ChecklistItemTable>? orderByList,
    ChecklistItemInclude? include,
  }) {
    return ChecklistItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChecklistItem.t),
      orderByList: orderByList?.call(ChecklistItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class ChecklistItemUpdateTable extends _is.UpdateTable<ChecklistItemTable> {
  ChecklistItemUpdateTable(super.table);

  _is.ColumnValue<int, int> stageId(int value) => _is.ColumnValue(
    table.stageId,
    value,
  );

  _is.ColumnValue<int, int> orderIndex(int value) => _is.ColumnValue(
    table.orderIndex,
    value,
  );

  _is.ColumnValue<String, String> label(String value) => _is.ColumnValue(
    table.label,
    value,
  );

  _is.ColumnValue<bool, bool> isRequired(bool value) => _is.ColumnValue(
    table.isRequired,
    value,
  );
}

class ChecklistItemTable extends _is.Table<int?> {
  ChecklistItemTable({super.tableRelation})
    : super(tableName: 'checklist_item') {
    updateTable = ChecklistItemUpdateTable(this);
    stageId = _is.ColumnInt(
      'stageId',
      this,
    );
    orderIndex = _is.ColumnInt(
      'orderIndex',
      this,
    );
    label = _is.ColumnString(
      'label',
      this,
    );
    isRequired = _is.ColumnBool(
      'isRequired',
      this,
    );
  }

  late final ChecklistItemUpdateTable updateTable;

  late final _is.ColumnInt stageId;

  /// 0…n−1 within the stage.
  late final _is.ColumnInt orderIndex;

  /// 1–200 characters after trimming.
  late final _is.ColumnString label;

  late final _is.ColumnBool isRequired;

  @override
  List<_is.Column> get columns => [
    id,
    stageId,
    orderIndex,
    label,
    isRequired,
  ];
}

class ChecklistItemInclude extends _is.IncludeObject {
  ChecklistItemInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ChecklistItem.t;
}

class ChecklistItemIncludeList extends _is.IncludeList {
  ChecklistItemIncludeList._({
    _is.WhereExpressionBuilder<ChecklistItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChecklistItem.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ChecklistItem.t;
}

class ChecklistItemRepository {
  const ChecklistItemRepository._();

  /// Returns a list of [ChecklistItem]s matching the given query parameters.
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
  Future<List<ChecklistItem>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChecklistItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChecklistItemTable>? orderBy,
    _is.OrderByListBuilder<ChecklistItemTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ChecklistItem>(
      where: where?.call(ChecklistItem.t),
      orderBy: orderBy?.call(ChecklistItem.t),
      orderByList: orderByList?.call(ChecklistItem.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ChecklistItem] matching the given query parameters.
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
  Future<ChecklistItem?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChecklistItemTable>? where,
    int? offset,
    _is.OrderByBuilder<ChecklistItemTable>? orderBy,
    _is.OrderByListBuilder<ChecklistItemTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ChecklistItem>(
      where: where?.call(ChecklistItem.t),
      orderBy: orderBy?.call(ChecklistItem.t),
      orderByList: orderByList?.call(ChecklistItem.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ChecklistItem] by its [id] or null if no such row exists.
  Future<ChecklistItem?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ChecklistItem>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ChecklistItem]s in the list and returns the inserted rows.
  ///
  /// The returned [ChecklistItem]s will have their `id` fields set.
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
  Future<List<ChecklistItem>> insert(
    _is.DatabaseSession session,
    List<ChecklistItem> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ChecklistItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ChecklistItem] and returns the inserted row.
  ///
  /// The returned [ChecklistItem] will have its `id` field set.
  Future<ChecklistItem> insertRow(
    _is.DatabaseSession session,
    ChecklistItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChecklistItem>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ChecklistItem]s in the list and returns the resulting rows.
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
  /// The returned [ChecklistItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChecklistItem>> upsert(
    _is.DatabaseSession session,
    List<ChecklistItem> rows, {
    required _is.ColumnSelections<ChecklistItemTable> conflictColumns,
    _is.ColumnSelections<ChecklistItemTable>? updateColumns,
    _is.WhereExpressionBuilder<ChecklistItemTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ChecklistItem>(
      rows,
      conflictColumns: conflictColumns(ChecklistItem.t),
      updateColumns: updateColumns?.call(ChecklistItem.t),
      updateWhere: updateWhere?.call(ChecklistItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ChecklistItem] and returns the resulting row.
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
  /// The returned [ChecklistItem] will have its `id` field set.
  Future<ChecklistItem?> upsertRow(
    _is.DatabaseSession session,
    ChecklistItem row, {
    required _is.ColumnSelections<ChecklistItemTable> conflictColumns,
    _is.ColumnSelections<ChecklistItemTable>? updateColumns,
    _is.WhereExpressionBuilder<ChecklistItemTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ChecklistItem>(
      row,
      conflictColumns: conflictColumns(ChecklistItem.t),
      updateColumns: updateColumns?.call(ChecklistItem.t),
      updateWhere: updateWhere?.call(ChecklistItem.t),
      transaction: transaction,
    );
  }

  /// Updates all [ChecklistItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChecklistItem>> update(
    _is.DatabaseSession session,
    List<ChecklistItem> rows, {
    _is.ColumnSelections<ChecklistItemTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ChecklistItem>(
      rows,
      columns: columns?.call(ChecklistItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ChecklistItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChecklistItem> updateRow(
    _is.DatabaseSession session,
    ChecklistItem row, {
    _is.ColumnSelections<ChecklistItemTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChecklistItem>(
      row,
      columns: columns?.call(ChecklistItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChecklistItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ChecklistItem?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ChecklistItemUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ChecklistItem>(
      id,
      columnValues: columnValues(ChecklistItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ChecklistItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChecklistItem>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ChecklistItemUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ChecklistItemTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChecklistItemTable>? orderBy,
    _is.OrderByListBuilder<ChecklistItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ChecklistItem>(
      columnValues: columnValues(ChecklistItem.t.updateTable),
      where: where(ChecklistItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChecklistItem.t),
      orderByList: orderByList?.call(ChecklistItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ChecklistItem]s in the list and returns the deleted rows.
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
  Future<List<ChecklistItem>> delete(
    _is.DatabaseSession session,
    List<ChecklistItem> rows, {
    _is.OrderByBuilder<ChecklistItemTable>? orderBy,
    _is.OrderByListBuilder<ChecklistItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ChecklistItem>(
      rows,
      orderBy: orderBy?.call(ChecklistItem.t),
      orderByList: orderByList?.call(ChecklistItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ChecklistItem].
  Future<ChecklistItem> deleteRow(
    _is.DatabaseSession session,
    ChecklistItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChecklistItem>(
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
  Future<List<ChecklistItem>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChecklistItemTable> where,
    _is.OrderByBuilder<ChecklistItemTable>? orderBy,
    _is.OrderByListBuilder<ChecklistItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ChecklistItem>(
      where: where(ChecklistItem.t),
      orderBy: orderBy?.call(ChecklistItem.t),
      orderByList: orderByList?.call(ChecklistItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChecklistItemTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ChecklistItem>(
      where: where?.call(ChecklistItem.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ChecklistItem] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChecklistItemTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ChecklistItem>(
      where: where(ChecklistItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
