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
import 'activity_type.dart' as _iorr0e24;

/// One entry of a project's activity feed (FEED). Written from M2, streamed
/// to members from M5; (projectId, id) supports catch-up after a reconnect.
abstract class ActivityEvent
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ActivityEvent._({
    this.id,
    required this.projectId,
    required this.actorId,
    required this.type,
    required this.targetType,
    this.targetId,
    this.payload,
    required this.createdAt,
  });

  factory ActivityEvent({
    int? id,
    required int projectId,
    required _is.UuidValue actorId,
    required _iorr0e24.ActivityType type,
    required String targetType,
    int? targetId,
    Map<String, String>? payload,
    required DateTime createdAt,
  }) = _ActivityEventImpl;

  factory ActivityEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return ActivityEvent(
      id: jsonSerialization['id'] as int?,
      projectId: jsonSerialization['projectId'] as int,
      actorId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['actorId'],
      ),
      type: _iorr0e24.ActivityType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      targetType: jsonSerialization['targetType'] as String,
      targetId: jsonSerialization['targetId'] as int?,
      payload: jsonSerialization['payload'] == null
          ? null
          : _irbavk3a.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['payload'],
            ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = ActivityEventTable();

  static const db = ActivityEventRepository._();

  @override
  int? id;

  int projectId;

  _is.UuidValue actorId;

  _iorr0e24.ActivityType type;

  String targetType;

  int? targetId;

  /// Small summary so the feed renders without extra calls.
  Map<String, String>? payload;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ActivityEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ActivityEvent copyWith({
    int? id,
    int? projectId,
    _is.UuidValue? actorId,
    _iorr0e24.ActivityType? type,
    String? targetType,
    int? targetId,
    Map<String, String>? payload,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ActivityEvent',
      if (id != null) 'id': id,
      'projectId': projectId,
      'actorId': actorId.toJson(),
      'type': type.toJson(),
      'targetType': targetType,
      if (targetId != null) 'targetId': targetId,
      if (payload != null) 'payload': payload?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ActivityEvent',
      if (id != null) 'id': id,
      'projectId': projectId,
      'actorId': actorId.toJson(),
      'type': type.toJson(),
      'targetType': targetType,
      if (targetId != null) 'targetId': targetId,
      if (payload != null) 'payload': payload?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static ActivityEventInclude include() {
    return ActivityEventInclude._();
  }

  static ActivityEventIncludeList includeList({
    _is.WhereExpressionBuilder<ActivityEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ActivityEventTable>? orderBy,
    _is.OrderByListBuilder<ActivityEventTable>? orderByList,
    ActivityEventInclude? include,
  }) {
    return ActivityEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ActivityEvent.t),
      orderByList: orderByList?.call(ActivityEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ActivityEventImpl extends ActivityEvent {
  _ActivityEventImpl({
    int? id,
    required int projectId,
    required _is.UuidValue actorId,
    required _iorr0e24.ActivityType type,
    required String targetType,
    int? targetId,
    Map<String, String>? payload,
    required DateTime createdAt,
  }) : super._(
         id: id,
         projectId: projectId,
         actorId: actorId,
         type: type,
         targetType: targetType,
         targetId: targetId,
         payload: payload,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ActivityEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ActivityEvent copyWith({
    Object? id = _Undefined,
    int? projectId,
    _is.UuidValue? actorId,
    _iorr0e24.ActivityType? type,
    String? targetType,
    Object? targetId = _Undefined,
    Object? payload = _Undefined,
    DateTime? createdAt,
  }) {
    return ActivityEvent(
      id: id is int? ? id : this.id,
      projectId: projectId ?? this.projectId,
      actorId: actorId ?? this.actorId,
      type: type ?? this.type,
      targetType: targetType ?? this.targetType,
      targetId: targetId is int? ? targetId : this.targetId,
      payload: payload is Map<String, String>?
          ? payload
          : this.payload?.map(
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

class ActivityEventUpdateTable extends _is.UpdateTable<ActivityEventTable> {
  ActivityEventUpdateTable(super.table);

  _is.ColumnValue<int, int> projectId(int value) => _is.ColumnValue(
    table.projectId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> actorId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.actorId,
        value,
      );

  _is.ColumnValue<_iorr0e24.ActivityType, _iorr0e24.ActivityType> type(
    _iorr0e24.ActivityType value,
  ) => _is.ColumnValue(
    table.type,
    value,
  );

  _is.ColumnValue<String, String> targetType(String value) => _is.ColumnValue(
    table.targetType,
    value,
  );

  _is.ColumnValue<int, int> targetId(int? value) => _is.ColumnValue(
    table.targetId,
    value,
  );

  _is.ColumnValue<Map<String, String>, Map<String, String>> payload(
    Map<String, String>? value,
  ) => _is.ColumnValue(
    table.payload,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ActivityEventTable extends _is.Table<int?> {
  ActivityEventTable({super.tableRelation})
    : super(tableName: 'activity_event') {
    updateTable = ActivityEventUpdateTable(this);
    projectId = _is.ColumnInt(
      'projectId',
      this,
    );
    actorId = _is.ColumnUuid(
      'actorId',
      this,
    );
    type = _is.ColumnEnum(
      'type',
      this,
      _is.EnumSerialization.byName,
    );
    targetType = _is.ColumnString(
      'targetType',
      this,
    );
    targetId = _is.ColumnInt(
      'targetId',
      this,
    );
    payload = _is.ColumnSerializable<Map<String, String>>(
      'payload',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final ActivityEventUpdateTable updateTable;

  late final _is.ColumnInt projectId;

  late final _is.ColumnUuid actorId;

  late final _is.ColumnEnum<_iorr0e24.ActivityType> type;

  late final _is.ColumnString targetType;

  late final _is.ColumnInt targetId;

  /// Small summary so the feed renders without extra calls.
  late final _is.ColumnSerializable<Map<String, String>> payload;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    projectId,
    actorId,
    type,
    targetType,
    targetId,
    payload,
    createdAt,
  ];
}

class ActivityEventInclude extends _is.IncludeObject {
  ActivityEventInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ActivityEvent.t;
}

class ActivityEventIncludeList extends _is.IncludeList {
  ActivityEventIncludeList._({
    _is.WhereExpressionBuilder<ActivityEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ActivityEvent.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ActivityEvent.t;
}

class ActivityEventRepository {
  const ActivityEventRepository._();

  /// Returns a list of [ActivityEvent]s matching the given query parameters.
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
  Future<List<ActivityEvent>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ActivityEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ActivityEventTable>? orderBy,
    _is.OrderByListBuilder<ActivityEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ActivityEvent>(
      where: where?.call(ActivityEvent.t),
      orderBy: orderBy?.call(ActivityEvent.t),
      orderByList: orderByList?.call(ActivityEvent.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ActivityEvent] matching the given query parameters.
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
  Future<ActivityEvent?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ActivityEventTable>? where,
    int? offset,
    _is.OrderByBuilder<ActivityEventTable>? orderBy,
    _is.OrderByListBuilder<ActivityEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ActivityEvent>(
      where: where?.call(ActivityEvent.t),
      orderBy: orderBy?.call(ActivityEvent.t),
      orderByList: orderByList?.call(ActivityEvent.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ActivityEvent] by its [id] or null if no such row exists.
  Future<ActivityEvent?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ActivityEvent>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ActivityEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [ActivityEvent]s will have their `id` fields set.
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
  Future<List<ActivityEvent>> insert(
    _is.DatabaseSession session,
    List<ActivityEvent> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ActivityEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ActivityEvent] and returns the inserted row.
  ///
  /// The returned [ActivityEvent] will have its `id` field set.
  Future<ActivityEvent> insertRow(
    _is.DatabaseSession session,
    ActivityEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ActivityEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ActivityEvent]s in the list and returns the resulting rows.
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
  /// The returned [ActivityEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ActivityEvent>> upsert(
    _is.DatabaseSession session,
    List<ActivityEvent> rows, {
    required _is.ColumnSelections<ActivityEventTable> conflictColumns,
    _is.ColumnSelections<ActivityEventTable>? updateColumns,
    _is.WhereExpressionBuilder<ActivityEventTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ActivityEvent>(
      rows,
      conflictColumns: conflictColumns(ActivityEvent.t),
      updateColumns: updateColumns?.call(ActivityEvent.t),
      updateWhere: updateWhere?.call(ActivityEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ActivityEvent] and returns the resulting row.
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
  /// The returned [ActivityEvent] will have its `id` field set.
  Future<ActivityEvent?> upsertRow(
    _is.DatabaseSession session,
    ActivityEvent row, {
    required _is.ColumnSelections<ActivityEventTable> conflictColumns,
    _is.ColumnSelections<ActivityEventTable>? updateColumns,
    _is.WhereExpressionBuilder<ActivityEventTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ActivityEvent>(
      row,
      conflictColumns: conflictColumns(ActivityEvent.t),
      updateColumns: updateColumns?.call(ActivityEvent.t),
      updateWhere: updateWhere?.call(ActivityEvent.t),
      transaction: transaction,
    );
  }

  /// Updates all [ActivityEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ActivityEvent>> update(
    _is.DatabaseSession session,
    List<ActivityEvent> rows, {
    _is.ColumnSelections<ActivityEventTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ActivityEvent>(
      rows,
      columns: columns?.call(ActivityEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ActivityEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ActivityEvent> updateRow(
    _is.DatabaseSession session,
    ActivityEvent row, {
    _is.ColumnSelections<ActivityEventTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ActivityEvent>(
      row,
      columns: columns?.call(ActivityEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ActivityEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ActivityEvent?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ActivityEventUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ActivityEvent>(
      id,
      columnValues: columnValues(ActivityEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ActivityEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ActivityEvent>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ActivityEventUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ActivityEventTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ActivityEventTable>? orderBy,
    _is.OrderByListBuilder<ActivityEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ActivityEvent>(
      columnValues: columnValues(ActivityEvent.t.updateTable),
      where: where(ActivityEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ActivityEvent.t),
      orderByList: orderByList?.call(ActivityEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ActivityEvent]s in the list and returns the deleted rows.
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
  Future<List<ActivityEvent>> delete(
    _is.DatabaseSession session,
    List<ActivityEvent> rows, {
    _is.OrderByBuilder<ActivityEventTable>? orderBy,
    _is.OrderByListBuilder<ActivityEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ActivityEvent>(
      rows,
      orderBy: orderBy?.call(ActivityEvent.t),
      orderByList: orderByList?.call(ActivityEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ActivityEvent].
  Future<ActivityEvent> deleteRow(
    _is.DatabaseSession session,
    ActivityEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ActivityEvent>(
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
  Future<List<ActivityEvent>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ActivityEventTable> where,
    _is.OrderByBuilder<ActivityEventTable>? orderBy,
    _is.OrderByListBuilder<ActivityEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ActivityEvent>(
      where: where(ActivityEvent.t),
      orderBy: orderBy?.call(ActivityEvent.t),
      orderByList: orderByList?.call(ActivityEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ActivityEventTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ActivityEvent>(
      where: where?.call(ActivityEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ActivityEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ActivityEventTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ActivityEvent>(
      where: where(ActivityEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
