import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04b-m2-projects-site-members.md, group F (MEMB-04, MEMB-05).
void main() {
  late AppLocalizations l10n;
  late MockProjectRepository projectRepository;
  late MockMembershipRepository membershipRepository;

  final ownerOverview = testOverview();
  final managerOverview = testOverview(role: ProjectRole.siteManager);
  final owner = testMember(id: 1);
  final manager = testMember(
    id: 2,
    fullName: 'Bob Mbarga',
    role: ProjectRole.siteManager,
  );
  final invitation = testInvitation(id: 5);

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(ProjectRole.viewer);
  });
  setUp(() {
    projectRepository = MockProjectRepository();
    membershipRepository = MockMembershipRepository();
  });

  MembersBloc build() => MembersBloc(
    projectRepository: projectRepository,
    membershipRepository: membershipRepository,
  );

  final ownerLoaded = MembersState(
    membersStatus: GenericStatus.success,
    overview: ownerOverview,
    members: [owner, manager],
    invitations: [invitation],
  );

  group('Given the members page is opened', () {
    blocTest<MembersBloc, MembersState>(
      'when the owner opens it then members and pending invitations load',
      setUp: () {
        when(
          () => projectRepository.fetchProject(1),
        ).thenAnswer((_) async => ownerOverview);
        when(
          () => membershipRepository.fetchMembers(1),
        ).thenAnswer((_) async => [owner, manager]);
        when(
          () => membershipRepository.fetchInvitations(1),
        ).thenAnswer((_) async => [invitation]);
      },
      build: build,
      act: (bloc) => bloc.add(const MembersEvent.fetchMembers(projectId: 1)),
      expect: () => [
        const MembersState(membersStatus: GenericStatus.loading),
        ownerLoaded,
      ],
    );

    blocTest<MembersBloc, MembersState>(
      'when a site manager opens it then invitations are not asked for',
      setUp: () {
        when(
          () => projectRepository.fetchProject(1),
        ).thenAnswer((_) async => managerOverview);
        when(
          () => membershipRepository.fetchMembers(1),
        ).thenAnswer((_) async => [owner, manager]);
      },
      build: build,
      act: (bloc) => bloc.add(const MembersEvent.fetchMembers(projectId: 1)),
      skip: 1,
      expect: () => [
        MembersState(
          membersStatus: GenericStatus.success,
          overview: managerOverview,
          members: [owner, manager],
        ),
      ],
      verify: (_) =>
          verifyNever(() => membershipRepository.fetchInvitations(any())),
    );

    final failures = <String, (Object, String Function())>{
      'the user is not a member': (
        const HttpException400(code: AppErrorCode.projectNotFound),
        () => l10n.errorProjectNotFound,
      ),
      'the device is offline': (
        const NetworkException(),
        () => l10n.networkError,
      ),
      'something unexpected happens': (
        StateError('x'),
        () => l10n.errorMembersLoad,
      ),
    };
    for (final MapEntry(key: when_, value: (error, message))
        in failures.entries) {
      blocTest<MembersBloc, MembersState>(
        'when $when_ then it shows the matching message',
        setUp: () =>
            when(() => projectRepository.fetchProject(1)).thenThrow(error),
        build: build,
        act: (bloc) => bloc.add(const MembersEvent.fetchMembers(projectId: 1)),
        skip: 1,
        expect: () => [
          MembersState(
            membersStatus: GenericStatus.failure,
            membersErrorMessage: message(),
          ),
        ],
      );
    }
  });

  group('Given the owner manages the members', () {
    blocTest<MembersBloc, MembersState>(
      'when a member is removed then they leave the list',
      setUp: () => when(
        () => membershipRepository.removeMember(1, 2),
      ).thenAnswer((_) async {}),
      build: build,
      seed: () => ownerLoaded,
      act: (bloc) => bloc.add(const MembersEvent.removeMember(memberId: 2)),
      skip: 1,
      expect: () => [
        ownerLoaded.copyWith(
          members: [owner],
          flowStep: GenericFlowStep.deletingItem,
          actionStatus: GenericStatus.success,
        ),
      ],
    );

    blocTest<MembersBloc, MembersState>(
      'when an invitation is cancelled then it leaves the list',
      setUp: () => when(
        () => membershipRepository.cancelInvitation(1, 5),
      ).thenAnswer((_) async {}),
      build: build,
      seed: () => ownerLoaded,
      act: (bloc) =>
          bloc.add(const MembersEvent.cancelInvitation(invitationId: 5)),
      skip: 1,
      expect: () => [
        ownerLoaded.copyWith(
          invitations: [],
          flowStep: GenericFlowStep.deletingItem,
          actionStatus: GenericStatus.success,
        ),
      ],
    );

    blocTest<MembersBloc, MembersState>(
      'when removing the owner is refused then it shows why',
      setUp: () => when(
        () => membershipRepository.removeMember(any(), any()),
      ).thenThrow(const HttpException400(code: AppErrorCode.cannotRemoveOwner)),
      build: build,
      seed: () => ownerLoaded,
      act: (bloc) => bloc.add(const MembersEvent.removeMember(memberId: 1)),
      skip: 1,
      expect: () => [
        ownerLoaded.copyWith(
          flowStep: GenericFlowStep.deletingItem,
          actionStatus: GenericStatus.failure,
          actionErrorMessage: l10n.errorCannotRemoveOwner,
        ),
      ],
    );

    // doc/04b H-4.
    blocTest<MembersBloc, MembersState>(
      'when a member\'s role is changed then their row shows the new role',
      setUp: () =>
          when(
            () => membershipRepository.changeRole(1, 2, ProjectRole.viewer),
          ).thenAnswer(
            (_) async => manager.member.copyWith(role: ProjectRole.viewer),
          ),
      build: build,
      seed: () => ownerLoaded,
      act: (bloc) => bloc.add(
        const MembersEvent.changeRole(memberId: 2, role: ProjectRole.viewer),
      ),
      // Serverpod's MemberView has no value equality, so the roles are
      // compared rather than whole states.
      expect: () => [
        ownerLoaded.copyWith(
          flowStep: GenericFlowStep.updatingItem,
          actionStatus: GenericStatus.loading,
        ),
        isA<MembersState>()
            .having(
              (s) => s.members.map((v) => (v.member.id, v.member.role)),
              'member roles',
              [(1, ProjectRole.owner), (2, ProjectRole.viewer)],
            )
            .having(
              (s) => s.actionStatus,
              'actionStatus',
              GenericStatus.success,
            )
            .having(
              (s) => s.flowStep,
              'flowStep',
              GenericFlowStep.updatingItem,
            ),
      ],
    );

    blocTest<MembersBloc, MembersState>(
      'when a role change is refused then the row keeps its role and it '
      'shows why',
      setUp: () =>
          when(
            () => membershipRepository.changeRole(any(), any(), any()),
          ).thenThrow(
            const HttpException400(code: AppErrorCode.cannotChangeOwnerRole),
          ),
      build: build,
      seed: () => ownerLoaded,
      act: (bloc) => bloc.add(
        const MembersEvent.changeRole(memberId: 1, role: ProjectRole.viewer),
      ),
      skip: 1,
      expect: () => [
        ownerLoaded.copyWith(
          flowStep: GenericFlowStep.updatingItem,
          actionStatus: GenericStatus.failure,
          actionErrorMessage: l10n.errorCannotChangeOwnerRole,
        ),
      ],
    );

    final created = testInvitation(id: 9, code: 'WXYZ6789');
    blocTest<MembersBloc, MembersState>(
      'when a new invitation was created then it joins the list first',
      build: build,
      seed: () => ownerLoaded,
      act: (bloc) =>
          bloc.add(MembersEvent.invitationCreated(invitation: created)),
      expect: () => [
        ownerLoaded.copyWith(invitations: [created, invitation]),
      ],
    );
  });
}
