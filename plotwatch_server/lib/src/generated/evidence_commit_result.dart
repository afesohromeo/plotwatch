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
import 'evidence.dart' as _iptmmm0p;

/// The committed capture and where to upload its photo (decision M4-3).
abstract class EvidenceCommitResult
    implements _is.SerializableModel, _is.ProtocolSerialization {
  EvidenceCommitResult._({
    required this.evidence,
    required this.uploadDescription,
  });

  factory EvidenceCommitResult({
    required _iptmmm0p.Evidence evidence,
    required String uploadDescription,
  }) = _EvidenceCommitResultImpl;

  factory EvidenceCommitResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EvidenceCommitResult(
      evidence: _irbavk3a.Protocol().deserialize<_iptmmm0p.Evidence>(
        jsonSerialization['evidence'],
      ),
      uploadDescription: jsonSerialization['uploadDescription'] as String,
    );
  }

  _iptmmm0p.Evidence evidence;

  String uploadDescription;

  /// Returns a shallow copy of this [EvidenceCommitResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EvidenceCommitResult copyWith({
    _iptmmm0p.Evidence? evidence,
    String? uploadDescription,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EvidenceCommitResult',
      'evidence': evidence.toJson(),
      'uploadDescription': uploadDescription,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EvidenceCommitResult',
      'evidence': evidence.toJsonForProtocol(),
      'uploadDescription': uploadDescription,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _EvidenceCommitResultImpl extends EvidenceCommitResult {
  _EvidenceCommitResultImpl({
    required _iptmmm0p.Evidence evidence,
    required String uploadDescription,
  }) : super._(
         evidence: evidence,
         uploadDescription: uploadDescription,
       );

  /// Returns a shallow copy of this [EvidenceCommitResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EvidenceCommitResult copyWith({
    _iptmmm0p.Evidence? evidence,
    String? uploadDescription,
  }) {
    return EvidenceCommitResult(
      evidence: evidence ?? this.evidence.copyWith(),
      uploadDescription: uploadDescription ?? this.uploadDescription,
    );
  }
}
