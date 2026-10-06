import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';
part 'sign_up_bloc.freezed.dart';

/// Three-step sign-up (decision M1-4): name + email → emailed code →
/// password. Finishing signs the user in, then saves name and language.
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required this._authRepository,
    required this._profileRepository,
  })  : super(const SignUpState()) {
    on<_DetailsSubmitted>(_onDetailsSubmitted);
    on<_CodeSubmitted>(_onCodeSubmitted);
    on<_CodeResent>(_onCodeResent);
    on<_PasswordSubmitted>(_onPasswordSubmitted);
    on<_PasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<_ConfirmPasswordVisibilityToggled>(_onConfirmPasswordVisibilityToggled);
    on<_Reset>(_onReset);
  }

  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;

  Future<void> _onDetailsSubmitted(
    _DetailsSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(_loading());
    try {
      final email = event.email.trim();
      final accountRequestId =
          await _authRepository.startRegistration(email: email);
      emit(state.copyWith(
        signUpStatus: GenericStatus.success,
        step: SignUpStep.verifyCode,
        fullName: event.fullName.trim(),
        email: email,
        accountRequestId: accountRequestId,
      ));
    } on HttpException400 catch (e) {
      emit(_failure(e.code.message(LocalizationService.localization)));
    } on HttpException401 catch (_) {
      emit(_failure(LocalizationService.localization.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_failure(LocalizationService.localization.networkError));
    } catch (e) {
      log('SignUpBloc._onDetailsSubmitted error: $e');
      emit(_failure(LocalizationService.localization.errorSignUp));
    }
  }

  Future<void> _onCodeSubmitted(
    _CodeSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(_loading());
    try {
      final registrationToken = await _authRepository.verifyRegistrationCode(
        accountRequestId: state.accountRequestId!,
        code: event.code.trim(),
      );
      emit(state.copyWith(
        signUpStatus: GenericStatus.success,
        step: SignUpStep.password,
        registrationToken: registrationToken,
      ));
    } on HttpException400 catch (e) {
      emit(_failure(e.code.message(LocalizationService.localization)));
    } on HttpException401 catch (_) {
      emit(_failure(LocalizationService.localization.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_failure(LocalizationService.localization.networkError));
    } catch (e) {
      log('SignUpBloc._onCodeSubmitted error: $e');
      emit(_failure(LocalizationService.localization.errorSignUp));
    }
  }

  Future<void> _onCodeResent(
    _CodeResent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(_loading());
    try {
      final accountRequestId =
          await _authRepository.startRegistration(email: state.email);
      emit(state.copyWith(
        signUpStatus: GenericStatus.success,
        accountRequestId: accountRequestId,
      ));
    } on HttpException400 catch (e) {
      emit(_failure(e.code.message(LocalizationService.localization)));
    } on HttpException401 catch (_) {
      emit(_failure(LocalizationService.localization.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_failure(LocalizationService.localization.networkError));
    } catch (e) {
      log('SignUpBloc._onCodeResent error: $e');
      emit(_failure(LocalizationService.localization.errorSignUp));
    }
  }

  Future<void> _onPasswordSubmitted(
    _PasswordSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(_loading());
    try {
      await _authRepository.finishRegistration(
        registrationToken: state.registrationToken!,
        password: event.password,
      );
    } on HttpException400 catch (e) {
      emit(_failure(e.code.message(LocalizationService.localization)));
      return;
    } on HttpException401 catch (_) {
      emit(_failure(LocalizationService.localization.errorUnauthorized));
      return;
    } on NetworkException catch (_) {
      emit(_failure(LocalizationService.localization.networkError));
      return;
    } catch (e) {
      log('SignUpBloc._onPasswordSubmitted error: $e');
      emit(_failure(LocalizationService.localization.errorSignUp));
      return;
    }

    // The account exists and the user is signed in. A failure to save the
    // name must not undo that; it can be set later on the profile page.
    try {
      await _profileRepository.updateMe(
        fullName: state.fullName,
        locale: event.locale,
      );
    } catch (e) {
      log('SignUpBloc: saving the name after sign-up failed: $e');
    }
    emit(state.copyWith(signUpStatus: GenericStatus.success));
  }

  void _onPasswordVisibilityToggled(
    _PasswordVisibilityToggled event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _onConfirmPasswordVisibilityToggled(
    _ConfirmPasswordVisibilityToggled event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(
      isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
    ));
  }

  void _onReset(_Reset event, Emitter<SignUpState> emit) {
    emit(const SignUpState());
  }

  SignUpState _loading() => state.copyWith(
        signUpStatus: GenericStatus.loading,
        signUpErrorMessage: null,
      );

  SignUpState _failure(String message) => state.copyWith(
        signUpStatus: GenericStatus.failure,
        signUpErrorMessage: message,
      );
}
