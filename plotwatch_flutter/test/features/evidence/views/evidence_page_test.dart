import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockEvidenceBloc extends MockBloc<EvidenceEvent, EvidenceState>
    implements EvidenceBloc {}

class MockEvidenceMediaBloc
    extends MockBloc<EvidenceMediaEvent, EvidenceMediaState>
    implements EvidenceMediaBloc {}

// Plan: doc/04d-m4-capture.md, group D (VER-03, VER-10, decision M4-11).
void main() {
  late AppLocalizations l10n;
  late MockEvidenceBloc bloc;
  late MockEvidenceMediaBloc media;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const EvidenceEvent.resetFlowStep());
  });
  setUp(() {
    bloc = MockEvidenceBloc();
    media = MockEvidenceMediaBloc();
    when(() => media.state).thenReturn(const EvidenceMediaState());
  });

  Future<void> pumpWith(WidgetTester tester, EvidenceState state) {
    when(() => bloc.state).thenReturn(state);
    return tester.pumpApp(
      BlocProvider<EvidenceMediaBloc>.value(
        value: media,
        child: BlocProvider<EvidenceBloc>.value(
          value: bloc,
          child: const EvidencePage(projectId: 1, stageId: 1, evidenceId: 9),
        ),
      ),
    );
  }

  EvidenceState loaded({
    Evidence? evidence,
    bool isMine = false,
    ProjectRole role = ProjectRole.coFunder,
  }) => EvidenceState(
    projectId: 1,
    stageId: 1,
    evidenceId: 9,
    overview: testOverview(role: role),
    evidence: evidence ?? testEvidence(level: VerificationLevel.unverified),
    isMine: isMine,
    loadStatus: GenericStatus.success,
  );

  testWidgets('Given the page opens then it loads that capture', (
    tester,
  ) async {
    await pumpWith(tester, const EvidenceState());

    verify(
      () => bloc.add(
        const EvidenceEvent.load(projectId: 1, stageId: 1, evidenceId: 9),
      ),
    ).called(1);
  });

  testWidgets('Given a capture then the badge, each check, the details and '
      'the "where and when, not quality" notice are shown', (tester) async {
    await pumpWith(tester, loaded());

    expect(find.text(l10n.verificationUnverified), findsOneWidget);
    expect(find.text(l10n.checkInsideSiteFailed(137, 58)), findsOneWidget);
    expect(find.text('Pixel 7 · Android 15'), findsOneWidget);
    expect(find.text(l10n.verificationNotice), findsOneWidget);
  });

  testWidgets('Given someone else\'s capture then it can\'t be retracted', (
    tester,
  ) async {
    await pumpWith(tester, loaded());

    expect(find.byKey(EvidencePage.retractButtonKey), findsNothing);
  });

  testWidgets('Given the author when they retract with a reason then it is '
      'sent', (tester) async {
    await pumpWith(
      tester,
      loaded(isMine: true, role: ProjectRole.siteManager),
    );

    await tester.ensureVisible(find.byKey(EvidencePage.retractButtonKey));
    await tester.tap(find.byKey(EvidencePage.retractButtonKey));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(EvidencePage.retractReasonFieldKey),
      'Blurred',
    );
    await tester.tap(find.text(l10n.confirm));
    await tester.pumpAndSettle();

    verify(
      () => bloc.add(const EvidenceEvent.retractRequested(reason: 'Blurred')),
    ).called(1);
  });

  testWidgets('Given the author when the reason is left empty then nothing '
      'is sent', (tester) async {
    await pumpWith(
      tester,
      loaded(isMine: true, role: ProjectRole.siteManager),
    );

    await tester.ensureVisible(find.byKey(EvidencePage.retractButtonKey));
    await tester.tap(find.byKey(EvidencePage.retractButtonKey));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.confirm));
    await tester.pumpAndSettle();

    expect(find.text(l10n.validateRetractReasonRequired), findsOneWidget);
    verifyNever(
      () => bloc.add(
        any(
          that: isA<EvidenceEvent>().having(
            (e) => '$e',
            'event',
            startsWith('EvidenceEvent.retractRequested'),
          ),
        ),
      ),
    );
  });

  testWidgets('Given a retracted capture then its reason is shown and it '
      'can\'t be retracted again', (tester) async {
    await pumpWith(
      tester,
      loaded(
        isMine: true,
        role: ProjectRole.siteManager,
        evidence: testEvidence(
          status: EvidenceStatus.retracted,
          retractedReason: 'Blurred',
        ),
      ),
    );

    expect(find.text(l10n.captureRetractedReason('Blurred')), findsOneWidget);
    expect(find.byKey(EvidencePage.retractButtonKey), findsNothing);
  });
}
