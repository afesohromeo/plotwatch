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

  withServerpod('Given a registered user and the profile endpoint', (
    sessionBuilder,
    endpoints,
  ) {
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
        authentication: AuthenticationOverride.authenticationInfo(
          authUser.id.uuid,
          {},
        ),
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

      test('for the first time then it returns the auth profile with default '
          'settings', () async {
        final me = await endpoints.profile.getMe(signedIn);

        expect(me.fullName, 'Ada Lovelace');
        expect(me.email, 'ada@example.com');
        expect(me.locale, 'en');
        expect(me.countryCode, isNull);
      });

      test('then it only reads: no settings row is created', () async {
        await endpoints.profile.getMe(signedIn);
        await endpoints.profile.getMe(signedIn);

        expect(await UserSettings.db.count(sessionBuilder.build()), 0);
      });
    });

    test('when updateMe is called for a user without settings then exactly '
        'one settings row is created', () async {
      await endpoints.profile.updateMe(signedIn, fullName: 'Ada', locale: 'en');

      expect(await UserSettings.db.count(sessionBuilder.build()), 1);
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
        await endpoints.profile.updateMe(
          signedIn,
          fullName: 'Ada',
          countryCode: 'CM',
          locale: 'en',
        );

        final updated = await endpoints.profile.updateMe(
          signedIn,
          fullName: 'Ada',
          locale: 'en',
        );

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
        test(
          'with the country "$country" then it throws invalidCountryCode',
          () async {
            await expectLater(
              endpoints.profile.updateMe(
                signedIn,
                fullName: 'Ada',
                countryCode: country,
                locale: 'en',
              ),
              throwsA(_appException(AppErrorCode.invalidCountryCode)),
            );
          },
        );
      }

      test('with the language "de" then it throws invalidLocale', () async {
        await expectLater(
          endpoints.profile.updateMe(signedIn, fullName: 'Ada', locale: 'de'),
          throwsA(_appException(AppErrorCode.invalidLocale)),
        );
      });
    });
  });

  // Regression test for the Cloud bug of 2026-10-06: right after sign-up the
  // app fetched the profile and saved the name at the same moment; both
  // requests tried to create the settings row and the save failed with a
  // unique-constraint violation. Concurrent transactions need the database
  // without automatic rollback (serverpod-testing skill).
  withServerpod(
    'Given a new user whose profile is fetched and saved at the same time',
    (sessionBuilder, endpoints) {
      test('when both requests run concurrently then both succeed and the '
          'name is kept', () async {
        final session = sessionBuilder.build();
        final authUser = await AuthServices.instance.authUsers.create(session);
        await AuthServices.instance.userProfiles.createUserProfile(
          session,
          authUser.id,
          UserProfileData(email: 'ada@example.com'),
        );
        final signedIn = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            authUser.id.uuid,
            {},
          ),
        );

        await Future.wait([
          endpoints.profile.getMe(signedIn),
          endpoints.profile.updateMe(
            signedIn,
            fullName: 'Ada Lovelace',
            locale: 'fr',
          ),
        ]);

        final me = await endpoints.profile.getMe(signedIn);
        expect(me.fullName, 'Ada Lovelace');
        expect(me.locale, 'fr');
      });
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );

  // doc/04g step 4: a Google sign-up sends no language, so the app sends its
  // own, as the email sign-up does (finishRegistrationWithProfile).
  withServerpod('Given a user who signed up with Google', (
    sessionBuilder,
    endpoints,
  ) {
    late TestSessionBuilder signedIn;

    setUp(() async {
      final session = sessionBuilder.build();
      final authUser = await AuthServices.instance.authUsers.create(session);
      await AuthServices.instance.userProfiles.createUserProfile(
        session,
        authUser.id,
        UserProfileData(fullName: 'Ada Lovelace', email: 'ada@gmail.com'),
      );
      signedIn = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          authUser.id.uuid,
          {},
        ),
      );
    });

    test('when the app adopts its language then the profile has it, with '
        'the name from Google', () async {
      final me = await endpoints.profile.adoptLocale(signedIn, locale: 'fr');

      expect(me.locale, 'fr');
      expect(me.fullName, 'Ada Lovelace');
      expect((await endpoints.profile.getMe(signedIn)).locale, 'fr');
    });

    test('when settings were already saved then adopting keeps them', () async {
      await endpoints.profile.updateMe(
        signedIn,
        fullName: 'Ada Lovelace',
        countryCode: 'CM',
        locale: 'en',
      );

      final me = await endpoints.profile.adoptLocale(signedIn, locale: 'fr');

      expect(me.locale, 'en');
      expect(me.countryCode, 'CM');
    });

    test('when the language is not supported then it is refused', () async {
      await expectLater(
        endpoints.profile.adoptLocale(signedIn, locale: 'de'),
        throwsA(_appException(AppErrorCode.invalidLocale)),
      );
    });

    test('without signing in then it throws unauthenticated', () async {
      await expectLater(
        endpoints.profile.adoptLocale(
          sessionBuilder.copyWith(
            authentication: AuthenticationOverride.unauthenticated(),
          ),
          locale: 'fr',
        ),
        throwsA(isA<ServerpodUnauthenticatedException>()),
      );
    });
  });
}

Matcher _appException(AppErrorCode code) =>
    isA<AppException>().having((e) => e.code, 'code', code);
