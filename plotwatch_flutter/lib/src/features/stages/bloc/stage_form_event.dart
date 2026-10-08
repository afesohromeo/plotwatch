part of 'stage_form_bloc.dart';

@freezed
sealed class StageFormEvent with _$StageFormEvent {
  /// A new stage when [stageId] is null, otherwise that stage.
  const factory StageFormEvent.load({required int projectId, int? stageId}) =
      _Load;

  const factory StageFormEvent.saveRequested({required StageDraft draft}) =
      _SaveRequested;

  const factory StageFormEvent.resetFlowStep() = _ResetFlowStep;
}
