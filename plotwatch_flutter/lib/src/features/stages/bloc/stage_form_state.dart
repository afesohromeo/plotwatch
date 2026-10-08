part of 'stage_form_bloc.dart';

@freezed
sealed class StageFormState with _$StageFormState {
  const StageFormState._();

  const factory StageFormState({
    int? projectId,

    /// Null for a new stage.
    int? stageId,
    ProjectOverview? overview,

    /// The stage being edited; null for a new one.
    StageView? view,
    @Default(GenericStatus.initial) GenericStatus loadStatus,
    String? loadErrorMessage,
    @Default(GenericStatus.initial) GenericStatus actionStatus,
    String? actionErrorMessage,

    /// The stage as the server saved it; the page then opens it.
    StageView? saved,
  }) = _StageFormState;

  String get currencyCode => overview?.project.currencyCode ?? 'XAF';
}
