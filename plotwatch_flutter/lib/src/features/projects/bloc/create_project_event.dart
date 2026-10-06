part of 'create_project_bloc.dart';

@freezed
sealed class CreateProjectEvent with _$CreateProjectEvent {
  /// The details step is valid: show the review.
  const factory CreateProjectEvent.detailsSubmitted({
    required ProjectDetails details,
  }) = _DetailsSubmitted;

  const factory CreateProjectEvent.backToDetails() = _BackToDetails;

  /// Creates the project from the reviewed details (one request, M2-3).
  const factory CreateProjectEvent.createSubmitted() = _CreateSubmitted;

  const factory CreateProjectEvent.resetFlowStep() = _ResetFlowStep;
}
