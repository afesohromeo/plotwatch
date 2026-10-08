import 'dart:developer';

import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// A project's stage plan (doc/04c). Errors are logged and rethrown
/// (RULE-012).
class StageRepository {
  StageRepository({StageApiProvider? apiProvider})
    : _apiProvider = apiProvider ?? StageApiProvider();

  final StageApiProvider _apiProvider;

  Future<StagePlan> fetchPlan(int projectId) =>
      _logged('fetching the stage plan', () => _apiProvider.plan(projectId));

  Future<StageView> fetchStage(int projectId, int stageId) =>
      _logged('fetching a stage', () => _apiProvider.get(projectId, stageId));

  /// Fills an empty plan, e.g. from a template (decision M3-3).
  Future<StagePlan> createPlan(int projectId, List<StageDraft> stages) =>
      _logged(
        'creating the stage plan',
        () => _apiProvider.createPlan(projectId, stages),
      );

  Future<StageView> createStage(int projectId, StageDraft draft) =>
      _logged('creating a stage', () => _apiProvider.create(projectId, draft));

  Future<StageView> updateStage(int projectId, int stageId, StageDraft draft) =>
      _logged(
        'updating a stage',
        () => _apiProvider.update(projectId, stageId, draft),
      );

  Future<void> deleteStage(int projectId, int stageId) => _logged(
    'deleting a stage',
    () => _apiProvider.delete(projectId, stageId),
  );

  Future<StagePlan> reorderStages(int projectId, List<int> stageIds) => _logged(
    'reordering stages',
    () => _apiProvider.reorder(projectId, stageIds),
  );

  Future<StageView> startStage(int projectId, int stageId) =>
      _logged('starting a stage', () => _apiProvider.start(projectId, stageId));

  Future<T> _logged<T>(String what, Future<T> Function() call) async {
    try {
      return await call();
    } catch (e) {
      log('Error $what: $e');
      rethrow;
    }
  }
}
