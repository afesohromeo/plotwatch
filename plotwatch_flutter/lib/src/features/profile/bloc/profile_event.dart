part of 'profile_bloc.dart';

@freezed
sealed class ProfileEvent with _$ProfileEvent {
  /// Loads the profile (after sign-in, or when the profile page opens).
  const factory ProfileEvent.fetchMe() = _FetchMe;

  /// Saves name, country and language; the server validates them.
  const factory ProfileEvent.updateMe({
    required String fullName,
    String? countryCode,
    required String locale,
  }) = _UpdateMe;

  const factory ProfileEvent.resetFlowStep() = _ResetFlowStep;

  /// Forgets the profile (sign-out).
  const factory ProfileEvent.reset() = _Reset;
}
