import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockStageBloc extends MockBloc<StageEvent, StageState>
    implements StageBloc {}

// Plan: doc/04c-m3-stages.md, group D (decisions M3-6, M3-8).
void main() {
  late AppLocalizations l10n;
  late MockStageBloc bloc;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const StageEvent.resetFlowStep());
  });
  setUp(() => bloc = MockStageBloc());

  Future<void> pumpWith(WidgetTester tester, StageState state) {
    when(() => bloc.state).thenReturn(state);
    return tester.pumpApp(
      BlocProvider<StageBloc>.value(
        value: bloc,
        child: const StagePage(projectId: 1, stageId: 2),
      ),
    );
  }

  StageState loaded({
    ProjectRole role = ProjectRole.owner,
    ProjectStatus projectStatus = ProjectStatus.active,
    StageStatus status = StageStatus.notStarted,
  }) => StageState(
    projectId: 1,
    stageId: 2,
    overview: testOverview(
      role: role,
      project: testProject(status: projectStatus),
    ),
    view: testStageView(id: 2, status: status),
    loadStatus: GenericStatus.success,
  );

  testWidgets('Given the page opens then it loads that stage', (tester) async {
    await pumpWith(tester, const StageState());

    verify(
      () => bloc.add(const StageEvent.load(projectId: 1, stageId: 2)),
    ).called(1);
  });

  testWidgets('Given a stage then its details, budget, status and checklist '
      'are shown', (tester) async {
    await pumpWith(tester, loaded(role: ProjectRole.viewer));

    expect(find.text('Foundation'), findsWidgets);
    expect(
      find.text(formatMoney(1500000, 'XAF', locale: 'en')),
      findsOneWidget,
    );
    expect(find.text(l10n.stageStatusNotStarted), findsOneWidget);
    expect(find.text('Wide shot'), findsOneWidget);
    expect(find.text('Detail'), findsOneWidget);
    expect(find.text(l10n.checklistOptional), findsOneWidget);
    expect(find.text(l10n.itemsCovered(0, 2)), findsOneWidget);
  });

  testWidgets('Given the owner and a stage not started then it can be '
      'edited and deleted, not started', (tester) async {
    await pumpWith(tester, loaded());

    expect(find.byKey(StagePage.editButtonKey), findsOneWidget);
    expect(find.byKey(StagePage.deleteButtonKey), findsOneWidget);
    expect(find.byKey(StagePage.startButtonKey), findsNothing);
  });

  testWidgets('Given the owner and a submitted stage then it is locked', (
    tester,
  ) async {
    await pumpWith(tester, loaded(status: StageStatus.submitted));

    expect(find.byKey(StagePage.editButtonKey), findsNothing);
    expect(find.byKey(StagePage.deleteButtonKey), findsNothing);
  });

  testWidgets('Given the owner deletes when they confirm then it is sent', (
    tester,
  ) async {
    await pumpWith(tester, loaded());

    await tester.tap(find.byKey(StagePage.deleteButtonKey));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.confirm));
    await tester.pump();

    verify(() => bloc.add(const StageEvent.deleteRequested())).called(1);
  });

  testWidgets('Given the site manager on an active project when Start is '
      'tapped then it is sent', (tester) async {
    await pumpWith(tester, loaded(role: ProjectRole.siteManager));

    expect(find.byKey(StagePage.editButtonKey), findsNothing);
    await tester.ensureVisible(find.byKey(StagePage.startButtonKey));
    await tester.tap(find.byKey(StagePage.startButtonKey));
    await tester.pump();

    verify(() => bloc.add(const StageEvent.startRequested())).called(1);
  });

  testWidgets('Given the site manager before the site is validated then it '
      'says why the stage can\'t start yet', (tester) async {
    await pumpWith(
      tester,
      loaded(role: ProjectRole.siteManager, projectStatus: ProjectStatus.draft),
    );

    expect(find.byKey(StagePage.startButtonKey), findsNothing);
    expect(find.text(l10n.stageStartNeedsSite), findsOneWidget);
  });

  // doc/04c M3-F1: the app stayed on the deleted stage.
  testWidgets('Given the owner when the delete succeeds then the stage plan '
      'opens', (tester) async {
    final owner = loaded();
    final deleting = owner.copyWith(
      flowStep: GenericFlowStep.deletingItem,
      actionStatus: GenericStatus.loading,
    );
    when(() => bloc.state).thenReturn(owner);
    whenListen(
      bloc,
      Stream.fromIterable([
        deleting,
        deleting.copyWith(actionStatus: GenericStatus.success),
      ]),
      initialState: owner,
    );
    final router = GoRouter(
      initialLocation: '/projects/1/stages/2',
      routes: [
        GoRoute(
          name: stagesRouteName,
          path: '/projects/:projectId/stages',
          builder: (context, state) => const Text('the plan'),
          routes: [
            GoRoute(
              path: ':stageId',
              builder: (context, state) => BlocProvider<StageBloc>.value(
                value: bloc,
                child: const StagePage(projectId: 1, stageId: 2),
              ),
            ),
          ],
        ),
      ],
    );

    await tester.pumpRouterApp(router);
    await tester.pumpAndSettle();

    expect(find.text('the plan'), findsOneWidget);
    expect(router.routerDelegate.currentConfiguration.uri.path, '/projects/1/stages');
  });
}
