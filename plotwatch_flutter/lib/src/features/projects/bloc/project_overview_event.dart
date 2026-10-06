part of 'project_overview_bloc.dart';

@freezed
sealed class ProjectOverviewEvent with _$ProjectOverviewEvent {
  const factory ProjectOverviewEvent.fetchProject({required int projectId}) =
      _FetchProject;

  /// Saves new details of the loaded project (owner, PROJ-04).
  const factory ProjectOverviewEvent.updateProject({
    required ProjectDetails details,
  }) = _UpdateProject;

  /// Moves the loaded project to [status] (owner, PROJ-05).
  const factory ProjectOverviewEvent.changeStatus({
    required ProjectStatus status,
  }) = _ChangeStatus;

  const factory ProjectOverviewEvent.resetFlowStep() = _ResetFlowStep;
}
