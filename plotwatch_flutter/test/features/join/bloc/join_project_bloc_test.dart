import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04b-m2-projects-site-members.md, group F (MEMB-03, AC-2).
void main() {
  late AppLocalizations l10n;
  late MockMembershipRepository repository;

  setUpAll(() => l10n = setUpTestLocalization());
  setUp(() => repository = MockMembershipRepository());

  JoinProjectBloc build() => JoinProjectBloc(membershipRepository: repository);

  final previewed = JoinProjectState(
    code: 'ABCD2345',
    previewStatus: GenericStatus.success,
    preview: testPreview,
  );

  group('Given an invitation code', () {
    blocTest<JoinProjectBloc, JoinProjectState>(
      'when it is checked then the project, role and inviter are shown',
      setUp: () => when(
        () => repository.previewInvitation('ABCD2345'),
      ).thenAnswer((_) async => testPreview),
      build: build,
      act: (bloc) =>
          bloc.add(const JoinProjectEvent.previewRequested(code: 'ABCD2345')),
      expect: () => [
        const JoinProjectState(
          code: 'ABCD2345',
          previewStatus: GenericStatus.loading,
        ),
        previewed,
      ],
    );

    final previewFailures = <String, (AppErrorCode, String Function())>{
      'no invitation has it': (
        AppErrorCode.invitationNotFound,
        () => l10n.errorInvitationNotFound,
      ),
      'it has expired': (
        AppErrorCode.invitationExpired,
        () => l10n.errorInvitationExpired,
      ),
      'it was already used': (
        AppErrorCode.invitationUsed,
        () => l10n.errorInvitationUsed,
      ),
    };
    for (final MapEntry(key: when_, value: (code, message))
        in previewFailures.entries) {
      blocTest<JoinProjectBloc, JoinProjectState>(
        'when $when_ then it says so',
        setUp: () => when(
          () => repository.previewInvitation(any()),
        ).thenThrow(HttpException400(code: code)),
        build: build,
        act: (bloc) =>
            bloc.add(const JoinProjectEvent.previewRequested(code: 'ABCD2345')),
        skip: 1,
        expect: () => [
          JoinProjectState(
            code: 'ABCD2345',
            previewStatus: GenericStatus.failure,
            previewErrorMessage: message(),
          ),
        ],
      );
    }

    final member = testMember(id: 2, role: ProjectRole.siteManager).member;
    blocTest<JoinProjectBloc, JoinProjectState>(
      'when the user joins then the new membership is kept',
      setUp: () => when(
        () => repository.acceptInvitation('ABCD2345'),
      ).thenAnswer((_) async => member),
      build: build,
      seed: () => previewed,
      act: (bloc) => bloc.add(const JoinProjectEvent.joinRequested()),
      expect: () => [
        previewed.copyWith(joinStatus: GenericStatus.loading),
        previewed.copyWith(joinStatus: GenericStatus.success, joined: member),
      ],
    );

    blocTest<JoinProjectBloc, JoinProjectState>(
      'when the user is already a member then it says so',
      setUp: () => when(
        () => repository.acceptInvitation(any()),
      ).thenThrow(const HttpException400(code: AppErrorCode.alreadyMember)),
      build: build,
      seed: () => previewed,
      act: (bloc) => bloc.add(const JoinProjectEvent.joinRequested()),
      skip: 1,
      expect: () => [
        previewed.copyWith(
          joinStatus: GenericStatus.failure,
          joinErrorMessage: l10n.errorAlreadyMember,
        ),
      ],
    );

    blocTest<JoinProjectBloc, JoinProjectState>(
      'when joining fails unexpectedly then it shows the join message',
      setUp: () => when(
        () => repository.acceptInvitation(any()),
      ).thenThrow(StateError('x')),
      build: build,
      seed: () => previewed,
      act: (bloc) => bloc.add(const JoinProjectEvent.joinRequested()),
      skip: 1,
      expect: () => [
        previewed.copyWith(
          joinStatus: GenericStatus.failure,
          joinErrorMessage: l10n.errorJoinProject,
        ),
      ],
    );

    blocTest<JoinProjectBloc, JoinProjectState>(
      'when joining before a successful check then nothing is sent',
      build: build,
      act: (bloc) => bloc.add(const JoinProjectEvent.joinRequested()),
      expect: () => <JoinProjectState>[],
      verify: (_) => verifyNever(() => repository.acceptInvitation(any())),
    );

    // doc/04b F2-1: Join must never act on a code other than the one shown.
    blocTest<JoinProjectBloc, JoinProjectState>(
      'when the code is edited after a check then the preview is cleared',
      build: build,
      seed: () => previewed,
      act: (bloc) =>
          bloc.add(const JoinProjectEvent.codeEdited(code: 'ABCD2346')),
      expect: () => [const JoinProjectState()],
    );

    blocTest<JoinProjectBloc, JoinProjectState>(
      'when the field still holds the checked code then the preview stays',
      build: build,
      seed: () => previewed,
      act: (bloc) =>
          bloc.add(const JoinProjectEvent.codeEdited(code: ' ABCD2345 ')),
      expect: () => <JoinProjectState>[],
    );

    blocTest<JoinProjectBloc, JoinProjectState>(
      'when the code is edited after a failed check then the error is cleared',
      build: build,
      seed: () => JoinProjectState(
        code: 'ABCD2345',
        previewStatus: GenericStatus.failure,
        previewErrorMessage: l10n.errorInvitationExpired,
      ),
      act: (bloc) =>
          bloc.add(const JoinProjectEvent.codeEdited(code: 'ABCD234')),
      expect: () => [const JoinProjectState()],
    );

    blocTest<JoinProjectBloc, JoinProjectState>(
      'when the error has been shown then the join status is reset',
      build: build,
      seed: () => previewed.copyWith(
        joinStatus: GenericStatus.failure,
        joinErrorMessage: 'x',
      ),
      act: (bloc) => bloc.add(const JoinProjectEvent.resetFlowStep()),
      expect: () => [previewed],
    );
  });
}
