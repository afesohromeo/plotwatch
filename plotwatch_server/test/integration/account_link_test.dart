import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:plotwatch_server/src/services/account_link_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:serverpod_auth_idp_server/providers/google.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Plan: doc/04g-m8-hardening.md, "One account per email" (AUTH-04b).
void main() {
  setUp(() {
    AuthServices.set(
      tokenManagerBuilders: [
        ServerSideSessionsConfig(sessionKeyHashPepper: 'test-pepper'),
      ],
      identityProviderBuilders: [
        EmailIdpConfig(secretHashPepper: 'test-pepper'),
        GoogleIdpConfig(
          clientSecret: GoogleClientSecret.fromJsonString(
            '{"web": {"client_id": "test.apps.googleusercontent.com", '
            '"client_secret": "test-secret", "redirect_uris": []}}',
          ),
        ),
      ],
    );
  });

  const service = AccountLinkService();

  GoogleAccountDetails google(
    String email, {
    String id = 'google-1',
    bool? verified = true,
  }) => (
    userIdentifier: id,
    email: email,
    name: 'Ada',
    fullName: 'Ada Lovelace',
    image: null,
    verifiedEmail: verified,
  );

  // The auth module's registration runs in a transaction of its own (rate
  // limiter), so the database is not rolled back; each test has its email.
  withServerpod(
    'Given a person who signed up with an email and a password',
    (sessionBuilder, endpoints) {
      final session = sessionBuilder.build();

      Future<UuidValue> passwordUser(String email) async {
        final user = await AuthServices.instance.authUsers.create(session);
        await EmailAccount.db.insertRow(
          session,
          EmailAccount(
            authUserId: user.id,
            email: email,
            passwordHash: 'hash',
          ),
        );
        return user.id;
      }

      Future<GoogleAccount?> googleAccount(String id) => GoogleAccount.db
          .findFirstRow(session, where: (t) => t.userIdentifier.equals(id));

      test('when they continue with Google with that verified email then '
          'Google is linked to the same user', () async {
        final userId = await passwordUser('ada@example.com');

        await service.linkGoogleToPasswordAccount(
          session,
          google('Ada@Example.com'),
        );

        expect((await googleAccount('google-1'))?.authUserId, userId);
      });

      test('when Google says the email is not verified then nothing is '
          'linked', () async {
        await passwordUser('grace@example.com');

        await service.linkGoogleToPasswordAccount(
          session,
          google('grace@example.com', id: 'google-2', verified: false),
        );

        expect(await googleAccount('google-2'), isNull);
      });

      test('when a Google email has no account then nothing is linked, so '
          'the login makes a new user', () async {
        await service.linkGoogleToPasswordAccount(
          session,
          google('new@example.com', id: 'google-3'),
        );

        expect(await googleAccount('google-3'), isNull);
      });

      test('when a returning Google user signs in then their link is kept '
          'as it is', () async {
        final first = await passwordUser('linus@example.com');
        await service.linkGoogleToPasswordAccount(
          session,
          google('linus@example.com', id: 'google-4'),
        );

        await service.linkGoogleToPasswordAccount(
          session,
          google('linus@example.com', id: 'google-4'),
        );

        final links = await GoogleAccount.db.find(
          session,
          where: (t) => t.userIdentifier.equals('google-4'),
        );
        expect(links.single.authUserId, first);
      });

      group('when someone signs up with an email', () {
        test('that only a Google user has then it is refused', () async {
          final user = await AuthServices.instance.authUsers.create(session);
          await AuthServices.instance.googleIdp.utils.linkGoogleAuthentication(
            session,
            authUserId: user.id,
            accountDetails: google('margaret@gmail.com', id: 'google-5'),
          );

          await expectLater(
            endpoints.emailIdp.startRegistration(
              sessionBuilder,
              email: ' Margaret@Gmail.com ',
            ),
            throwsA(
              isA<AppException>().having(
                (e) => e.code,
                'code',
                AppErrorCode.emailUsesGoogle,
              ),
            ),
          );
        });

        test('that nobody has then the registration starts', () async {
          expect(
            await endpoints.emailIdp.startRegistration(
              sessionBuilder,
              email: 'barbara@example.com',
            ),
            isA<UuidValue>(),
          );
        });
      });
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}
