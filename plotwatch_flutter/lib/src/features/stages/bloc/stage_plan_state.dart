part of 'stage_plan_bloc.dart';

@freezed
sealed class StagePlanState with _$StagePlanState {
  const StagePlanState._();

  const factory StagePlanState({
    int? projectId,
    ProjectOverview? overview,
    StagePlan? plan,
    @Default(GenericStatus.initial) GenericStatus loadStatus,
    String? loadErrorMessage,

    /// `updatingItem` = reordering, `creatingItem` = applying a template.
    @Default(GenericFlowStep.none) GenericFlowStep flowStep,
    @Default(GenericStatus.initial) GenericStatus actionStatus,
    String? actionErrorMessage,
  }) = _StagePlanState;

  /// Only the owner plans, and not on a completed or archived project
  /// (decision M3-6; the server enforces it too).
  bool get canEdit {
    final overview = this.overview;
    if (overview == null || overview.myRole != ProjectRole.owner) return false;
    return overview.project.status != ProjectStatus.completed &&
        overview.project.status != ProjectStatus.archived;
  }

  String get currencyCode => overview?.project.currencyCode ?? 'XAF';
}
