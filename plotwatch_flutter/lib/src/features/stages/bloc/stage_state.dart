part of 'stage_bloc.dart';

@freezed
sealed class StageState with _$StageState {
  const StageState._();

  const factory StageState({
    int? projectId,
    int? stageId,
    ProjectOverview? overview,
    StageView? view,
    @Default(GenericStatus.initial) GenericStatus loadStatus,
    String? loadErrorMessage,

    /// `updatingItem` = starting, `deletingItem` = deleting.
    @Default(GenericFlowStep.none) GenericFlowStep flowStep,
    @Default(GenericStatus.initial) GenericStatus actionStatus,
    String? actionErrorMessage,
  }) = _StageState;

  ProjectRole? get _role => overview?.myRole;
  StageStatus? get _status => view?.stage.status;

  bool get _projectOpen {
    final status = overview?.project.status;
    return status != null &&
        status != ProjectStatus.completed &&
        status != ProjectStatus.archived;
  }

  /// The owner edits a stage until it is submitted (decision M3-6).
  bool get canEdit =>
      _role == ProjectRole.owner &&
      _projectOpen &&
      (_status?.isEditable ?? false);

  /// The owner deletes only a stage that hasn't started (decision M3-6).
  bool get canDelete =>
      _role == ProjectRole.owner &&
      _projectOpen &&
      _status == StageStatus.notStarted;

  /// The site manager starts a stage that hasn't started (decision M3-8);
  /// the server also requires an active project.
  bool get canStart =>
      _role == ProjectRole.siteManager && _status == StageStatus.notStarted;

  bool get isProjectActive => overview?.project.status == ProjectStatus.active;

  String get currencyCode => overview?.project.currencyCode ?? 'XAF';
}
