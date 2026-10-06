part of 'project_overview_bloc.dart';

@freezed
sealed class ProjectOverviewState with _$ProjectOverviewState {
  const factory ProjectOverviewState({
    ProjectOverview? overview,
    @Default(GenericStatus.initial) GenericStatus overviewStatus,
    String? overviewErrorMessage,
    @Default(GenericStatus.initial) GenericStatus actionStatus,
    @Default(GenericFlowStep.none) GenericFlowStep flowStep,
    String? actionErrorMessage,
  }) = _ProjectOverviewState;
}
