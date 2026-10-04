import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Plan: doc/04a-m1-foundation.md, group B. Decisions M1-1 and M1-2.
void main() {
  // `withServerpod` doesn't run lib/server.dart, so the auth services are set
  // here, the same way the auth module's own tests do it.
  setUp(() {
    AuthServices.set(
      tokenManagerBuilders: [
        ServerSideSessionsConfig(sessionKeyHashPepper: 'test-pepper'),
      ],
    );
  });

  withServerpod('Given a registered user and the profile endpoint',
      (sessionBuilder, endpoints) {
    late TestSessionBuilder signedIn;

    setUp(() async {
      final session = sessionBuilder.build();
      final authUser = await AuthServices.instance.authUsers.create(session);
      await AuthServices.instance.userProfiles.createUserProfile(
        session,
        authUser.id,
        UserProfileData(fullName: 'Ada Lovelace', email: 'ada@example.com'),
      );
      signedIn = sessionBuilder.copyWith(
        authentication:
            AuthenticationOverride.authenticationInfo(authUser.id.uuid, {}),
      );
    });

    group('when getMe is called', () {
      test('without signing in then it throws unauthenticated', () async {
        await expectLater(
          endpoints.profile.getMe(
            sessionBuilder.copyWith(
              authentication: AuthenticationOverride.unauthenticated(),
            ),
          ),
          throwsA(isA<ServerpodUnauthenticatedException>()),
        );
      });

      test(
          'for the first time then it returns the auth profile with default '
          'settings', () async {
        final me = await endpoints.profile.getMe(signedIn);

        expect(me.fullName, 'Ada Lovelace');
        expect(me.email, 'ada@example.com');
        expect(me.locale, 'en');
        expect(me.countryCode, isNull);
      });

      test('twice then only one settings row exists', () async {
        await endpoints.profile.getMe(signedIn);
        await endpoints.profile.getMe(signedIn);

        expect(await UserSettings.db.count(sessionBuilder.build()), 1);
      });
    });

    group('when updateMe is called', () {
      test('with valid values then they are saved and returned', () async {
        final updated = await endpoints.profile.updateMe(
          signedIn,
          fullName: '  Ada King ',
          countryCode: 'CM',
          locale: 'fr',
        );
        final reloaded = await endpoints.profile.getMe(signedIn);

        for (final me in [updated, reloaded]) {
          expect(me.fullName, 'Ada King');
          expect(me.countryCode, 'CM');
          expect(me.locale, 'fr');
          expect(me.email, 'ada@example.com');
        }
      });

      test('without a country then the country is cleared', () async {
        await endpoints.profile.updateMe(signedIn,
            fullName: 'Ada', countryCode: 'CM', locale: 'en');

        final updated =
            await endpoints.profile.updateMe(signedIn, fullName: 'Ada', locale: 'en');

        expect(updated.countryCode, isNull);
      });

      for (final name in ['   ', 'x' * 101]) {
        test('with the name "${name.length > 10 ? '101 characters' : 'blank'}" '
            'then it throws invalidFullName', () async {
          await expectLater(
            endpoints.profile.updateMe(signedIn, fullName: name, locale: 'en'),
            throwsA(_appException(AppErrorCode.invalidFullName)),
          );
        });
      }

      for (final country in ['cm', 'CMR']) {
        test('with the country "$country" then it throws invalidCountryCode',
            () async {
          await expectLater(
            endpoints.profile.updateMe(signedIn,
                fullName: 'Ada', countryCode: country, locale: 'en'),
            throwsA(_appException(AppErrorCode.invalidCountryCode)),
          );
        });
      }

      test('with the language "de" then it throws invalidLocale', () async {
        await expectLater(
          endpoints.profile.updateMe(signedIn, fullName: 'Ada', locale: 'de'),
          throwsA(_appException(AppErrorCode.invalidLocale)),
        );
      });
    });
  });
}

Matcher _appException(AppErrorCode code) =>
    isA<AppException>().having((e) => e.code, 'code', code);
