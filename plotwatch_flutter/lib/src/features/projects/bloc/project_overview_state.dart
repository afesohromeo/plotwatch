part of 'project_overview_bloc.dart';

@freezed
sealed class ProjectOverviewState with _$ProjectOverviewState {
  const factory ProjectOverviewState({
    ProjectOverview? overview,

    /// For the members card (doc/05 §9 DP-4); empty when not loaded.
    @Default([]) List<MemberView> members,
    @Default(GenericStatus.initial) GenericStatus overviewStatus,
    String? overviewErrorMessage,
    @Default(GenericStatus.initial) GenericStatus actionStatus,
    @Default(GenericFlowStep.none) GenericFlowStep flowStep,
    String? actionErrorMessage,
  }) = _ProjectOverviewState;
}
