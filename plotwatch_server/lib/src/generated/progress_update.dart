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
import 'weather.dart' as _ifjsehv5;

/// The site manager's news from the site, without photos for now
/// (UPD-01, doc/04e M5-9 b).
abstract class ProgressUpdate
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ProgressUpdate._({
    this.id,
    required this.projectId,
    this.stageId,
    required this.authorId,
    this.authorName,
    this.authorFormer,
    required this.text,
    this.workersCount,
    this.weather,
    this.issues,
    required this.createdAt,
  });

  factory ProgressUpdate({
    int? id,
    required int projectId,
    int? stageId,
    required _is.UuidValue authorId,
    String? authorName,
    bool? authorFormer,
    required String text,
    int? workersCount,
    _ifjsehv5.Weather? weather,
    String? issues,
    required DateTime createdAt,
  }) = _ProgressUpdateImpl;

  factory ProgressUpdate.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProgressUpdate(
      id: jsonSerialization['id'] as int?,
      projectId: jsonSerialization['projectId'] as int,
      stageId: jsonSerialization['stageId'] as int?,
      authorId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authorId'],
      ),
      authorName: jsonSerialization['authorName'] as String?,
      authorFormer: jsonSerialization['authorFormer'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['authorFormer']),
      text: jsonSerialization['text'] as String,
      workersCount: jsonSerialization['workersCount'] as int?,
      weather: jsonSerialization['weather'] == null
          ? null
          : _ifjsehv5.Weather.fromJson(
              (jsonSerialization['weather'] as String),
            ),
      issues: jsonSerialization['issues'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = ProgressUpdateTable();

  static const db = ProgressUpdateRepository._();

  @override
  int? id;

  int projectId;

  int? stageId;

  _is.UuidValue authorId;

  /// Filled when one update is read (doc/04e C-2d).
  String? authorName;

  /// True when they are no longer a member.
  bool? authorFormer;

  /// 1–2,000 characters.
  String text;

  /// 0–999.
  int? workersCount;

  _ifjsehv5.Weather? weather;

  /// At most 1,000 characters.
  String? issues;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProgressUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ProgressUpdate copyWith({
    int? id,
    int? projectId,
    int? stageId,
    _is.UuidValue? authorId,
    String? authorName,
    bool? authorFormer,
    String? text,
    int? workersCount,
    _ifjsehv5.Weather? weather,
    String? issues,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProgressUpdate',
      if (id != null) 'id': id,
      'projectId': projectId,
      if (stageId != null) 'stageId': stageId,
      'authorId': authorId.toJson(),
      if (authorName != null) 'authorName': authorName,
      if (authorFormer != null) 'authorFormer': authorFormer,
      'text': text,
      if (workersCount != null) 'workersCount': workersCount,
      if (weather != null) 'weather': weather?.toJson(),
      if (issues != null) 'issues': issues,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProgressUpdate',
      if (id != null) 'id': id,
      'projectId': projectId,
      if (stageId != null) 'stageId': stageId,
      'authorId': authorId.toJson(),
      if (authorName != null) 'authorName': authorName,
      if (authorFormer != null) 'authorFormer': authorFormer,
      'text': text,
      if (workersCount != null) 'workersCount': workersCount,
      if (weather != null) 'weather': weather?.toJson(),
      if (issues != null) 'issues': issues,
      'createdAt': createdAt.toJson(),
    };
  }

  static ProgressUpdateInclude include() {
    return ProgressUpdateInclude._();
  }

  static ProgressUpdateIncludeList includeList({
    _is.WhereExpressionBuilder<ProgressUpdateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProgressUpdateTable>? orderBy,
    _is.OrderByListBuilder<ProgressUpdateTable>? orderByList,
    ProgressUpdateInclude? include,
  }) {
    return ProgressUpdateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProgressUpdate.t),
      orderByList: orderByList?.call(ProgressUpdate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProgressUpdateImpl extends ProgressUpdate {
  _ProgressUpdateImpl({
    int? id,
    required int projectId,
    int? stageId,
    required _is.UuidValue authorId,
    String? authorName,
    bool? authorFormer,
    required String text,
    int? workersCount,
    _ifjsehv5.Weather? weather,
    String? issues,
    required DateTime createdAt,
  }) : super._(
         id: id,
         projectId: projectId,
         stageId: stageId,
         authorId: authorId,
         authorName: authorName,
         authorFormer: authorFormer,
         text: text,
         workersCount: workersCount,
         weather: weather,
         issues: issues,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ProgressUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ProgressUpdate copyWith({
    Object? id = _Undefined,
    int? projectId,
    Object? stageId = _Undefined,
    _is.UuidValue? authorId,
    Object? authorName = _Undefined,
    Object? authorFormer = _Undefined,
    String? text,
    Object? workersCount = _Undefined,
    Object? weather = _Undefined,
    Object? issues = _Undefined,
    DateTime? createdAt,
  }) {
    return ProgressUpdate(
      id: id is int? ? id : this.id,
      projectId: projectId ?? this.projectId,
      stageId: stageId is int? ? stageId : this.stageId,
      authorId: authorId ?? this.authorId,
      authorName: authorName is String? ? authorName : this.authorName,
      authorFormer: authorFormer is bool? ? authorFormer : this.authorFormer,
      text: text ?? this.text,
      workersCount: workersCount is int? ? workersCount : this.workersCount,
      weather: weather is _ifjsehv5.Weather? ? weather : this.weather,
      issues: issues is String? ? issues : this.issues,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ProgressUpdateUpdateTable extends _is.UpdateTable<ProgressUpdateTable> {
  ProgressUpdateUpdateTable(super.table);

  _is.ColumnValue<int, int> projectId(int value) => _is.ColumnValue(
    table.projectId,
    value,
  );

  _is.ColumnValue<int, int> stageId(int? value) => _is.ColumnValue(
    table.stageId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authorId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.authorId,
        value,
      );

  _is.ColumnValue<String, String> text(String value) => _is.ColumnValue(
    table.text,
    value,
  );

  _is.ColumnValue<int, int> workersCount(int? value) => _is.ColumnValue(
    table.workersCount,
    value,
  );

  _is.ColumnValue<_ifjsehv5.Weather, _ifjsehv5.Weather> weather(
    _ifjsehv5.Weather? value,
  ) => _is.ColumnValue(
    table.weather,
    value,
  );

  _is.ColumnValue<String, String> issues(String? value) => _is.ColumnValue(
    table.issues,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ProgressUpdateTable extends _is.Table<int?> {
  ProgressUpdateTable({super.tableRelation})
    : super(tableName: 'progress_update') {
    updateTable = ProgressUpdateUpdateTable(this);
    projectId = _is.ColumnInt(
      'projectId',
      this,
    );
    stageId = _is.ColumnInt(
      'stageId',
      this,
    );
    authorId = _is.ColumnUuid(
      'authorId',
      this,
    );
    text = _is.ColumnString(
      'text',
      this,
    );
    workersCount = _is.ColumnInt(
      'workersCount',
      this,
    );
    weather = _is.ColumnEnum(
      'weather',
      this,
      _is.EnumSerialization.byName,
    );
    issues = _is.ColumnString(
      'issues',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final ProgressUpdateUpdateTable updateTable;

  late final _is.ColumnInt projectId;

  late final _is.ColumnInt stageId;

  late final _is.ColumnUuid authorId;

  /// 1–2,000 characters.
  late final _is.ColumnString text;

  /// 0–999.
  late final _is.ColumnInt workersCount;

  late final _is.ColumnEnum<_ifjsehv5.Weather> weather;

  /// At most 1,000 characters.
  late final _is.ColumnString issues;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    projectId,
    stageId,
    authorId,
    text,
    workersCount,
    weather,
    issues,
    createdAt,
  ];
}

class ProgressUpdateInclude extends _is.IncludeObject {
  ProgressUpdateInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ProgressUpdate.t;
}

class ProgressUpdateIncludeList extends _is.IncludeList {
  ProgressUpdateIncludeList._({
    _is.WhereExpressionBuilder<ProgressUpdateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProgressUpdate.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ProgressUpdate.t;
}

class ProgressUpdateRepository {
  const ProgressUpdateRepository._();

  /// Returns a list of [ProgressUpdate]s matching the given query parameters.
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
  Future<List<ProgressUpdate>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProgressUpdateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProgressUpdateTable>? orderBy,
    _is.OrderByListBuilder<ProgressUpdateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ProgressUpdate>(
      where: where?.call(ProgressUpdate.t),
      orderBy: orderBy?.call(ProgressUpdate.t),
      orderByList: orderByList?.call(ProgressUpdate.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ProgressUpdate] matching the given query parameters.
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
  Future<ProgressUpdate?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProgressUpdateTable>? where,
    int? offset,
    _is.OrderByBuilder<ProgressUpdateTable>? orderBy,
    _is.OrderByListBuilder<ProgressUpdateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ProgressUpdate>(
      where: where?.call(ProgressUpdate.t),
      orderBy: orderBy?.call(ProgressUpdate.t),
      orderByList: orderByList?.call(ProgressUpdate.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ProgressUpdate] by its [id] or null if no such row exists.
  Future<ProgressUpdate?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ProgressUpdate>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ProgressUpdate]s in the list and returns the inserted rows.
  ///
  /// The returned [ProgressUpdate]s will have their `id` fields set.
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
  Future<List<ProgressUpdate>> insert(
    _is.DatabaseSession session,
    List<ProgressUpdate> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ProgressUpdate>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ProgressUpdate] and returns the inserted row.
  ///
  /// The returned [ProgressUpdate] will have its `id` field set.
  Future<ProgressUpdate> insertRow(
    _is.DatabaseSession session,
    ProgressUpdate row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProgressUpdate>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ProgressUpdate]s in the list and returns the resulting rows.
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
  /// The returned [ProgressUpdate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProgressUpdate>> upsert(
    _is.DatabaseSession session,
    List<ProgressUpdate> rows, {
    required _is.ColumnSelections<ProgressUpdateTable> conflictColumns,
    _is.ColumnSelections<ProgressUpdateTable>? updateColumns,
    _is.WhereExpressionBuilder<ProgressUpdateTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ProgressUpdate>(
      rows,
      conflictColumns: conflictColumns(ProgressUpdate.t),
      updateColumns: updateColumns?.call(ProgressUpdate.t),
      updateWhere: updateWhere?.call(ProgressUpdate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ProgressUpdate] and returns the resulting row.
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
  /// The returned [ProgressUpdate] will have its `id` field set.
  Future<ProgressUpdate?> upsertRow(
    _is.DatabaseSession session,
    ProgressUpdate row, {
    required _is.ColumnSelections<ProgressUpdateTable> conflictColumns,
    _is.ColumnSelections<ProgressUpdateTable>? updateColumns,
    _is.WhereExpressionBuilder<ProgressUpdateTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ProgressUpdate>(
      row,
      conflictColumns: conflictColumns(ProgressUpdate.t),
      updateColumns: updateColumns?.call(ProgressUpdate.t),
      updateWhere: updateWhere?.call(ProgressUpdate.t),
      transaction: transaction,
    );
  }

  /// Updates all [ProgressUpdate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProgressUpdate>> update(
    _is.DatabaseSession session,
    List<ProgressUpdate> rows, {
    _is.ColumnSelections<ProgressUpdateTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ProgressUpdate>(
      rows,
      columns: columns?.call(ProgressUpdate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ProgressUpdate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProgressUpdate> updateRow(
    _is.DatabaseSession session,
    ProgressUpdate row, {
    _is.ColumnSelections<ProgressUpdateTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProgressUpdate>(
      row,
      columns: columns?.call(ProgressUpdate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProgressUpdate] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ProgressUpdate?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ProgressUpdateUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ProgressUpdate>(
      id,
      columnValues: columnValues(ProgressUpdate.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProgressUpdate]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProgressUpdate>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ProgressUpdateUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ProgressUpdateTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProgressUpdateTable>? orderBy,
    _is.OrderByListBuilder<ProgressUpdateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ProgressUpdate>(
      columnValues: columnValues(ProgressUpdate.t.updateTable),
      where: where(ProgressUpdate.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProgressUpdate.t),
      orderByList: orderByList?.call(ProgressUpdate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ProgressUpdate]s in the list and returns the deleted rows.
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
  Future<List<ProgressUpdate>> delete(
    _is.DatabaseSession session,
    List<ProgressUpdate> rows, {
    _is.OrderByBuilder<ProgressUpdateTable>? orderBy,
    _is.OrderByListBuilder<ProgressUpdateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ProgressUpdate>(
      rows,
      orderBy: orderBy?.call(ProgressUpdate.t),
      orderByList: orderByList?.call(ProgressUpdate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ProgressUpdate].
  Future<ProgressUpdate> deleteRow(
    _is.DatabaseSession session,
    ProgressUpdate row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProgressUpdate>(
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
  Future<List<ProgressUpdate>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProgressUpdateTable> where,
    _is.OrderByBuilder<ProgressUpdateTable>? orderBy,
    _is.OrderByListBuilder<ProgressUpdateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ProgressUpdate>(
      where: where(ProgressUpdate.t),
      orderBy: orderBy?.call(ProgressUpdate.t),
      orderByList: orderByList?.call(ProgressUpdate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProgressUpdateTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ProgressUpdate>(
      where: where?.call(ProgressUpdate.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ProgressUpdate] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProgressUpdateTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ProgressUpdate>(
      where: where(ProgressUpdate.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
