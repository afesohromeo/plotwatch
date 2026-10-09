import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The site manager's progress updates (`client.progressUpdate`, UPD-01;
/// doc/04e M5-9 b).
class UpdateApiProvider {
  Client get _client => ApiProvider().client;

  Future<ProgressUpdate> create(
    int projectId,
    ProgressUpdateDraft draft,
  ) async {
    try {
      return await _client.progressUpdate.create(projectId, draft);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<ProgressUpdate> get(int projectId, int updateId) async {
    try {
      return await _client.progressUpdate.get(projectId, updateId);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
