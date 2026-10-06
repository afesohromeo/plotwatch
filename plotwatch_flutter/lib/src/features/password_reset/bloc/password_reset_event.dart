part of 'password_reset_bloc.dart';

@freezed
sealed class PasswordResetEvent with _$PasswordResetEvent {
  /// Step 1: the server emails a reset code (if the account exists).
  const factory PasswordResetEvent.emailSubmitted({required String email}) =
      _EmailSubmitted;

  /// Step 2: the code from the email.
  const factory PasswordResetEvent.codeSubmitted({required String code}) =
      _CodeSubmitted;

  /// Step 2: asks for a new code.
  const factory PasswordResetEvent.codeResent() = _CodeResent;

  /// Step 3: sets the new password and signs in with it.
  const factory PasswordResetEvent.newPasswordSubmitted({
    required String password,
  }) = _NewPasswordSubmitted;

  /// Shows or hides the password field.
  const factory PasswordResetEvent.passwordVisibilityToggled() =
      _PasswordVisibilityToggled;

  /// Shows or hides the confirm-password field.
  const factory PasswordResetEvent.confirmPasswordVisibilityToggled() =
      _ConfirmPasswordVisibilityToggled;

  const factory PasswordResetEvent.reset() = _Reset;
}
