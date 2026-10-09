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
import 'review_decision.dart' as _idrjy6ic;

/// One review decision, kept for good (REV-05, doc/04e M5-3).
abstract class StageReview
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  StageReview._({
    this.id,
    required this.stageId,
    required this.reviewerId,
    required this.decision,
    this.comment,
    required this.createdAt,
  });

  factory StageReview({
    int? id,
    required int stageId,
    required _is.UuidValue reviewerId,
    required _idrjy6ic.ReviewDecision decision,
    String? comment,
    required DateTime createdAt,
  }) = _StageReviewImpl;

  factory StageReview.fromJson(Map<String, dynamic> jsonSerialization) {
    return StageReview(
      id: jsonSerialization['id'] as int?,
      stageId: jsonSerialization['stageId'] as int,
      reviewerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['reviewerId'],
      ),
      decision: _idrjy6ic.ReviewDecision.fromJson(
        (jsonSerialization['decision'] as String),
      ),
      comment: jsonSerialization['comment'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = StageReviewTable();

  static const db = StageReviewRepository._();

  @override
  int? id;

  int stageId;

  _is.UuidValue reviewerId;

  _idrjy6ic.ReviewDecision decision;

  /// Required when changes are requested, 1–1,000 characters.
  String? comment;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [StageReview]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StageReview copyWith({
    int? id,
    int? stageId,
    _is.UuidValue? reviewerId,
    _idrjy6ic.ReviewDecision? decision,
    String? comment,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StageReview',
      if (id != null) 'id': id,
      'stageId': stageId,
      'reviewerId': reviewerId.toJson(),
      'decision': decision.toJson(),
      if (comment != null) 'comment': comment,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StageReview',
      if (id != null) 'id': id,
      'stageId': stageId,
      'reviewerId': reviewerId.toJson(),
      'decision': decision.toJson(),
      if (comment != null) 'comment': comment,
      'createdAt': createdAt.toJson(),
    };
  }

  static StageReviewInclude include() {
    return StageReviewInclude._();
  }

  static StageReviewIncludeList includeList({
    _is.WhereExpressionBuilder<StageReviewTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StageReviewTable>? orderBy,
    _is.OrderByListBuilder<StageReviewTable>? orderByList,
    StageReviewInclude? include,
  }) {
    return StageReviewIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StageReview.t),
      orderByList: orderByList?.call(StageReview.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StageReviewImpl extends StageReview {
  _StageReviewImpl({
    int? id,
    required int stageId,
    required _is.UuidValue reviewerId,
    required _idrjy6ic.ReviewDecision decision,
    String? comment,
    required DateTime createdAt,
  }) : super._(
         id: id,
         stageId: stageId,
         reviewerId: reviewerId,
         decision: decision,
         comment: comment,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [StageReview]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StageReview copyWith({
    Object? id = _Undefined,
    int? stageId,
    _is.UuidValue? reviewerId,
    _idrjy6ic.ReviewDecision? decision,
    Object? comment = _Undefined,
    DateTime? createdAt,
  }) {
    return StageReview(
      id: id is int? ? id : this.id,
      stageId: stageId ?? this.stageId,
      reviewerId: reviewerId ?? this.reviewerId,
      decision: decision ?? this.decision,
      comment: comment is String? ? comment : this.comment,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class StageReviewUpdateTable extends _is.UpdateTable<StageReviewTable> {
  StageReviewUpdateTable(super.table);

  _is.ColumnValue<int, int> stageId(int value) => _is.ColumnValue(
    table.stageId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> reviewerId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.reviewerId,
    value,
  );

  _is.ColumnValue<_idrjy6ic.ReviewDecision, _idrjy6ic.ReviewDecision> decision(
    _idrjy6ic.ReviewDecision value,
  ) => _is.ColumnValue(
    table.decision,
    value,
  );

  _is.ColumnValue<String, String> comment(String? value) => _is.ColumnValue(
    table.comment,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class StageReviewTable extends _is.Table<int?> {
  StageReviewTable({super.tableRelation}) : super(tableName: 'stage_review') {
    updateTable = StageReviewUpdateTable(this);
    stageId = _is.ColumnInt(
      'stageId',
      this,
    );
    reviewerId = _is.ColumnUuid(
      'reviewerId',
      this,
    );
    decision = _is.ColumnEnum(
      'decision',
      this,
      _is.EnumSerialization.byName,
    );
    comment = _is.ColumnString(
      'comment',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final StageReviewUpdateTable updateTable;

  late final _is.ColumnInt stageId;

  late final _is.ColumnUuid reviewerId;

  late final _is.ColumnEnum<_idrjy6ic.ReviewDecision> decision;

  /// Required when changes are requested, 1–1,000 characters.
  late final _is.ColumnString comment;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    stageId,
    reviewerId,
    decision,
    comment,
    createdAt,
  ];
}

class StageReviewInclude extends _is.IncludeObject {
  StageReviewInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => StageReview.t;
}

class StageReviewIncludeList extends _is.IncludeList {
  StageReviewIncludeList._({
    _is.WhereExpressionBuilder<StageReviewTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StageReview.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => StageReview.t;
}

class StageReviewRepository {
  const StageReviewRepository._();

  /// Returns a list of [StageReview]s matching the given query parameters.
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
  Future<List<StageReview>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StageReviewTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StageReviewTable>? orderBy,
    _is.OrderByListBuilder<StageReviewTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StageReview>(
      where: where?.call(StageReview.t),
      orderBy: orderBy?.call(StageReview.t),
      orderByList: orderByList?.call(StageReview.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StageReview] matching the given query parameters.
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
  Future<StageReview?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StageReviewTable>? where,
    int? offset,
    _is.OrderByBuilder<StageReviewTable>? orderBy,
    _is.OrderByListBuilder<StageReviewTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StageReview>(
      where: where?.call(StageReview.t),
      orderBy: orderBy?.call(StageReview.t),
      orderByList: orderByList?.call(StageReview.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StageReview] by its [id] or null if no such row exists.
  Future<StageReview?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StageReview>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StageReview]s in the list and returns the inserted rows.
  ///
  /// The returned [StageReview]s will have their `id` fields set.
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
  Future<List<StageReview>> insert(
    _is.DatabaseSession session,
    List<StageReview> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<StageReview>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [StageReview] and returns the inserted row.
  ///
  /// The returned [StageReview] will have its `id` field set.
  Future<StageReview> insertRow(
    _is.DatabaseSession session,
    StageReview row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<StageReview>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [StageReview]s in the list and returns the resulting rows.
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
  /// The returned [StageReview]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StageReview>> upsert(
    _is.DatabaseSession session,
    List<StageReview> rows, {
    required _is.ColumnSelections<StageReviewTable> conflictColumns,
    _is.ColumnSelections<StageReviewTable>? updateColumns,
    _is.WhereExpressionBuilder<StageReviewTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<StageReview>(
      rows,
      conflictColumns: conflictColumns(StageReview.t),
      updateColumns: updateColumns?.call(StageReview.t),
      updateWhere: updateWhere?.call(StageReview.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [StageReview] and returns the resulting row.
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
  /// The returned [StageReview] will have its `id` field set.
  Future<StageReview?> upsertRow(
    _is.DatabaseSession session,
    StageReview row, {
    required _is.ColumnSelections<StageReviewTable> conflictColumns,
    _is.ColumnSelections<StageReviewTable>? updateColumns,
    _is.WhereExpressionBuilder<StageReviewTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<StageReview>(
      row,
      conflictColumns: conflictColumns(StageReview.t),
      updateColumns: updateColumns?.call(StageReview.t),
      updateWhere: updateWhere?.call(StageReview.t),
      transaction: transaction,
    );
  }

  /// Updates all [StageReview]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StageReview>> update(
    _is.DatabaseSession session,
    List<StageReview> rows, {
    _is.ColumnSelections<StageReviewTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<StageReview>(
      rows,
      columns: columns?.call(StageReview.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [StageReview]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StageReview> updateRow(
    _is.DatabaseSession session,
    StageReview row, {
    _is.ColumnSelections<StageReviewTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<StageReview>(
      row,
      columns: columns?.call(StageReview.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StageReview] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StageReview?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StageReviewUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<StageReview>(
      id,
      columnValues: columnValues(StageReview.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StageReview]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StageReview>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StageReviewUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<StageReviewTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StageReviewTable>? orderBy,
    _is.OrderByListBuilder<StageReviewTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<StageReview>(
      columnValues: columnValues(StageReview.t.updateTable),
      where: where(StageReview.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StageReview.t),
      orderByList: orderByList?.call(StageReview.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [StageReview]s in the list and returns the deleted rows.
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
  Future<List<StageReview>> delete(
    _is.DatabaseSession session,
    List<StageReview> rows, {
    _is.OrderByBuilder<StageReviewTable>? orderBy,
    _is.OrderByListBuilder<StageReviewTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<StageReview>(
      rows,
      orderBy: orderBy?.call(StageReview.t),
      orderByList: orderByList?.call(StageReview.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [StageReview].
  Future<StageReview> deleteRow(
    _is.DatabaseSession session,
    StageReview row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StageReview>(
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
  Future<List<StageReview>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StageReviewTable> where,
    _is.OrderByBuilder<StageReviewTable>? orderBy,
    _is.OrderByListBuilder<StageReviewTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<StageReview>(
      where: where(StageReview.t),
      orderBy: orderBy?.call(StageReview.t),
      orderByList: orderByList?.call(StageReview.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StageReviewTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<StageReview>(
      where: where?.call(StageReview.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StageReview] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StageReviewTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StageReview>(
      where: where(StageReview.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
