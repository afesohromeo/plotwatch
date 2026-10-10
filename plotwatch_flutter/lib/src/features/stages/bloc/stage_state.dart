part of 'stage_bloc.dart';

/// Which action finished, so the page shows the matching message.
enum StageAction { none, start, delete, submit, approve, requestChanges }

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

    /// Every review decision, oldest first (REV-05).
    @Default(<StageReviewView>[]) List<StageReviewView> reviews,
    @Default(StageAction.none) StageAction action,
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

  /// The site manager submits a stage being worked on, on an active
  /// project (STG-07, doc/04e M5-2); [missingItems] must then be empty.
  bool get canSubmit =>
      _role == ProjectRole.siteManager &&
      isProjectActive &&
      (_status == StageStatus.inProgress ||
          _status == StageStatus.changesRequested);

  /// Required items without a finalized capture: what still blocks the
  /// submission (the server checks it too).
  List<ChecklistItem> get missingItems {
    final covered = {
      for (final e in evidence)
        if (e.status == EvidenceStatus.finalized) e.checklistItemId,
    };
    return [
      for (final item in view?.items ?? const <ChecklistItem>[])
        if (item.isRequired && !covered.contains(item.id)) item,
    ];
  }

  /// The owner, or a co-funder allowed to approve, decides on a submitted
  /// stage (REV-03, doc/04e M5-3; the server checks it too).
  bool get canReview {
    final approver =
        _role == ProjectRole.owner ||
        (_role == ProjectRole.coFunder && (overview?.myCanApprove ?? false));
    final open = !(overview?.project.status.isClosed ?? true);
    return approver && open && _status == StageStatus.submitted;
  }

  /// The latest decision when it asked for changes: shown to the site
  /// manager at the top of the stage (doc/04e M5-8).
  StageReviewView? get lastChangesRequested {
    final last = reviews.lastOrNull;
    return _status == StageStatus.changesRequested &&
            last?.review.decision == ReviewDecision.changesRequested
        ? last
        : null;
  }

  String get currencyCode => overview?.project.currencyCode ?? 'XAF';
}
