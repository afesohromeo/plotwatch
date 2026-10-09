import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04e-m5-review-realtime.md, group F (M5-9 b).
void main() {
  late AppLocalizations l10n;
  late MockUpdateRepository updateRepository;
  late MockStageRepository stageRepository;

  final plan = testStagePlan();
  final draft = ProgressUpdateDraft(text: 'Concrete poured.', stageId: 2);

  setUpAll(() => l10n = setUpTestLocalization());

  setUp(() {
    updateRepository = MockUpdateRepository();
    stageRepository = MockStageRepository();
    when(() => stageRepository.fetchPlan(1)).thenAnswer((_) async => plan);
  });

  group('Given the update form', () {
    UpdateFormBloc build() => UpdateFormBloc(
      updateRepository: updateRepository,
      stageRepository: stageRepository,
    );

    blocTest<UpdateFormBloc, UpdateFormState>(
      'when it opens then the stages load for the picker',
      build: build,
      act: (bloc) => bloc.add(const UpdateFormEvent.load(projectId: 1)),
      expect: () => [
        const UpdateFormState(projectId: 1, loadStatus: GenericStatus.loading),
        UpdateFormState(
          projectId: 1,
          loadStatus: GenericStatus.success,
          stages: [for (final view in plan.stages) view.stage],
        ),
      ],
    );

    blocTest<UpdateFormBloc, UpdateFormState>(
      'when it is posted then the saved update is kept',
      build: build,
      setUp: () => when(
        () => updateRepository.createUpdate(1, draft),
      ).thenAnswer((_) async => testUpdate()),
      seed: () => const UpdateFormState(
        projectId: 1,
        loadStatus: GenericStatus.success,
      ),
      act: (bloc) => bloc.add(UpdateFormEvent.saveRequested(draft)),
      expect: () => [
        const UpdateFormState(
          projectId: 1,
          loadStatus: GenericStatus.success,
          actionStatus: GenericStatus.loading,
        ),
        isA<UpdateFormState>()
            .having((s) => s.actionStatus, 'status', GenericStatus.success)
            .having((s) => s.saved?.id, 'saved', 4),
      ],
    );

    blocTest<UpdateFormBloc, UpdateFormState>(
      'when the server refuses (e.g. not the site manager) then its message '
      'is shown',
      build: build,
      setUp: () => when(
        () => updateRepository.createUpdate(1, draft),
      ).thenThrow(const HttpException400(code: AppErrorCode.permissionDenied)),
      seed: () => const UpdateFormState(projectId: 1),
      act: (bloc) => bloc.add(UpdateFormEvent.saveRequested(draft)),
      skip: 1,
      expect: () => [
        isA<UpdateFormState>()
            .having((s) => s.actionStatus, 'status', GenericStatus.failure)
            .having(
              (s) => s.actionErrorMessage,
              'message',
              AppErrorCode.permissionDenied.message(l10n),
            ),
      ],
    );
  });

  group('Given an update opened from the feed', () {
    UpdateBloc build() => UpdateBloc(
      updateRepository: updateRepository,
      stageRepository: stageRepository,
    );

    blocTest<UpdateBloc, UpdateState>(
      'then it loads with the name of its stage',
      build: build,
      setUp: () {
        when(
          () => updateRepository.fetchUpdate(1, 4),
        ).thenAnswer((_) async => testUpdate());
        when(
          () => stageRepository.fetchStage(1, 2),
        ).thenAnswer((_) async => testStageView(id: 2, name: 'Walls'));
      },
      act: (bloc) =>
          bloc.add(const UpdateEvent.load(projectId: 1, updateId: 4)),
      skip: 1,
      expect: () => [
        isA<UpdateState>()
            .having((s) => s.update?.id, 'update', 4)
            .having((s) => s.stageName, 'stage', 'Walls'),
      ],
    );

    blocTest<UpdateBloc, UpdateState>(
      'when it is not found then the message is shown',
      build: build,
      setUp: () => when(
        () => updateRepository.fetchUpdate(1, 4),
      ).thenThrow(const HttpException400(code: AppErrorCode.updateNotFound)),
      act: (bloc) =>
          bloc.add(const UpdateEvent.load(projectId: 1, updateId: 4)),
      skip: 1,
      expect: () => [
        isA<UpdateState>().having(
          (s) => s.loadErrorMessage,
          'message',
          AppErrorCode.updateNotFound.message(l10n),
        ),
      ],
    );
  });
}
