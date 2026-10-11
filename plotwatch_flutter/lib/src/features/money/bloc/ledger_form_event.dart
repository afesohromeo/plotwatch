part of 'ledger_form_bloc.dart';

@freezed
sealed class LedgerFormEvent with _$LedgerFormEvent {
  /// Loads the project (its currency) and its stages, for the picker.
  const factory LedgerFormEvent.load({required int projectId}) = _Load;

  const factory LedgerFormEvent.saveRelease(ReleaseDraft draft) =
      _SaveRelease;

  /// With the receipt photo's bytes when one was taken (doc/04f M6-5 a).
  const factory LedgerFormEvent.saveExpense(
    ExpenseDraft draft, {
    Uint8List? receipt,
  }) = _SaveExpense;

  const factory LedgerFormEvent.resetFlowStep() = _ResetFlowStep;
}
