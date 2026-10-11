part of 'money_bloc.dart';

@freezed
sealed class MoneyEvent with _$MoneyEvent {
  /// Loads the summary and starts following the project's ledger events.
  const factory MoneyEvent.load({required int projectId}) = _Load;

  /// Fetches the entries older than [pageKey] (the last loaded ID; 0 for
  /// the newest), only [kind] and [stageId]'s when given, on the server
  /// (`_standards/13`, doc/05 §9.5).
  const factory MoneyEvent.fetchEntries({
    required int projectId,
    @Default(0) int pageKey,
    LedgerEntryKind? kind,
    int? stageId,
    int? size,
  }) = _FetchEntries;

  const factory MoneyEvent.refreshEntries() = _RefreshEntries;

  /// From the project's live stream: a ledger event refreshes the summary
  /// and the list (doc/04f M6-9).
  const factory MoneyEvent.liveUpdateReceived(
    LiveUpdate<ActivityEntry> update,
  ) = _LiveUpdateReceived;
}
