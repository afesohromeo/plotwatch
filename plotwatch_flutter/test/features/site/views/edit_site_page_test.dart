import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockEditSiteBloc extends MockBloc<EditSiteEvent, EditSiteState>
    implements EditSiteBloc {}

// Plan: doc/04b-m2-projects-site-members.md, group H (H-3).
void main() {
  late AppLocalizations l10n;
  late MockEditSiteBloc bloc;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const EditSiteEvent.load(projectId: 1));
  });
  setUp(() => bloc = MockEditSiteBloc());

  const mapKey = Key('test.map');

  Future<void> pumpWith(WidgetTester tester, EditSiteState state) {
    when(() => bloc.state).thenReturn(state);
    return tester.pumpApp(
      BlocProvider<EditSiteBloc>.value(
        value: bloc,
        child: EditSitePage(
          projectId: 1,
          // The Google map can't render in widget tests (G-8).
          mapBuilder: (lat, lng, radiusM) => const SizedBox(key: mapKey),
        ),
      ),
    );
  }

  final loaded = EditSiteState(
    projectId: 1,
    site: testSite().copyWith(radiusM: 60, addressText: 'Gate'),
    radiusM: 60,
    loadStatus: GenericStatus.success,
  );

  testWidgets('Given the page opens then it loads that project\'s site', (
    tester,
  ) async {
    await pumpWith(tester, const EditSiteState());

    verify(() => bloc.add(const EditSiteEvent.load(projectId: 1))).called(1);
  });

  testWidgets(
    'Given the site is loaded then the map, the radius and the address are '
    'shown',
    (tester) async {
      await pumpWith(tester, loaded);
      await tester.pump();

      expect(find.byKey(mapKey), findsOneWidget);
      expect(find.text(l10n.radiusMeters(60)), findsOneWidget);
      expect(find.text('Gate'), findsOneWidget);
    },
  );

  testWidgets('Given a new address when Save is tapped then it is sent', (
    tester,
  ) async {
    await pumpWith(tester, loaded);
    await tester.pump();

    await tester.enterText(find.byKey(EditSitePage.addressFieldKey), 'Market');
    await tester.ensureVisible(find.byKey(EditSitePage.saveButtonKey));
    await tester.tap(find.byKey(EditSitePage.saveButtonKey));
    await tester.pump();

    verify(
      () => bloc.add(const EditSiteEvent.saveRequested(addressText: 'Market')),
    ).called(1);
  });

  testWidgets('Given the address is cleared when Save is tapped then no '
      'address is sent', (tester) async {
    await pumpWith(tester, loaded);
    await tester.pump();

    await tester.enterText(find.byKey(EditSitePage.addressFieldKey), '  ');
    await tester.ensureVisible(find.byKey(EditSitePage.saveButtonKey));
    await tester.tap(find.byKey(EditSitePage.saveButtonKey));
    await tester.pump();

    verify(() => bloc.add(const EditSiteEvent.saveRequested())).called(1);
  });

  testWidgets('Given the radius slider when it is dragged then it is sent', (
    tester,
  ) async {
    await pumpWith(tester, loaded);

    await tester.ensureVisible(find.byKey(EditSitePage.radiusSliderKey));
    await tester.drag(
      find.byKey(EditSitePage.radiusSliderKey),
      const Offset(150, 0),
    );
    await tester.pump();

    final events = verify(() => bloc.add(captureAny())).captured;
    expect(
      events.map((e) => '$e'),
      contains(startsWith('EditSiteEvent.radiusChanged')),
    );
  });

  testWidgets('Given there is no site then the error is shown', (tester) async {
    await pumpWith(
      tester,
      EditSiteState(
        projectId: 1,
        loadStatus: GenericStatus.failure,
        loadErrorMessage: l10n.errorSiteNotFound,
      ),
    );

    expect(find.text(l10n.errorSiteNotFound), findsOneWidget);
    expect(find.byKey(EditSitePage.saveButtonKey), findsNothing);
  });
}
