import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The stage plan (`client.stage`, STG-01–09; doc/04c).
class StageApiProvider {
  Client get _client => ApiProvider().client;

  Future<StagePlan> plan(int projectId) =>
      _call(() => _client.stage.plan(projectId));

  Future<StageView> get(int projectId, int stageId) =>
      _call(() => _client.stage.get(projectId, stageId));

  Future<StagePlan> createPlan(int projectId, List<StageDraft> stages) =>
      _call(() => _client.stage.createPlan(projectId, stages));

  Future<StageView> create(int projectId, StageDraft draft) =>
      _call(() => _client.stage.create(projectId, draft));

  Future<StageView> update(int projectId, int stageId, StageDraft draft) =>
      _call(() => _client.stage.update(projectId, stageId, draft));

  Future<void> delete(int projectId, int stageId) =>
      _call(() => _client.stage.delete(projectId, stageId));

  Future<StagePlan> reorder(int projectId, List<int> stageIds) =>
      _call(() => _client.stage.reorder(projectId, stageIds));

  Future<StageView> start(int projectId, int stageId) =>
      _call(() => _client.stage.start(projectId, stageId));

  Future<StageView> submit(int projectId, int stageId) =>
      _call(() => _client.stage.submit(projectId, stageId));

  Future<StageView> review(
    int projectId,
    int stageId,
    ReviewDecision decision, {
    String? comment,
  }) => _call(
    () => _client.stage.review(projectId, stageId, decision, comment: comment),
  );

  Future<List<StageReviewView>> reviews(int projectId, int stageId) =>
      _call(() => _client.stage.reviews(projectId, stageId));

  Future<T> _call<T>(Future<T> Function() call) async {
    try {
      return await call();
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
