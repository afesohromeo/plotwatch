part of 'google_sign_in_bloc.dart';

@freezed
sealed class GoogleSignInEvent with _$GoogleSignInEvent {
  /// The Continue with Google button; [locale] is the app's language, kept
  /// for a new user.
  const factory GoogleSignInEvent.started({required String locale}) =
      _Started;
  const factory GoogleSignInEvent.reset() = _Reset;
}
