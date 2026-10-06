part of 'sign_up_bloc.dart';

enum SignUpStep { details, verifyCode, password }

@freezed
sealed class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default(SignUpStep.details) SignUpStep step,
    @Default('') String fullName,
    @Default('') String email,
    UuidValue? accountRequestId,
    String? registrationToken,
    @Default(GenericStatus.initial) GenericStatus signUpStatus,
    String? signUpErrorMessage,
    @Default(false) bool isPasswordVisible,
    @Default(false) bool isConfirmPasswordVisible,
  }) = _SignUpState;
}
