part of 'stage_bloc.dart';

@freezed
sealed class StageState with _$StageState {
  const StageState._();

  const factory StageState({
    int? projectId,
    int? stageId,
    ProjectOverview? overview,
    StageView? view,

    /// The stage's captures, newest first (doc/04d M4-10).
    @Default(<Evidence>[]) List<Evidence> evidence,
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

  bool get isProjectActive =>
      overview?.project.status == ProjectStatus.active;

  /// The site manager adds photos on an active project to a stage that
  /// isn't submitted or approved (doc/04d M4-9; the server checks it too).
  bool get canCapture =>
      _role == ProjectRole.siteManager &&
      isProjectActive &&
      const {
        StageStatus.notStarted,
        StageStatus.inProgress,
        StageStatus.changesRequested,
      }.contains(_status);

  /// The captures of one checklist item, newest first.
  List<Evidence> evidenceFor(int itemId) => [
    for (final e in evidence)
      if (e.checklistItemId == itemId) e,
  ];

  String get currencyCode => overview?.project.currencyCode ?? 'XAF';
}
