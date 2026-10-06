part of 'sign_in_bloc.dart';

@freezed
sealed class SignInState with _$SignInState {
  const factory SignInState({
    @Default(GenericStatus.initial) GenericStatus signInStatus,
    String? signInErrorMessage,
    @Default(false) bool isPasswordVisible,
  }) = _SignInState;
}
