part of 'sign_up_bloc.dart';

@freezed
sealed class SignUpEvent with _$SignUpEvent {
  /// Step 1: starts the registration; the server emails a code.
  const factory SignUpEvent.detailsSubmitted({
    required String fullName,
    required String email,
  }) = _DetailsSubmitted;

  /// Step 2: the code from the email.
  const factory SignUpEvent.codeSubmitted({required String code}) =
      _CodeSubmitted;

  /// Step 2: asks for a new code (the previous request is replaced).
  const factory SignUpEvent.codeResent() = _CodeResent;

  /// Step 3: creates the account. [locale] is the app language, saved with
  /// the name.
  const factory SignUpEvent.passwordSubmitted({
    required String password,
    required String locale,
  }) = _PasswordSubmitted;

  /// Shows or hides the password field.
  const factory SignUpEvent.passwordVisibilityToggled() =
      _PasswordVisibilityToggled;

  /// Shows or hides the confirm-password field.
  const factory SignUpEvent.confirmPasswordVisibilityToggled() =
      _ConfirmPasswordVisibilityToggled;

  const factory SignUpEvent.reset() = _Reset;
}
