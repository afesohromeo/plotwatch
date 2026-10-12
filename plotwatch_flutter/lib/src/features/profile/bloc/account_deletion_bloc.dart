import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'account_deletion_event.dart';
part 'account_deletion_state.dart';
part 'account_deletion_bloc.freezed.dart';

/// Profile › Delete account (doc/04g step 6): first the projects that block
/// it, then the deletion. On success the session is gone and the router
/// goes back to the welcome page.
class AccountDeletionBloc
    extends Bloc<AccountDeletionEvent, AccountDeletionState> {
  AccountDeletionBloc({required this._authRepository})
    : super(const AccountDeletionState()) {
    on<_CheckRequested>(_onCheckRequested);
    on<_DeleteRequested>(_onDeleteRequested);
    on<_Reset>((event, emit) => emit(const AccountDeletionState()));
  }

  final AuthRepository _authRepository;

  Future<void> _onCheckRequested(
    _CheckRequested event,
    Emitter<AccountDeletionState> emit,
  ) async {
    emit(
      const AccountDeletionState(checkStatus: GenericStatus.loading),
    );
    try {
      final blockers = await _authRepository.deletionBlockers();
      emit(
        state.copyWith(checkStatus: GenericStatus.success, blockers: blockers),
      );
    } catch (e) {
      emit(
        state.copyWith(
          checkStatus: GenericStatus.failure,
          errorMessage: _message(e),
        ),
      );
    }
  }

  Future<void> _onDeleteRequested(
    _DeleteRequested event,
    Emitter<AccountDeletionState> emit,
  ) async {
    if (state.deleteStatus == GenericStatus.loading) return;
    emit(
      state.copyWith(deleteStatus: GenericStatus.loading, errorMessage: null),
    );
    try {
      await _authRepository.deleteAccount();
      emit(state.copyWith(deleteStatus: GenericStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          deleteStatus: GenericStatus.failure,
          errorMessage: _message(e),
        ),
      );
    }
  }

  String _message(Object error) {
    final l10n = LocalizationService.localization;
    return switch (error) {
      HttpException400(:final code) => code.message(l10n),
      NetworkException() => l10n.networkError,
      _ => () {
        log('AccountDeletionBloc error: $error');
        return l10n.errorDeleteAccount;
      }(),
    };
  }
}
