import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'password_reset_event.dart';
part 'password_reset_state.dart';
part 'password_reset_bloc.freezed.dart';

/// Three-step password reset: email → emailed code → new password, then
/// signs in with the new password.
class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  PasswordResetBloc({required this._authRepository})
    : super(const PasswordResetState()) {
    on<_EmailSubmitted>(_onEmailSubmitted);
    on<_CodeSubmitted>(_onCodeSubmitted);
    on<_CodeResent>(_onCodeResent);
    on<_NewPasswordSubmitted>(_onNewPasswordSubmitted);
    on<_PasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<_ConfirmPasswordVisibilityToggled>(_onConfirmPasswordVisibilityToggled);
    on<_Reset>(_onReset);
  }

  final AuthRepository _authRepository;

  Future<void> _onEmailSubmitted(
    _EmailSubmitted event,
    Emitter<PasswordResetState> emit,
  ) async {
    emit(_loading());
    try {
      final email = event.email.trim();
      final requestId = await _authRepository.startPasswordReset(email: email);
      emit(
        state.copyWith(
          passwordResetStatus: GenericStatus.success,
          step: PasswordResetStep.verifyCode,
          email: email,
          passwordResetRequestId: requestId,
        ),
      );
    } on HttpException400 catch (e) {
      emit(_failure(e.code.message(LocalizationService.localization)));
    } on HttpException401 catch (_) {
      emit(_failure(LocalizationService.localization.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_failure(LocalizationService.localization.networkError));
    } catch (e) {
      log('PasswordResetBloc._onEmailSubmitted error: $e');
      emit(_failure(LocalizationService.localization.errorPasswordReset));
    }
  }

  Future<void> _onCodeSubmitted(
    _CodeSubmitted event,
    Emitter<PasswordResetState> emit,
  ) async {
    emit(_loading());
    try {
      final token = await _authRepository.verifyPasswordResetCode(
        passwordResetRequestId: state.passwordResetRequestId!,
        code: event.code.trim(),
      );
      emit(
        state.copyWith(
          passwordResetStatus: GenericStatus.success,
          step: PasswordResetStep.newPassword,
          finishPasswordResetToken: token,
        ),
      );
    } on HttpException400 catch (e) {
      emit(_failure(e.code.message(LocalizationService.localization)));
    } on HttpException401 catch (_) {
      emit(_failure(LocalizationService.localization.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_failure(LocalizationService.localization.networkError));
    } catch (e) {
      log('PasswordResetBloc._onCodeSubmitted error: $e');
      emit(_failure(LocalizationService.localization.errorPasswordReset));
    }
  }

  Future<void> _onCodeResent(
    _CodeResent event,
    Emitter<PasswordResetState> emit,
  ) async {
    emit(_loading());
    try {
      final requestId = await _authRepository.startPasswordReset(
        email: state.email,
      );
      emit(
        state.copyWith(
          passwordResetStatus: GenericStatus.success,
          passwordResetRequestId: requestId,
        ),
      );
    } on HttpException400 catch (e) {
      emit(_failure(e.code.message(LocalizationService.localization)));
    } on HttpException401 catch (_) {
      emit(_failure(LocalizationService.localization.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_failure(LocalizationService.localization.networkError));
    } catch (e) {
      log('PasswordResetBloc._onCodeResent error: $e');
      emit(_failure(LocalizationService.localization.errorPasswordReset));
    }
  }

  Future<void> _onNewPasswordSubmitted(
    _NewPasswordSubmitted event,
    Emitter<PasswordResetState> emit,
  ) async {
    emit(_loading());
    try {
      await _authRepository.finishPasswordReset(
        finishPasswordResetToken: state.finishPasswordResetToken!,
        newPassword: event.password,
      );
      await _authRepository.signIn(
        email: state.email,
        password: event.password,
      );
      emit(state.copyWith(passwordResetStatus: GenericStatus.success));
    } on HttpException400 catch (e) {
      emit(_failure(e.code.message(LocalizationService.localization)));
    } on HttpException401 catch (_) {
      emit(_failure(LocalizationService.localization.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_failure(LocalizationService.localization.networkError));
    } catch (e) {
      log('PasswordResetBloc._onNewPasswordSubmitted error: $e');
      emit(_failure(LocalizationService.localization.errorPasswordReset));
    }
  }

  void _onPasswordVisibilityToggled(
    _PasswordVisibilityToggled event,
    Emitter<PasswordResetState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _onConfirmPasswordVisibilityToggled(
    _ConfirmPasswordVisibilityToggled event,
    Emitter<PasswordResetState> emit,
  ) {
    emit(
      state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible),
    );
  }

  void _onReset(_Reset event, Emitter<PasswordResetState> emit) {
    emit(const PasswordResetState());
  }

  PasswordResetState _loading() => state.copyWith(
    passwordResetStatus: GenericStatus.loading,
    passwordResetErrorMessage: null,
  );

  PasswordResetState _failure(String message) => state.copyWith(
    passwordResetStatus: GenericStatus.failure,
    passwordResetErrorMessage: message,
  );
}
