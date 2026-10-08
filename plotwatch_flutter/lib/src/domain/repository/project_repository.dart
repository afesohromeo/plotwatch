import 'dart:developer';

import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Projects. Errors are logged and rethrown (RULE-012).
class ProjectRepository {
  ProjectRepository({ProjectApiProvider? apiProvider})
    : _apiProvider = apiProvider ?? ProjectApiProvider();

  final ProjectApiProvider _apiProvider;

  /// A page of the caller's projects (`_standards/14` §3.2).
  Future<PaginatedList<ProjectSummary>> fetchProjects(
    int pageKey, {
    int? size,
  }) async {
    try {
      final page = await _apiProvider.list(page: pageKey, pageSize: size);
      return PaginatedList(
        content: page.items,
        pagination: Pagination(size: page.pageSize),
      );
    } catch (e) {
      log('Error fetching projects: $e');
      rethrow;
    }
  }

  /// Creates the project with its first [stages], if any, in one request
  /// (decision M3-3).
  Future<ProjectOverview> createProject(
    ProjectDetails details, {
    List<StageDraft> stages = const [],
  }) async {
    try {
      return await _apiProvider.create(
        details,
        stages: stages.isEmpty ? null : stages,
      );
    } catch (e) {
      log('Error creating project: $e');
      rethrow;
    }
  }

  Future<ProjectOverview> fetchProject(int projectId) async {
    try {
      return await _apiProvider.get(projectId);
    } catch (e) {
      log('Error fetching project: $e');
      rethrow;
    }
  }

  Future<ProjectOverview> updateProject(
    int projectId,
    ProjectDetails details,
  ) async {
    try {
      return await _apiProvider.update(projectId, details);
    } catch (e) {
      log('Error updating project: $e');
      rethrow;
    }
  }

  Future<ProjectOverview> setProjectStatus(
    int projectId,
    ProjectStatus status,
  ) async {
    try {
      return await _apiProvider.setStatus(projectId, status);
    } catch (e) {
      log('Error changing project status: $e');
      rethrow;
    }
  }
}
