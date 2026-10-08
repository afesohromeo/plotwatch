import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockStageFormBloc extends MockBloc<StageFormEvent, StageFormState>
    implements StageFormBloc {}

// Plan: doc/04c-m3-stages.md, group D (decisions M3-4, M3-5): the form
// checks what the server checks, and existing checklist items keep their
// IDs.
void main() {
  late AppLocalizations l10n;
  late MockStageFormBloc bloc;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const StageFormEvent.resetFlowStep());
  });
  setUp(() => bloc = MockStageFormBloc());

  Future<void> pumpWith(
    WidgetTester tester,
    StageFormState state, {
    int? stageId,
  }) async {
    when(() => bloc.state).thenReturn(state);
    await tester.pumpApp(
      BlocProvider<StageFormBloc>.value(
        value: bloc,
        child: StageFormPage(projectId: 1, stageId: stageId),
      ),
    );
    await tester.pump();
  }

  final newForm = StageFormState(
    projectId: 1,
    overview: testOverview(),
    loadStatus: GenericStatus.success,
  );
  StageFormState editForm({StageStatus status = StageStatus.notStarted}) =>
      StageFormState(
        projectId: 1,
        stageId: 2,
        overview: testOverview(),
        view: testStageView(id: 2, status: status),
        loadStatus: GenericStatus.success,
      );

  /// The draft the page sent with Save.
  StageDraft sentDraft() =>
      (verify(() => bloc.add(captureAny())).captured.last as dynamic).draft
          as StageDraft;

  Future<void> tapSave(WidgetTester tester) async {
    await tester.ensureVisible(find.byKey(StageFormPage.saveButtonKey));
    await tester.tap(find.byKey(StageFormPage.saveButtonKey));
    await tester.pump();
  }

  testWidgets('Given the page opens for a stage then it loads it', (
    tester,
  ) async {
    await pumpWith(tester, const StageFormState(), stageId: 2);

    verify(
      () => bloc.add(const StageFormEvent.load(projectId: 1, stageId: 2)),
    ).called(1);
  });

  testWidgets('Given a new stage when saved without a name then it asks '
      'for one and sends nothing', (tester) async {
    await pumpWith(tester, newForm);

    await tapSave(tester);

    expect(find.text(l10n.validateStageNameRequired), findsOneWidget);
    verifyNever(
      () => bloc.add(
        any(
          that: isA<StageFormEvent>().having(
            (e) => '$e',
            'event',
            startsWith('StageFormEvent.saveRequested'),
          ),
        ),
      ),
    );
  });

  testWidgets('Given a new stage when filled and saved then the name, the '
      'budget in minor units and the checklist are sent', (tester) async {
    await pumpWith(tester, newForm);

    await tester.enterText(find.byKey(StageFormPage.nameFieldKey), 'Roofing');
    await tester.enterText(
      find.byKey(StageFormPage.budgetFieldKey),
      '1,500,000',
    );
    await tester.ensureVisible(find.byKey(StageFormPage.addItemButtonKey));
    await tester.tap(find.byKey(StageFormPage.addItemButtonKey));
    await tester.pump();
    await tester.enterText(
      find.byKey(StageFormPage.itemFieldKey(0)),
      'Roof structure',
    );
    await tapSave(tester);

    final draft = sentDraft();
    expect(draft.name, 'Roofing');
    expect(draft.budgetMinor, 1500000);
    expect(draft.items.map((i) => (i.itemId, i.label, i.isRequired)), [
      (null, 'Roof structure', true),
    ]);
  });

  testWidgets('Given an existing stage then its values are filled in and '
      'its items keep their IDs when saved', (tester) async {
    await pumpWith(tester, editForm(), stageId: 2);

    expect(find.text('Foundation'), findsOneWidget);
    expect(find.text('Wide shot'), findsOneWidget);
    await tapSave(tester);

    expect(sentDraft().items.map((i) => (i.itemId, i.label, i.isRequired)), [
      (20, 'Wide shot', true),
      (21, 'Detail', false),
    ]);
  });

  testWidgets('Given an existing stage when an item is removed then it is '
      'left out', (tester) async {
    await pumpWith(tester, editForm(), stageId: 2);

    await tester.ensureVisible(find.byKey(StageFormPage.itemRemoveKey(1)));
    await tester.tap(find.byKey(StageFormPage.itemRemoveKey(1)));
    await tester.pump();
    await tapSave(tester);

    expect(sentDraft().items.map((i) => i.itemId), [20]);
  });

  testWidgets('Given an existing stage when an item is moved up then the '
      'order changes', (tester) async {
    await pumpWith(tester, editForm(), stageId: 2);

    await tester.ensureVisible(find.byKey(StageFormPage.itemUpKey(1)));
    await tester.tap(find.byKey(StageFormPage.itemUpKey(1)));
    await tester.pump();
    await tapSave(tester);

    expect(sentDraft().items.map((i) => i.label), ['Detail', 'Wide shot']);
  });

  testWidgets('Given an item when its label is emptied then it asks for one', (
    tester,
  ) async {
    await pumpWith(tester, editForm(), stageId: 2);

    await tester.enterText(find.byKey(StageFormPage.itemFieldKey(0)), ' ');
    await tapSave(tester);

    expect(find.text(l10n.validateChecklistLabelRequired), findsOneWidget);
  });

  testWidgets('Given a submitted stage then it can no longer be edited', (
    tester,
  ) async {
    await pumpWith(tester, editForm(status: StageStatus.submitted), stageId: 2);

    expect(find.text(l10n.errorStageLocked), findsOneWidget);
    expect(find.byKey(StageFormPage.saveButtonKey), findsNothing);
  });
}
