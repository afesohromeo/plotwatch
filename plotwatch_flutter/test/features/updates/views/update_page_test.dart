import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockUpdateBloc extends MockBloc<UpdateEvent, UpdateState>
    implements UpdateBloc {}

// Plan: doc/05-design-system.md §9.6: the update as on the canvas; facts
// only when set; the way back when it is gone.
void main() {
  late AppLocalizations l10n;
  late MockUpdateBloc bloc;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const UpdateEvent.load(projectId: 1, updateId: 4));
  });
  setUp(() => bloc = MockUpdateBloc());

  Future<void> pumpWith(
    WidgetTester tester,
    UpdateState state, {
    Size size = const Size(390, 844),
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    when(() => bloc.state).thenReturn(state);
    await tester.pumpApp(
      BlocProvider<UpdateBloc>.value(
        value: bloc,
        child: const UpdatePage(projectId: 1, updateId: 4),
      ),
    );
  }

  UpdateState loaded(ProgressUpdate update, {String? stageName = 'Walls'}) =>
      UpdateState(
        update: update.copyWith(authorName: 'Bob Mbarga'),
        stageName: stageName,
        loadStatus: GenericStatus.success,
      );

  testWidgets('Given the page opens then it loads that update', (
    tester,
  ) async {
    await pumpWith(tester, const UpdateState());

    verify(
      () => bloc.add(const UpdateEvent.load(projectId: 1, updateId: 4)),
    ).called(1);
  });

  testWidgets('Given an update with everything then the author, the text, '
      'the facts, the issues and the stage link show', (tester) async {
    await pumpWith(tester, loaded(testUpdate()));

    expect(find.text('Bob Mbarga'), findsOneWidget);
    expect(find.text('Concrete poured on the east side.'), findsOneWidget);
    expect(find.byKey(UpdatePage.stageTileKey), findsOneWidget);
    expect(find.text('6'), findsOneWidget);
    expect(find.text(l10n.weatherSunny), findsOneWidget);
    expect(find.text(l10n.updateIssuesTitle), findsOneWidget);
    expect(find.text('Cement delivery late.'), findsOneWidget);
    expect(find.text(l10n.openStageTitle('Walls')), findsOneWidget);
  });

  testWidgets('Given an update with only its text then no fact, issue or '
      'stage link shows', (tester) async {
    final bare = ProgressUpdate(
      id: 4,
      projectId: 1,
      authorId: UuidValue.fromString(testManagerId),
      text: 'Quiet day.',
      createdAt: DateTime.utc(2026, 10, 9, 16),
    );
    await pumpWith(tester, loaded(bare, stageName: null));

    expect(find.text('Quiet day.'), findsOneWidget);
    expect(find.byKey(UpdatePage.stageTileKey), findsNothing);
    expect(find.text(l10n.labelWorkersCount), findsNothing);
    expect(find.text(l10n.labelWeather), findsNothing);
    expect(find.text(l10n.updateIssuesTitle), findsNothing);
    expect(find.byKey(UpdatePage.stageLinkKey), findsNothing);
  });

  testWidgets('Given a wide screen then the facts are rows of a side card', (
    tester,
  ) async {
    await pumpWith(tester, loaded(testUpdate()), size: const Size(1440, 900));

    expect(find.text(l10n.updateOnSite), findsOneWidget);
    expect(find.text(l10n.labelPosted), findsOneWidget);
    expect(find.byKey(UpdatePage.stageTileKey), findsNothing);
  });

  testWidgets('Given the update is gone then it says so and offers the way '
      'back, not Retry', (tester) async {
    await pumpWith(
      tester,
      UpdateState(
        loadStatus: GenericStatus.failure,
        loadErrorMessage: AppErrorCode.updateNotFound.message(l10n),
        notFound: true,
      ),
    );

    expect(find.text(l10n.updateGone), findsOneWidget);
    expect(find.byKey(UpdatePage.backToActivityKey), findsOneWidget);
    expect(find.text(l10n.refresh), findsNothing);
  });

  testWidgets('Given it failed to load then the error has Retry', (
    tester,
  ) async {
    await pumpWith(
      tester,
      UpdateState(
        loadStatus: GenericStatus.failure,
        loadErrorMessage: l10n.networkError,
      ),
    );

    expect(find.text(l10n.networkError), findsOneWidget);
    expect(find.byKey(UpdatePage.backToActivityKey), findsNothing);
  });
}
