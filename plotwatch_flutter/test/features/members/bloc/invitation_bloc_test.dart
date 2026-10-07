import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04b-m2-projects-site-members.md, group F (MEMB-01; decisions
// M2-6, M2-7).
void main() {
  late AppLocalizations l10n;
  late MockMembershipRepository repository;
  late MockShareProvider shareProvider;

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(ProjectRole.viewer);
  });
  setUp(() {
    repository = MockMembershipRepository();
    shareProvider = MockShareProvider();
  });

  InvitationBloc build() => InvitationBloc(
        membershipRepository: repository,
        shareProvider: shareProvider,
        webAppUrl: 'https://plotwatch.serverpod.space',
      );

  group('Given the invite sheet', () {
    blocTest<InvitationBloc, InvitationState>(
      'when a role is picked then it is kept, and leaving co-funder drops the '
      'approval right',
      build: build,
      act: (bloc) => bloc
        ..add(const InvitationEvent.roleChanged(role: ProjectRole.coFunder))
        ..add(const InvitationEvent.canApproveChanged(canApprove: true))
        ..add(const InvitationEvent.roleChanged(role: ProjectRole.viewer)),
      expect: () => const [
        InvitationState(role: ProjectRole.coFunder),
        InvitationState(role: ProjectRole.coFunder, canApprove: true),
        InvitationState(role: ProjectRole.viewer),
      ],
    );

    final invitation = testInvitation(role: ProjectRole.coFunder);
    blocTest<InvitationBloc, InvitationState>(
      'when the invitation is created then its code is kept',
      setUp: () => when(() => repository.createInvitation(
            1,
            ProjectRole.coFunder,
            canApprove: true,
          )).thenAnswer((_) async => invitation),
      build: build,
      seed: () =>
          const InvitationState(role: ProjectRole.coFunder, canApprove: true),
      act: (bloc) =>
          bloc.add(const InvitationEvent.createSubmitted(projectId: 1)),
      expect: () => [
        const InvitationState(
          role: ProjectRole.coFunder,
          canApprove: true,
          createStatus: GenericStatus.loading,
        ),
        InvitationState(
          role: ProjectRole.coFunder,
          canApprove: true,
          createStatus: GenericStatus.success,
          invitation: invitation,
        ),
      ],
    );

    final failures = <String, (Object, String Function())>{
      'the user is not the owner': (
        const HttpException400(code: AppErrorCode.permissionDenied),
        () => l10n.errorPermissionDenied
      ),
      'the device is offline': (
        const NetworkException(),
        () => l10n.networkError
      ),
      'something unexpected happens': (
        StateError('x'),
        () => l10n.errorInvitationCreate
      ),
    };
    for (final MapEntry(key: when_, value: (error, message))
        in failures.entries) {
      blocTest<InvitationBloc, InvitationState>(
        'when $when_ then it shows the matching message',
        setUp: () => when(() => repository.createInvitation(any(), any(),
            canApprove: any(named: 'canApprove'))).thenThrow(error),
        build: build,
        act: (bloc) =>
            bloc.add(const InvitationEvent.createSubmitted(projectId: 1)),
        skip: 1,
        expect: () => [
          InvitationState(
            createStatus: GenericStatus.failure,
            createErrorMessage: message(),
          ),
        ],
      );
    }

    blocTest<InvitationBloc, InvitationState>(
      'when the invitation is shared then the message holds the link and the '
      'formatted code',
      setUp: () => when(() => shareProvider.shareText(any()))
          .thenAnswer((_) async {}),
      build: build,
      seed: () => InvitationState(
        createStatus: GenericStatus.success,
        invitation: testInvitation(code: 'ABCD2345'),
      ),
      act: (bloc) => bloc.add(const InvitationEvent.shareRequested()),
      expect: () => <InvitationState>[],
      verify: (_) => verify(() => shareProvider.shareText(l10n.invitationShareText(
            'https://plotwatch.serverpod.space/join/ABCD2345',
            'ABCD-2345',
          ))).called(1),
    );
  });
}
