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
import 'package:plotwatch_client/src/protocol/protocol.dart' as _immd62fm;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'stage_review.dart' as _ie5kygoh;

/// A review decision with the reviewer's name, for the stage history.
abstract class StageReviewView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StageReviewView._({
    required this.review,
    this.reviewerName,
  });

  factory StageReviewView({
    required _ie5kygoh.StageReview review,
    String? reviewerName,
  }) = _StageReviewViewImpl;

  factory StageReviewView.fromJson(Map<String, dynamic> jsonSerialization) {
    return StageReviewView(
      review: _immd62fm.Protocol().deserialize<_ie5kygoh.StageReview>(
        jsonSerialization['review'],
      ),
      reviewerName: jsonSerialization['reviewerName'] as String?,
    );
  }

  _ie5kygoh.StageReview review;

  String? reviewerName;

  /// Returns a shallow copy of this [StageReviewView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StageReviewView copyWith({
    _ie5kygoh.StageReview? review,
    String? reviewerName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StageReviewView',
      'review': review.toJson(),
      if (reviewerName != null) 'reviewerName': reviewerName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StageReviewView',
      'review': review.toJsonForProtocol(),
      if (reviewerName != null) 'reviewerName': reviewerName,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StageReviewViewImpl extends StageReviewView {
  _StageReviewViewImpl({
    required _ie5kygoh.StageReview review,
    String? reviewerName,
  }) : super._(
         review: review,
         reviewerName: reviewerName,
       );

  /// Returns a shallow copy of this [StageReviewView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StageReviewView copyWith({
    _ie5kygoh.StageReview? review,
    Object? reviewerName = _Undefined,
  }) {
    return StageReviewView(
      review: review ?? this.review.copyWith(),
      reviewerName: reviewerName is String? ? reviewerName : this.reviewerName,
    );
  }
}
