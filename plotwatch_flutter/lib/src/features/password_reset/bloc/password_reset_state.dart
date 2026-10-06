part of 'password_reset_bloc.dart';

enum PasswordResetStep { email, verifyCode, newPassword }

@freezed
sealed class PasswordResetState with _$PasswordResetState {
  const factory PasswordResetState({
    @Default(PasswordResetStep.email) PasswordResetStep step,
    @Default('') String email,
    UuidValue? passwordResetRequestId,
    String? finishPasswordResetToken,
    @Default(GenericStatus.initial) GenericStatus passwordResetStatus,
    String? passwordResetErrorMessage,
    @Default(false) bool isPasswordVisible,
    @Default(false) bool isConfirmPasswordVisible,
  }) = _PasswordResetState;
}
