part of 'ledger_form_bloc.dart';

@freezed
sealed class LedgerFormState with _$LedgerFormState {
  const factory LedgerFormState({
    int? projectId,
    ProjectOverview? overview,

    /// For the stage picker, in plan order.
    @Default([]) List<Stage> stages,
    @Default(GenericStatus.initial) GenericStatus loadStatus,
    String? loadErrorMessage,
    @Default(GenericStatus.initial) GenericStatus actionStatus,
    String? actionErrorMessage,

    /// The entry as the server saved it.
    LedgerEntry? saved,
  }) = _LedgerFormState;
}
