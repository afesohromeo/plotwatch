part of 'join_project_bloc.dart';

@freezed
sealed class JoinProjectEvent with _$JoinProjectEvent {
  /// Checks a code and shows what it joins (the server normalises it).
  const factory JoinProjectEvent.previewRequested({required String code}) =
      _PreviewRequested;

  /// Joins with the checked code.
  const factory JoinProjectEvent.joinRequested() = _JoinRequested;

  const factory JoinProjectEvent.resetFlowStep() = _ResetFlowStep;
}
