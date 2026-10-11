part of 'ledger_entry_bloc.dart';

@freezed
sealed class LedgerEntryState with _$LedgerEntryState {
  const LedgerEntryState._();

  const factory LedgerEntryState({
    int? projectId,
    int? entryId,
    LedgerEntry? entry,
    ProjectOverview? overview,

    /// The receipt photo's bytes, once loaded.
    Uint8List? receipt,

    /// The signed-in user.
    UuidValue? me,
    @Default(GenericStatus.initial) GenericStatus loadStatus,
    String? loadErrorMessage,
    @Default(GenericStatus.initial) GenericStatus actionStatus,
    String? actionErrorMessage,

    /// What the last action did, for its message.
    LedgerEntryAction? lastAction,
  }) = _LedgerEntryState;

  bool get _open => overview != null && !overview!.project.status.isClosed;

  /// A reversal, or an entry already reversed: nothing more to do.
  bool get _settled =>
      entry == null || entry!.reversesId != null || entry!.reversedById != null;

  /// A release not confirmed yet, for the site manager (LED-02; the server
  /// checks it too).
  bool get canConfirm =>
      _open &&
      !_settled &&
      entry!.kind == LedgerEntryKind.release &&
      entry!.confirmedAt == null &&
      overview!.myRole == ProjectRole.siteManager;

  /// Only its recorder, once, never a reversal (LED-06).
  bool get canReverse => _open && !_settled && entry!.recordedBy == me;
}

/// The actions of the entry page.
enum LedgerEntryAction { confirm, reverse }
