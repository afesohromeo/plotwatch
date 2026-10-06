part of 'project_list_bloc.dart';

@freezed
sealed class ProjectListState with _$ProjectListState {
  const factory ProjectListState({
    // --- Projects (infinite-scroll pagination, _standards/13) ---
    @Default([]) List<ProjectSummary> projects,
    @Default([]) List<ProjectSummary> paginatedProjects,
    @Default(false) bool maxProjects,
    @Default(false) bool projectsRefreshController,
    @Default(0) int projectsPageKey,
    @Default(GenericStatus.initial) GenericStatus projectsListStatus,
    String? projectsListError,
  }) = _ProjectListState;
}
