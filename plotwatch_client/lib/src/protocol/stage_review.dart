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
import 'review_decision.dart' as _idrjy6ic;

/// One review decision, kept for good (REV-05, doc/04e M5-3).
abstract class StageReview
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    required _isc.UuidValue reviewerId,
    required _idrjy6ic.ReviewDecision decision,
    String? comment,
    required DateTime createdAt,
  }) = _StageReviewImpl;

  factory StageReview.fromJson(Map<String, dynamic> jsonSerialization) {
    return StageReview(
      id: jsonSerialization['id'] as int?,
      stageId: jsonSerialization['stageId'] as int,
      reviewerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['reviewerId'],
      ),
      decision: _idrjy6ic.ReviewDecision.fromJson(
        (jsonSerialization['decision'] as String),
      ),
      comment: jsonSerialization['comment'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int stageId;

  _isc.UuidValue reviewerId;

  _idrjy6ic.ReviewDecision decision;

  /// Required when changes are requested, 1–1,000 characters.
  String? comment;

  DateTime createdAt;

  /// Returns a shallow copy of this [StageReview]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StageReview copyWith({
    int? id,
    int? stageId,
    _isc.UuidValue? reviewerId,
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StageReviewImpl extends StageReview {
  _StageReviewImpl({
    int? id,
    required int stageId,
    required _isc.UuidValue reviewerId,
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
  @_isc.useResult
  @override
  StageReview copyWith({
    Object? id = _Undefined,
    int? stageId,
    _isc.UuidValue? reviewerId,
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
