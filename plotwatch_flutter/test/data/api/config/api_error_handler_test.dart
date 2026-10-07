import 'package:flutter_test/flutter_test.dart';
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

// Mapping rules: _standards/14_serverpod_adaptation.md §2.2, §2.3, §2.3.1.
void main() {
  group('ApiErrorHandler.handle', () {
    test('AppException becomes HttpException400 with the same code', () {
      final result = ApiErrorHandler.handle(
        AppException(code: AppErrorCode.permissionDenied),
      );

      expect(
        result,
        isA<HttpException400>().having(
          (e) => e.code,
          'code',
          AppErrorCode.permissionDenied,
        ),
      );
    });

    group(
      'auth module exceptions become HttpException400 with an auth code',
      () {
        final cases = <String, (Object, AppErrorCode)>{
          'login invalidCredentials': (
            EmailAccountLoginException(
              reason: EmailAccountLoginExceptionReason.invalidCredentials,
            ),
            AppErrorCode.authInvalidCredentials,
          ),
          'login tooManyAttempts': (
            EmailAccountLoginException(
              reason: EmailAccountLoginExceptionReason.tooManyAttempts,
            ),
            AppErrorCode.authTooManyAttempts,
          ),
          'login unknown': (
            EmailAccountLoginException(
              reason: EmailAccountLoginExceptionReason.unknown,
            ),
            AppErrorCode.authUnknown,
          ),
          'registration expired': (
            EmailAccountRequestException(
              reason: EmailAccountRequestExceptionReason.expired,
            ),
            AppErrorCode.authRequestExpired,
          ),
          'registration invalid': (
            EmailAccountRequestException(
              reason: EmailAccountRequestExceptionReason.invalid,
            ),
            AppErrorCode.authRequestInvalid,
          ),
          'registration policyViolation': (
            EmailAccountRequestException(
              reason: EmailAccountRequestExceptionReason.policyViolation,
            ),
            AppErrorCode.authPasswordPolicy,
          ),
          'registration tooManyAttempts': (
            EmailAccountRequestException(
              reason: EmailAccountRequestExceptionReason.tooManyAttempts,
            ),
            AppErrorCode.authTooManyAttempts,
          ),
          'registration unknown': (
            EmailAccountRequestException(
              reason: EmailAccountRequestExceptionReason.unknown,
            ),
            AppErrorCode.authUnknown,
          ),
          'password reset expired': (
            EmailAccountPasswordResetException(
              reason: EmailAccountPasswordResetExceptionReason.expired,
            ),
            AppErrorCode.authRequestExpired,
          ),
          'password reset invalid': (
            EmailAccountPasswordResetException(
              reason: EmailAccountPasswordResetExceptionReason.invalid,
            ),
            AppErrorCode.authRequestInvalid,
          ),
          'password reset policyViolation': (
            EmailAccountPasswordResetException(
              reason: EmailAccountPasswordResetExceptionReason.policyViolation,
            ),
            AppErrorCode.authPasswordPolicy,
          ),
          'password reset tooManyAttempts': (
            EmailAccountPasswordResetException(
              reason: EmailAccountPasswordResetExceptionReason.tooManyAttempts,
            ),
            AppErrorCode.authTooManyAttempts,
          ),
          'password reset unknown': (
            EmailAccountPasswordResetException(
              reason: EmailAccountPasswordResetExceptionReason.unknown,
            ),
            AppErrorCode.authUnknown,
          ),
          'user blocked': (
            AuthUserBlockedException(),
            AppErrorCode.authUserBlocked,
          ),
        };

        for (final MapEntry(key: name, value: (error, code)) in cases.entries) {
          test(name, () {
            expect(
              ApiErrorHandler.handle(error),
              isA<HttpException400>().having((e) => e.code, 'code', code),
            );
          });
        }
      },
    );

    test('ServerpodClientUnauthorized becomes HttpException401', () {
      expect(
        ApiErrorHandler.handle(ServerpodClientUnauthorized()),
        isA<HttpException401>(),
      );
    });

    test(
      'ServerpodClientForbidden becomes HttpException400 permissionDenied',
      () {
        expect(
          ApiErrorHandler.handle(ServerpodClientForbidden()),
          isA<HttpException400>().having(
            (e) => e.code,
            'code',
            AppErrorCode.permissionDenied,
          ),
        );
      },
    );

    test('ServerpodClientNetworkException becomes NetworkException', () {
      expect(
        ApiErrorHandler.handle(
          const ServerpodClientNetworkException('offline'),
        ),
        isA<NetworkException>(),
      );
    });

    test('a stream connection error becomes NetworkException', () {
      expect(
        ApiErrorHandler.handle(const ConnectionClosedException()),
        isA<NetworkException>(),
      );
    });

    test('a server error becomes UnknownApiException', () {
      expect(
        ApiErrorHandler.handle(ServerpodClientInternalServerError()),
        isA<UnknownApiException>(),
      );
    });

    test(
      'any other error becomes UnknownApiException keeping the original',
      () {
        final original = StateError('unexpected');

        expect(
          ApiErrorHandler.handle(original),
          isA<UnknownApiException>().having(
            (e) => e.error,
            'error',
            same(original),
          ),
        );
      },
    );
  });
}
