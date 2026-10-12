import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'google_sign_in_event.dart';
part 'google_sign_in_state.dart';
part 'google_sign_in_bloc.freezed.dart';

/// Continue with Google, on the sign-in and sign-up pages (AUTH-04,
/// doc/04g step 4). On success the session changes and the router moves to
/// the home page (through `AuthenticationBloc`); closing Google's window is
/// not an error.
class GoogleSignInBloc extends Bloc<GoogleSignInEvent, GoogleSignInState> {
  GoogleSignInBloc({required this._authRepository})
    : super(
        GoogleSignInState(
          isAvailable: _authRepository.isGoogleSignInAvailable,
        ),
      ) {
    on<_Started>(_onStarted);
    on<_Reset>(_onReset);
  }

  final AuthRepository _authRepository;

  Future<void> _onStarted(_Started event, Emitter<GoogleSignInState> emit) async {
    if (state.status == GenericStatus.loading) return;
    emit(state.copyWith(status: GenericStatus.loading, errorMessage: null));
    try {
      final signedIn = await _authRepository.signInWithGoogle(
        locale: event.locale,
      );
      emit(
        state.copyWith(
          status: signedIn ? GenericStatus.success : GenericStatus.initial,
        ),
      );
    } on HttpException400 catch (e) {
      emit(
        state.copyWith(
          status: GenericStatus.failure,
          errorMessage: e.code.message(LocalizationService.localization),
        ),
      );
    } on NetworkException catch (_) {
      emit(
        state.copyWith(
          status: GenericStatus.failure,
          errorMessage: LocalizationService.localization.networkError,
        ),
      );
    } catch (e) {
      log('GoogleSignInBloc._onStarted error: $e');
      emit(
        state.copyWith(
          status: GenericStatus.failure,
          errorMessage: LocalizationService.localization.errorGoogleSignIn,
        ),
      );
    }
  }

  void _onReset(_Reset event, Emitter<GoogleSignInState> emit) {
    emit(GoogleSignInState(isAvailable: state.isAvailable));
  }
}
