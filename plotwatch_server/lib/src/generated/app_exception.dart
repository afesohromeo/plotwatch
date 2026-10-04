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
import 'app_error_code.dart' as _imu8gbx5;

/// The only exception the server throws for business and validation errors
/// (`_standards/14` §2.1).
abstract class AppException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  AppException._({
    required this.code,
    this.details,
  });

  factory AppException({
    required _imu8gbx5.AppErrorCode code,
    String? details,
  }) = _AppExceptionImpl;

  factory AppException.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppException(
      code: _imu8gbx5.AppErrorCode.fromJson(
        (jsonSerialization['code'] as String),
      ),
      details: jsonSerialization['details'] as String?,
    );
  }

  /// What went wrong; the client turns it into a localized message.
  _imu8gbx5.AppErrorCode code;

  /// Technical detail for logs only, never shown to users.
  String? details;

  /// Returns a shallow copy of this [AppException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AppException copyWith({
    _imu8gbx5.AppErrorCode? code,
    String? details,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppException',
      'code': code.toJson(),
      if (details != null) 'details': details,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AppException',
      'code': code.toJson(),
      if (details != null) 'details': details,
    };
  }

  @override
  String toString() {
    return 'AppException(code: $code, details: $details)';
  }
}

class _Undefined {}

class _AppExceptionImpl extends AppException {
  _AppExceptionImpl({
    required _imu8gbx5.AppErrorCode code,
    String? details,
  }) : super._(
         code: code,
         details: details,
       );

  /// Returns a shallow copy of this [AppException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AppException copyWith({
    _imu8gbx5.AppErrorCode? code,
    Object? details = _Undefined,
  }) {
    return AppException(
      code: code ?? this.code,
      details: details is String? ? details : this.details,
    );
  }
}
