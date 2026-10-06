part of 'create_project_bloc.dart';

/// Wizard steps (PROJ-08). The Stages step is added in M3.
enum CreateProjectStep { details, review }

@freezed
sealed class CreateProjectState with _$CreateProjectState {
  const factory CreateProjectState({
    @Default(CreateProjectStep.details) CreateProjectStep step,
    ProjectDetails? details,
    @Default(GenericStatus.initial) GenericStatus createStatus,
    String? createErrorMessage,

    /// The new project, once created; the page then opens it.
    ProjectOverview? created,
  }) = _CreateProjectState;
}
