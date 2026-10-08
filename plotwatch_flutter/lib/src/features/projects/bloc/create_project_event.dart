part of 'create_project_bloc.dart';

@freezed
sealed class CreateProjectEvent with _$CreateProjectEvent {
  /// The details step is valid: show the stages step.
  const factory CreateProjectEvent.detailsSubmitted({
    required ProjectDetails details,
  }) = _DetailsSubmitted;

  /// The owner picks a stage template (decision M3-2).
  const factory CreateProjectEvent.templateChosen({
    required StageTemplate template,
  }) = _TemplateChosen;

  /// The template is confirmed: show the review.
  const factory CreateProjectEvent.stagesSubmitted() = _StagesSubmitted;

  /// One step back, keeping what was entered.
  const factory CreateProjectEvent.stepBack() = _StepBack;

  /// Creates the project with the template's stages (one request, M3-3).
  const factory CreateProjectEvent.createSubmitted() = _CreateSubmitted;

  const factory CreateProjectEvent.resetFlowStep() = _ResetFlowStep;
}
