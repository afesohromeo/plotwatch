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

    test('when opening the home page then it goes to the welcome page', () {
      expect(
        RouteManager.redirectFor(AuthenticationStatus.unauthenticated, homePage),
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

  test('Given an unknown session when opening any page then nothing changes',
      () {
    expect(
      RouteManager.redirectFor(AuthenticationStatus.unknown, homePage),
      isNull,
    );
  });
}
