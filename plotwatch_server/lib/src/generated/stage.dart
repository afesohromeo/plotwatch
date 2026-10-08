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
import 'stage_status.dart' as _iblg1lql;

/// A milestone of the build with a budget, planned dates and a checklist of
/// required evidence (STG-01, doc/04c M3-4).
abstract class Stage implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Stage._({
    this.id,
    required this.projectId,
    required this.orderIndex,
    required this.name,
    this.description,
    required this.budgetMinor,
    this.plannedStart,
    this.plannedEnd,
    required this.status,
    this.startedAt,
    this.submittedAt,
    this.approvedAt,
    this.approvedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Stage({
    int? id,
    required int projectId,
    required int orderIndex,
    required String name,
    String? description,
    required int budgetMinor,
    DateTime? plannedStart,
    DateTime? plannedEnd,
    required _iblg1lql.StageStatus status,
    DateTime? startedAt,
    DateTime? submittedAt,
    DateTime? approvedAt,
    _is.UuidValue? approvedBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _StageImpl;

  factory Stage.fromJson(Map<String, dynamic> jsonSerialization) {
    return Stage(
      id: jsonSerialization['id'] as int?,
      projectId: jsonSerialization['projectId'] as int,
      orderIndex: jsonSerialization['orderIndex'] as int,
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
      status: _iblg1lql.StageStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      submittedAt: jsonSerialization['submittedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['submittedAt'],
            ),
      approvedAt: jsonSerialization['approvedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['approvedAt']),
      approvedBy: jsonSerialization['approvedBy'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['approvedBy'],
            ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = StageTable();

  static const db = StageRepository._();

  @override
  int? id;

  int projectId;

  /// 0…n−1 without gaps within the project (decision M3-7).
  int orderIndex;

  /// 1–100 characters after trimming.
  String name;

  /// At most 1,000 characters; blank is saved as none.
  String? description;

  /// Minor units of the project currency, 0 to 10^15 (BUD-02).
  int budgetMinor;

  DateTime? plannedStart;

  /// On or after [plannedStart] when both are set.
  DateTime? plannedEnd;

  _iblg1lql.StageStatus status;

  DateTime? startedAt;

  /// Set by the review loop from M5 on.
  DateTime? submittedAt;

  DateTime? approvedAt;

  _is.UuidValue? approvedBy;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Stage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Stage copyWith({
    int? id,
    int? projectId,
    int? orderIndex,
    String? name,
    String? description,
    int? budgetMinor,
    DateTime? plannedStart,
    DateTime? plannedEnd,
    _iblg1lql.StageStatus? status,
    DateTime? startedAt,
    DateTime? submittedAt,
    DateTime? approvedAt,
    _is.UuidValue? approvedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Stage',
      if (id != null) 'id': id,
      'projectId': projectId,
      'orderIndex': orderIndex,
      'name': name,
      if (description != null) 'description': description,
      'budgetMinor': budgetMinor,
      if (plannedStart != null) 'plannedStart': plannedStart?.toJson(),
      if (plannedEnd != null) 'plannedEnd': plannedEnd?.toJson(),
      'status': status.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (submittedAt != null) 'submittedAt': submittedAt?.toJson(),
      if (approvedAt != null) 'approvedAt': approvedAt?.toJson(),
      if (approvedBy != null) 'approvedBy': approvedBy?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Stage',
      if (id != null) 'id': id,
      'projectId': projectId,
      'orderIndex': orderIndex,
      'name': name,
      if (description != null) 'description': description,
      'budgetMinor': budgetMinor,
      if (plannedStart != null) 'plannedStart': plannedStart?.toJson(),
      if (plannedEnd != null) 'plannedEnd': plannedEnd?.toJson(),
      'status': status.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (submittedAt != null) 'submittedAt': submittedAt?.toJson(),
      if (approvedAt != null) 'approvedAt': approvedAt?.toJson(),
      if (approvedBy != null) 'approvedBy': approvedBy?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static StageInclude include() {
    return StageInclude._();
  }

  static StageIncludeList includeList({
    _is.WhereExpressionBuilder<StageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StageTable>? orderBy,
    _is.OrderByListBuilder<StageTable>? orderByList,
    StageInclude? include,
  }) {
    return StageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Stage.t),
      orderByList: orderByList?.call(Stage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StageImpl extends Stage {
  _StageImpl({
    int? id,
    required int projectId,
    required int orderIndex,
    required String name,
    String? description,
    required int budgetMinor,
    DateTime? plannedStart,
    DateTime? plannedEnd,
    required _iblg1lql.StageStatus status,
    DateTime? startedAt,
    DateTime? submittedAt,
    DateTime? approvedAt,
    _is.UuidValue? approvedBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         projectId: projectId,
         orderIndex: orderIndex,
         name: name,
         description: description,
         budgetMinor: budgetMinor,
         plannedStart: plannedStart,
         plannedEnd: plannedEnd,
         status: status,
         startedAt: startedAt,
         submittedAt: submittedAt,
         approvedAt: approvedAt,
         approvedBy: approvedBy,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Stage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Stage copyWith({
    Object? id = _Undefined,
    int? projectId,
    int? orderIndex,
    String? name,
    Object? description = _Undefined,
    int? budgetMinor,
    Object? plannedStart = _Undefined,
    Object? plannedEnd = _Undefined,
    _iblg1lql.StageStatus? status,
    Object? startedAt = _Undefined,
    Object? submittedAt = _Undefined,
    Object? approvedAt = _Undefined,
    Object? approvedBy = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Stage(
      id: id is int? ? id : this.id,
      projectId: projectId ?? this.projectId,
      orderIndex: orderIndex ?? this.orderIndex,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      budgetMinor: budgetMinor ?? this.budgetMinor,
      plannedStart: plannedStart is DateTime?
          ? plannedStart
          : this.plannedStart,
      plannedEnd: plannedEnd is DateTime? ? plannedEnd : this.plannedEnd,
      status: status ?? this.status,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      submittedAt: submittedAt is DateTime? ? submittedAt : this.submittedAt,
      approvedAt: approvedAt is DateTime? ? approvedAt : this.approvedAt,
      approvedBy: approvedBy is _is.UuidValue? ? approvedBy : this.approvedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class StageUpdateTable extends _is.UpdateTable<StageTable> {
  StageUpdateTable(super.table);

  _is.ColumnValue<int, int> projectId(int value) => _is.ColumnValue(
    table.projectId,
    value,
  );

  _is.ColumnValue<int, int> orderIndex(int value) => _is.ColumnValue(
    table.orderIndex,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<int, int> budgetMinor(int value) => _is.ColumnValue(
    table.budgetMinor,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> plannedStart(DateTime? value) =>
      _is.ColumnValue(
        table.plannedStart,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> plannedEnd(DateTime? value) =>
      _is.ColumnValue(
        table.plannedEnd,
        value,
      );

  _is.ColumnValue<_iblg1lql.StageStatus, _iblg1lql.StageStatus> status(
    _iblg1lql.StageStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startedAt(DateTime? value) =>
      _is.ColumnValue(
        table.startedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> submittedAt(DateTime? value) =>
      _is.ColumnValue(
        table.submittedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> approvedAt(DateTime? value) =>
      _is.ColumnValue(
        table.approvedAt,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> approvedBy(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.approvedBy,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class StageTable extends _is.Table<int?> {
  StageTable({super.tableRelation}) : super(tableName: 'stage') {
    updateTable = StageUpdateTable(this);
    projectId = _is.ColumnInt(
      'projectId',
      this,
    );
    orderIndex = _is.ColumnInt(
      'orderIndex',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    budgetMinor = _is.ColumnInt(
      'budgetMinor',
      this,
    );
    plannedStart = _is.ColumnDateTime(
      'plannedStart',
      this,
    );
    plannedEnd = _is.ColumnDateTime(
      'plannedEnd',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    startedAt = _is.ColumnDateTime(
      'startedAt',
      this,
    );
    submittedAt = _is.ColumnDateTime(
      'submittedAt',
      this,
    );
    approvedAt = _is.ColumnDateTime(
      'approvedAt',
      this,
    );
    approvedBy = _is.ColumnUuid(
      'approvedBy',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final StageUpdateTable updateTable;

  late final _is.ColumnInt projectId;

  /// 0…n−1 without gaps within the project (decision M3-7).
  late final _is.ColumnInt orderIndex;

  /// 1–100 characters after trimming.
  late final _is.ColumnString name;

  /// At most 1,000 characters; blank is saved as none.
  late final _is.ColumnString description;

  /// Minor units of the project currency, 0 to 10^15 (BUD-02).
  late final _is.ColumnInt budgetMinor;

  late final _is.ColumnDateTime plannedStart;

  /// On or after [plannedStart] when both are set.
  late final _is.ColumnDateTime plannedEnd;

  late final _is.ColumnEnum<_iblg1lql.StageStatus> status;

  late final _is.ColumnDateTime startedAt;

  /// Set by the review loop from M5 on.
  late final _is.ColumnDateTime submittedAt;

  late final _is.ColumnDateTime approvedAt;

  late final _is.ColumnUuid approvedBy;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    projectId,
    orderIndex,
    name,
    description,
    budgetMinor,
    plannedStart,
    plannedEnd,
    status,
    startedAt,
    submittedAt,
    approvedAt,
    approvedBy,
    createdAt,
    updatedAt,
  ];
}

class StageInclude extends _is.IncludeObject {
  StageInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Stage.t;
}

class StageIncludeList extends _is.IncludeList {
  StageIncludeList._({
    _is.WhereExpressionBuilder<StageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Stage.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Stage.t;
}

class StageRepository {
  const StageRepository._();

  /// Returns a list of [Stage]s matching the given query parameters.
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
  Future<List<Stage>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StageTable>? orderBy,
    _is.OrderByListBuilder<StageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Stage>(
      where: where?.call(Stage.t),
      orderBy: orderBy?.call(Stage.t),
      orderByList: orderByList?.call(Stage.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Stage] matching the given query parameters.
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
  Future<Stage?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StageTable>? where,
    int? offset,
    _is.OrderByBuilder<StageTable>? orderBy,
    _is.OrderByListBuilder<StageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Stage>(
      where: where?.call(Stage.t),
      orderBy: orderBy?.call(Stage.t),
      orderByList: orderByList?.call(Stage.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Stage] by its [id] or null if no such row exists.
  Future<Stage?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Stage>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Stage]s in the list and returns the inserted rows.
  ///
  /// The returned [Stage]s will have their `id` fields set.
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
  Future<List<Stage>> insert(
    _is.DatabaseSession session,
    List<Stage> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Stage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Stage] and returns the inserted row.
  ///
  /// The returned [Stage] will have its `id` field set.
  Future<Stage> insertRow(
    _is.DatabaseSession session,
    Stage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Stage>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Stage]s in the list and returns the resulting rows.
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
  /// The returned [Stage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Stage>> upsert(
    _is.DatabaseSession session,
    List<Stage> rows, {
    required _is.ColumnSelections<StageTable> conflictColumns,
    _is.ColumnSelections<StageTable>? updateColumns,
    _is.WhereExpressionBuilder<StageTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Stage>(
      rows,
      conflictColumns: conflictColumns(Stage.t),
      updateColumns: updateColumns?.call(Stage.t),
      updateWhere: updateWhere?.call(Stage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Stage] and returns the resulting row.
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
  /// The returned [Stage] will have its `id` field set.
  Future<Stage?> upsertRow(
    _is.DatabaseSession session,
    Stage row, {
    required _is.ColumnSelections<StageTable> conflictColumns,
    _is.ColumnSelections<StageTable>? updateColumns,
    _is.WhereExpressionBuilder<StageTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Stage>(
      row,
      conflictColumns: conflictColumns(Stage.t),
      updateColumns: updateColumns?.call(Stage.t),
      updateWhere: updateWhere?.call(Stage.t),
      transaction: transaction,
    );
  }

  /// Updates all [Stage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Stage>> update(
    _is.DatabaseSession session,
    List<Stage> rows, {
    _is.ColumnSelections<StageTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Stage>(
      rows,
      columns: columns?.call(Stage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Stage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Stage> updateRow(
    _is.DatabaseSession session,
    Stage row, {
    _is.ColumnSelections<StageTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Stage>(
      row,
      columns: columns?.call(Stage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Stage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Stage?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StageUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Stage>(
      id,
      columnValues: columnValues(Stage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Stage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Stage>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StageUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<StageTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StageTable>? orderBy,
    _is.OrderByListBuilder<StageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Stage>(
      columnValues: columnValues(Stage.t.updateTable),
      where: where(Stage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Stage.t),
      orderByList: orderByList?.call(Stage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Stage]s in the list and returns the deleted rows.
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
  Future<List<Stage>> delete(
    _is.DatabaseSession session,
    List<Stage> rows, {
    _is.OrderByBuilder<StageTable>? orderBy,
    _is.OrderByListBuilder<StageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Stage>(
      rows,
      orderBy: orderBy?.call(Stage.t),
      orderByList: orderByList?.call(Stage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Stage].
  Future<Stage> deleteRow(
    _is.DatabaseSession session,
    Stage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Stage>(
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
  Future<List<Stage>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StageTable> where,
    _is.OrderByBuilder<StageTable>? orderBy,
    _is.OrderByListBuilder<StageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Stage>(
      where: where(Stage.t),
      orderBy: orderBy?.call(Stage.t),
      orderByList: orderByList?.call(Stage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StageTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Stage>(
      where: where?.call(Stage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Stage] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StageTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Stage>(
      where: where(Stage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
