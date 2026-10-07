import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockJoinProjectBloc extends MockBloc<JoinProjectEvent, JoinProjectState>
    implements JoinProjectBloc {}

// Plan: doc/04b-m2-projects-site-members.md, group F (MEMB-03, AC-2).
void main() {
  late AppLocalizations l10n;
  late MockJoinProjectBloc bloc;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const JoinProjectEvent.resetFlowStep());
  });
  setUp(() => bloc = MockJoinProjectBloc());

  Future<void> pumpWith(
    WidgetTester tester,
    JoinProjectState state, {
    String? initialCode,
  }) {
    when(() => bloc.state).thenReturn(state);
    return tester.pumpApp(
      BlocProvider<JoinProjectBloc>.value(
        value: bloc,
        child: JoinProjectPage(initialCode: initialCode),
      ),
    );
  }

  testWidgets('Given a typed code when it is checked then it is sent trimmed', (
    tester,
  ) async {
    await pumpWith(tester, const JoinProjectState());

    await tester.enterText(
      find.byKey(JoinProjectPage.codeFieldKey),
      ' abcd-2345 ',
    );
    await tester.tap(find.byKey(JoinProjectPage.checkButtonKey));
    await tester.pump();

    verify(
      () =>
          bloc.add(const JoinProjectEvent.previewRequested(code: 'abcd-2345')),
    ).called(1);
  });

  testWidgets('Given no code when it is checked then it asks for one', (
    tester,
  ) async {
    await pumpWith(tester, const JoinProjectState());

    await tester.tap(find.byKey(JoinProjectPage.checkButtonKey));
    await tester.pump();

    expect(find.text(l10n.validateInvitationCodeRequired), findsOneWidget);
    verifyNever(() => bloc.add(any()));
  });

  testWidgets('Given an invitation link then its code is checked at once', (
    tester,
  ) async {
    await pumpWith(tester, const JoinProjectState(), initialCode: 'ABCD2345');

    verify(
      () => bloc.add(const JoinProjectEvent.previewRequested(code: 'ABCD2345')),
    ).called(1);
  });

  testWidgets(
    'Given a checked code then the project, role and inviter are shown and '
    'Join sends the request',
    (tester) async {
      await pumpWith(
        tester,
        JoinProjectState(
          code: 'ABCD2345',
          previewStatus: GenericStatus.success,
          preview: testPreview,
        ),
      );

      expect(find.text('House in Bafoussam'), findsOneWidget);
      expect(find.text(l10n.projectRoleSiteManager), findsOneWidget);
      expect(find.text(l10n.invitedBy('Ada Lovelace')), findsOneWidget);

      await tester.ensureVisible(find.byKey(JoinProjectPage.joinButtonKey));
      await tester.tap(find.byKey(JoinProjectPage.joinButtonKey));
      await tester.pump();

      verify(() => bloc.add(const JoinProjectEvent.joinRequested())).called(1);
    },
  );

  testWidgets(
    'Given a checked code when the field is edited then the page reports it, '
    'so the preview and Join disappear',
    (tester) async {
      await pumpWith(
        tester,
        JoinProjectState(
          code: 'ABCD2345',
          previewStatus: GenericStatus.success,
          preview: testPreview,
        ),
        initialCode: 'ABCD2345',
      );
      clearInteractions(bloc);

      await tester.enterText(
        find.byKey(JoinProjectPage.codeFieldKey),
        'ABCD2346',
      );
      await tester.pump();

      verify(
        () => bloc.add(const JoinProjectEvent.codeEdited(code: 'ABCD2346')),
      ).called(1);
    },
  );

  testWidgets('Given a code that failed the check then the reason is shown', (
    tester,
  ) async {
    await pumpWith(
      tester,
      JoinProjectState(
        code: 'ABCD2345',
        previewStatus: GenericStatus.failure,
        previewErrorMessage: l10n.errorInvitationExpired,
      ),
    );

    expect(find.text(l10n.errorInvitationExpired), findsOneWidget);
  });
}
