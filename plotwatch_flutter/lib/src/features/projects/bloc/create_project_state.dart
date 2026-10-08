part of 'create_project_bloc.dart';

/// Wizard steps (PROJ-08, doc/04c M3-3).
enum CreateProjectStep { details, stages, review }

@freezed
sealed class CreateProjectState with _$CreateProjectState {
  const factory CreateProjectState({
    @Default(CreateProjectStep.details) CreateProjectStep step,
    ProjectDetails? details,

    /// The stage plan to start from; editable after creation.
    @Default(StageTemplate.singleStoreyHouse) StageTemplate template,
    @Default(GenericStatus.initial) GenericStatus createStatus,
    String? createErrorMessage,

    /// The new project, once created; the page then opens it.
    ProjectOverview? created,
  }) = _CreateProjectState;
}
