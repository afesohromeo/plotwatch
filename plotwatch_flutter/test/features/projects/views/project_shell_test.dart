import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockProjectOverviewBloc
    extends MockBloc<ProjectOverviewEvent, ProjectOverviewState>
    implements ProjectOverviewBloc {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

// Plan: doc/05-design-system.md §9, group DP-B (DP-3, DP-6).
void main() {
  late MockProjectOverviewBloc overviewBloc;

  setUpAll(setUpTestLocalization);
  setUp(() {
    ProjectShell.forgetTabs();
    overviewBloc = MockProjectOverviewBloc();
    when(() => overviewBloc.state).thenReturn(
      ProjectOverviewState(
        overviewStatus: GenericStatus.success,
        overview: testOverview(),
      ),
    );
  });

  group('Given a screen size', () {
    test('then a phone gets the bottom bar, a tablet the rail and the web '
        'the sidebar', () {
      expect(
        ProjectShell.layoutFor(const Size(390, 844)),
        ShellLayout.bottomBar,
      );
      // A phone held sideways keeps the bottom bar.
      expect(
        ProjectShell.layoutFor(const Size(844, 390)),
        ShellLayout.bottomBar,
      );
      expect(ProjectShell.layoutFor(const Size(800, 1100)), ShellLayout.rail);
      expect(
        ProjectShell.layoutFor(const Size(1280, 800)),
        ShellLayout.sidebar,
      );
    });
  });

  group('Given an address', () {
    test('then it belongs to its tab', () {
      expect(ProjectShell.tabOf('/projects/1'), ProjectTab.overview);
      expect(ProjectShell.tabOf('/projects/1/members'), ProjectTab.overview);
      expect(
        ProjectShell.tabOf('/projects/1/updates/new'),
        ProjectTab.overview,
      );
      expect(ProjectShell.tabOf('/projects/1/stages'), ProjectTab.stages);
      expect(
        ProjectShell.tabOf('/projects/1/stages/2/evidence/9'),
        ProjectTab.stages,
      );
      expect(ProjectShell.tabOf('/projects/1/feed'), ProjectTab.activity);
      // An update is read from the Activity tab (doc/05 §9.6).
      expect(
        ProjectShell.tabOf('/projects/1/updates/4'),
        ProjectTab.activity,
      );
    });

    test('then only posting an update is a focused page', () {
      expect(ProjectShell.isFocused('/projects/1/updates/new'), isTrue);
      expect(ProjectShell.isFocused('/projects/1/updates/4'), isFalse);
      expect(ProjectShell.isFocused('/projects/1'), isFalse);
    });
  });

  group('Given the project shell', () {
    GoRouter router(String initial) => GoRouter(
      initialLocation: initial,
      routes: [
        GoRoute(
          name: homeRouteName,
          path: '/',
          builder: (context, state) => const Text('the projects'),
          routes: [
            ShellRoute(
              builder: (context, state, child) =>
                  BlocProvider<ProjectOverviewBloc>.value(
                    value: overviewBloc,
                    child: ProjectShell(
                      projectId: 1,
                      location: state.uri.toString(),
                      child: child,
                    ),
                  ),
              routes: [
                GoRoute(
                  name: projectRouteName,
                  path: 'projects/:projectId',
                  builder: (context, state) => const Text('overview'),
                  routes: [
                    GoRoute(
                      name: stagesRouteName,
                      path: 'stages',
                      builder: (context, state) => const Text('plan'),
                      routes: [
                        GoRoute(
                          name: stageRouteName,
                          path: ':stageId',
                          builder: (context, state) => const Text('a stage'),
                        ),
                      ],
                    ),
                    GoRoute(
                      name: feedRouteName,
                      path: 'feed',
                      builder: (context, state) => const Text('feed'),
                    ),
                    GoRoute(
                      name: createUpdateRouteName,
                      path: 'updates/new',
                      builder: (context, state) => const Text('the form'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );

    Future<GoRouter> pumpAt(
      WidgetTester tester,
      Size size,
      String initial,
    ) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final r = router(initial);
      await tester.pumpRouterApp(r);
      await tester.pumpAndSettle();
      return r;
    }

    String path(GoRouter r) => r.routerDelegate.currentConfiguration.uri.path;

    testWidgets('on a phone then the tabs are a bottom bar', (tester) async {
      await pumpAt(tester, const Size(390, 844), '/projects/1');

      expect(find.byKey(ProjectShell.bottomBarKey), findsOneWidget);
      expect(find.byKey(ProjectShell.railKey), findsNothing);
      expect(find.text('overview'), findsOneWidget);
    });

    // doc/05 §9.6: the form's button stays at the bottom.
    testWidgets('on a phone when posting an update then there is no bottom '
        'bar', (tester) async {
      await pumpAt(tester, const Size(390, 844), '/projects/1/updates/new');

      expect(find.text('the form'), findsOneWidget);
      expect(find.byKey(ProjectShell.bottomBarKey), findsNothing);
    });

    testWidgets('on a tablet then the tabs are a rail', (tester) async {
      await pumpAt(tester, const Size(900, 1100), '/projects/1');

      expect(find.byKey(ProjectShell.railKey), findsOneWidget);
      expect(find.byKey(ProjectShell.bottomBarKey), findsNothing);
      expect(find.byKey(ProjectShell.logoKey), findsOneWidget);
    });

    testWidgets('on the web then the tabs are a sidebar with the project', (
      tester,
    ) async {
      await pumpAt(tester, const Size(1280, 800), '/projects/1');

      expect(find.byKey(ProjectShell.sidebarKey), findsOneWidget);
      expect(find.byKey(ProjectShell.logoKey), findsOneWidget);
      expect(find.text(testOverview().project.name), findsOneWidget);
    });

    testWidgets('when another tab is opened and the first one again then it '
        'comes back to where it was', (tester) async {
      final r = await pumpAt(
        tester,
        const Size(390, 844),
        '/projects/1/stages/2',
      );

      await tester.tap(find.byKey(ProjectShell.tabKey(ProjectTab.activity)));
      await tester.pumpAndSettle();
      expect(path(r), '/projects/1/feed');

      await tester.tap(find.byKey(ProjectShell.tabKey(ProjectTab.stages)));
      await tester.pumpAndSettle();
      expect(path(r), '/projects/1/stages/2');
      expect(find.text('a stage'), findsOneWidget);
    });

    testWidgets('when the current tab is tapped then it goes to its first '
        'page', (tester) async {
      final r = await pumpAt(
        tester,
        const Size(390, 844),
        '/projects/1/stages/2',
      );

      await tester.tap(find.byKey(ProjectShell.tabKey(ProjectTab.stages)));
      await tester.pumpAndSettle();

      expect(path(r), '/projects/1/stages');
    });

    testWidgets('on the web when "All projects" is tapped then the project '
        'list opens', (tester) async {
      await pumpAt(tester, const Size(1280, 800), '/projects/1');

      await tester.tap(find.text(setUpTestLocalization().allProjects));
      await tester.pumpAndSettle();

      expect(find.text('the projects'), findsOneWidget);
    });
  });

  group('Given any page (DP-6)', () {
    late MockAuthenticationBloc auth;
    late MockNotificationsBloc notifications;

    setUp(() {
      auth = MockAuthenticationBloc();
      notifications = MockNotificationsBloc();
      when(() => notifications.state).thenReturn(const NotificationsState());
    });

    Future<void> pumpPage(WidgetTester tester, AuthenticationStatus status) {
      when(() => auth.state).thenReturn(AuthenticationState(status: status));
      return tester.pumpApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>.value(value: auth),
            BlocProvider<NotificationsBloc>.value(value: notifications),
          ],
          child: const ResponsiveScaffoldWrapper(
            props: ScaffoldWrapperProps(title: Text('a page')),
            mobileBody: SizedBox.shrink(),
          ),
        ),
      );
    }

    testWidgets('when signed in then the bell is in its app bar', (
      tester,
    ) async {
      await pumpPage(tester, AuthenticationStatus.authenticated);

      expect(find.byKey(NotificationBell.buttonKey), findsOneWidget);
    });

    testWidgets('when signed out then there is no bell', (tester) async {
      await pumpPage(tester, AuthenticationStatus.unauthenticated);

      expect(find.byKey(NotificationBell.buttonKey), findsNothing);
    });
  });
}
