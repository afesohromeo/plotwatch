part of 'money_bloc.dart';

@freezed
sealed class MoneyState with _$MoneyState {
  const factory MoneyState({
    int? projectId,

    // --- Summary (LED-04)
    LedgerSummary? summary,
    @Default(GenericStatus.initial) GenericStatus summaryStatus,
    String? summaryError,

    // --- Entries (infinite scroll keyed by the last ID, _standards/14 §3.3)
    @Default([]) List<LedgerEntry> entries,
    @Default([]) List<LedgerEntry> paginatedEntries,
    @Default(false) bool maxEntries,
    @Default(false) bool entriesRefreshController,

    /// The ID of the last entry of the last page: the next page's key.
    @Default(0) int entriesPageKey,
    @Default(GenericStatus.initial) GenericStatus entriesListStatus,
    String? entriesListError,

    // --- Live (doc/04e M5-6)
    @Default(false) bool reconnecting,
  }) = _MoneyState;
}
