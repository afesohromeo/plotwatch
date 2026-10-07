import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockValidateSiteBloc
    extends MockBloc<ValidateSiteEvent, ValidateSiteState>
    implements ValidateSiteBloc {}

// Plan: doc/04b-m2-projects-site-members.md, group G (G-6, G-8).
void main() {
  late AppLocalizations l10n;
  late MockValidateSiteBloc bloc;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const ValidateSiteEvent.resetFlowStep());
  });
  setUp(() => bloc = MockValidateSiteBloc());

  const mapKey = Key('test.map');

  Future<void> pumpWith(WidgetTester tester, ValidateSiteState state) {
    when(() => bloc.state).thenReturn(state);
    return tester.pumpApp(
      BlocProvider<ValidateSiteBloc>.value(
        value: bloc,
        child: ValidateSitePage(
          projectId: 1,
          // The Google map can't render in widget tests (G-8).
          mapBuilder: (lat, lng, radiusM) => const SizedBox(key: mapKey),
        ),
      ),
    );
  }

  final loaded = ValidateSiteState(
    projectId: 1,
    loadStatus: GenericStatus.success,
    proposal: testProposal(accuracyM: 8),
  );

  testWidgets('Given the page opens then it loads that project\'s proposal', (
    tester,
  ) async {
    await pumpWith(tester, const ValidateSiteState());

    verify(
      () => bloc.add(const ValidateSiteEvent.load(projectId: 1)),
    ).called(1);
  });

  testWidgets(
    'Given a pending proposal then the map, its accuracy and the radius '
    'are shown',
    (tester) async {
      await pumpWith(tester, loaded);

      expect(find.byKey(mapKey), findsOneWidget);
      expect(find.text(l10n.accuracyMeters(8)), findsOneWidget);
      expect(find.text(l10n.radiusMeters(50)), findsOneWidget);
    },
  );

  testWidgets('Given nothing is pending then it says so', (tester) async {
    await pumpWith(
      tester,
      const ValidateSiteState(projectId: 1, loadStatus: GenericStatus.success),
    );

    expect(find.text(l10n.noPendingProposal), findsOneWidget);
    expect(find.byKey(ValidateSitePage.validateButtonKey), findsNothing);
  });

  testWidgets('Given the radius slider when it is dragged then it is sent', (
    tester,
  ) async {
    await pumpWith(tester, loaded);

    // Below the 280 px map, outside the 800x600 test screen.
    await tester.ensureVisible(find.byKey(ValidateSitePage.radiusSliderKey));
    await tester.drag(
      find.byKey(ValidateSitePage.radiusSliderKey),
      const Offset(150, 0),
    );
    await tester.pump();

    final events = verify(() => bloc.add(captureAny())).captured;
    expect(
      events.map((e) => '$e'),
      contains(startsWith('ValidateSiteEvent.radiusChanged')),
    );
  });

  testWidgets('Given an address when Validate is tapped then both are sent', (
    tester,
  ) async {
    await pumpWith(tester, loaded);

    await tester.enterText(
      find.byKey(ValidateSitePage.addressFieldKey),
      'Behind the church',
    );
    await tester.ensureVisible(find.byKey(ValidateSitePage.validateButtonKey));
    await tester.tap(find.byKey(ValidateSitePage.validateButtonKey));
    await tester.pump();

    verify(
      () => bloc.add(
        const ValidateSiteEvent.validateRequested(
          addressText: 'Behind the church',
        ),
      ),
    ).called(1);
  });

  testWidgets('Given Reject when a reason is given and confirmed then it is '
      'sent', (tester) async {
    await pumpWith(tester, loaded);

    await tester.ensureVisible(find.byKey(ValidateSitePage.rejectButtonKey));
    await tester.tap(find.byKey(ValidateSitePage.rejectButtonKey));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(ValidateSitePage.rejectReasonFieldKey),
      'Wrong plot',
    );
    await tester.tap(find.text(l10n.confirm));
    await tester.pumpAndSettle();

    verify(
      () => bloc.add(
        const ValidateSiteEvent.rejectRequested(reason: 'Wrong plot'),
      ),
    ).called(1);
  });
}
