part of 'localize_site_bloc.dart';

@freezed
sealed class LocalizeSiteEvent with _$LocalizeSiteEvent {
  /// Loads the caller's role, asks for location and streams the readings.
  /// Sent again after the user allows location.
  const factory LocalizeSiteEvent.started({required int projectId}) = _Started;

  /// Opens the app or location settings (refused for good, or GPS off).
  const factory LocalizeSiteEvent.settingsRequested() = _SettingsRequested;

  /// Saves the current reading as the site proposal.
  const factory LocalizeSiteEvent.proposeRequested({required int projectId}) =
      _ProposeRequested;

  const factory LocalizeSiteEvent.resetFlowStep() = _ResetFlowStep;
}
