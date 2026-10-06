import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04b-m2-projects-site-members.md, group E.
void main() {
  late AppLocalizations l10n;
  late MockProjectRepository repository;

  final overview = testOverview();
  final loaded = ProjectOverviewState(
    overviewStatus: GenericStatus.success,
    overview: overview,
  );

  setUpAll(() {
    l10n = setUpTestLocalization();
    registerFallbackValue(testDetails);
    registerFallbackValue(ProjectStatus.active);
  });
  setUp(() => repository = MockProjectRepository());

  ProjectOverviewBloc build() =>
      ProjectOverviewBloc(projectRepository: repository);

  group('Given a project is opened', () {
    blocTest<ProjectOverviewBloc, ProjectOverviewState>(
      'when it loads then the overview is kept',
      setUp: () =>
          when(() => repository.fetchProject(1)).thenAnswer((_) async => overview),
      build: build,
      act: (bloc) =>
          bloc.add(const ProjectOverviewEvent.fetchProject(projectId: 1)),
      expect: () => [
        const ProjectOverviewState(overviewStatus: GenericStatus.loading),
        loaded,
      ],
    );

    final failures = <String, (Object, String Function())>{
      'the user is not a member': (
        const HttpException400(code: AppErrorCode.projectNotFound),
        () => l10n.errorProjectNotFound
      ),
      'the session expired': (
        const HttpException401(),
        () => l10n.errorUnauthorized
      ),
      'the device is offline': (
        const NetworkException(),
        () => l10n.networkError
      ),
      'something unexpected happens': (
        StateError('x'),
        () => l10n.errorProjectLoad
      ),
    };
    for (final MapEntry(key: when_, value: (error, message))
        in failures.entries) {
      blocTest<ProjectOverviewBloc, ProjectOverviewState>(
        'when $when_ then it shows the matching message',
        setUp: () => when(() => repository.fetchProject(1)).thenThrow(error),
        build: build,
        act: (bloc) =>
            bloc.add(const ProjectOverviewEvent.fetchProject(projectId: 1)),
        skip: 1,
        expect: () => [
          ProjectOverviewState(
            overviewStatus: GenericStatus.failure,
            overviewErrorMessage: message(),
          ),
        ],
      );
    }
  });

  group('Given a loaded project', () {
    final renamed = testOverview(project: testProject(name: 'Bigger house'));

    blocTest<ProjectOverviewBloc, ProjectOverviewState>(
      'when the owner saves new details then the overview is replaced',
      setUp: () => when(() => repository.updateProject(1, testDetails))
          .thenAnswer((_) async => renamed),
      build: build,
      seed: () => loaded,
      act: (bloc) =>
          bloc.add(ProjectOverviewEvent.updateProject(details: testDetails)),
      expect: () => [
        loaded.copyWith(
          flowStep: GenericFlowStep.updatingItem,
          actionStatus: GenericStatus.loading,
        ),
        loaded.copyWith(
          flowStep: GenericFlowStep.updatingItem,
          actionStatus: GenericStatus.success,
          overview: renamed,
        ),
      ],
    );

    final paused = testOverview(
        project: testProject(status: ProjectStatus.paused));
    blocTest<ProjectOverviewBloc, ProjectOverviewState>(
      'when the owner changes the status then the overview is replaced',
      setUp: () => when(() => repository.setProjectStatus(1, ProjectStatus.paused))
          .thenAnswer((_) async => paused),
      build: build,
      seed: () => loaded,
      act: (bloc) => bloc.add(
          const ProjectOverviewEvent.changeStatus(status: ProjectStatus.paused)),
      skip: 1,
      expect: () => [
        loaded.copyWith(
          flowStep: GenericFlowStep.updatingItem,
          actionStatus: GenericStatus.success,
          overview: paused,
        ),
      ],
    );

    blocTest<ProjectOverviewBloc, ProjectOverviewState>(
      'when the server refuses the status then it shows why',
      setUp: () => when(() => repository.setProjectStatus(any(), any()))
          .thenThrow(const HttpException400(
              code: AppErrorCode.invalidStatusTransition)),
      build: build,
      seed: () => loaded,
      act: (bloc) => bloc.add(
          const ProjectOverviewEvent.changeStatus(status: ProjectStatus.active)),
      skip: 1,
      expect: () => [
        loaded.copyWith(
          flowStep: GenericFlowStep.updatingItem,
          actionStatus: GenericStatus.failure,
          actionErrorMessage: l10n.errorInvalidStatusTransition,
        ),
      ],
    );

    blocTest<ProjectOverviewBloc, ProjectOverviewState>(
      'when saving fails unexpectedly then it shows the save message',
      setUp: () => when(() => repository.updateProject(any(), any()))
          .thenThrow(StateError('x')),
      build: build,
      seed: () => loaded,
      act: (bloc) =>
          bloc.add(ProjectOverviewEvent.updateProject(details: testDetails)),
      skip: 1,
      expect: () => [
        loaded.copyWith(
          flowStep: GenericFlowStep.updatingItem,
          actionStatus: GenericStatus.failure,
          actionErrorMessage: l10n.errorProjectSave,
        ),
      ],
    );

    blocTest<ProjectOverviewBloc, ProjectOverviewState>(
      'when the result has been shown then the action is reset',
      build: build,
      seed: () => loaded.copyWith(
        flowStep: GenericFlowStep.updatingItem,
        actionStatus: GenericStatus.success,
      ),
      act: (bloc) => bloc.add(const ProjectOverviewEvent.resetFlowStep()),
      expect: () => [loaded],
    );
  });
}
