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

/// Where the project is built: the centre and radius that captures are
/// checked against (SITE). One per project, created when the owner validates
/// the first proposal (decision M2-15).
abstract class Site implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Site._({
    this.id,
    required this.projectId,
    required this.centerLat,
    required this.centerLng,
    required this.plusCode,
    required this.radiusM,
    this.addressText,
    this.timezone,
    required this.validatedProposalId,
    required this.validatedBy,
    required this.validatedAt,
    required this.updatedAt,
  });

  factory Site({
    int? id,
    required int projectId,
    required double centerLat,
    required double centerLng,
    required String plusCode,
    required int radiusM,
    String? addressText,
    String? timezone,
    required int validatedProposalId,
    required _is.UuidValue validatedBy,
    required DateTime validatedAt,
    required DateTime updatedAt,
  }) = _SiteImpl;

  factory Site.fromJson(Map<String, dynamic> jsonSerialization) {
    return Site(
      id: jsonSerialization['id'] as int?,
      projectId: jsonSerialization['projectId'] as int,
      centerLat: (jsonSerialization['centerLat'] as num).toDouble(),
      centerLng: (jsonSerialization['centerLng'] as num).toDouble(),
      plusCode: jsonSerialization['plusCode'] as String,
      radiusM: jsonSerialization['radiusM'] as int,
      addressText: jsonSerialization['addressText'] as String?,
      timezone: jsonSerialization['timezone'] as String?,
      validatedProposalId: jsonSerialization['validatedProposalId'] as int,
      validatedBy: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['validatedBy'],
      ),
      validatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['validatedAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = SiteTable();

  static const db = SiteRepository._();

  @override
  int? id;

  int projectId;

  double centerLat;

  double centerLng;

  /// 10-digit Plus Code, computed by the server from the centre.
  String plusCode;

  /// 10–500 m, set by the owner when validating (SITE-03, decision M2-16).
  int radiusM;

  String? addressText;

  /// IANA time zone; no UI in the MVP (decision M2-10).
  String? timezone;

  /// The proposal this location comes from.
  int validatedProposalId;

  _is.UuidValue validatedBy;

  DateTime validatedAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Site]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Site copyWith({
    int? id,
    int? projectId,
    double? centerLat,
    double? centerLng,
    String? plusCode,
    int? radiusM,
    String? addressText,
    String? timezone,
    int? validatedProposalId,
    _is.UuidValue? validatedBy,
    DateTime? validatedAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Site',
      if (id != null) 'id': id,
      'projectId': projectId,
      'centerLat': centerLat,
      'centerLng': centerLng,
      'plusCode': plusCode,
      'radiusM': radiusM,
      if (addressText != null) 'addressText': addressText,
      if (timezone != null) 'timezone': timezone,
      'validatedProposalId': validatedProposalId,
      'validatedBy': validatedBy.toJson(),
      'validatedAt': validatedAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Site',
      if (id != null) 'id': id,
      'projectId': projectId,
      'centerLat': centerLat,
      'centerLng': centerLng,
      'plusCode': plusCode,
      'radiusM': radiusM,
      if (addressText != null) 'addressText': addressText,
      if (timezone != null) 'timezone': timezone,
      'validatedProposalId': validatedProposalId,
      'validatedBy': validatedBy.toJson(),
      'validatedAt': validatedAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SiteInclude include() {
    return SiteInclude._();
  }

  static SiteIncludeList includeList({
    _is.WhereExpressionBuilder<SiteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SiteTable>? orderBy,
    _is.OrderByListBuilder<SiteTable>? orderByList,
    SiteInclude? include,
  }) {
    return SiteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Site.t),
      orderByList: orderByList?.call(Site.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SiteImpl extends Site {
  _SiteImpl({
    int? id,
    required int projectId,
    required double centerLat,
    required double centerLng,
    required String plusCode,
    required int radiusM,
    String? addressText,
    String? timezone,
    required int validatedProposalId,
    required _is.UuidValue validatedBy,
    required DateTime validatedAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         projectId: projectId,
         centerLat: centerLat,
         centerLng: centerLng,
         plusCode: plusCode,
         radiusM: radiusM,
         addressText: addressText,
         timezone: timezone,
         validatedProposalId: validatedProposalId,
         validatedBy: validatedBy,
         validatedAt: validatedAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Site]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Site copyWith({
    Object? id = _Undefined,
    int? projectId,
    double? centerLat,
    double? centerLng,
    String? plusCode,
    int? radiusM,
    Object? addressText = _Undefined,
    Object? timezone = _Undefined,
    int? validatedProposalId,
    _is.UuidValue? validatedBy,
    DateTime? validatedAt,
    DateTime? updatedAt,
  }) {
    return Site(
      id: id is int? ? id : this.id,
      projectId: projectId ?? this.projectId,
      centerLat: centerLat ?? this.centerLat,
      centerLng: centerLng ?? this.centerLng,
      plusCode: plusCode ?? this.plusCode,
      radiusM: radiusM ?? this.radiusM,
      addressText: addressText is String? ? addressText : this.addressText,
      timezone: timezone is String? ? timezone : this.timezone,
      validatedProposalId: validatedProposalId ?? this.validatedProposalId,
      validatedBy: validatedBy ?? this.validatedBy,
      validatedAt: validatedAt ?? this.validatedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SiteUpdateTable extends _is.UpdateTable<SiteTable> {
  SiteUpdateTable(super.table);

  _is.ColumnValue<int, int> projectId(int value) => _is.ColumnValue(
    table.projectId,
    value,
  );

  _is.ColumnValue<double, double> centerLat(double value) => _is.ColumnValue(
    table.centerLat,
    value,
  );

  _is.ColumnValue<double, double> centerLng(double value) => _is.ColumnValue(
    table.centerLng,
    value,
  );

  _is.ColumnValue<String, String> plusCode(String value) => _is.ColumnValue(
    table.plusCode,
    value,
  );

  _is.ColumnValue<int, int> radiusM(int value) => _is.ColumnValue(
    table.radiusM,
    value,
  );

  _is.ColumnValue<String, String> addressText(String? value) => _is.ColumnValue(
    table.addressText,
    value,
  );

  _is.ColumnValue<String, String> timezone(String? value) => _is.ColumnValue(
    table.timezone,
    value,
  );

  _is.ColumnValue<int, int> validatedProposalId(int value) => _is.ColumnValue(
    table.validatedProposalId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> validatedBy(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.validatedBy,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> validatedAt(DateTime value) =>
      _is.ColumnValue(
        table.validatedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class SiteTable extends _is.Table<int?> {
  SiteTable({super.tableRelation}) : super(tableName: 'site') {
    updateTable = SiteUpdateTable(this);
    projectId = _is.ColumnInt(
      'projectId',
      this,
    );
    centerLat = _is.ColumnDouble(
      'centerLat',
      this,
    );
    centerLng = _is.ColumnDouble(
      'centerLng',
      this,
    );
    plusCode = _is.ColumnString(
      'plusCode',
      this,
    );
    radiusM = _is.ColumnInt(
      'radiusM',
      this,
    );
    addressText = _is.ColumnString(
      'addressText',
      this,
    );
    timezone = _is.ColumnString(
      'timezone',
      this,
    );
    validatedProposalId = _is.ColumnInt(
      'validatedProposalId',
      this,
    );
    validatedBy = _is.ColumnUuid(
      'validatedBy',
      this,
    );
    validatedAt = _is.ColumnDateTime(
      'validatedAt',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final SiteUpdateTable updateTable;

  late final _is.ColumnInt projectId;

  late final _is.ColumnDouble centerLat;

  late final _is.ColumnDouble centerLng;

  /// 10-digit Plus Code, computed by the server from the centre.
  late final _is.ColumnString plusCode;

  /// 10–500 m, set by the owner when validating (SITE-03, decision M2-16).
  late final _is.ColumnInt radiusM;

  late final _is.ColumnString addressText;

  /// IANA time zone; no UI in the MVP (decision M2-10).
  late final _is.ColumnString timezone;

  /// The proposal this location comes from.
  late final _is.ColumnInt validatedProposalId;

  late final _is.ColumnUuid validatedBy;

  late final _is.ColumnDateTime validatedAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    projectId,
    centerLat,
    centerLng,
    plusCode,
    radiusM,
    addressText,
    timezone,
    validatedProposalId,
    validatedBy,
    validatedAt,
    updatedAt,
  ];
}

class SiteInclude extends _is.IncludeObject {
  SiteInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Site.t;
}

class SiteIncludeList extends _is.IncludeList {
  SiteIncludeList._({
    _is.WhereExpressionBuilder<SiteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Site.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Site.t;
}

class SiteRepository {
  const SiteRepository._();

  /// Returns a list of [Site]s matching the given query parameters.
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
  Future<List<Site>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SiteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SiteTable>? orderBy,
    _is.OrderByListBuilder<SiteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Site>(
      where: where?.call(Site.t),
      orderBy: orderBy?.call(Site.t),
      orderByList: orderByList?.call(Site.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Site] matching the given query parameters.
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
  Future<Site?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SiteTable>? where,
    int? offset,
    _is.OrderByBuilder<SiteTable>? orderBy,
    _is.OrderByListBuilder<SiteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Site>(
      where: where?.call(Site.t),
      orderBy: orderBy?.call(Site.t),
      orderByList: orderByList?.call(Site.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Site] by its [id] or null if no such row exists.
  Future<Site?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Site>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Site]s in the list and returns the inserted rows.
  ///
  /// The returned [Site]s will have their `id` fields set.
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
  Future<List<Site>> insert(
    _is.DatabaseSession session,
    List<Site> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Site>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Site] and returns the inserted row.
  ///
  /// The returned [Site] will have its `id` field set.
  Future<Site> insertRow(
    _is.DatabaseSession session,
    Site row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Site>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Site]s in the list and returns the resulting rows.
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
  /// The returned [Site]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Site>> upsert(
    _is.DatabaseSession session,
    List<Site> rows, {
    required _is.ColumnSelections<SiteTable> conflictColumns,
    _is.ColumnSelections<SiteTable>? updateColumns,
    _is.WhereExpressionBuilder<SiteTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Site>(
      rows,
      conflictColumns: conflictColumns(Site.t),
      updateColumns: updateColumns?.call(Site.t),
      updateWhere: updateWhere?.call(Site.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Site] and returns the resulting row.
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
  /// The returned [Site] will have its `id` field set.
  Future<Site?> upsertRow(
    _is.DatabaseSession session,
    Site row, {
    required _is.ColumnSelections<SiteTable> conflictColumns,
    _is.ColumnSelections<SiteTable>? updateColumns,
    _is.WhereExpressionBuilder<SiteTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Site>(
      row,
      conflictColumns: conflictColumns(Site.t),
      updateColumns: updateColumns?.call(Site.t),
      updateWhere: updateWhere?.call(Site.t),
      transaction: transaction,
    );
  }

  /// Updates all [Site]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Site>> update(
    _is.DatabaseSession session,
    List<Site> rows, {
    _is.ColumnSelections<SiteTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Site>(
      rows,
      columns: columns?.call(Site.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Site]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Site> updateRow(
    _is.DatabaseSession session,
    Site row, {
    _is.ColumnSelections<SiteTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Site>(
      row,
      columns: columns?.call(Site.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Site] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Site?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SiteUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Site>(
      id,
      columnValues: columnValues(Site.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Site]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Site>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SiteUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SiteTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SiteTable>? orderBy,
    _is.OrderByListBuilder<SiteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Site>(
      columnValues: columnValues(Site.t.updateTable),
      where: where(Site.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Site.t),
      orderByList: orderByList?.call(Site.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Site]s in the list and returns the deleted rows.
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
  Future<List<Site>> delete(
    _is.DatabaseSession session,
    List<Site> rows, {
    _is.OrderByBuilder<SiteTable>? orderBy,
    _is.OrderByListBuilder<SiteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Site>(
      rows,
      orderBy: orderBy?.call(Site.t),
      orderByList: orderByList?.call(Site.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Site].
  Future<Site> deleteRow(
    _is.DatabaseSession session,
    Site row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Site>(
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
  Future<List<Site>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SiteTable> where,
    _is.OrderByBuilder<SiteTable>? orderBy,
    _is.OrderByListBuilder<SiteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Site>(
      where: where(Site.t),
      orderBy: orderBy?.call(Site.t),
      orderByList: orderByList?.call(Site.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SiteTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Site>(
      where: where?.call(Site.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Site] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SiteTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Site>(
      where: where(Site.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
