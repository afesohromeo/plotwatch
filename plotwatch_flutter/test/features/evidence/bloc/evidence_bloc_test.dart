import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04d-m4-capture.md, group D (decision M4-11): one capture with
// its checks; its author can retract it with a reason.
void main() {
  late AppLocalizations l10n;
  late MockEvidenceRepository evidenceRepository;
  late MockProjectRepository projectRepository;
  late MockAuthRepository authRepository;

  final managerOverview = testOverview(role: ProjectRole.siteManager);
  final evidence = testEvidence();
  final retracted = testEvidence(
    status: EvidenceStatus.retracted,
    retractedReason: 'Blurred',
  );

  setUpAll(() => l10n = setUpTestLocalization());
  setUp(() {
    evidenceRepository = MockEvidenceRepository();
    projectRepository = MockProjectRepository();
    authRepository = MockAuthRepository();
    when(
      () => projectRepository.fetchProject(1),
    ).thenAnswer((_) async => managerOverview);
    when(
      () => evidenceRepository.fetchEvidence(1, 9),
    ).thenAnswer((_) async => evidence);
  });

  EvidenceBloc build() => EvidenceBloc(
    evidenceRepository: evidenceRepository,
    projectRepository: projectRepository,
    authRepository: authRepository,
  );

  final loaded = EvidenceState(
    projectId: 1,
    stageId: 1,
    evidenceId: 9,
    overview: managerOverview,
    evidence: evidence,
    isMine: true,
    loadStatus: GenericStatus.success,
  );

  group('Given the evidence page opens', () {
    blocTest<EvidenceBloc, EvidenceState>(
      'when the signed-in user took the photo then it is theirs',
      setUp: () => when(
        () => authRepository.currentUserId,
      ).thenReturn(UuidValue.fromString(testManagerId)),
      build: build,
      act: (bloc) => bloc.add(
        const EvidenceEvent.load(projectId: 1, stageId: 1, evidenceId: 9),
      ),
      skip: 1,
      expect: () => [loaded],
      verify: (bloc) => expect(bloc.state.canRetract, isTrue),
    );

    blocTest<EvidenceBloc, EvidenceState>(
      'when someone else took it then it can only be read',
      setUp: () => when(() => authRepository.currentUserId).thenReturn(
        UuidValue.fromString('00000000-0000-4000-8000-000000000099'),
      ),
      build: build,
      act: (bloc) => bloc.add(
        const EvidenceEvent.load(projectId: 1, stageId: 1, evidenceId: 9),
      ),
      verify: (bloc) {
        expect(bloc.state.isMine, isFalse);
        expect(bloc.state.canRetract, isFalse);
      },
    );

    blocTest<EvidenceBloc, EvidenceState>(
      'when the photo is gone then it says so',
      setUp: () => when(
        () => evidenceRepository.fetchEvidence(1, 9),
      ).thenThrow(const HttpException400(code: AppErrorCode.evidenceNotFound)),
      build: build,
      act: (bloc) => bloc.add(
        const EvidenceEvent.load(projectId: 1, stageId: 1, evidenceId: 9),
      ),
      verify: (bloc) {
        expect(bloc.state.loadStatus, GenericStatus.failure);
        expect(bloc.state.loadErrorMessage, l10n.errorEvidenceNotFound);
      },
    );
  });

  group('Given the author retracts', () {
    blocTest<EvidenceBloc, EvidenceState>(
      'when a reason is given then the capture is shown as retracted',
      setUp: () => when(
        () => evidenceRepository.retract(1, 9, 'Blurred'),
      ).thenAnswer((_) async => retracted),
      build: build,
      seed: () => loaded,
      act: (bloc) =>
          bloc.add(const EvidenceEvent.retractRequested(reason: 'Blurred')),
      expect: () => [
        loaded.copyWith(actionStatus: GenericStatus.loading),
        loaded.copyWith(
          evidence: retracted,
          actionStatus: GenericStatus.success,
        ),
      ],
      verify: (bloc) => expect(bloc.state.canRetract, isFalse),
    );

    blocTest<EvidenceBloc, EvidenceState>(
      'when it was already retracted then it shows why',
      setUp: () => when(
        () => evidenceRepository.retract(any(), any(), any()),
      ).thenThrow(
        const HttpException400(code: AppErrorCode.evidenceAlreadyRetracted),
      ),
      build: build,
      seed: () => loaded,
      act: (bloc) =>
          bloc.add(const EvidenceEvent.retractRequested(reason: 'Again')),
      skip: 1,
      expect: () => [
        loaded.copyWith(
          actionStatus: GenericStatus.failure,
          actionErrorMessage: l10n.errorEvidenceAlreadyRetracted,
        ),
      ],
    );
  });
}
