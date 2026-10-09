import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Exceptions thrown by API providers (`_standards/14` §2.2).
/// BLoCs catch them and show the localized message for each case.

/// Business or validation error. [code] selects the localized message.
class HttpException400 implements Exception {
  const HttpException400({required this.code});

  final AppErrorCode code;

  @override
  String toString() => 'HttpException400(${code.name})';
}

/// Not signed in, or the session has expired.
class HttpException401 implements Exception {
  const HttpException401();
}

/// No connection, timeout, or a dropped stream connection.
class NetworkException implements Exception {
  const NetworkException();
}

/// A photo upload that didn't reach the storage (doc/04d M4-3); the capture
/// stays committed and can be sent again.
class UploadException implements Exception {
  const UploadException();
}

/// Anything else (server error, unexpected). [error] keeps the original for logs.
class UnknownApiException implements Exception {
  const UnknownApiException(this.error);

  final Object error;

  @override
  String toString() => 'UnknownApiException($error)';
}
