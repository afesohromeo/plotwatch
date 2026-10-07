part of 'sign_in_bloc.dart';

@freezed
sealed class SignInEvent with _$SignInEvent {
  const factory SignInEvent.signInSubmitted({
    required String email,
    required String password,
  }) = _SignInSubmitted;

  /// Shows or hides the password typed in the password field.
  const factory SignInEvent.passwordVisibilityToggled() =
      _PasswordVisibilityToggled;
  const factory SignInEvent.reset() = _Reset;
}
