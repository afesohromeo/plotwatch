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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'site_proposal_status.dart' as _i8b5g94r;

/// A site location proposed by a site manager on the plot (decision M2-15).
/// Rows are never deleted: they are the history of the site's location.
abstract class SiteProposal
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SiteProposal._({
    this.id,
    required this.projectId,
    required this.proposedBy,
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
    required _isc.UuidValue proposedBy,
    required double lat,
    required double lng,
    required double accuracyM,
    required DateTime proposedAt,
    required _i8b5g94r.SiteProposalStatus status,
    _isc.UuidValue? decidedBy,
    DateTime? decidedAt,
    String? rejectReason,
  }) = _SiteProposalImpl;

  factory SiteProposal.fromJson(Map<String, dynamic> jsonSerialization) {
    return SiteProposal(
      id: jsonSerialization['id'] as int?,
      projectId: jsonSerialization['projectId'] as int,
      proposedBy: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['proposedBy'],
      ),
      lat: (jsonSerialization['lat'] as num).toDouble(),
      lng: (jsonSerialization['lng'] as num).toDouble(),
      accuracyM: (jsonSerialization['accuracyM'] as num).toDouble(),
      proposedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['proposedAt'],
      ),
      status: _i8b5g94r.SiteProposalStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      decidedBy: jsonSerialization['decidedBy'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['decidedBy'],
            ),
      decidedAt: jsonSerialization['decidedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['decidedAt']),
      rejectReason: jsonSerialization['rejectReason'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int projectId;

  _isc.UuidValue proposedBy;

  double lat;

  double lng;

  /// GPS accuracy of the reading in metres; at most 20 (decision M2-17).
  double accuracyM;

  /// When the server received the proposal (trusted time).
  DateTime proposedAt;

  _i8b5g94r.SiteProposalStatus status;

  _isc.UuidValue? decidedBy;

  DateTime? decidedAt;

  /// Optional, at most 500 characters (decision M2-18).
  String? rejectReason;

  /// Returns a shallow copy of this [SiteProposal]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SiteProposal copyWith({
    int? id,
    int? projectId,
    _isc.UuidValue? proposedBy,
    double? lat,
    double? lng,
    double? accuracyM,
    DateTime? proposedAt,
    _i8b5g94r.SiteProposalStatus? status,
    _isc.UuidValue? decidedBy,
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
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SiteProposalImpl extends SiteProposal {
  _SiteProposalImpl({
    int? id,
    required int projectId,
    required _isc.UuidValue proposedBy,
    required double lat,
    required double lng,
    required double accuracyM,
    required DateTime proposedAt,
    required _i8b5g94r.SiteProposalStatus status,
    _isc.UuidValue? decidedBy,
    DateTime? decidedAt,
    String? rejectReason,
  }) : super._(
         id: id,
         projectId: projectId,
         proposedBy: proposedBy,
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
  @_isc.useResult
  @override
  SiteProposal copyWith({
    Object? id = _Undefined,
    int? projectId,
    _isc.UuidValue? proposedBy,
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
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      accuracyM: accuracyM ?? this.accuracyM,
      proposedAt: proposedAt ?? this.proposedAt,
      status: status ?? this.status,
      decidedBy: decidedBy is _isc.UuidValue? ? decidedBy : this.decidedBy,
      decidedAt: decidedAt is DateTime? ? decidedAt : this.decidedAt,
      rejectReason: rejectReason is String? ? rejectReason : this.rejectReason,
    );
  }
}
