part of 'evidence_bloc.dart';

@freezed
sealed class EvidenceState with _$EvidenceState {
  const EvidenceState._();

  const factory EvidenceState({
    int? projectId,
    int? stageId,
    int? evidenceId,
    ProjectOverview? overview,
    Evidence? evidence,

    /// The signed-in user took the photo.
    @Default(false) bool isMine,
    @Default(GenericStatus.initial) GenericStatus loadStatus,
    String? loadErrorMessage,
    @Default(GenericStatus.initial) GenericStatus actionStatus,
    String? actionErrorMessage,
  }) = _EvidenceState;

  /// Only its author retracts a capture, once (decision M4-11; the server
  /// checks it too).
  bool get canRetract =>
      isMine &&
      overview?.myRole == ProjectRole.siteManager &&
      evidence != null &&
      evidence!.status != EvidenceStatus.retracted;
}
