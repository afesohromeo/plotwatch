part of 'authentication_bloc.dart';

@freezed
sealed class AuthenticationEvent with _$AuthenticationEvent {
  /// Starts following session changes (sign-in, sign-out, expiry).
  const factory AuthenticationEvent.started() = _Started;
  const factory AuthenticationEvent.signOutRequested() = _SignOutRequested;
}
