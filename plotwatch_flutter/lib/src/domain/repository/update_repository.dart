import 'dart:developer';

import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Progress updates (UPD-01; doc/04e M5-9 b). Errors are logged and
/// rethrown (RULE-012).
class UpdateRepository {
  UpdateRepository({UpdateApiProvider? apiProvider})
    : _apiProvider = apiProvider ?? UpdateApiProvider();

  final UpdateApiProvider _apiProvider;

  Future<ProgressUpdate> createUpdate(
    int projectId,
    ProgressUpdateDraft draft,
  ) =>
      _logged('posting an update', () => _apiProvider.create(projectId, draft));

  Future<ProgressUpdate> fetchUpdate(int projectId, int updateId) => _logged(
    'fetching an update',
    () => _apiProvider.get(projectId, updateId),
  );

  Future<T> _logged<T>(String what, Future<T> Function() call) async {
    try {
      return await call();
    } catch (e) {
      log('Error $what: $e');
      rethrow;
    }
  }
}
