part of 'project_list_bloc.dart';

@freezed
sealed class ProjectListEvent with _$ProjectListEvent {
  /// Fetches a page of the caller's projects (`_standards/13`).
  const factory ProjectListEvent.fetchProjects({
    @Default(0) int pageKey,
    int? size,
  }) = _FetchProjects;

  const factory ProjectListEvent.refreshProjects() = _RefreshProjects;
}
