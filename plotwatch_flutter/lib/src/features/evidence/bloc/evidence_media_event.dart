part of 'evidence_media_bloc.dart';

@freezed
sealed class EvidenceMediaEvent with _$EvidenceMediaEvent {
  const factory EvidenceMediaEvent.requested({
    required int projectId,
    required int evidenceId,
    required MediaVariant variant,
  }) = _Requested;

  /// At sign-out: the photos are private to the person who loaded them.
  const factory EvidenceMediaEvent.cleared() = _Cleared;
}
