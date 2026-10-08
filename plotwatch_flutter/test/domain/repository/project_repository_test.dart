import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../helpers/helpers.dart';

// Plan: doc/04b-m2-projects-site-members.md, group E.
void main() {
  late MockProjectApiProvider apiProvider;
  late ProjectRepository repository;

  setUp(() {
    apiProvider = MockProjectApiProvider();
    repository = ProjectRepository(apiProvider: apiProvider);
  });

  group('Given the project repository', () {
    test('when a page of projects is fetched then it becomes a PaginatedList '
        'with the page size the server used', () async {
      final summary = testSummary();
      when(() => apiProvider.list(page: 2, pageSize: 20)).thenAnswer(
        (_) async =>
            ProjectSummaryPage(items: [summary], page: 2, pageSize: 20),
      );

      final result = await repository.fetchProjects(2, size: 20);

      expect(result.content, [summary]);
      expect(result.pagination.size, 20);
    });

    test('when fetching projects fails then the error is rethrown', () async {
      when(
        () => apiProvider.list(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
        ),
      ).thenThrow(const NetworkException());

      await expectLater(
        repository.fetchProjects(0),
        throwsA(isA<NetworkException>()),
      );
    });

    test('when a project is created then the details are sent once', () async {
      final overview = testOverview();
      when(
        () => apiProvider.create(testDetails),
      ).thenAnswer((_) async => overview);

      final result = await repository.createProject(testDetails);

      expect(result, overview);
      verify(() => apiProvider.create(testDetails)).called(1);
    });

    // doc/04c M3-3: the wizard sends the template's stages with the project.
    test(
      'when a project is created with stages then they are sent with it',
      () async {
        final overview = testOverview(stageCount: 1);
        final stages = [testStageDraft()];
        when(
          () => apiProvider.create(testDetails, stages: stages),
        ).thenAnswer((_) async => overview);

        expect(
          await repository.createProject(testDetails, stages: stages),
          overview,
        );
      },
    );

    test('when a project is fetched, updated or its status changed then the '
        'server answer is returned', () async {
      final overview = testOverview();
      when(() => apiProvider.get(1)).thenAnswer((_) async => overview);
      when(
        () => apiProvider.update(1, testDetails),
      ).thenAnswer((_) async => overview);
      when(
        () => apiProvider.setStatus(1, ProjectStatus.paused),
      ).thenAnswer((_) async => overview);

      expect(await repository.fetchProject(1), overview);
      expect(await repository.updateProject(1, testDetails), overview);
      expect(
        await repository.setProjectStatus(1, ProjectStatus.paused),
        overview,
      );
    });
  });
}
