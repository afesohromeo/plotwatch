part of 'stage_bloc.dart';

@freezed
sealed class StageEvent with _$StageEvent {
  /// Loads the project (role, currency, status) and the stage.
  const factory StageEvent.load({
    required int projectId,
    required int stageId,
  }) = _Load;

  /// The site manager starts work on the stage (STG-06).
  const factory StageEvent.startRequested() = _StartRequested;

  /// The owner deletes a stage that hasn't started (decision M3-6).
  const factory StageEvent.deleteRequested() = _DeleteRequested;

  /// The site manager sends the stage for review (STG-07, doc/04e M5-2).
  const factory StageEvent.submitRequested() = _SubmitRequested;

  /// An approver decides; a comment is required for changes (M5-3).
  const factory StageEvent.reviewRequested({
    required ReviewDecision decision,
    String? comment,
  }) = _ReviewRequested;

  const factory StageEvent.resetFlowStep() = _ResetFlowStep;
}
