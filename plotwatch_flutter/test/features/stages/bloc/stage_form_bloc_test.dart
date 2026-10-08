import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04c-m3-stages.md, group D (decisions M3-4, M3-5): the owner
// creates or edits a stage with its checklist.
void main() {
  late AppLocalizations l10n;
  late MockStageRepository stageRepository;
  late MockProjectRepository projectRepository;

  final overview = testOverview();
  final view = testStageView(id: 2);
  final draft = testStageDraft(name: 'Roofing');

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(testStageDraft());
  });
  setUp(() {
    stageRepository = MockStageRepository();
    projectRepository = MockProjectRepository();
    when(
      () => projectRepository.fetchProject(1),
    ).thenAnswer((_) async => overview);
  });

  StageFormBloc build() => StageFormBloc(
    stageRepository: stageRepository,
    projectRepository: projectRepository,
  );

  final newForm = StageFormState(
    projectId: 1,
    overview: overview,
    loadStatus: GenericStatus.success,
  );
  final editForm = StageFormState(
    projectId: 1,
    stageId: 2,
    overview: overview,
    view: view,
    loadStatus: GenericStatus.success,
  );

  group('Given the form opens', () {
    blocTest<StageFormBloc, StageFormState>(
      'for a new stage then only the project is loaded',
      build: build,
      act: (bloc) => bloc.add(const StageFormEvent.load(projectId: 1)),
      expect: () => [
        const StageFormState(projectId: 1, loadStatus: GenericStatus.loading),
        newForm,
      ],
      verify: (_) =>
          verifyNever(() => stageRepository.fetchStage(any(), any())),
    );

    blocTest<StageFormBloc, StageFormState>(
      'for an existing stage then the stage is loaded too',
      setUp: () => when(
        () => stageRepository.fetchStage(1, 2),
      ).thenAnswer((_) async => view),
      build: build,
      act: (bloc) =>
          bloc.add(const StageFormEvent.load(projectId: 1, stageId: 2)),
      skip: 1,
      expect: () => [editForm],
    );
  });

  group('Given the owner saves', () {
    blocTest<StageFormBloc, StageFormState>(
      'a new stage then it is created',
      setUp: () => when(
        () => stageRepository.createStage(1, draft),
      ).thenAnswer((_) async => view),
      build: build,
      seed: () => newForm,
      act: (bloc) => bloc.add(StageFormEvent.saveRequested(draft: draft)),
      expect: () => [
        newForm.copyWith(actionStatus: GenericStatus.loading),
        newForm.copyWith(actionStatus: GenericStatus.success, saved: view),
      ],
    );

    blocTest<StageFormBloc, StageFormState>(
      'an existing stage then it is updated',
      setUp: () => when(
        () => stageRepository.updateStage(1, 2, draft),
      ).thenAnswer((_) async => view),
      build: build,
      seed: () => editForm,
      act: (bloc) => bloc.add(StageFormEvent.saveRequested(draft: draft)),
      expect: () => [
        editForm.copyWith(actionStatus: GenericStatus.loading),
        editForm.copyWith(actionStatus: GenericStatus.success, saved: view),
      ],
      verify: (_) =>
          verifyNever(() => stageRepository.createStage(any(), any())),
    );

    blocTest<StageFormBloc, StageFormState>(
      'and the server refuses the name then it shows why',
      setUp: () => when(
        () => stageRepository.createStage(any(), any()),
      ).thenThrow(const HttpException400(code: AppErrorCode.invalidStageName)),
      build: build,
      seed: () => newForm,
      act: (bloc) => bloc.add(StageFormEvent.saveRequested(draft: draft)),
      skip: 1,
      expect: () => [
        newForm.copyWith(
          actionStatus: GenericStatus.failure,
          actionErrorMessage: l10n.errorInvalidStageName,
        ),
      ],
    );
  });
}
