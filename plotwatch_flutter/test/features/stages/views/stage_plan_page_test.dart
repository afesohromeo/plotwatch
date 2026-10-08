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
    expect(find.text(l10n.progressPercent(25)), findsOneWidget);
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
        .widget<ReorderableListView>(find.byType(ReorderableListView))
        .onReorderItem!(0, 1);
    await tester.pump();

    verify(
      () => bloc.add(
        const StagePlanEvent.reorderRequested(oldIndex: 0, newIndex: 1),
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
}
