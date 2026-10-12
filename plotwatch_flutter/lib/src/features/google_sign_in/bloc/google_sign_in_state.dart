part of 'google_sign_in_bloc.dart';

@freezed
sealed class GoogleSignInState with _$GoogleSignInState {
  const factory GoogleSignInState({
    /// False where Google sign-in isn't configured: the button stays hidden.
    @Default(false) bool isAvailable,
    @Default(GenericStatus.initial) GenericStatus status,
    String? errorMessage,
  }) = _GoogleSignInState;
}
