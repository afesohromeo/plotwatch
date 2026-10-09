import 'dart:async';

import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Converts any error from the Serverpod client into the app's exception
/// types (`_standards/14` §2.3). Used by every API provider:
/// `catch (e) { throw ApiErrorHandler.handle(e); }`.
class ApiErrorHandler {
  ApiErrorHandler._();

  /// The same conversion for a live stream's errors (doc/04e M5-6).
  static StreamTransformer<T, T> streamErrors<T>() =>
      StreamTransformer<T, T>.fromHandlers(
        handleError: (error, stackTrace, sink) =>
            sink.addError(handle(error), stackTrace),
      );

  static Exception handle(Object e) {
    if (e is AppException) return HttpException400(code: e.code);

    final authCode = _authErrorCode(e);
    if (authCode != null) return HttpException400(code: authCode);

    if (e is ServerpodClientUnauthorized) return const HttpException401();
    if (e is ServerpodClientForbidden) {
      return const HttpException400(code: AppErrorCode.permissionDenied);
    }
    if (e is ServerpodClientNetworkException || e is MethodStreamException) {
      return const NetworkException();
    }
    return UnknownApiException(e);
  }

  /// Maps the auth module's own exceptions to app error codes
  /// (`_standards/14` §2.3.1); `null` for anything else. The switches are
  /// exhaustive, so a new reason in a Serverpod update fails to compile.
  static AppErrorCode? _authErrorCode(Object e) => switch (e) {
    EmailAccountLoginException(:final reason) => switch (reason) {
      EmailAccountLoginExceptionReason.invalidCredentials =>
        AppErrorCode.authInvalidCredentials,
      EmailAccountLoginExceptionReason.tooManyAttempts =>
        AppErrorCode.authTooManyAttempts,
      EmailAccountLoginExceptionReason.unknown => AppErrorCode.authUnknown,
    },
    EmailAccountRequestException(:final reason) => switch (reason) {
      EmailAccountRequestExceptionReason.expired =>
        AppErrorCode.authRequestExpired,
      EmailAccountRequestExceptionReason.invalid =>
        AppErrorCode.authRequestInvalid,
      EmailAccountRequestExceptionReason.policyViolation =>
        AppErrorCode.authPasswordPolicy,
      EmailAccountRequestExceptionReason.tooManyAttempts =>
        AppErrorCode.authTooManyAttempts,
      EmailAccountRequestExceptionReason.unknown => AppErrorCode.authUnknown,
    },
    EmailAccountPasswordResetException(:final reason) => switch (reason) {
      EmailAccountPasswordResetExceptionReason.expired =>
        AppErrorCode.authRequestExpired,
      EmailAccountPasswordResetExceptionReason.invalid =>
        AppErrorCode.authRequestInvalid,
      EmailAccountPasswordResetExceptionReason.policyViolation =>
        AppErrorCode.authPasswordPolicy,
      EmailAccountPasswordResetExceptionReason.tooManyAttempts =>
        AppErrorCode.authTooManyAttempts,
      EmailAccountPasswordResetExceptionReason.unknown =>
        AppErrorCode.authUnknown,
    },
    AuthUserBlockedException() => AppErrorCode.authUserBlocked,
    _ => null,
  };
}
