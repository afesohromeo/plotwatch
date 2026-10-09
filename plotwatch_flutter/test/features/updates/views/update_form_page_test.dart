import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockUpdateFormBloc extends MockBloc<UpdateFormEvent, UpdateFormState>
    implements UpdateFormBloc {}

// Plan: doc/04e-m5-review-realtime.md, group F (M5-9 b): text required,
// stage, workers, weather and issues optional; the limits mirror the
// server's.
void main() {
  late AppLocalizations l10n;
  late MockUpdateFormBloc bloc;

  final stages = [
    testStage(id: 1, name: 'Foundation', status: StageStatus.approved),
    testStage(id: 2, name: 'Walls', status: StageStatus.inProgress),
  ];

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const UpdateFormEvent.resetFlowStep());
  });
  setUp(() => bloc = MockUpdateFormBloc());

  Future<void> pumpForm(WidgetTester tester) async {
    when(() => bloc.state).thenReturn(
      UpdateFormState(
        projectId: 1,
        stages: stages,
        loadStatus: GenericStatus.success,
      ),
    );
    await tester.pumpApp(
      BlocProvider<UpdateFormBloc>.value(
        value: bloc,
        child: const UpdateFormPage(projectId: 1),
      ),
    );
  }

  Future<void> save(WidgetTester tester) async {
    await tester.ensureVisible(find.byKey(UpdateFormPage.saveButtonKey));
    await tester.tap(find.byKey(UpdateFormPage.saveButtonKey));
    await tester.pump();
  }

  testWidgets('Given the form opens then it loads the stages', (tester) async {
    await pumpForm(tester);

    verify(() => bloc.add(const UpdateFormEvent.load(projectId: 1))).called(1);
  });

  testWidgets('Given no text when it is posted then the text is required', (
    tester,
  ) async {
    await pumpForm(tester);

    await save(tester);

    expect(find.text(l10n.validateUpdateTextRequired), findsOneWidget);
    // Only the load: nothing was posted.
    verify(() => bloc.add(any())).called(1);
  });

  testWidgets('Given more than 999 workers then it is refused', (tester) async {
    await pumpForm(tester);

    await tester.enterText(find.byKey(UpdateFormPage.textFieldKey), 'Walls up');
    await tester.enterText(find.byKey(UpdateFormPage.workersFieldKey), '1000');
    await save(tester);

    expect(find.text(l10n.validateWorkersCount), findsOneWidget);
  });

  testWidgets('Given the stage in progress, the workers and the weather when '
      'it is posted then all of it is sent', (tester) async {
    await pumpForm(tester);

    await tester.enterText(
      find.byKey(UpdateFormPage.textFieldKey),
      '  Concrete poured.  ',
    );
    await tester.enterText(find.byKey(UpdateFormPage.workersFieldKey), '6');
    await tester.ensureVisible(
      find.byKey(UpdateFormPage.weatherKey(Weather.rain)),
    );
    await tester.tap(find.byKey(UpdateFormPage.weatherKey(Weather.rain)));
    await tester.pump();
    await save(tester);

    // The only stage in progress is picked by default.
    verify(
      () => bloc.add(
        UpdateFormEvent.saveRequested(
          ProgressUpdateDraft(
            text: 'Concrete poured.',
            stageId: 2,
            workersCount: 6,
            weather: Weather.rain,
          ),
        ),
      ),
    ).called(1);
  });
}
