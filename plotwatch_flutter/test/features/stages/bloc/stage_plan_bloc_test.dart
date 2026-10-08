import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04c-m3-stages.md, group C (decisions M3-3, M3-7, M3-11): the
// plan with its total and progress; the owner reorders and starts from a
// template.
void main() {
  late AppLocalizations l10n;
  late MockStageRepository stageRepository;
  late MockProjectRepository projectRepository;

  final overview = testOverview(stageCount: 3);
  final a = testStageView(id: 1, name: 'A', orderIndex: 0, budgetMinor: 100);
  final b = testStageView(id: 2, name: 'B', orderIndex: 1, budgetMinor: 200);
  final c = testStageView(id: 3, name: 'C', orderIndex: 2, budgetMinor: 300);
  final plan = testStagePlan(stages: [a, b, c]);

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(<int>[]);
    registerFallbackValue(<StageDraft>[]);
  });
  setUp(() {
    stageRepository = MockStageRepository();
    projectRepository = MockProjectRepository();
  });

  StagePlanBloc build() => StagePlanBloc(
    stageRepository: stageRepository,
    projectRepository: projectRepository,
  );

  final loaded = StagePlanState(
    projectId: 1,
    overview: overview,
    plan: plan,
    loadStatus: GenericStatus.success,
  );

  List<String> names(StagePlanState state) =>
      state.plan!.stages.map((v) => v.stage.name).toList();

  group('Given the plan opens', () {
    blocTest<StagePlanBloc, StagePlanState>(
      'when it loads then the project and its stages are shown',
      setUp: () {
        when(
          () => projectRepository.fetchProject(1),
        ).thenAnswer((_) async => overview);
        when(() => stageRepository.fetchPlan(1)).thenAnswer((_) async => plan);
      },
      build: build,
      act: (bloc) => bloc.add(const StagePlanEvent.load(projectId: 1)),
      expect: () => [
        const StagePlanState(projectId: 1, loadStatus: GenericStatus.loading),
        loaded,
      ],
    );

    blocTest<StagePlanBloc, StagePlanState>(
      'when the network is down then it says so',
      setUp: () {
        when(
          () => projectRepository.fetchProject(1),
        ).thenAnswer((_) async => overview);
        when(
          () => stageRepository.fetchPlan(1),
        ).thenThrow(const NetworkException());
      },
      build: build,
      act: (bloc) => bloc.add(const StagePlanEvent.load(projectId: 1)),
      skip: 1,
      expect: () => [
        StagePlanState(
          projectId: 1,
          loadStatus: GenericStatus.failure,
          loadErrorMessage: l10n.networkError,
        ),
      ],
    );
  });

  group('Given the owner reorders', () {
    blocTest<StagePlanBloc, StagePlanState>(
      'when the first stage is dragged below the last then the list moves '
      'at once and the new order is sent',
      setUp: () => when(
        () => stageRepository.reorderStages(1, any()),
      ).thenAnswer((_) async => testStagePlan(stages: [b, c, a])),
      build: build,
      seed: () => loaded,
      act: (bloc) => bloc.add(
        const StagePlanEvent.reorderRequested(oldIndex: 0, newIndex: 2),
      ),
      expect: () => [
        isA<StagePlanState>()
            .having(names, 'stages', ['B', 'C', 'A'])
            .having((s) => s.actionStatus, 'status', GenericStatus.loading),
        isA<StagePlanState>()
            .having(names, 'stages', ['B', 'C', 'A'])
            .having((s) => s.actionStatus, 'status', GenericStatus.success),
      ],
      verify: (_) => expect(
        verify(
          () => stageRepository.reorderStages(1, captureAny()),
        ).captured.single,
        [2, 3, 1],
      ),
    );

    blocTest<StagePlanBloc, StagePlanState>(
      'when the server refuses the order then the list goes back and it '
      'shows why',
      setUp: () => when(
        () => stageRepository.reorderStages(any(), any()),
      ).thenThrow(const HttpException400(code: AppErrorCode.stageLocked)),
      build: build,
      seed: () => loaded,
      act: (bloc) => bloc.add(
        const StagePlanEvent.reorderRequested(oldIndex: 2, newIndex: 0),
      ),
      skip: 1,
      expect: () => [
        isA<StagePlanState>()
            .having(names, 'stages', ['A', 'B', 'C'])
            .having((s) => s.actionStatus, 'status', GenericStatus.failure)
            .having(
              (s) => s.actionErrorMessage,
              'message',
              l10n.errorStageLocked,
            ),
      ],
    );

    blocTest<StagePlanBloc, StagePlanState>(
      'when a stage is dropped where it was then nothing is sent',
      build: build,
      seed: () => loaded,
      act: (bloc) => bloc.add(
        const StagePlanEvent.reorderRequested(oldIndex: 1, newIndex: 1),
      ),
      expect: () => <StagePlanState>[],
      verify: (_) =>
          verifyNever(() => stageRepository.reorderStages(any(), any())),
    );

    blocTest<StagePlanBloc, StagePlanState>(
      'when a site manager tries then nothing is sent',
      build: build,
      seed: () => loaded.copyWith(
        overview: testOverview(role: ProjectRole.siteManager),
      ),
      act: (bloc) => bloc.add(
        const StagePlanEvent.reorderRequested(oldIndex: 0, newIndex: 2),
      ),
      expect: () => <StagePlanState>[],
    );
  });

  group('Given an empty plan', () {
    final empty = loaded.copyWith(plan: testStagePlan(stages: []));

    blocTest<StagePlanBloc, StagePlanState>(
      'when the owner applies a template then its stages are created',
      setUp: () => when(
        () => stageRepository.createPlan(1, any()),
      ).thenAnswer((_) async => plan),
      build: build,
      seed: () => empty,
      act: (bloc) => bloc.add(
        const StagePlanEvent.templateApplied(
          template: StageTemplate.renovation,
        ),
      ),
      expect: () => [
        empty.copyWith(
          flowStep: GenericFlowStep.creatingItem,
          actionStatus: GenericStatus.loading,
        ),
        empty.copyWith(
          plan: plan,
          flowStep: GenericFlowStep.creatingItem,
          actionStatus: GenericStatus.success,
        ),
      ],
      verify: (_) => expect(
        (verify(
                  () => stageRepository.createPlan(1, captureAny()),
                ).captured.single
                as List<StageDraft>)
            .length,
        6,
      ),
    );
  });

  test(
    'Given a completed project then even the owner cannot edit the plan',
    () {
      final completed = loaded.copyWith(
        overview: testOverview(
          project: testProject(status: ProjectStatus.completed),
        ),
      );

      expect(loaded.canEdit, isTrue);
      expect(completed.canEdit, isFalse);
      expect(
        loaded
            .copyWith(overview: testOverview(role: ProjectRole.viewer))
            .canEdit,
        isFalse,
      );
    },
  );
}
