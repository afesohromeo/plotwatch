part of 'evidence_media_bloc.dart';

@freezed
sealed class EvidenceMediaState with _$EvidenceMediaState {
  const EvidenceMediaState._();

  const factory EvidenceMediaState({
    /// Bytes by [keyFor].
    @Default(<String, Uint8List>{}) Map<String, Uint8List> images,
    @Default(<String>{}) Set<String> loading,
    @Default(<String>{}) Set<String> failed,
  }) = _EvidenceMediaState;

  static String keyFor(int evidenceId, MediaVariant variant) =>
      '$evidenceId.${variant.name}';
}
