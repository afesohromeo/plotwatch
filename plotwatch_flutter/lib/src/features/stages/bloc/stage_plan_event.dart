part of 'stage_plan_bloc.dart';

@freezed
sealed class StagePlanEvent with _$StagePlanEvent {
  /// Loads the project (role, currency, status) and its stage plan.
  const factory StagePlanEvent.load({required int projectId}) = _Load;

  /// A drag ended: the stage at [oldIndex] now sits at [newIndex] (the
  /// final position, as Flutter's `onReorderItem` gives it).
  const factory StagePlanEvent.reorderRequested({
    required int oldIndex,
    required int newIndex,
  }) = _ReorderRequested;

  /// Fills an empty plan from [template] (decision M3-3).
  const factory StagePlanEvent.templateApplied({
    required StageTemplate template,
  }) = _TemplateApplied;

  const factory StagePlanEvent.resetFlowStep() = _ResetFlowStep;
}
