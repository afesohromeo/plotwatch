import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockStagePlanBloc extends MockBloc<StagePlanEvent, StagePlanState>
    implements StagePlanBloc {}

// Plan: doc/04c-m3-stages.md, group C (decision M3-11).
void main() {
  late AppLocalizations l10n;
  late MockStagePlanBloc bloc;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const StagePlanEvent.resetFlowStep());
  });
  setUp(() => bloc = MockStagePlanBloc());

  Future<void> pumpWith(WidgetTester tester, StagePlanState state) {
    when(() => bloc.state).thenReturn(state);
    return tester.pumpApp(
      BlocProvider<StagePlanBloc>.value(
        value: bloc,
        child: const StagePlanPage(projectId: 1),
      ),
    );
  }

  StagePlanState loaded({
    ProjectRole role = ProjectRole.owner,
    StagePlan? plan,
  }) => StagePlanState(
    projectId: 1,
    overview: testOverview(role: role),
    plan: plan ?? testStagePlan(progressPercent: 25),
    loadStatus: GenericStatus.success,
  );

  testWidgets('Given the page opens then it loads that project\'s plan', (
    tester,
  ) async {
    await pumpWith(tester, const StagePlanState());

    verify(() => bloc.add(const StagePlanEvent.load(projectId: 1))).called(1);
  });

  testWidgets('Given a plan then the stages, the total budget and the '
      'progress are shown', (tester) async {
    await pumpWith(tester, loaded());

    expect(find.text('Foundation'), findsOneWidget);
    expect(find.text('Walls'), findsOneWidget);
    expect(
      find.text(formatMoney(2000000, 'XAF', locale: 'en')),
      findsOneWidget,
    );
    // doc/04e M5-F2: neither fixture stage is approved yet.
    expect(find.text(l10n.progressBudgetAndStages(25, 0, 2)), findsOneWidget);
  });

  testWidgets('Given the owner then stages can be added and dragged', (
    tester,
  ) async {
    await pumpWith(tester, loaded());

    expect(find.byKey(StagePlanPage.addStageButtonKey), findsOneWidget);
    expect(find.byKey(StagePlanPage.dragHandleKey(1)), findsOneWidget);
  });

  for (final role in [
    ProjectRole.siteManager,
    ProjectRole.coFunder,
    ProjectRole.viewer,
  ]) {
    testWidgets('Given a ${role.name} then the plan is read-only', (
      tester,
    ) async {
      await pumpWith(tester, loaded(role: role));

      expect(find.text('Foundation'), findsOneWidget);
      expect(find.byKey(StagePlanPage.addStageButtonKey), findsNothing);
      expect(find.byKey(StagePlanPage.dragHandleKey(1)), findsNothing);
    });
  }

  testWidgets('Given the owner when a stage is dropped elsewhere then the '
      'move is sent', (tester) async {
    await pumpWith(tester, loaded());

    tester
        .widget<SliverReorderableList>(find.byType(SliverReorderableList))
        .onReorderItem!(0, 1);
    await tester.pump();

    verify(
      () => bloc.add(
        const StagePlanEvent.reorderRequested(oldIndex: 0, newIndex: 1),
      ),
    ).called(1);
  });

  // doc/04c M3-F3: dragging a stage had to stop at the screen edge, because
  // the page didn't scroll during the drag.
  testWidgets('Given 20 stages on a small screen when the last is dragged '
      'to the top then the page scrolls with it and the move is sent', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 700);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final stages = [
      for (var i = 1; i <= 20; i++)
        testStageView(id: i, name: 'Stage $i', orderIndex: i - 1),
    ];
    await pumpWith(tester, loaded(plan: testStagePlan(stages: stages)));
    final page = find.byType(Scrollable).first;
    final handle = find.byKey(StagePlanPage.dragHandleKey(20));
    await tester.scrollUntilVisible(handle, 300, scrollable: page);
    final position = tester.state<ScrollableState>(page).position;
    expect(position.pixels, greaterThan(0));

    final start = tester.getCenter(handle);
    final gesture = await tester.startGesture(start);
    await gesture.moveBy(const Offset(0, -20));
    await tester.pump();
    // Hold the stage at the top edge: the page scrolls up under it.
    await gesture.moveTo(Offset(start.dx, 20));
    for (var i = 0; i < 100 && position.pixels > 0; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    expect(position.pixels, 0);
    await gesture.up();
    await tester.pumpAndSettle();

    verify(
      () => bloc.add(
        const StagePlanEvent.reorderRequested(oldIndex: 19, newIndex: 0),
      ),
    ).called(1);
  });

  group('Given an empty plan', () {
    final empty = testStagePlan(stages: []);

    testWidgets('when the owner picks a template then it is applied', (
      tester,
    ) async {
      await pumpWith(tester, loaded(plan: empty));

      await tester.tap(
        find.byKey(StagePlanPage.templateButtonKey(StageTemplate.renovation)),
      );
      await tester.pump();

      verify(
        () => bloc.add(
          const StagePlanEvent.templateApplied(
            template: StageTemplate.renovation,
          ),
        ),
      ).called(1);
    });

    testWidgets('then a viewer is told there are no stages yet', (
      tester,
    ) async {
      await pumpWith(tester, loaded(role: ProjectRole.viewer, plan: empty));

      expect(find.text(l10n.stagesEmpty), findsOneWidget);
      expect(
        find.byKey(
          StagePlanPage.templateButtonKey(StageTemplate.singleStoreyHouse),
        ),
        findsNothing,
      );
    });
  });

  testWidgets('Given the plan failed to load then the error is shown', (
    tester,
  ) async {
    await pumpWith(
      tester,
      StagePlanState(
        projectId: 1,
        loadStatus: GenericStatus.failure,
        loadErrorMessage: l10n.networkError,
      ),
    );

    expect(find.text(l10n.networkError), findsOneWidget);
  });

  // doc/04e M5-10 (STG-10).
  testWidgets('Given a stage past its planned end and not approved then its '
      'tile is marked late, and an approved one is not', (tester) async {
    final overdue = testStageView(id: 1, status: StageStatus.inProgress);
    final done = testStageView(
      id: 2,
      name: 'Walls',
      status: StageStatus.approved,
    );
    await pumpWith(
      tester,
      loaded(
        plan: testStagePlan(
          stages: [
            overdue.copyWith(
              stage: overdue.stage.copyWith(
                plannedEnd: DateTime.utc(2020, 1, 1),
              ),
            ),
            done.copyWith(
              stage: done.stage.copyWith(plannedEnd: DateTime.utc(2020, 1, 1)),
            ),
          ],
        ),
      ),
    );

    expect(find.text(l10n.stageLate), findsOneWidget);
  });

  // doc/05 §9 DP-9: the stage that waits for the owner stands out.
  testWidgets('Given a submitted stage then the owner sees it waiting for '
      'their review', (tester) async {
    await pumpWith(
      tester,
      loaded(
        plan: testStagePlan(
          stages: [testStageView(id: 1, status: StageStatus.submitted)],
        ),
      ),
    );

    expect(find.text(l10n.waitingForYourReview), findsOneWidget);
  });

  // doc/05 §9.5: chips filter the loaded plan; each stage keeps its number.
  group('Given the Stages chips', () {
    final plan = testStagePlan(
      stages: [
        testStageView(id: 1, name: 'Foundation', status: StageStatus.approved),
        testStageView(
          id: 2,
          name: 'Walls',
          orderIndex: 1,
          status: StageStatus.submitted,
        ),
        testStageView(
          id: 3,
          name: 'Roof',
          orderIndex: 2,
          status: StageStatus.changesRequested,
        ),
        testStageView(id: 4, name: 'Plaster', orderIndex: 3),
      ],
    );

    Future<void> choose(WidgetTester tester, StagePlanFilter filter) async {
      await tester.tap(
        find.byKey(
          FilterChips.chipKey(
            StagePlanPage.filterChipsPrefix,
            StagePlanFilter.values.indexOf(filter),
          ),
        ),
      );
      await tester.pump();
    }

    testWidgets('when Approved is chosen then only approved stages show, '
        'and none can be dragged', (tester) async {
      await pumpWith(tester, loaded(plan: plan));

      await choose(tester, StagePlanFilter.approved);

      expect(find.byKey(StagePlanPage.stageTileKey(1)), findsOneWidget);
      expect(find.byKey(StagePlanPage.stageTileKey(2)), findsNothing);
      expect(find.byKey(StagePlanPage.dragHandleKey(1)), findsNothing);
    });

    testWidgets('when In progress is chosen then a stage with changes '
        'requested shows, with its number in the plan', (tester) async {
      await pumpWith(tester, loaded(plan: plan));

      await choose(tester, StagePlanFilter.inProgress);

      expect(find.byKey(StagePlanPage.stageTileKey(3)), findsOneWidget);
      expect(find.byKey(StagePlanPage.stageTileKey(4)), findsNothing);
      expect(find.textContaining('3 · Roof'), findsOneWidget);
    });

    testWidgets('when Needs you is chosen then the owner sees the stage to '
        'review', (tester) async {
      await pumpWith(tester, loaded(plan: plan));

      await choose(tester, StagePlanFilter.needsYou);

      expect(find.byKey(StagePlanPage.stageTileKey(2)), findsOneWidget);
      expect(find.byKey(StagePlanPage.stageTileKey(1)), findsNothing);
    });

    testWidgets('when no stage fits then it says so', (tester) async {
      await pumpWith(tester, loaded(plan: plan));

      await choose(tester, StagePlanFilter.late);

      expect(find.text(l10n.noStageHere), findsOneWidget);
    });
  });
}
