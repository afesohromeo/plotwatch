import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../../helpers/helpers.dart';

// Plan: doc/04b-m2-projects-site-members.md, group E. Infinite scroll per
// _standards/13.
void main() {
  late AppLocalizations l10n;
  late MockProjectRepository repository;

  final first = testSummary(id: 1, name: 'First');
  final second = testSummary(id: 2, name: 'Second');

  PaginatedList<ProjectSummary> page(List<ProjectSummary> items) =>
      PaginatedList(content: items, pagination: const Pagination(size: 20));

  setUpAll(() => l10n = setUpTestLocalization());
  setUp(() => repository = MockProjectRepository());

  ProjectListBloc build() => ProjectListBloc(projectRepository: repository);

  group('Given the project list', () {
    blocTest<ProjectListBloc, ProjectListState>(
      'when the first page is shorter than the page size then it is the last',
      setUp: () => when(
        () => repository.fetchProjects(0, size: 20),
      ).thenAnswer((_) async => page([first, second])),
      build: build,
      act: (bloc) => bloc.add(const ProjectListEvent.fetchProjects()),
      expect: () => [
        const ProjectListState(projectsListStatus: GenericStatus.loading),
        ProjectListState(
          projectsListStatus: GenericStatus.success,
          projects: [first, second],
          paginatedProjects: [first, second],
          maxProjects: true,
        ),
      ],
    );

    final fullPage = [
      for (var i = 0; i < 20; i++) testSummary(id: 100 + i, name: 'P$i'),
    ];
    blocTest<ProjectListBloc, ProjectListState>(
      'when a full next page arrives then it is appended and more may follow',
      setUp: () => when(
        () => repository.fetchProjects(1, size: 20),
      ).thenAnswer((_) async => page(fullPage)),
      build: build,
      seed: () => ProjectListState(
        projectsListStatus: GenericStatus.success,
        projects: [first],
        paginatedProjects: [first],
      ),
      act: (bloc) => bloc.add(const ProjectListEvent.fetchProjects(pageKey: 1)),
      skip: 1,
      expect: () => [
        ProjectListState(
          projectsListStatus: GenericStatus.success,
          projects: [first, ...fullPage],
          paginatedProjects: fullPage,
          maxProjects: false,
          projectsPageKey: 1,
        ),
      ],
    );

    final failures = <String, (Object, String Function())>{
      'the server refuses': (
        const HttpException400(code: AppErrorCode.permissionDenied),
        () => l10n.errorPermissionDenied,
      ),
      'the session expired': (
        const HttpException401(),
        () => l10n.errorUnauthorized,
      ),
      'the device is offline': (
        const NetworkException(),
        () => l10n.networkError,
      ),
      'something unexpected happens': (
        StateError('x'),
        () => l10n.errorProjectsLoad,
      ),
    };
    for (final MapEntry(key: when_, value: (error, message))
        in failures.entries) {
      blocTest<ProjectListBloc, ProjectListState>(
        'when $when_ then it shows the matching message',
        setUp: () =>
            when(() => repository.fetchProjects(0, size: 20)).thenThrow(error),
        build: build,
        act: (bloc) => bloc.add(const ProjectListEvent.fetchProjects()),
        skip: 1,
        expect: () => [
          ProjectListState(
            projectsListStatus: GenericStatus.failure,
            projectsListError: message(),
          ),
        ],
      );
    }

    blocTest<ProjectListBloc, ProjectListState>(
      'when it is refreshed then it resets and asks the list to reload',
      build: build,
      seed: () => ProjectListState(
        projectsListStatus: GenericStatus.success,
        projects: [first],
        paginatedProjects: [first],
        maxProjects: true,
        projectsPageKey: 3,
      ),
      act: (bloc) => bloc.add(const ProjectListEvent.refreshProjects()),
      expect: () => [const ProjectListState(projectsRefreshController: true)],
    );
  });
}
