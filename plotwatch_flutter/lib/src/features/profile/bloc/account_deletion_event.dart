part of 'account_deletion_bloc.dart';

@freezed
sealed class AccountDeletionEvent with _$AccountDeletionEvent {
  /// Delete account was tapped: which projects block it, if any.
  const factory AccountDeletionEvent.checkRequested() = _CheckRequested;

  /// Confirmed with the typed email.
  const factory AccountDeletionEvent.deleteRequested() = _DeleteRequested;
  const factory AccountDeletionEvent.reset() = _Reset;
}
