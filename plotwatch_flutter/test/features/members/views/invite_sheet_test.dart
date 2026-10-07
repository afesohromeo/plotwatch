import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockInvitationBloc extends MockBloc<InvitationEvent, InvitationState>
    implements InvitationBloc {}

// Plan: doc/04b-m2-projects-site-members.md, group F (MEMB-01; M2-6, M2-7).
void main() {
  late AppLocalizations l10n;
  late MockInvitationBloc bloc;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const InvitationEvent.shareRequested());
  });
  setUp(() => bloc = MockInvitationBloc());

  Future<void> pumpWith(WidgetTester tester, InvitationState state) {
    when(() => bloc.state).thenReturn(state);
    return tester.pumpApp(
      Scaffold(
        body: BlocProvider<InvitationBloc>.value(
          value: bloc,
          child: const InviteSheet(projectId: 1),
        ),
      ),
    );
  }

  testWidgets('Given the sheet when a role is chosen then it is sent', (
    tester,
  ) async {
    await pumpWith(tester, const InvitationState());

    await tester.tap(find.text(l10n.projectRoleCoFunder));
    await tester.pump();

    verify(
      () => bloc.add(
        const InvitationEvent.roleChanged(role: ProjectRole.coFunder),
      ),
    ).called(1);
  });

  testWidgets(
    'Given a site-manager invitation then there is no approval switch '
    '(approval rights are for co-funders only)',
    (tester) async {
      await pumpWith(tester, const InvitationState());

      expect(find.byKey(InviteSheet.canApproveKey), findsNothing);
    },
  );

  testWidgets('Given a co-funder role when the approval switch is turned on '
      'then it is sent', (tester) async {
    await pumpWith(tester, const InvitationState(role: ProjectRole.coFunder));

    await tester.tap(find.byKey(InviteSheet.canApproveKey));
    await tester.pump();

    verify(
      () => bloc.add(const InvitationEvent.canApproveChanged(canApprove: true)),
    ).called(1);
  });

  testWidgets('Given the sheet when Create is tapped then the invitation is '
      'created for that project', (tester) async {
    await pumpWith(tester, const InvitationState());

    await tester.tap(find.byKey(InviteSheet.createButtonKey));
    await tester.pump();

    verify(
      () => bloc.add(const InvitationEvent.createSubmitted(projectId: 1)),
    ).called(1);
  });

  testWidgets('Given a created invitation then its code is shown and it can be '
      'shared', (tester) async {
    await pumpWith(
      tester,
      InvitationState(
        createStatus: GenericStatus.success,
        invitation: testInvitation(code: 'ABCD2345'),
      ),
    );

    expect(find.text('ABCD-2345'), findsOneWidget);
    await tester.tap(find.byKey(InviteSheet.shareButtonKey));
    await tester.pump();

    verify(() => bloc.add(const InvitationEvent.shareRequested())).called(1);
  });

  testWidgets('Given a created invitation when Copy link is tapped then it is '
      'sent', (tester) async {
    await pumpWith(
      tester,
      InvitationState(
        createStatus: GenericStatus.success,
        invitation: testInvitation(),
      ),
    );

    await tester.ensureVisible(find.byKey(InviteSheet.copyLinkButtonKey));
    await tester.tap(find.byKey(InviteSheet.copyLinkButtonKey));
    await tester.pump();

    verify(() => bloc.add(const InvitationEvent.linkCopyRequested())).called(1);
  });

  testWidgets('Given the link was copied then the button says so', (
    tester,
  ) async {
    await pumpWith(
      tester,
      InvitationState(
        createStatus: GenericStatus.success,
        invitation: testInvitation(),
        linkCopied: true,
      ),
    );

    expect(find.text(l10n.linkCopied), findsOneWidget);
  });
}
