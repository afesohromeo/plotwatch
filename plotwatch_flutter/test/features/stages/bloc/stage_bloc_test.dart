import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04c-m3-stages.md, group D (decisions M3-6, M3-8): one stage;
// the site manager starts it, the owner deletes it.
void main() {
  late AppLocalizations l10n;
  late MockStageRepository stageRepository;
  late MockProjectRepository projectRepository;

  final view = testStageView(id: 2);
  final started = testStageView(id: 2, status: StageStatus.inProgress);

  setUpAll(() => l10n = setUpTestLocalization());
  setUp(() {
    stageRepository = MockStageRepository();
    projectRepository = MockProjectRepository();
  });

  StageBloc build() => StageBloc(
    stageRepository: stageRepository,
    projectRepository: projectRepository,
  );

  StageState loaded({
    ProjectRole role = ProjectRole.owner,
    ProjectStatus projectStatus = ProjectStatus.active,
    StageView? stage,
  }) => StageState(
    projectId: 1,
    stageId: 2,
    overview: testOverview(
      role: role,
      project: testProject(status: projectStatus),
    ),
    view: stage ?? view,
    loadStatus: GenericStatus.success,
  );

  group('Given the stage page opens', () {
    final overview = testOverview();

    blocTest<StageBloc, StageState>(
      'when it loads then the project and the stage are shown',
      setUp: () {
        when(
          () => projectRepository.fetchProject(1),
        ).thenAnswer((_) async => overview);
        when(
          () => stageRepository.fetchStage(1, 2),
        ).thenAnswer((_) async => view);
      },
      build: build,
      act: (bloc) => bloc.add(const StageEvent.load(projectId: 1, stageId: 2)),
      expect: () => [
        const StageState(
          projectId: 1,
          stageId: 2,
          loadStatus: GenericStatus.loading,
        ),
        StageState(
          projectId: 1,
          stageId: 2,
          overview: overview,
          view: view,
          loadStatus: GenericStatus.success,
        ),
      ],
    );

    blocTest<StageBloc, StageState>(
      'when the stage is gone then it says so',
      setUp: () {
        when(
          () => projectRepository.fetchProject(1),
        ).thenAnswer((_) async => overview);
        when(
          () => stageRepository.fetchStage(1, 2),
        ).thenThrow(const HttpException400(code: AppErrorCode.stageNotFound));
      },
      build: build,
      act: (bloc) => bloc.add(const StageEvent.load(projectId: 1, stageId: 2)),
      skip: 1,
      expect: () => [
        StageState(
          projectId: 1,
          stageId: 2,
          loadStatus: GenericStatus.failure,
          loadErrorMessage: l10n.errorStageNotFound,
        ),
      ],
    );
  });

  // Built once: Serverpod models compare by identity, so expectations are
  // derived from the seeded state with copyWith.
  final asManager = loaded(role: ProjectRole.siteManager);
  final asOwner = loaded();

  group('Given the site manager', () {
    blocTest<StageBloc, StageState>(
      'when Start is tapped then the stage is in progress',
      setUp: () => when(
        () => stageRepository.startStage(1, 2),
      ).thenAnswer((_) async => started),
      build: build,
      seed: () => asManager,
      act: (bloc) => bloc.add(const StageEvent.startRequested()),
      expect: () => [
        asManager.copyWith(
          flowStep: GenericFlowStep.updatingItem,
          actionStatus: GenericStatus.loading,
        ),
        asManager.copyWith(
          view: started,
          flowStep: GenericFlowStep.updatingItem,
          actionStatus: GenericStatus.success,
        ),
      ],
    );

    blocTest<StageBloc, StageState>(
      'when the server refuses then it shows why',
      setUp: () => when(
        () => stageRepository.startStage(any(), any()),
      ).thenThrow(const HttpException400(code: AppErrorCode.projectNotActive)),
      build: build,
      seed: () => asManager,
      act: (bloc) => bloc.add(const StageEvent.startRequested()),
      skip: 1,
      expect: () => [
        asManager.copyWith(
          flowStep: GenericFlowStep.updatingItem,
          actionStatus: GenericStatus.failure,
          actionErrorMessage: l10n.errorProjectNotActive,
        ),
      ],
    );
  });

  group('Given the owner', () {
    blocTest<StageBloc, StageState>(
      'when Delete is confirmed then the stage is deleted',
      setUp: () => when(
        () => stageRepository.deleteStage(1, 2),
      ).thenAnswer((_) async {}),
      build: build,
      seed: () => asOwner,
      act: (bloc) => bloc.add(const StageEvent.deleteRequested()),
      expect: () => [
        asOwner.copyWith(
          flowStep: GenericFlowStep.deletingItem,
          actionStatus: GenericStatus.loading,
        ),
        asOwner.copyWith(
          flowStep: GenericFlowStep.deletingItem,
          actionStatus: GenericStatus.success,
        ),
      ],
    );

    // doc/04c M3-F1: a reload during the delete reset the flow step, so
    // the page took the result for another action and stayed put.
    blocTest<StageBloc, StageState>(
      'when a reload runs during the delete then the result is still '
      'reported as a delete',
      setUp: () {
        when(() => stageRepository.deleteStage(1, 2)).thenAnswer(
          (_) => Future<void>.delayed(const Duration(milliseconds: 50)),
        );
        when(
          () => projectRepository.fetchProject(1),
        ).thenAnswer((_) async => asOwner.overview!);
        when(
          () => stageRepository.fetchStage(1, 2),
        ).thenAnswer((_) async => view);
      },
      build: build,
      seed: () => asOwner,
      act: (bloc) => bloc
        ..add(const StageEvent.deleteRequested())
        ..add(const StageEvent.load(projectId: 1, stageId: 2)),
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        expect(bloc.state.actionStatus, GenericStatus.success);
        expect(bloc.state.flowStep, GenericFlowStep.deletingItem);
      },
    );

    blocTest<StageBloc, StageState>(
      'when the stage has started meanwhile then it shows why',
      setUp: () => when(
        () => stageRepository.deleteStage(any(), any()),
      ).thenThrow(const HttpException400(code: AppErrorCode.stageLocked)),
      build: build,
      seed: () => asOwner,
      act: (bloc) => bloc.add(const StageEvent.deleteRequested()),
      skip: 1,
      expect: () => [
        asOwner.copyWith(
          flowStep: GenericFlowStep.deletingItem,
          actionStatus: GenericStatus.failure,
          actionErrorMessage: l10n.errorStageLocked,
        ),
      ],
    );
  });

  group('Given what each member may do', () {
    test('then the owner edits and deletes a stage that has not started', () {
      expect(loaded().canEdit, isTrue);
      expect(loaded().canDelete, isTrue);
      expect(loaded().canStart, isFalse);
    });

    test('then the owner edits but no longer deletes a stage in progress', () {
      final inProgress = loaded(stage: started);
      expect(inProgress.canEdit, isTrue);
      expect(inProgress.canDelete, isFalse);
    });

    test('then a submitted stage is locked for the owner', () {
      final submitted = loaded(
        stage: testStageView(id: 2, status: StageStatus.submitted),
      );
      expect(submitted.canEdit, isFalse);
      expect(submitted.canDelete, isFalse);
    });

    test('then the site manager starts a stage that has not started', () {
      final manager = loaded(role: ProjectRole.siteManager);
      expect(manager.canStart, isTrue);
      expect(manager.canEdit, isFalse);
      expect(
        loaded(role: ProjectRole.siteManager, stage: started).canStart,
        isFalse,
      );
    });

    test('then a viewer only reads', () {
      final viewer = loaded(role: ProjectRole.viewer);
      expect(viewer.canEdit || viewer.canDelete || viewer.canStart, isFalse);
    });
  });
}
