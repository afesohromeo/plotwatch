part of 'update_form_bloc.dart';

@freezed
sealed class UpdateFormEvent with _$UpdateFormEvent {
  const factory UpdateFormEvent.load({required int projectId}) = _Load;

  const factory UpdateFormEvent.saveRequested(ProgressUpdateDraft draft) =
      _SaveRequested;

  const factory UpdateFormEvent.resetFlowStep() = _ResetFlowStep;
}
