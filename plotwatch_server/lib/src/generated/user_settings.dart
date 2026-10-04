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

/// App settings of a signed-in user. Name and email live in the auth
/// module's own profile (decision M1-1, doc/04a-m1-foundation.md).
abstract class UserSettings
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  UserSettings._({
    this.id,
    required this.authUserId,
    this.countryCode,
    required this.locale,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserSettings({
    int? id,
    required _is.UuidValue authUserId,
    String? countryCode,
    required String locale,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserSettingsImpl;

  factory UserSettings.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserSettings(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      countryCode: jsonSerialization['countryCode'] as String?,
      locale: jsonSerialization['locale'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = UserSettingsTable();

  static const db = UserSettingsRepository._();

  @override
  int? id;

  /// The auth module's user ID (`session.authenticated!.authUserId`).
  _is.UuidValue authUserId;

  /// ISO 3166-1 alpha-2, upper case (e.g. CM); null when not set.
  String? countryCode;

  /// `en` or `fr`.
  String locale;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserSettings]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  UserSettings copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? countryCode,
    String? locale,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserSettings',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (countryCode != null) 'countryCode': countryCode,
      'locale': locale,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserSettings',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (countryCode != null) 'countryCode': countryCode,
      'locale': locale,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static UserSettingsInclude include() {
    return UserSettingsInclude._();
  }

  static UserSettingsIncludeList includeList({
    _is.WhereExpressionBuilder<UserSettingsTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserSettingsTable>? orderBy,
    _is.OrderByListBuilder<UserSettingsTable>? orderByList,
    UserSettingsInclude? include,
  }) {
    return UserSettingsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserSettings.t),
      orderByList: orderByList?.call(UserSettings.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserSettingsImpl extends UserSettings {
  _UserSettingsImpl({
    int? id,
    required _is.UuidValue authUserId,
    String? countryCode,
    required String locale,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         countryCode: countryCode,
         locale: locale,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [UserSettings]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  UserSettings copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    Object? countryCode = _Undefined,
    String? locale,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserSettings(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      countryCode: countryCode is String? ? countryCode : this.countryCode,
      locale: locale ?? this.locale,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class UserSettingsUpdateTable extends _is.UpdateTable<UserSettingsTable> {
  UserSettingsUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> countryCode(String? value) => _is.ColumnValue(
    table.countryCode,
    value,
  );

  _is.ColumnValue<String, String> locale(String value) => _is.ColumnValue(
    table.locale,
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

class UserSettingsTable extends _is.Table<int?> {
  UserSettingsTable({super.tableRelation}) : super(tableName: 'user_settings') {
    updateTable = UserSettingsUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    countryCode = _is.ColumnString(
      'countryCode',
      this,
    );
    locale = _is.ColumnString(
      'locale',
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

  late final UserSettingsUpdateTable updateTable;

  /// The auth module's user ID (`session.authenticated!.authUserId`).
  late final _is.ColumnUuid authUserId;

  /// ISO 3166-1 alpha-2, upper case (e.g. CM); null when not set.
  late final _is.ColumnString countryCode;

  /// `en` or `fr`.
  late final _is.ColumnString locale;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    countryCode,
    locale,
    createdAt,
    updatedAt,
  ];
}

class UserSettingsInclude extends _is.IncludeObject {
  UserSettingsInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => UserSettings.t;
}

class UserSettingsIncludeList extends _is.IncludeList {
  UserSettingsIncludeList._({
    _is.WhereExpressionBuilder<UserSettingsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserSettings.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => UserSettings.t;
}

class UserSettingsRepository {
  const UserSettingsRepository._();

  /// Returns a list of [UserSettings]s matching the given query parameters.
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
  Future<List<UserSettings>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserSettingsTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserSettingsTable>? orderBy,
    _is.OrderByListBuilder<UserSettingsTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserSettings>(
      where: where?.call(UserSettings.t),
      orderBy: orderBy?.call(UserSettings.t),
      orderByList: orderByList?.call(UserSettings.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserSettings] matching the given query parameters.
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
  Future<UserSettings?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserSettingsTable>? where,
    int? offset,
    _is.OrderByBuilder<UserSettingsTable>? orderBy,
    _is.OrderByListBuilder<UserSettingsTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserSettings>(
      where: where?.call(UserSettings.t),
      orderBy: orderBy?.call(UserSettings.t),
      orderByList: orderByList?.call(UserSettings.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserSettings] by its [id] or null if no such row exists.
  Future<UserSettings?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserSettings>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserSettings]s in the list and returns the inserted rows.
  ///
  /// The returned [UserSettings]s will have their `id` fields set.
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
  Future<List<UserSettings>> insert(
    _is.DatabaseSession session,
    List<UserSettings> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<UserSettings>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [UserSettings] and returns the inserted row.
  ///
  /// The returned [UserSettings] will have its `id` field set.
  Future<UserSettings> insertRow(
    _is.DatabaseSession session,
    UserSettings row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserSettings>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [UserSettings]s in the list and returns the resulting rows.
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
  /// The returned [UserSettings]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserSettings>> upsert(
    _is.DatabaseSession session,
    List<UserSettings> rows, {
    required _is.ColumnSelections<UserSettingsTable> conflictColumns,
    _is.ColumnSelections<UserSettingsTable>? updateColumns,
    _is.WhereExpressionBuilder<UserSettingsTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<UserSettings>(
      rows,
      conflictColumns: conflictColumns(UserSettings.t),
      updateColumns: updateColumns?.call(UserSettings.t),
      updateWhere: updateWhere?.call(UserSettings.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [UserSettings] and returns the resulting row.
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
  /// The returned [UserSettings] will have its `id` field set.
  Future<UserSettings?> upsertRow(
    _is.DatabaseSession session,
    UserSettings row, {
    required _is.ColumnSelections<UserSettingsTable> conflictColumns,
    _is.ColumnSelections<UserSettingsTable>? updateColumns,
    _is.WhereExpressionBuilder<UserSettingsTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<UserSettings>(
      row,
      conflictColumns: conflictColumns(UserSettings.t),
      updateColumns: updateColumns?.call(UserSettings.t),
      updateWhere: updateWhere?.call(UserSettings.t),
      transaction: transaction,
    );
  }

  /// Updates all [UserSettings]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserSettings>> update(
    _is.DatabaseSession session,
    List<UserSettings> rows, {
    _is.ColumnSelections<UserSettingsTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<UserSettings>(
      rows,
      columns: columns?.call(UserSettings.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [UserSettings]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserSettings> updateRow(
    _is.DatabaseSession session,
    UserSettings row, {
    _is.ColumnSelections<UserSettingsTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserSettings>(
      row,
      columns: columns?.call(UserSettings.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserSettings] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserSettings?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<UserSettingsUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<UserSettings>(
      id,
      columnValues: columnValues(UserSettings.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserSettings]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserSettings>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<UserSettingsUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<UserSettingsTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserSettingsTable>? orderBy,
    _is.OrderByListBuilder<UserSettingsTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<UserSettings>(
      columnValues: columnValues(UserSettings.t.updateTable),
      where: where(UserSettings.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserSettings.t),
      orderByList: orderByList?.call(UserSettings.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [UserSettings]s in the list and returns the deleted rows.
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
  Future<List<UserSettings>> delete(
    _is.DatabaseSession session,
    List<UserSettings> rows, {
    _is.OrderByBuilder<UserSettingsTable>? orderBy,
    _is.OrderByListBuilder<UserSettingsTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<UserSettings>(
      rows,
      orderBy: orderBy?.call(UserSettings.t),
      orderByList: orderByList?.call(UserSettings.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [UserSettings].
  Future<UserSettings> deleteRow(
    _is.DatabaseSession session,
    UserSettings row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserSettings>(
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
  Future<List<UserSettings>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserSettingsTable> where,
    _is.OrderByBuilder<UserSettingsTable>? orderBy,
    _is.OrderByListBuilder<UserSettingsTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<UserSettings>(
      where: where(UserSettings.t),
      orderBy: orderBy?.call(UserSettings.t),
      orderByList: orderByList?.call(UserSettings.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserSettingsTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<UserSettings>(
      where: where?.call(UserSettings.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserSettings] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserSettingsTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserSettings>(
      where: where(UserSettings.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
