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

/// Where to upload a receipt photo, and how (doc/04f M6-5 a).
abstract class ReceiptUpload
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ReceiptUpload._({
    required this.path,
    required this.uploadDescription,
  });

  factory ReceiptUpload({
    required String path,
    required String uploadDescription,
  }) = _ReceiptUploadImpl;

  factory ReceiptUpload.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReceiptUpload(
      path: jsonSerialization['path'] as String,
      uploadDescription: jsonSerialization['uploadDescription'] as String,
    );
  }

  String path;

  String uploadDescription;

  /// Returns a shallow copy of this [ReceiptUpload]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ReceiptUpload copyWith({
    String? path,
    String? uploadDescription,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReceiptUpload',
      'path': path,
      'uploadDescription': uploadDescription,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReceiptUpload',
      'path': path,
      'uploadDescription': uploadDescription,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ReceiptUploadImpl extends ReceiptUpload {
  _ReceiptUploadImpl({
    required String path,
    required String uploadDescription,
  }) : super._(
         path: path,
         uploadDescription: uploadDescription,
       );

  /// Returns a shallow copy of this [ReceiptUpload]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ReceiptUpload copyWith({
    String? path,
    String? uploadDescription,
  }) {
    return ReceiptUpload(
      path: path ?? this.path,
      uploadDescription: uploadDescription ?? this.uploadDescription,
    );
  }
}
