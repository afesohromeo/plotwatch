import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.freezed.dart';

/// App-wide session status; the router guard follows it (`_standards/07`).
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        // The session is restored before the first frame (decision M1-5),
        // so the initial status is already known.
        super(AuthenticationState(
          status: authRepository.isSignedIn
              ? AuthenticationStatus.authenticated
              : AuthenticationStatus.unauthenticated,
        )) {
    on<_Started>(_onStarted);
    on<_SignOutRequested>(_onSignOutRequested);
  }

  final AuthRepository _authRepository;

  Future<void> _onStarted(_Started event, Emitter<AuthenticationState> emit) {
    return emit.forEach<bool>(
      _authRepository.signedInChanges,
      onData: (isSignedIn) => state.copyWith(
        status: isSignedIn
            ? AuthenticationStatus.authenticated
            : AuthenticationStatus.unauthenticated,
      ),
    );
  }

  Future<void> _onSignOutRequested(
    _SignOutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(
      signOutStatus: GenericStatus.loading,
      signOutErrorMessage: null,
    ));
    try {
      await _authRepository.signOut();
      emit(state.copyWith(signOutStatus: GenericStatus.success));
    } on HttpException400 catch (e) {
      emit(state.copyWith(
        signOutStatus: GenericStatus.failure,
        signOutErrorMessage: e.code.message(LocalizationService.localization),
      ));
    } on HttpException401 catch (_) {
      emit(state.copyWith(
        signOutStatus: GenericStatus.failure,
        signOutErrorMessage: LocalizationService.localization.errorUnauthorized,
      ));
    } on NetworkException catch (_) {
      emit(state.copyWith(
        signOutStatus: GenericStatus.failure,
        signOutErrorMessage: LocalizationService.localization.networkError,
      ));
    } catch (e) {
      log('AuthenticationBloc._onSignOutRequested error: $e');
      emit(state.copyWith(
        signOutStatus: GenericStatus.failure,
        signOutErrorMessage: LocalizationService.localization.errorSignOut,
      ));
    }
  }
}
