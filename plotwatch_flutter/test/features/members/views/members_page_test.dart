import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

class MockMembersBloc extends MockBloc<MembersEvent, MembersState>
    implements MembersBloc {}

// Plan: doc/04b-m2-projects-site-members.md, group F (MEMB-04, MEMB-05).
void main() {
  late AppLocalizations l10n;
  late MockMembersBloc bloc;

  final owner = testMember(id: 1);
  final manager =
      testMember(id: 2, fullName: 'Bob Mbarga', role: ProjectRole.siteManager);

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(const MembersEvent.resetFlowStep());
  });
  setUp(() => bloc = MockMembersBloc());

  Future<void> pumpWith(WidgetTester tester, MembersState state) {
    when(() => bloc.state).thenReturn(state);
    return tester.pumpApp(BlocProvider<MembersBloc>.value(
      value: bloc,
      child: const MembersPage(projectId: 1),
    ));
  }

  MembersState loaded(ProjectRole myRole, {List<Invitation> invitations = const []}) =>
      MembersState(
        membersStatus: GenericStatus.success,
        overview: testOverview(role: myRole),
        members: [owner, manager],
        invitations: invitations,
      );

  testWidgets('Given the page opens then it loads the members of that project',
      (tester) async {
    await pumpWith(tester, const MembersState());

    verify(() => bloc.add(const MembersEvent.fetchMembers(projectId: 1)))
        .called(1);
  });

  testWidgets(
      'Given the owner then members show with their role, and pending '
      'invitations with their formatted code', (tester) async {
    await pumpWith(
        tester, loaded(ProjectRole.owner, invitations: [testInvitation()]));

    expect(find.text('Ada Lovelace'), findsOneWidget);
    expect(find.text('Bob Mbarga'), findsOneWidget);
    expect(find.text(l10n.projectRoleSiteManager), findsWidgets);
    expect(find.text('ABCD-2345'), findsOneWidget);
    expect(find.byKey(MembersPage.inviteButtonKey), findsOneWidget);
  });

  testWidgets('Given the owner then only other members can be removed',
      (tester) async {
    await pumpWith(tester, loaded(ProjectRole.owner));

    expect(find.byKey(MembersPage.removeButtonKey(1)), findsNothing);
    expect(find.byKey(MembersPage.removeButtonKey(2)), findsOneWidget);
  });

  testWidgets(
      'Given a site manager then there is no invite, remove or invitations '
      'section', (tester) async {
    await pumpWith(tester, loaded(ProjectRole.siteManager));

    expect(find.byKey(MembersPage.inviteButtonKey), findsNothing);
    expect(find.byKey(MembersPage.removeButtonKey(2)), findsNothing);
    expect(find.text(l10n.pendingInvitations), findsNothing);
  });

  testWidgets('Given the owner removes a member when they confirm then it is '
      'sent', (tester) async {
    await pumpWith(tester, loaded(ProjectRole.owner));

    await tester.tap(find.byKey(MembersPage.removeButtonKey(2)));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.confirm));
    await tester.pump();

    verify(() => bloc.add(const MembersEvent.removeMember(memberId: 2)))
        .called(1);
  });

  testWidgets('Given the owner cancels an invitation then it is sent',
      (tester) async {
    await pumpWith(
        tester, loaded(ProjectRole.owner, invitations: [testInvitation(id: 5)]));

    await tester.ensureVisible(find.byKey(MembersPage.cancelInvitationKey(5)));
    await tester.tap(find.byKey(MembersPage.cancelInvitationKey(5)));
    await tester.pump();

    verify(() =>
            bloc.add(const MembersEvent.cancelInvitation(invitationId: 5)))
        .called(1);
  });
}
