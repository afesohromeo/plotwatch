import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockLocalizeSiteBloc
    extends MockBloc<LocalizeSiteEvent, LocalizeSiteState>
    implements LocalizeSiteBloc {}

// Plan: doc/04b-m2-projects-site-members.md, group G (G-4, G-5).
void main() {
  late AppLocalizations l10n;
  late MockLocalizeSiteBloc bloc;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const LocalizeSiteEvent.resetFlowStep());
  });
  setUp(() => bloc = MockLocalizeSiteBloc());

  Future<void> pumpWith(
    WidgetTester tester,
    LocalizeSiteState state, {
    bool isWeb = false,
  }) {
    when(() => bloc.state).thenReturn(state);
    return tester.pumpApp(
      BlocProvider<LocalizeSiteBloc>.value(
        value: bloc,
        child: LocalizeSitePage(projectId: 1, isWeb: isWeb),
      ),
    );
  }

  const granted = LocalizeSiteState(
    myRole: ProjectRole.siteManager,
    access: LocationAccess.granted,
  );

  FilledButton saveButton(WidgetTester tester) => tester.widget<FilledButton>(
    find.descendant(
      of: find.byKey(LocalizeSitePage.saveButtonKey),
      matching: find.byType(FilledButton),
    ),
  );

  testWidgets('Given the web app then it says to use the phone and asks for '
      'no location', (tester) async {
    await pumpWith(tester, const LocalizeSiteState(), isWeb: true);

    expect(find.text(l10n.localizePhoneOnly), findsOneWidget);
    verifyNever(() => bloc.add(any()));
  });

  testWidgets('Given the phone app then it starts reading the position', (
    tester,
  ) async {
    await pumpWith(tester, const LocalizeSiteState());

    verify(
      () => bloc.add(const LocalizeSiteEvent.started(projectId: 1)),
    ).called(1);
    expect(find.text(l10n.gettingPosition), findsOneWidget);
  });

  testWidgets('Given location was refused then Allow asks again', (
    tester,
  ) async {
    await pumpWith(
      tester,
      const LocalizeSiteState(access: LocationAccess.denied),
    );

    await tester.tap(find.byKey(LocalizeSitePage.allowButtonKey));
    await tester.pump();

    verify(
      () => bloc.add(const LocalizeSiteEvent.started(projectId: 1)),
    ).called(2);
  });

  for (final access in [
    LocationAccess.deniedForever,
    LocationAccess.serviceDisabled,
  ]) {
    testWidgets('Given location is ${access.name} then a button opens the '
        'settings', (tester) async {
      await pumpWith(tester, LocalizeSiteState(access: access));

      await tester.tap(find.byKey(LocalizeSitePage.settingsButtonKey));
      await tester.pump();

      verify(
        () => bloc.add(const LocalizeSiteEvent.settingsRequested()),
      ).called(1);
    });
  }

  testWidgets(
    'Given an accurate reading then the accuracy shows and Save sends it',
    (tester) async {
      await pumpWith(
        tester,
        granted.copyWith(reading: testReading(accuracyM: 8)),
      );

      expect(find.text(l10n.accuracyMeters(8)), findsOneWidget);
      expect(find.text(l10n.accuracyGood), findsOneWidget);
      await tester.ensureVisible(find.byKey(LocalizeSitePage.saveButtonKey));
      await tester.tap(find.byKey(LocalizeSitePage.saveButtonKey));
      await tester.pump();

      verify(
        () => bloc.add(const LocalizeSiteEvent.proposeRequested(projectId: 1)),
      ).called(1);
    },
  );

  testWidgets('Given a reading worse than 20 m then Save is disabled', (
    tester,
  ) async {
    await pumpWith(
      tester,
      granted.copyWith(reading: testReading(accuracyM: 35)),
    );

    expect(find.text(l10n.accuracyWaiting), findsOneWidget);
    expect(saveButton(tester).onPressed, isNull);
  });

  testWidgets('Given a mocked position then it says so and Save is disabled', (
    tester,
  ) async {
    await pumpWith(
      tester,
      granted.copyWith(reading: testReading(isMocked: true)),
    );

    expect(find.text(l10n.errorSiteMockLocation), findsOneWidget);
    expect(saveButton(tester).onPressed, isNull);
  });
}
