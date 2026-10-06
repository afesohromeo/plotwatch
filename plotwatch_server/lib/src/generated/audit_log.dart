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

/// Append-only record of security-relevant and financial actions (AUD-01).
/// Only AuditService writes it; nothing updates or deletes a row. Server only:
/// owners reading it is AUD-02 (P1).
abstract class AuditLog
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  AuditLog._({
    this.id,
    this.actorId,
    this.projectId,
    required this.action,
    required this.entityType,
    this.entityId,
    this.before,
    this.after,
    required this.createdAt,
  });

  factory AuditLog({
    int? id,
    _is.UuidValue? actorId,
    int? projectId,
    required String action,
    required String entityType,
    int? entityId,
    Map<String, String>? before,
    Map<String, String>? after,
    required DateTime createdAt,
  }) = _AuditLogImpl;

  factory AuditLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuditLog(
      id: jsonSerialization['id'] as int?,
      actorId: jsonSerialization['actorId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['actorId']),
      projectId: jsonSerialization['projectId'] as int?,
      action: jsonSerialization['action'] as String,
      entityType: jsonSerialization['entityType'] as String,
      entityId: jsonSerialization['entityId'] as int?,
      before: jsonSerialization['before'] == null
          ? null
          : _irbavk3a.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['before'],
            ),
      after: jsonSerialization['after'] == null
          ? null
          : _irbavk3a.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['after'],
            ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = AuditLogTable();

  static const db = AuditLogRepository._();

  @override
  int? id;

  _is.UuidValue? actorId;

  int? projectId;

  /// e.g. `project.create`, `site.set`, `member.remove`.
  String action;

  String entityType;

  int? entityId;

  Map<String, String>? before;

  Map<String, String>? after;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AuditLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AuditLog copyWith({
    int? id,
    _is.UuidValue? actorId,
    int? projectId,
    String? action,
    String? entityType,
    int? entityId,
    Map<String, String>? before,
    Map<String, String>? after,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuditLog',
      if (id != null) 'id': id,
      if (actorId != null) 'actorId': actorId?.toJson(),
      if (projectId != null) 'projectId': projectId,
      'action': action,
      'entityType': entityType,
      if (entityId != null) 'entityId': entityId,
      if (before != null) 'before': before?.toJson(),
      if (after != null) 'after': after?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static AuditLogInclude include() {
    return AuditLogInclude._();
  }

  static AuditLogIncludeList includeList({
    _is.WhereExpressionBuilder<AuditLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AuditLogTable>? orderBy,
    _is.OrderByListBuilder<AuditLogTable>? orderByList,
    AuditLogInclude? include,
  }) {
    return AuditLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AuditLog.t),
      orderByList: orderByList?.call(AuditLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuditLogImpl extends AuditLog {
  _AuditLogImpl({
    int? id,
    _is.UuidValue? actorId,
    int? projectId,
    required String action,
    required String entityType,
    int? entityId,
    Map<String, String>? before,
    Map<String, String>? after,
    required DateTime createdAt,
  }) : super._(
         id: id,
         actorId: actorId,
         projectId: projectId,
         action: action,
         entityType: entityType,
         entityId: entityId,
         before: before,
         after: after,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AuditLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AuditLog copyWith({
    Object? id = _Undefined,
    Object? actorId = _Undefined,
    Object? projectId = _Undefined,
    String? action,
    String? entityType,
    Object? entityId = _Undefined,
    Object? before = _Undefined,
    Object? after = _Undefined,
    DateTime? createdAt,
  }) {
    return AuditLog(
      id: id is int? ? id : this.id,
      actorId: actorId is _is.UuidValue? ? actorId : this.actorId,
      projectId: projectId is int? ? projectId : this.projectId,
      action: action ?? this.action,
      entityType: entityType ?? this.entityType,
      entityId: entityId is int? ? entityId : this.entityId,
      before: before is Map<String, String>?
          ? before
          : this.before?.map(
              (
                key0,
                value0,
              ) => MapEntry(
                key0,
                value0,
              ),
            ),
      after: after is Map<String, String>?
          ? after
          : this.after?.map(
              (
                key0,
                value0,
              ) => MapEntry(
                key0,
                value0,
              ),
            ),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AuditLogUpdateTable extends _is.UpdateTable<AuditLogTable> {
  AuditLogUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> actorId(_is.UuidValue? value) =>
      _is.ColumnValue(
        table.actorId,
        value,
      );

  _is.ColumnValue<int, int> projectId(int? value) => _is.ColumnValue(
    table.projectId,
    value,
  );

  _is.ColumnValue<String, String> action(String value) => _is.ColumnValue(
    table.action,
    value,
  );

  _is.ColumnValue<String, String> entityType(String value) => _is.ColumnValue(
    table.entityType,
    value,
  );

  _is.ColumnValue<int, int> entityId(int? value) => _is.ColumnValue(
    table.entityId,
    value,
  );

  _is.ColumnValue<Map<String, String>, Map<String, String>> before(
    Map<String, String>? value,
  ) => _is.ColumnValue(
    table.before,
    value,
  );

  _is.ColumnValue<Map<String, String>, Map<String, String>> after(
    Map<String, String>? value,
  ) => _is.ColumnValue(
    table.after,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class AuditLogTable extends _is.Table<int?> {
  AuditLogTable({super.tableRelation}) : super(tableName: 'audit_log') {
    updateTable = AuditLogUpdateTable(this);
    actorId = _is.ColumnUuid(
      'actorId',
      this,
    );
    projectId = _is.ColumnInt(
      'projectId',
      this,
    );
    action = _is.ColumnString(
      'action',
      this,
    );
    entityType = _is.ColumnString(
      'entityType',
      this,
    );
    entityId = _is.ColumnInt(
      'entityId',
      this,
    );
    before = _is.ColumnSerializable<Map<String, String>>(
      'before',
      this,
    );
    after = _is.ColumnSerializable<Map<String, String>>(
      'after',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final AuditLogUpdateTable updateTable;

  late final _is.ColumnUuid actorId;

  late final _is.ColumnInt projectId;

  /// e.g. `project.create`, `site.set`, `member.remove`.
  late final _is.ColumnString action;

  late final _is.ColumnString entityType;

  late final _is.ColumnInt entityId;

  late final _is.ColumnSerializable<Map<String, String>> before;

  late final _is.ColumnSerializable<Map<String, String>> after;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    actorId,
    projectId,
    action,
    entityType,
    entityId,
    before,
    after,
    createdAt,
  ];
}

class AuditLogInclude extends _is.IncludeObject {
  AuditLogInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => AuditLog.t;
}

class AuditLogIncludeList extends _is.IncludeList {
  AuditLogIncludeList._({
    _is.WhereExpressionBuilder<AuditLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AuditLog.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AuditLog.t;
}

class AuditLogRepository {
  const AuditLogRepository._();

  /// Returns a list of [AuditLog]s matching the given query parameters.
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
  Future<List<AuditLog>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AuditLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AuditLogTable>? orderBy,
    _is.OrderByListBuilder<AuditLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AuditLog>(
      where: where?.call(AuditLog.t),
      orderBy: orderBy?.call(AuditLog.t),
      orderByList: orderByList?.call(AuditLog.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AuditLog] matching the given query parameters.
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
  Future<AuditLog?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AuditLogTable>? where,
    int? offset,
    _is.OrderByBuilder<AuditLogTable>? orderBy,
    _is.OrderByListBuilder<AuditLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AuditLog>(
      where: where?.call(AuditLog.t),
      orderBy: orderBy?.call(AuditLog.t),
      orderByList: orderByList?.call(AuditLog.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AuditLog] by its [id] or null if no such row exists.
  Future<AuditLog?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AuditLog>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AuditLog]s in the list and returns the inserted rows.
  ///
  /// The returned [AuditLog]s will have their `id` fields set.
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
  Future<List<AuditLog>> insert(
    _is.DatabaseSession session,
    List<AuditLog> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AuditLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AuditLog] and returns the inserted row.
  ///
  /// The returned [AuditLog] will have its `id` field set.
  Future<AuditLog> insertRow(
    _is.DatabaseSession session,
    AuditLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AuditLog>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AuditLog]s in the list and returns the resulting rows.
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
  /// The returned [AuditLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AuditLog>> upsert(
    _is.DatabaseSession session,
    List<AuditLog> rows, {
    required _is.ColumnSelections<AuditLogTable> conflictColumns,
    _is.ColumnSelections<AuditLogTable>? updateColumns,
    _is.WhereExpressionBuilder<AuditLogTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AuditLog>(
      rows,
      conflictColumns: conflictColumns(AuditLog.t),
      updateColumns: updateColumns?.call(AuditLog.t),
      updateWhere: updateWhere?.call(AuditLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AuditLog] and returns the resulting row.
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
  /// The returned [AuditLog] will have its `id` field set.
  Future<AuditLog?> upsertRow(
    _is.DatabaseSession session,
    AuditLog row, {
    required _is.ColumnSelections<AuditLogTable> conflictColumns,
    _is.ColumnSelections<AuditLogTable>? updateColumns,
    _is.WhereExpressionBuilder<AuditLogTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AuditLog>(
      row,
      conflictColumns: conflictColumns(AuditLog.t),
      updateColumns: updateColumns?.call(AuditLog.t),
      updateWhere: updateWhere?.call(AuditLog.t),
      transaction: transaction,
    );
  }

  /// Updates all [AuditLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AuditLog>> update(
    _is.DatabaseSession session,
    List<AuditLog> rows, {
    _is.ColumnSelections<AuditLogTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AuditLog>(
      rows,
      columns: columns?.call(AuditLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AuditLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AuditLog> updateRow(
    _is.DatabaseSession session,
    AuditLog row, {
    _is.ColumnSelections<AuditLogTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AuditLog>(
      row,
      columns: columns?.call(AuditLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AuditLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AuditLog?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AuditLogUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AuditLog>(
      id,
      columnValues: columnValues(AuditLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AuditLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AuditLog>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AuditLogUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AuditLogTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AuditLogTable>? orderBy,
    _is.OrderByListBuilder<AuditLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AuditLog>(
      columnValues: columnValues(AuditLog.t.updateTable),
      where: where(AuditLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AuditLog.t),
      orderByList: orderByList?.call(AuditLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AuditLog]s in the list and returns the deleted rows.
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
  Future<List<AuditLog>> delete(
    _is.DatabaseSession session,
    List<AuditLog> rows, {
    _is.OrderByBuilder<AuditLogTable>? orderBy,
    _is.OrderByListBuilder<AuditLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AuditLog>(
      rows,
      orderBy: orderBy?.call(AuditLog.t),
      orderByList: orderByList?.call(AuditLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AuditLog].
  Future<AuditLog> deleteRow(
    _is.DatabaseSession session,
    AuditLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AuditLog>(
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
  Future<List<AuditLog>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AuditLogTable> where,
    _is.OrderByBuilder<AuditLogTable>? orderBy,
    _is.OrderByListBuilder<AuditLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AuditLog>(
      where: where(AuditLog.t),
      orderBy: orderBy?.call(AuditLog.t),
      orderByList: orderByList?.call(AuditLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AuditLogTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AuditLog>(
      where: where?.call(AuditLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AuditLog] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AuditLogTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AuditLog>(
      where: where(AuditLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
