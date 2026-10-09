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
  late MockEvidenceRepository evidenceRepository;

  final view = testStageView(id: 2);
  final started = testStageView(id: 2, status: StageStatus.inProgress);

  setUpAll(() => l10n = setUpTestLocalization());
  setUp(() {
    stageRepository = MockStageRepository();
    projectRepository = MockProjectRepository();
    evidenceRepository = MockEvidenceRepository();
    when(
      () => evidenceRepository.fetchStageEvidence(any(), any()),
    ).thenAnswer((_) async => []);
    when(
      () => stageRepository.fetchReviews(any(), any()),
    ).thenAnswer((_) async => []);
  });

  StageBloc build() => StageBloc(
    stageRepository: stageRepository,
    projectRepository: projectRepository,
    evidenceRepository: evidenceRepository,
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
          action: StageAction.start,
          flowStep: GenericFlowStep.updatingItem,
          actionStatus: GenericStatus.loading,
        ),
        asManager.copyWith(
          view: started,
          action: StageAction.start,
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
          action: StageAction.start,
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
          action: StageAction.delete,
          flowStep: GenericFlowStep.deletingItem,
          actionStatus: GenericStatus.loading,
        ),
        asOwner.copyWith(
          action: StageAction.delete,
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
          action: StageAction.delete,
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

  // doc/04d group D: the stage's captures, and who may add one.
  group("Given the stage's captures", () {
    final mine = testEvidence(id: 9, checklistItemId: 20);
    final other = testEvidence(id: 8, checklistItemId: 21);

    blocTest<StageBloc, StageState>(
      'when the stage loads then its captures come with it, by item',
      setUp: () {
        when(
          () => projectRepository.fetchProject(1),
        ).thenAnswer((_) async => testOverview());
        when(
          () => stageRepository.fetchStage(1, 2),
        ).thenAnswer((_) async => view);
        when(
          () => evidenceRepository.fetchStageEvidence(1, 2),
        ).thenAnswer((_) async => [mine, other]);
      },
      build: build,
      act: (bloc) => bloc.add(const StageEvent.load(projectId: 1, stageId: 2)),
      verify: (bloc) {
        expect(bloc.state.evidenceFor(20), [mine]);
        expect(bloc.state.evidenceFor(21), [other]);
        expect(bloc.state.evidenceFor(99), isEmpty);
      },
    );

    test('then only the site manager captures, on an active project and an '
        'open stage', () {
      expect(loaded(role: ProjectRole.siteManager).canCapture, isTrue);
      expect(
        loaded(role: ProjectRole.siteManager, stage: started).canCapture,
        isTrue,
      );
      expect(loaded().canCapture, isFalse);
      expect(
        loaded(
          role: ProjectRole.siteManager,
          projectStatus: ProjectStatus.draft,
        ).canCapture,
        isFalse,
      );
      expect(
        loaded(
          role: ProjectRole.siteManager,
          stage: testStageView(id: 2, status: StageStatus.submitted),
        ).canCapture,
        isFalse,
      );
    });
  });

  // doc/04e group D (decisions M5-2, M5-3, M5-8).
  group('Given the review loop', () {
    final inProgress = testStageView(id: 2, status: StageStatus.inProgress);
    final submitted = testStageView(id: 2, status: StageStatus.submitted);
    final approved = testStageView(id: 2, status: StageStatus.approved);
    final managerAtWork = loaded(
      role: ProjectRole.siteManager,
      stage: inProgress,
    );
    final ownerReviewing = loaded(stage: submitted);
    final changes = StageReviewView(
      review: StageReview(
        id: 1,
        stageId: 2,
        reviewerId: UuidValue.fromString(testManagerId),
        decision: ReviewDecision.changesRequested,
        comment: 'Too dark',
        createdAt: DateTime.utc(2026, 10, 9),
      ),
      reviewerName: 'Ada Lovelace',
    );

    blocTest<StageBloc, StageState>(
      'when the site manager submits then the stage is shown submitted',
      setUp: () => when(
        () => stageRepository.submitStage(1, 2),
      ).thenAnswer((_) async => submitted),
      build: build,
      seed: () => managerAtWork,
      act: (bloc) => bloc.add(const StageEvent.submitRequested()),
      verify: (bloc) {
        expect(bloc.state.view, submitted);
        expect(bloc.state.action, StageAction.submit);
        expect(bloc.state.actionStatus, GenericStatus.success);
      },
    );

    blocTest<StageBloc, StageState>(
      'when the checklist is incomplete then it shows why',
      setUp: () =>
          when(() => stageRepository.submitStage(any(), any())).thenThrow(
            const HttpException400(code: AppErrorCode.checklistIncomplete),
          ),
      build: build,
      seed: () => managerAtWork,
      act: (bloc) => bloc.add(const StageEvent.submitRequested()),
      verify: (bloc) =>
          expect(bloc.state.actionErrorMessage, l10n.errorChecklistIncomplete),
    );

    blocTest<StageBloc, StageState>(
      'when the owner approves then the stage and its history are refreshed',
      setUp: () {
        when(
          () => stageRepository.reviewStage(1, 2, ReviewDecision.approved),
        ).thenAnswer((_) async => approved);
        when(
          () => stageRepository.fetchReviews(1, 2),
        ).thenAnswer((_) async => [changes]);
      },
      build: build,
      seed: () => ownerReviewing,
      act: (bloc) => bloc.add(
        const StageEvent.reviewRequested(decision: ReviewDecision.approved),
      ),
      verify: (bloc) {
        expect(bloc.state.view, approved);
        expect(bloc.state.reviews, [changes]);
        expect(bloc.state.action, StageAction.approve);
      },
    );

    blocTest<StageBloc, StageState>(
      'when the owner requests changes then the comment is sent',
      setUp: () => when(
        () => stageRepository.reviewStage(
          1,
          2,
          ReviewDecision.changesRequested,
          comment: 'Too dark',
        ),
      ).thenAnswer((_) async => inProgress),
      build: build,
      seed: () => ownerReviewing,
      act: (bloc) => bloc.add(
        const StageEvent.reviewRequested(
          decision: ReviewDecision.changesRequested,
          comment: 'Too dark',
        ),
      ),
      verify: (bloc) => expect(bloc.state.action, StageAction.requestChanges),
    );

    test('then only the site manager submits an open stage on an active '
        'project, and the missing required items are named', () {
      final evidence = [testEvidence(checklistItemId: 21)];
      // Item 20 is required, 21 optional (testStageView).
      final incomplete = managerAtWork.copyWith(evidence: evidence);
      final complete = managerAtWork.copyWith(
        evidence: [testEvidence(checklistItemId: 20)],
      );

      expect(incomplete.canSubmit, isTrue);
      expect(incomplete.missingItems.map((i) => i.id), [20]);
      expect(complete.missingItems, isEmpty);
      expect(
        managerAtWork
            .copyWith(
              evidence: [
                testEvidence(
                  checklistItemId: 20,
                  status: EvidenceStatus.retracted,
                ),
              ],
            )
            .missingItems
            .map((i) => i.id),
        [20],
      );
      expect(loaded(stage: inProgress).canSubmit, isFalse);
      expect(
        loaded(role: ProjectRole.siteManager, stage: submitted).canSubmit,
        isFalse,
      );
    });

    test('then the owner and an approving co-funder review a submitted '
        'stage, nobody else', () {
      StageState as(ProjectRole role, {bool canApprove = false}) => StageState(
        projectId: 1,
        stageId: 2,
        overview: testOverview(
          role: role,
          canApprove: canApprove,
          project: testProject(status: ProjectStatus.active),
        ),
        view: submitted,
        loadStatus: GenericStatus.success,
      );

      expect(as(ProjectRole.owner).canReview, isTrue);
      expect(as(ProjectRole.coFunder, canApprove: true).canReview, isTrue);
      expect(as(ProjectRole.coFunder).canReview, isFalse);
      expect(as(ProjectRole.siteManager).canReview, isFalse);
      expect(as(ProjectRole.viewer).canReview, isFalse);
      expect(ownerReviewing.copyWith(view: inProgress).canReview, isFalse);
    });

    test('then the site manager sees the last changes requested', () {
      final again = managerAtWork.copyWith(
        view: testStageView(id: 2, status: StageStatus.changesRequested),
        reviews: [changes],
      );

      expect(again.lastChangesRequested, changes);
      expect(managerAtWork.lastChangesRequested, isNull);
    });
  });
}
