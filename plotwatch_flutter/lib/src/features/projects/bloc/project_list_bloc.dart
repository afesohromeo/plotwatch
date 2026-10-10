import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'project_list_event.dart';
part 'project_list_state.dart';
part 'project_list_bloc.freezed.dart';

const _kProjectsPageSize = 20;

/// The caller's projects as an infinite-scroll list (PROJ-03,
/// `_standards/13`).
class ProjectListBloc extends Bloc<ProjectListEvent, ProjectListState> {
  ProjectListBloc({required this._projectRepository})
    : super(const ProjectListState()) {
    on<_FetchProjects>(_onFetchProjects);
    on<_RefreshProjects>(_onRefreshProjects);
  }

  final ProjectRepository _projectRepository;

  Future<void> _onFetchProjects(
    _FetchProjects event,
    Emitter<ProjectListState> emit,
  ) async {
    final l10n = LocalizationService.localization;
    emit(
      state.copyWith(
        projectsListStatus: event.searchTerm != null
            ? GenericStatus.filtering
            : GenericStatus.loading,
        projectsListError: null,
        projects: event.pageKey == 0 ? [] : state.projects,
        projectsRefreshController: false,
      ),
    );

    try {
      final result = await _projectRepository.fetchProjects(
        event.pageKey,
        size: event.size ?? _kProjectsPageSize,
        status: event.statusFilter,
        keyword: event.searchTerm,
        sort: event.sort,
      );
      final newItems = List<ProjectSummary>.from(result.content);
      emit(
        state.copyWith(
          projectsListStatus: GenericStatus.success,
          paginatedProjects: newItems,
          maxProjects:
              newItems.length < (result.pagination.size ?? _kProjectsPageSize),
          projectsPageKey: event.pageKey,
          projects: event.pageKey == 0
              ? newItems
              : [...state.projects, ...newItems],
        ),
      );
    } on HttpException400 catch (e) {
      emit(_failure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_failure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_failure(l10n.networkError));
    } catch (e) {
      log('ProjectListBloc._onFetchProjects error: $e');
      emit(_failure(l10n.errorProjectsLoad));
    }
  }

  void _onRefreshProjects(
    _RefreshProjects event,
    Emitter<ProjectListState> emit,
  ) {
    emit(
      state.copyWith(
        projectsListStatus: GenericStatus.initial,
        projects: [],
        paginatedProjects: [],
        projectsPageKey: 0,
        maxProjects: false,
        projectsRefreshController: true,
      ),
    );
  }

  ProjectListState _failure(String message) => state.copyWith(
    projectsListStatus: GenericStatus.failure,
    projectsListError: message,
  );
}
