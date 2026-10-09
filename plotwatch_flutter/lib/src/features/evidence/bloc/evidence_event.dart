part of 'evidence_bloc.dart';

@freezed
sealed class EvidenceEvent with _$EvidenceEvent {
  const factory EvidenceEvent.load({
    required int projectId,
    required int stageId,
    required int evidenceId,
  }) = _Load;

  /// The author withdraws the capture (CAP-09).
  const factory EvidenceEvent.retractRequested({required String reason}) =
      _RetractRequested;

  const factory EvidenceEvent.resetFlowStep() = _ResetFlowStep;
}
