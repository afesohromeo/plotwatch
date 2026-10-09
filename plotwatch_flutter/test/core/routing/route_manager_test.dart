import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
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
          '/$profilePage',
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

  // doc/04b H-1: nested routes, so going to a page builds its parents below
  // it and Android Back goes up one level instead of closing the app.
  group('Given the route tree', () {
    /// The route names from the top level down to [name].
    List<String>? search(
      List<RouteBase> routes,
      List<String> above,
      String name,
    ) {
      for (final route in routes.whereType<GoRoute>()) {
        final path = [...above, ?route.name];
        if (route.name == name) return path;
        final found = search(route.routes, path, name);
        if (found != null) return found;
      }
      return null;
    }

    List<String>? ancestry(String name) =>
        search(RouteManager.shellSubRoutes, [], name);

    test('then the project list is the home page at /', () {
      expect(homePage, '/');
      expect(ancestry(homeRouteName), [homeRouteName]);
    });

    for (final (name, parents) in [
      (createProjectRouteName, [homeRouteName]),
      (projectRouteName, [homeRouteName]),
      (editProjectRouteName, [homeRouteName, projectRouteName]),
      (membersRouteName, [homeRouteName, projectRouteName]),
      (localizeSiteRouteName, [homeRouteName, projectRouteName]),
      (validateSiteRouteName, [homeRouteName, projectRouteName]),
      (editSiteRouteName, [homeRouteName, projectRouteName]),
      // doc/04c M3-11.
      (stagesRouteName, [homeRouteName, projectRouteName]),
      (
        createStageRouteName,
        [homeRouteName, projectRouteName, stagesRouteName],
      ),
      (stageRouteName, [homeRouteName, projectRouteName, stagesRouteName]),
      (
        editStageRouteName,
        [homeRouteName, projectRouteName, stagesRouteName, stageRouteName],
      ),
      // doc/04d groups C and D.
      (
        captureRouteName,
        [homeRouteName, projectRouteName, stagesRouteName, stageRouteName],
      ),
      (
        evidenceRouteName,
        [homeRouteName, projectRouteName, stagesRouteName, stageRouteName],
      ),
      (joinRouteName, [homeRouteName]),
      (joinWithCodeRouteName, [homeRouteName, joinRouteName]),
      (profileRouteName, [homeRouteName]),
    ]) {
      test('then $name sits under ${parents.join(' > ')}', () {
        expect(ancestry(name), [...parents, name]);
      });
    }

    for (final name in [
      welcomeRouteName,
      signInRouteName,
      signUpRouteName,
      passwordResetRouteName,
    ]) {
      test('then $name stays at the top level', () {
        expect(ancestry(name), [name]);
      });
    }
  });
}
