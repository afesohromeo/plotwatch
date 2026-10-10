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
import 'site_proposal_status.dart' as _i8b5g94r;

/// A site location proposed by a site manager on the plot (decision M2-15).
/// Rows are never deleted: they are the history of the site's location.
abstract class SiteProposal
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SiteProposal._({
    this.id,
    required this.projectId,
    required this.proposedBy,
    this.proposedByName,
    this.proposedByFormer,
    required this.lat,
    required this.lng,
    required this.accuracyM,
    required this.proposedAt,
    required this.status,
    this.decidedBy,
    this.decidedAt,
    this.rejectReason,
  });

  factory SiteProposal({
    int? id,
    required int projectId,
    required _is.UuidValue proposedBy,
    String? proposedByName,
    bool? proposedByFormer,
    required double lat,
    required double lng,
    required double accuracyM,
    required DateTime proposedAt,
    required _i8b5g94r.SiteProposalStatus status,
    _is.UuidValue? decidedBy,
    DateTime? decidedAt,
    String? rejectReason,
  }) = _SiteProposalImpl;

  factory SiteProposal.fromJson(Map<String, dynamic> jsonSerialization) {
    return SiteProposal(
      id: jsonSerialization['id'] as int?,
      projectId: jsonSerialization['projectId'] as int,
      proposedBy: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['proposedBy'],
      ),
      proposedByName: jsonSerialization['proposedByName'] as String?,
      proposedByFormer: jsonSerialization['proposedByFormer'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['proposedByFormer'],
            ),
      lat: (jsonSerialization['lat'] as num).toDouble(),
      lng: (jsonSerialization['lng'] as num).toDouble(),
      accuracyM: (jsonSerialization['accuracyM'] as num).toDouble(),
      proposedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['proposedAt'],
      ),
      status: _i8b5g94r.SiteProposalStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      decidedBy: jsonSerialization['decidedBy'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['decidedBy']),
      decidedAt: jsonSerialization['decidedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['decidedAt']),
      rejectReason: jsonSerialization['rejectReason'] as String?,
    );
  }

  static final t = SiteProposalTable();

  static const db = SiteProposalRepository._();

  @override
  int? id;

  int projectId;

  _is.UuidValue proposedBy;

  /// Filled when proposals are listed (doc/04e C-2d).
  String? proposedByName;

  /// True when they are no longer a member.
  bool? proposedByFormer;

  double lat;

  double lng;

  /// GPS accuracy of the reading in metres; at most 20 (decision M2-17).
  double accuracyM;

  /// When the server received the proposal (trusted time).
  DateTime proposedAt;

  _i8b5g94r.SiteProposalStatus status;

  _is.UuidValue? decidedBy;

  DateTime? decidedAt;

  /// Optional, at most 500 characters (decision M2-18).
  String? rejectReason;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SiteProposal]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SiteProposal copyWith({
    int? id,
    int? projectId,
    _is.UuidValue? proposedBy,
    String? proposedByName,
    bool? proposedByFormer,
    double? lat,
    double? lng,
    double? accuracyM,
    DateTime? proposedAt,
    _i8b5g94r.SiteProposalStatus? status,
    _is.UuidValue? decidedBy,
    DateTime? decidedAt,
    String? rejectReason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SiteProposal',
      if (id != null) 'id': id,
      'projectId': projectId,
      'proposedBy': proposedBy.toJson(),
      if (proposedByName != null) 'proposedByName': proposedByName,
      if (proposedByFormer != null) 'proposedByFormer': proposedByFormer,
      'lat': lat,
      'lng': lng,
      'accuracyM': accuracyM,
      'proposedAt': proposedAt.toJson(),
      'status': status.toJson(),
      if (decidedBy != null) 'decidedBy': decidedBy?.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
      if (rejectReason != null) 'rejectReason': rejectReason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SiteProposal',
      if (id != null) 'id': id,
      'projectId': projectId,
      'proposedBy': proposedBy.toJson(),
      if (proposedByName != null) 'proposedByName': proposedByName,
      if (proposedByFormer != null) 'proposedByFormer': proposedByFormer,
      'lat': lat,
      'lng': lng,
      'accuracyM': accuracyM,
      'proposedAt': proposedAt.toJson(),
      'status': status.toJson(),
      if (decidedBy != null) 'decidedBy': decidedBy?.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
      if (rejectReason != null) 'rejectReason': rejectReason,
    };
  }

  static SiteProposalInclude include() {
    return SiteProposalInclude._();
  }

  static SiteProposalIncludeList includeList({
    _is.WhereExpressionBuilder<SiteProposalTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SiteProposalTable>? orderBy,
    _is.OrderByListBuilder<SiteProposalTable>? orderByList,
    SiteProposalInclude? include,
  }) {
    return SiteProposalIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SiteProposal.t),
      orderByList: orderByList?.call(SiteProposal.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SiteProposalImpl extends SiteProposal {
  _SiteProposalImpl({
    int? id,
    required int projectId,
    required _is.UuidValue proposedBy,
    String? proposedByName,
    bool? proposedByFormer,
    required double lat,
    required double lng,
    required double accuracyM,
    required DateTime proposedAt,
    required _i8b5g94r.SiteProposalStatus status,
    _is.UuidValue? decidedBy,
    DateTime? decidedAt,
    String? rejectReason,
  }) : super._(
         id: id,
         projectId: projectId,
         proposedBy: proposedBy,
         proposedByName: proposedByName,
         proposedByFormer: proposedByFormer,
         lat: lat,
         lng: lng,
         accuracyM: accuracyM,
         proposedAt: proposedAt,
         status: status,
         decidedBy: decidedBy,
         decidedAt: decidedAt,
         rejectReason: rejectReason,
       );

  /// Returns a shallow copy of this [SiteProposal]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SiteProposal copyWith({
    Object? id = _Undefined,
    int? projectId,
    _is.UuidValue? proposedBy,
    Object? proposedByName = _Undefined,
    Object? proposedByFormer = _Undefined,
    double? lat,
    double? lng,
    double? accuracyM,
    DateTime? proposedAt,
    _i8b5g94r.SiteProposalStatus? status,
    Object? decidedBy = _Undefined,
    Object? decidedAt = _Undefined,
    Object? rejectReason = _Undefined,
  }) {
    return SiteProposal(
      id: id is int? ? id : this.id,
      projectId: projectId ?? this.projectId,
      proposedBy: proposedBy ?? this.proposedBy,
      proposedByName: proposedByName is String?
          ? proposedByName
          : this.proposedByName,
      proposedByFormer: proposedByFormer is bool?
          ? proposedByFormer
          : this.proposedByFormer,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      accuracyM: accuracyM ?? this.accuracyM,
      proposedAt: proposedAt ?? this.proposedAt,
      status: status ?? this.status,
      decidedBy: decidedBy is _is.UuidValue? ? decidedBy : this.decidedBy,
      decidedAt: decidedAt is DateTime? ? decidedAt : this.decidedAt,
      rejectReason: rejectReason is String? ? rejectReason : this.rejectReason,
    );
  }
}

class SiteProposalUpdateTable extends _is.UpdateTable<SiteProposalTable> {
  SiteProposalUpdateTable(super.table);

  _is.ColumnValue<int, int> projectId(int value) => _is.ColumnValue(
    table.projectId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> proposedBy(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.proposedBy,
    value,
  );

  _is.ColumnValue<double, double> lat(double value) => _is.ColumnValue(
    table.lat,
    value,
  );

  _is.ColumnValue<double, double> lng(double value) => _is.ColumnValue(
    table.lng,
    value,
  );

  _is.ColumnValue<double, double> accuracyM(double value) => _is.ColumnValue(
    table.accuracyM,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> proposedAt(DateTime value) =>
      _is.ColumnValue(
        table.proposedAt,
        value,
      );

  _is.ColumnValue<_i8b5g94r.SiteProposalStatus, _i8b5g94r.SiteProposalStatus>
  status(_i8b5g94r.SiteProposalStatus value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> decidedBy(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.decidedBy,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> decidedAt(DateTime? value) =>
      _is.ColumnValue(
        table.decidedAt,
        value,
      );

  _is.ColumnValue<String, String> rejectReason(String? value) =>
      _is.ColumnValue(
        table.rejectReason,
        value,
      );
}

class SiteProposalTable extends _is.Table<int?> {
  SiteProposalTable({super.tableRelation}) : super(tableName: 'site_proposal') {
    updateTable = SiteProposalUpdateTable(this);
    projectId = _is.ColumnInt(
      'projectId',
      this,
    );
    proposedBy = _is.ColumnUuid(
      'proposedBy',
      this,
    );
    lat = _is.ColumnDouble(
      'lat',
      this,
    );
    lng = _is.ColumnDouble(
      'lng',
      this,
    );
    accuracyM = _is.ColumnDouble(
      'accuracyM',
      this,
    );
    proposedAt = _is.ColumnDateTime(
      'proposedAt',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    decidedBy = _is.ColumnUuid(
      'decidedBy',
      this,
    );
    decidedAt = _is.ColumnDateTime(
      'decidedAt',
      this,
    );
    rejectReason = _is.ColumnString(
      'rejectReason',
      this,
    );
  }

  late final SiteProposalUpdateTable updateTable;

  late final _is.ColumnInt projectId;

  late final _is.ColumnUuid proposedBy;

  late final _is.ColumnDouble lat;

  late final _is.ColumnDouble lng;

  /// GPS accuracy of the reading in metres; at most 20 (decision M2-17).
  late final _is.ColumnDouble accuracyM;

  /// When the server received the proposal (trusted time).
  late final _is.ColumnDateTime proposedAt;

  late final _is.ColumnEnum<_i8b5g94r.SiteProposalStatus> status;

  late final _is.ColumnUuid decidedBy;

  late final _is.ColumnDateTime decidedAt;

  /// Optional, at most 500 characters (decision M2-18).
  late final _is.ColumnString rejectReason;

  @override
  List<_is.Column> get columns => [
    id,
    projectId,
    proposedBy,
    lat,
    lng,
    accuracyM,
    proposedAt,
    status,
    decidedBy,
    decidedAt,
    rejectReason,
  ];
}

class SiteProposalInclude extends _is.IncludeObject {
  SiteProposalInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SiteProposal.t;
}

class SiteProposalIncludeList extends _is.IncludeList {
  SiteProposalIncludeList._({
    _is.WhereExpressionBuilder<SiteProposalTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SiteProposal.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SiteProposal.t;
}

class SiteProposalRepository {
  const SiteProposalRepository._();

  /// Returns a list of [SiteProposal]s matching the given query parameters.
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
  Future<List<SiteProposal>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SiteProposalTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SiteProposalTable>? orderBy,
    _is.OrderByListBuilder<SiteProposalTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SiteProposal>(
      where: where?.call(SiteProposal.t),
      orderBy: orderBy?.call(SiteProposal.t),
      orderByList: orderByList?.call(SiteProposal.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SiteProposal] matching the given query parameters.
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
  Future<SiteProposal?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SiteProposalTable>? where,
    int? offset,
    _is.OrderByBuilder<SiteProposalTable>? orderBy,
    _is.OrderByListBuilder<SiteProposalTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SiteProposal>(
      where: where?.call(SiteProposal.t),
      orderBy: orderBy?.call(SiteProposal.t),
      orderByList: orderByList?.call(SiteProposal.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SiteProposal] by its [id] or null if no such row exists.
  Future<SiteProposal?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SiteProposal>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SiteProposal]s in the list and returns the inserted rows.
  ///
  /// The returned [SiteProposal]s will have their `id` fields set.
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
  Future<List<SiteProposal>> insert(
    _is.DatabaseSession session,
    List<SiteProposal> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SiteProposal>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SiteProposal] and returns the inserted row.
  ///
  /// The returned [SiteProposal] will have its `id` field set.
  Future<SiteProposal> insertRow(
    _is.DatabaseSession session,
    SiteProposal row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SiteProposal>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SiteProposal]s in the list and returns the resulting rows.
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
  /// The returned [SiteProposal]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SiteProposal>> upsert(
    _is.DatabaseSession session,
    List<SiteProposal> rows, {
    required _is.ColumnSelections<SiteProposalTable> conflictColumns,
    _is.ColumnSelections<SiteProposalTable>? updateColumns,
    _is.WhereExpressionBuilder<SiteProposalTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SiteProposal>(
      rows,
      conflictColumns: conflictColumns(SiteProposal.t),
      updateColumns: updateColumns?.call(SiteProposal.t),
      updateWhere: updateWhere?.call(SiteProposal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SiteProposal] and returns the resulting row.
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
  /// The returned [SiteProposal] will have its `id` field set.
  Future<SiteProposal?> upsertRow(
    _is.DatabaseSession session,
    SiteProposal row, {
    required _is.ColumnSelections<SiteProposalTable> conflictColumns,
    _is.ColumnSelections<SiteProposalTable>? updateColumns,
    _is.WhereExpressionBuilder<SiteProposalTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SiteProposal>(
      row,
      conflictColumns: conflictColumns(SiteProposal.t),
      updateColumns: updateColumns?.call(SiteProposal.t),
      updateWhere: updateWhere?.call(SiteProposal.t),
      transaction: transaction,
    );
  }

  /// Updates all [SiteProposal]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SiteProposal>> update(
    _is.DatabaseSession session,
    List<SiteProposal> rows, {
    _is.ColumnSelections<SiteProposalTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SiteProposal>(
      rows,
      columns: columns?.call(SiteProposal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SiteProposal]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SiteProposal> updateRow(
    _is.DatabaseSession session,
    SiteProposal row, {
    _is.ColumnSelections<SiteProposalTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SiteProposal>(
      row,
      columns: columns?.call(SiteProposal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SiteProposal] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SiteProposal?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SiteProposalUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SiteProposal>(
      id,
      columnValues: columnValues(SiteProposal.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SiteProposal]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SiteProposal>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SiteProposalUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SiteProposalTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SiteProposalTable>? orderBy,
    _is.OrderByListBuilder<SiteProposalTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SiteProposal>(
      columnValues: columnValues(SiteProposal.t.updateTable),
      where: where(SiteProposal.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SiteProposal.t),
      orderByList: orderByList?.call(SiteProposal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SiteProposal]s in the list and returns the deleted rows.
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
  Future<List<SiteProposal>> delete(
    _is.DatabaseSession session,
    List<SiteProposal> rows, {
    _is.OrderByBuilder<SiteProposalTable>? orderBy,
    _is.OrderByListBuilder<SiteProposalTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SiteProposal>(
      rows,
      orderBy: orderBy?.call(SiteProposal.t),
      orderByList: orderByList?.call(SiteProposal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SiteProposal].
  Future<SiteProposal> deleteRow(
    _is.DatabaseSession session,
    SiteProposal row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SiteProposal>(
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
  Future<List<SiteProposal>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SiteProposalTable> where,
    _is.OrderByBuilder<SiteProposalTable>? orderBy,
    _is.OrderByListBuilder<SiteProposalTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SiteProposal>(
      where: where(SiteProposal.t),
      orderBy: orderBy?.call(SiteProposal.t),
      orderByList: orderByList?.call(SiteProposal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SiteProposalTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SiteProposal>(
      where: where?.call(SiteProposal.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SiteProposal] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SiteProposalTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SiteProposal>(
      where: where(SiteProposal.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
