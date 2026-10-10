import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockProjectListBloc extends MockBloc<ProjectListEvent, ProjectListState>
    implements ProjectListBloc {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

// Plan: doc/04b-m2-projects-site-members.md, group E (PROJ-03).
void main() {
  late AppLocalizations l10n;
  late MockProjectListBloc bloc;
  late MockAuthenticationBloc authBloc;
  late MockNotificationsBloc notificationsBloc;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const ProjectListEvent.refreshProjects());
  });

  setUp(() {
    bloc = MockProjectListBloc();
    authBloc = MockAuthenticationBloc();
    notificationsBloc = MockNotificationsBloc();
    when(() => notificationsBloc.state).thenReturn(const NotificationsState());
    when(() => authBloc.state).thenReturn(
      const AuthenticationState(status: AuthenticationStatus.authenticated),
    );
  });

  Future<void> pumpPage(WidgetTester tester, List<ProjectListState> states) {
    whenListen(
      bloc,
      Stream.fromIterable(states),
      initialState: const ProjectListState(),
    );
    return tester.pumpApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<ProjectListBloc>.value(value: bloc),
          BlocProvider<AuthenticationBloc>.value(value: authBloc),
          BlocProvider<NotificationsBloc>.value(value: notificationsBloc),
        ],
        child: const ProjectListPage(),
      ),
    );
  }

  ProjectListState loaded(List<ProjectSummary> items) => ProjectListState(
    projectsListStatus: GenericStatus.success,
    projects: items,
    paginatedProjects: items,
    maxProjects: true,
  );

  testWidgets('Given the project list when it opens then it asks for page 0', (
    tester,
  ) async {
    await pumpPage(tester, const []);

    verify(
      () => bloc.add(
        const ProjectListEvent.fetchProjects(sort: ProjectSort.recent),
      ),
    ).called(1);
  });

  testWidgets(
    'Given the user\'s projects then each shows its name, the user\'s role '
    'and the status',
    (tester) async {
      await pumpPage(tester, [
        loaded([
          testSummary(id: 1, name: 'House in Bafoussam'),
          testSummary(
            id: 2,
            name: 'Shop in Douala',
            role: ProjectRole.siteManager,
            status: ProjectStatus.active,
          ),
        ]),
      ]);
      await tester.pump();

      expect(find.text('House in Bafoussam'), findsOneWidget);
      expect(find.text('Shop in Douala'), findsOneWidget);
      // Under the name: "New house · Owner" (doc/05 §9).
      expect(find.textContaining(l10n.projectRoleOwner), findsOneWidget);
      expect(find.textContaining(l10n.projectRoleSiteManager), findsOneWidget);
      expect(find.text(l10n.projectStatusDraft), findsOneWidget);
      expect(find.text(l10n.projectStatusActive), findsOneWidget);
    },
  );

  testWidgets('Given no projects then it explains how to start', (
    tester,
  ) async {
    await pumpPage(tester, [loaded(const [])]);
    await tester.pump();

    expect(find.text(l10n.projectsEmpty), findsOneWidget);
  });

  testWidgets('Given the list fails to load then it shows the error', (
    tester,
  ) async {
    await pumpPage(tester, [
      ProjectListState(
        projectsListStatus: GenericStatus.failure,
        projectsListError: l10n.networkError,
      ),
    ]);
    await tester.pump();

    expect(find.text(l10n.networkError), findsOneWidget);
  });

  testWidgets('Given the project list then it offers to create a project', (
    tester,
  ) async {
    await pumpPage(tester, const []);

    expect(find.byKey(ProjectListPage.newProjectButtonKey), findsOneWidget);
  });

  // doc/05 §9.5: search, status chips and sort, sent with every page.
  group('Given the filters', () {
    late StreamController<ProjectListState> states;

    setUp(() => states = StreamController<ProjectListState>());
    tearDown(() {
      states.close();
    });

    Future<void> pumpLive(WidgetTester tester) {
      whenListen(bloc, states.stream, initialState: const ProjectListState());
      return tester.pumpApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<ProjectListBloc>.value(value: bloc),
            BlocProvider<AuthenticationBloc>.value(value: authBloc),
            BlocProvider<NotificationsBloc>.value(value: notificationsBloc),
          ],
          child: const ProjectListPage(),
        ),
      );
    }

    /// What the BLoC does on refresh: the list starts again from page 0.
    Future<void> refreshed(WidgetTester tester) async {
      states.add(const ProjectListState(projectsRefreshController: true));
      await tester.pump();
    }

    testWidgets('when a status is chosen then the list reloads with it', (
      tester,
    ) async {
      await pumpLive(tester);

      await tester.tap(
        find.byKey(FilterChips.chipKey(ProjectListPage.statusChipsPrefix, 2)),
      );
      await tester.pump();
      verify(
        () => bloc.add(const ProjectListEvent.refreshProjects()),
      ).called(1);
      await refreshed(tester);

      verify(
        () => bloc.add(
          const ProjectListEvent.fetchProjects(
            statusFilter: ProjectStatus.paused,
            sort: ProjectSort.recent,
          ),
        ),
      ).called(1);
    });

    testWidgets('when typing then it searches once the typing stops', (
      tester,
    ) async {
      await pumpLive(tester);
      final field = find.descendant(
        of: find.byKey(ProjectListPage.searchFieldKey),
        matching: find.byType(EditableText),
      );

      await tester.enterText(field, 'vil');
      await tester.pump(const Duration(milliseconds: 300));
      await tester.enterText(field, 'villa ');
      await tester.pump(const Duration(milliseconds: 300));
      verifyNever(() => bloc.add(const ProjectListEvent.refreshProjects()));

      await tester.pump(ProjectListPage.searchDebounce);
      verify(
        () => bloc.add(const ProjectListEvent.refreshProjects()),
      ).called(1);
      await refreshed(tester);
      verify(
        () => bloc.add(
          const ProjectListEvent.fetchProjects(
            searchTerm: 'villa',
            sort: ProjectSort.recent,
          ),
        ),
      ).called(1);
    });

    testWidgets('when a sort is chosen then the list reloads in that order', (
      tester,
    ) async {
      await pumpLive(tester);

      await tester.tap(find.byKey(SortButton.buttonKey));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(SortButton.optionKey(2)));
      await tester.pumpAndSettle();
      await refreshed(tester);

      verify(
        () => bloc.add(
          const ProjectListEvent.fetchProjects(sort: ProjectSort.progress),
        ),
      ).called(1);
    });

    testWidgets('when nothing matches then Clear filters starts over', (
      tester,
    ) async {
      await pumpLive(tester);
      await tester.tap(
        find.byKey(FilterChips.chipKey(ProjectListPage.statusChipsPrefix, 4)),
      );
      await tester.pump();
      await refreshed(tester);
      states.add(loaded(const []));
      await tester.pump();
      await tester.pump();

      expect(find.text(l10n.noMatches), findsOneWidget);
      expect(find.text(l10n.projectsEmpty), findsNothing);

      clearInteractions(bloc);
      await tester.tap(find.text(l10n.clearFilters));
      await tester.pump();
      await refreshed(tester);
      verify(
        () => bloc.add(
          const ProjectListEvent.fetchProjects(sort: ProjectSort.recent),
        ),
      ).called(1);
    });
  });
}
