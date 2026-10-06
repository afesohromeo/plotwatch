import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Sign-up creates the account, name and settings in one request, so no other
// request can see the new user half-created (Cloud bug of 2026-10-06).
void main() {
  String? sentCode;

  setUp(() {
    sentCode = null;
    AuthServices.set(
      tokenManagerBuilders: [
        ServerSideSessionsConfig(sessionKeyHashPepper: 'test-pepper'),
      ],
      identityProviderBuilders: [
        EmailIdpConfig(
          secretHashPepper: 'test-pepper',
          // Captures the code that is emailed in production.
          sendRegistrationVerificationCode:
              (
                session, {
                required email,
                required accountRequestId,
                required verificationCode,
                required transaction,
              }) => sentCode = verificationCode,
        ),
      ],
    );
  });

  // The auth module verifies the code in a transaction of its own (rate
  // limiter), which needs the database without automatic rollback. Data then
  // stays for the whole group, so the tests compare before and after.
  withServerpod('Given a registration whose email was verified', (
    sessionBuilder,
    endpoints,
  ) {
    Future<String> verifiedRegistration(String email) async {
      final requestId = await endpoints.emailIdp.startRegistration(
        sessionBuilder,
        email: email,
      );
      return endpoints.emailIdp.verifyRegistrationCode(
        sessionBuilder,
        accountRequestId: requestId,
        verificationCode: sentCode!,
      );
    }

    test('when it is finished with a profile then the account has the name, '
        'email and language', () async {
      final token = await verifiedRegistration('ada@example.com');

      final authSuccess = await endpoints.emailIdp
          .finishRegistrationWithProfile(
            sessionBuilder,
            registrationToken: token,
            password: 'secret123',
            fullName: '  Ada Lovelace ',
            locale: 'fr',
          );
      final me = await endpoints.profile.getMe(
        sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            authSuccess.authUserId.uuid,
            {},
          ),
        ),
      );

      expect(me.fullName, 'Ada Lovelace');
      expect(me.email, 'ada@example.com');
      expect(me.locale, 'fr');
      expect(
        await UserSettings.db.count(
          sessionBuilder.build(),
          where: (t) => t.authUserId.equals(authSuccess.authUserId),
        ),
        1,
      );
    });

    test(
      'when the name is invalid then it is refused and no account is created',
      () async {
        final token = await verifiedRegistration('bob@example.com');
        final accountsBefore = await AuthServices.instance.authUsers.list(
          sessionBuilder.build(),
        );

        await expectLater(
          endpoints.emailIdp.finishRegistrationWithProfile(
            sessionBuilder,
            registrationToken: token,
            password: 'secret123',
            fullName: '   ',
            locale: 'en',
          ),
          throwsA(
            isA<AppException>().having(
              (e) => e.code,
              'code',
              AppErrorCode.invalidFullName,
            ),
          ),
        );
        expect(
          await AuthServices.instance.authUsers.list(sessionBuilder.build()),
          hasLength(accountsBefore.length),
        );
      },
    );
  }, rollbackDatabase: RollbackDatabase.disabled);
}
