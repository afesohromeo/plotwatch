import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
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
    await pumpWith(tester, loaded(isMine: true, role: ProjectRole.siteManager));

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
    await pumpWith(tester, loaded(isMine: true, role: ProjectRole.siteManager));

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

  // M4-F4: a capture that never arrived can be opened and withdrawn.
  testWidgets('Given a capture never received then it says so, shows no '
      'photo, and its author can withdraw it', (tester) async {
    await pumpWith(
      tester,
      loaded(
        isMine: true,
        role: ProjectRole.siteManager,
        evidence: testEvidence(status: EvidenceStatus.committed),
      ),
    );

    expect(find.text(l10n.captureNeverReceived), findsOneWidget);
    expect(find.byType(EvidenceImage), findsNothing);
    expect(find.byKey(EvidencePage.retractButtonKey), findsOneWidget);
  });

  // M4-F5: after withdrawing, back to the stage.
  testWidgets('Given the author withdrew the photo when the confirmation has '
      'closed then the stage page opens', (tester) async {
    final mine = loaded(isMine: true, role: ProjectRole.siteManager);
    when(() => bloc.state).thenReturn(mine);
    whenListen(
      bloc,
      Stream.fromIterable([
        mine.copyWith(actionStatus: GenericStatus.loading),
        mine.copyWith(actionStatus: GenericStatus.success),
      ]),
      initialState: mine,
    );
    final router = GoRouter(
      initialLocation: '/projects/1/stages/1/evidence/9',
      routes: [
        GoRoute(
          name: stageRouteName,
          path: '/projects/:projectId/stages/:stageId',
          builder: (context, state) => const Text('the stage'),
          routes: [
            GoRoute(
              path: 'evidence/:evidenceId',
              builder: (context, state) => BlocProvider<EvidenceMediaBloc>.value(
                value: media,
                child: BlocProvider<EvidenceBloc>.value(
                  value: bloc,
                  child: const EvidencePage(
                    projectId: 1,
                    stageId: 1,
                    evidenceId: 9,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );

    await tester.pumpRouterApp(router);
    await tester.pump();
    // The confirmation closes itself after 3 s (DialogUtils.handleSuccess).
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    expect(find.text('the stage'), findsOneWidget);
  });
}
