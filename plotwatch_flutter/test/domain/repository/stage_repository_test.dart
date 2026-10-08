import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../helpers/helpers.dart';

// Plan: doc/04c-m3-stages.md, group B: the stage plan through
// `client.stage`.
void main() {
  late MockStageApiProvider apiProvider;
  late StageRepository repository;

  setUp(() {
    apiProvider = MockStageApiProvider();
    repository = StageRepository(apiProvider: apiProvider);
  });

  group('Given the stage repository', () {
    test('when the plan or one stage is fetched then the server answer is '
        'returned', () async {
      final plan = testStagePlan();
      final view = testStageView();
      when(() => apiProvider.plan(1)).thenAnswer((_) async => plan);
      when(() => apiProvider.get(1, 2)).thenAnswer((_) async => view);

      expect(await repository.fetchPlan(1), plan);
      expect(await repository.fetchStage(1, 2), view);
    });

    test('when stages are created, updated, started or a plan is filled '
        'then the server answer is returned', () async {
      final draft = testStageDraft();
      final view = testStageView();
      final plan = testStagePlan();
      // Lists compare by identity, so the same list is used on both sides.
      final drafts = [draft];
      when(() => apiProvider.create(1, draft)).thenAnswer((_) async => view);
      when(() => apiProvider.update(1, 2, draft)).thenAnswer((_) async => view);
      when(() => apiProvider.start(1, 2)).thenAnswer((_) async => view);
      when(
        () => apiProvider.createPlan(1, drafts),
      ).thenAnswer((_) async => plan);

      expect(await repository.createStage(1, draft), view);
      expect(await repository.updateStage(1, 2, draft), view);
      expect(await repository.startStage(1, 2), view);
      expect(await repository.createPlan(1, drafts), plan);
    });

    test('when stages are reordered or one is deleted then the call goes '
        'through', () async {
      final plan = testStagePlan();
      final order = [2, 1];
      when(() => apiProvider.reorder(1, order)).thenAnswer((_) async => plan);
      when(() => apiProvider.delete(1, 2)).thenAnswer((_) async {});

      expect(await repository.reorderStages(1, order), plan);
      await repository.deleteStage(1, 2);

      verify(() => apiProvider.delete(1, 2)).called(1);
    });

    test('when a call fails then the error is rethrown', () async {
      when(
        () => apiProvider.plan(any()),
      ).thenThrow(const HttpException400(code: AppErrorCode.stageNotFound));

      await expectLater(
        repository.fetchPlan(1),
        throwsA(isA<HttpException400>()),
      );
    });
  });
}
