part of 'ledger_entry_bloc.dart';

@freezed
sealed class LedgerEntryEvent with _$LedgerEntryEvent {
  const factory LedgerEntryEvent.load({
    required int projectId,
    required int entryId,
  }) = _Load;

  /// The site manager confirms receiving the release (LED-02).
  const factory LedgerEntryEvent.confirmRequested() = _ConfirmRequested;

  /// Its recorder corrects the entry (LED-06).
  const factory LedgerEntryEvent.reverseRequested(String reason) =
      _ReverseRequested;

  const factory LedgerEntryEvent.resetFlowStep() = _ResetFlowStep;
}
