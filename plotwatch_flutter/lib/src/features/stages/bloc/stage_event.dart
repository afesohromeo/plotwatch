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

  const factory StageEvent.resetFlowStep() = _ResetFlowStep;
}
