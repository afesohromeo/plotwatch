import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';
part 'sign_in_bloc.freezed.dart';

/// Email + password sign-in. On success the session changes and the router
/// moves to the home page (through `AuthenticationBloc`).
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required this._authRepository})
      : super(const SignInState()) {
    on<_SignInSubmitted>(_onSignInSubmitted);
    on<_PasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<_Reset>(_onReset);
  }

  final AuthRepository _authRepository;

  Future<void> _onSignInSubmitted(
    _SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(
      signInStatus: GenericStatus.loading,
      signInErrorMessage: null,
    ));
    try {
      await _authRepository.signIn(
        email: event.email.trim(),
        password: event.password,
      );
      emit(state.copyWith(signInStatus: GenericStatus.success));
    } on HttpException400 catch (e) {
      emit(state.copyWith(
        signInStatus: GenericStatus.failure,
        signInErrorMessage: e.code.message(LocalizationService.localization),
      ));
    } on HttpException401 catch (_) {
      emit(state.copyWith(
        signInStatus: GenericStatus.failure,
        signInErrorMessage: LocalizationService.localization.errorUnauthorized,
      ));
    } on NetworkException catch (_) {
      emit(state.copyWith(
        signInStatus: GenericStatus.failure,
        signInErrorMessage: LocalizationService.localization.networkError,
      ));
    } catch (e) {
      log('SignInBloc._onSignInSubmitted error: $e');
      emit(state.copyWith(
        signInStatus: GenericStatus.failure,
        signInErrorMessage: LocalizationService.localization.errorSignIn,
      ));
    }
  }

  void _onPasswordVisibilityToggled(
    _PasswordVisibilityToggled event,
    Emitter<SignInState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _onReset(_Reset event, Emitter<SignInState> emit) {
    emit(const SignInState());
  }
}
