import 'package:bloc_test/bloc_test.dart';
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

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const ProjectListEvent.refreshProjects());
  });

  setUp(() {
    bloc = MockProjectListBloc();
    authBloc = MockAuthenticationBloc();
    when(() => authBloc.state).thenReturn(
        const AuthenticationState(status: AuthenticationStatus.authenticated));
  });

  Future<void> pumpPage(WidgetTester tester, List<ProjectListState> states) {
    whenListen(bloc, Stream.fromIterable(states),
        initialState: const ProjectListState());
    return tester.pumpApp(MultiBlocProvider(
      providers: [
        BlocProvider<ProjectListBloc>.value(value: bloc),
        BlocProvider<AuthenticationBloc>.value(value: authBloc),
      ],
      child: const ProjectListPage(),
    ));
  }

  ProjectListState loaded(List<ProjectSummary> items) => ProjectListState(
        projectsListStatus: GenericStatus.success,
        projects: items,
        paginatedProjects: items,
        maxProjects: true,
      );

  testWidgets('Given the project list when it opens then it asks for page 0',
      (tester) async {
    await pumpPage(tester, const []);

    verify(() => bloc.add(const ProjectListEvent.fetchProjects())).called(1);
  });

  testWidgets(
      'Given the user\'s projects then each shows its name, the user\'s role '
      'and the status', (tester) async {
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
    expect(find.text(l10n.projectRoleOwner), findsOneWidget);
    expect(find.text(l10n.projectRoleSiteManager), findsOneWidget);
    expect(find.text(l10n.projectStatusDraft), findsOneWidget);
    expect(find.text(l10n.projectStatusActive), findsOneWidget);
  });

  testWidgets('Given no projects then it explains how to start',
      (tester) async {
    await pumpPage(tester, [loaded(const [])]);
    await tester.pump();

    expect(find.text(l10n.projectsEmpty), findsOneWidget);
  });

  testWidgets('Given the list fails to load then it shows the error',
      (tester) async {
    await pumpPage(tester, [
      ProjectListState(
        projectsListStatus: GenericStatus.failure,
        projectsListError: l10n.networkError,
      ),
    ]);
    await tester.pump();

    expect(find.text(l10n.networkError), findsOneWidget);
  });

  testWidgets('Given the project list then it offers to create a project',
      (tester) async {
    await pumpPage(tester, const []);

    expect(find.byKey(ProjectListPage.newProjectButtonKey), findsOneWidget);
  });
}
