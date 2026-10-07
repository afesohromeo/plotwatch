part of 'join_project_bloc.dart';

@freezed
sealed class JoinProjectEvent with _$JoinProjectEvent {
  /// Checks a code and shows what it joins (the server normalises it).
  const factory JoinProjectEvent.previewRequested({required String code}) =
      _PreviewRequested;

  /// The code field changed: once it no longer holds the checked code, the
  /// preview is dropped so Join can't act on another code (doc/04b F2-1).
  const factory JoinProjectEvent.codeEdited({required String code}) =
      _CodeEdited;

  /// Joins with the checked code.
  const factory JoinProjectEvent.joinRequested() = _JoinRequested;

  const factory JoinProjectEvent.resetFlowStep() = _ResetFlowStep;
}
