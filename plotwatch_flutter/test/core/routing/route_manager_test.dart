import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

// Auth guard (_standards/07): public pages when signed out, home when signed in.
void main() {
  group('Given a signed-out user', () {
    for (final page in publicPages) {
      test('when opening $page then it stays there', () {
        expect(
          RouteManager.redirectFor(AuthenticationStatus.unauthenticated, page),
          isNull,
        );
      });
    }

    test('when opening the profile page then it goes to the welcome page', () {
      expect(
        RouteManager.redirectFor(
          AuthenticationStatus.unauthenticated,
          profilePage,
        ),
        welcomePage,
      );
    });

    test('when opening the home page then it goes to the welcome page', () {
      expect(
        RouteManager.redirectFor(
          AuthenticationStatus.unauthenticated,
          homePage,
        ),
        welcomePage,
      );
    });

    test('when opening a project page then it goes to the welcome page', () {
      expect(
        RouteManager.redirectFor(
          AuthenticationStatus.unauthenticated,
          '/projects/7',
        ),
        welcomePage,
      );
    });
  });

  group('Given a signed-in user', () {
    for (final page in publicPages) {
      test('when opening $page then it goes to the home page', () {
        expect(
          RouteManager.redirectFor(AuthenticationStatus.authenticated, page),
          homePage,
        );
      });
    }

    test('when opening the home page then it stays there', () {
      expect(
        RouteManager.redirectFor(AuthenticationStatus.authenticated, homePage),
        isNull,
      );
    });
  });

  test(
    'Given an unknown session when opening any page then nothing changes',
    () {
      expect(
        RouteManager.redirectFor(AuthenticationStatus.unknown, homePage),
        isNull,
      );
    },
  );

  // MEMB-03: a signed-out user who opens an invitation link signs in or up
  // first, then lands on the join page (doc/04b, group F).
  group('Given an invitation link', () {
    test(
      'when signed out then it goes to the welcome page and is remembered',
      () {
        expect(
          RouteManager.redirectFor(
            AuthenticationStatus.unauthenticated,
            '/join/ABCD2345',
          ),
          welcomePage,
        );
        expect(RouteManager.isRememberedTarget('/join/ABCD2345'), isTrue);
      },
    );

    test('when the user has signed in then they go to the remembered link', () {
      expect(
        RouteManager.redirectFor(
          AuthenticationStatus.authenticated,
          signInPage,
          rememberedTarget: '/join/ABCD2345',
        ),
        '/join/ABCD2345',
      );
    });

    test('when signed in then the link opens directly', () {
      expect(
        RouteManager.redirectFor(
          AuthenticationStatus.authenticated,
          '/join/ABCD2345',
        ),
        isNull,
      );
    });

    test('Given an ordinary page then it is not remembered', () {
      expect(RouteManager.isRememberedTarget('/projects/7'), isFalse);
    });
  });
}
