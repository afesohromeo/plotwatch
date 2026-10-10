import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Projects (`client.project`, PROJ-01–05).
class ProjectApiProvider {
  Client get _client => ApiProvider().client;

  /// [stages]: the chosen template's plan, created with the project
  /// (decision M3-3).
  Future<ProjectOverview> create(
    ProjectDetails details, {
    List<StageDraft>? stages,
  }) async {
    try {
      return await _client.project.create(details, stages: stages);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  /// [status], [search] and [sort]: doc/05 §9.5.
  Future<ProjectSummaryPage> list({
    int? page,
    int? pageSize,
    ProjectStatus? status,
    String? search,
    ProjectSort? sort,
  }) async {
    try {
      return await _client.project.list(
        page: page,
        pageSize: pageSize,
        status: status,
        search: search,
        sort: sort,
      );
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<ProjectOverview> get(int projectId) async {
    try {
      return await _client.project.get(projectId);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<ProjectOverview> update(int projectId, ProjectDetails details) async {
    try {
      return await _client.project.update(projectId, details);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<ProjectOverview> setStatus(int projectId, ProjectStatus status) async {
    try {
      return await _client.project.setStatus(projectId, status);
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
