part of 'account_deletion_bloc.dart';

@freezed
sealed class AccountDeletionState with _$AccountDeletionState {
  const factory AccountDeletionState({
    @Default(GenericStatus.initial) GenericStatus checkStatus,

    /// Projects to complete or archive first.
    @Default(<String>[]) List<String> blockers,
    @Default(GenericStatus.initial) GenericStatus deleteStatus,
    String? errorMessage,
  }) = _AccountDeletionState;
}
