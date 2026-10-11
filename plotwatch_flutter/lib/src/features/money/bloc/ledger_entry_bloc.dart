import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'ledger_entry_event.dart';
part 'ledger_entry_state.dart';
part 'ledger_entry_bloc.freezed.dart';

/// One ledger entry with its receipt photo; the site manager confirms a
/// release, the recorder reverses an entry (doc/04f M6-3, M6-6).
class LedgerEntryBloc extends Bloc<LedgerEntryEvent, LedgerEntryState> {
  LedgerEntryBloc({
    required this._ledgerRepository,
    required this._projectRepository,
    required this._authRepository,
  }) : super(const LedgerEntryState()) {
    on<_Load>(_onLoad);
    on<_ConfirmRequested>(_onConfirmRequested);
    on<_ReverseRequested>(_onReverseRequested);
    on<_ResetFlowStep>(_onResetFlowStep);
  }

  final LedgerRepository _ledgerRepository;
  final ProjectRepository _projectRepository;
  final AuthRepository _authRepository;

  Future<void> _onLoad(_Load event, Emitter<LedgerEntryState> emit) async {
    final l10n = LocalizationService.localization;
    emit(
      state.copyWith(
        projectId: event.projectId,
        entryId: event.entryId,
        me: _authRepository.currentUserId,
        loadStatus: state.entry == null
            ? GenericStatus.loading
            : state.loadStatus,
        loadErrorMessage: null,
      ),
    );
    final LedgerEntry entry;
    try {
      final (overview, loaded) = await (
        _projectRepository.fetchProject(event.projectId),
        _ledgerRepository.fetchEntry(event.projectId, event.entryId),
      ).wait;
      entry = loaded;
      emit(
        state.copyWith(
          overview: overview,
          entry: entry,
          loadStatus: GenericStatus.success,
        ),
      );
    } catch (e) {
      log('LedgerEntryBloc._onLoad error: $e');
      emit(_loadFailure(_message(e, l10n)));
      return;
    }
    // The photo comes after; without it the entry still shows.
    if (entry.receiptPath != null && state.receipt == null) {
      try {
        final receipt = await _ledgerRepository.receipt(
          event.projectId,
          event.entryId,
        );
        emit(state.copyWith(receipt: receipt));
      } catch (e) {
        log('LedgerEntryBloc receipt error: $e');
      }
    }
  }

  Future<void> _onConfirmRequested(
    _ConfirmRequested event,
    Emitter<LedgerEntryState> emit,
  ) => _act(
    LedgerEntryAction.confirm,
    emit,
    (projectId, entryId) =>
        _ledgerRepository.confirmRelease(projectId, entryId),
  );

  Future<void> _onReverseRequested(
    _ReverseRequested event,
    Emitter<LedgerEntryState> emit,
  ) => _act(
    LedgerEntryAction.reverse,
    emit,
    (projectId, entryId) =>
        _ledgerRepository.reverse(projectId, entryId, event.reason),
  );

  /// Runs the action, then reads the entry again: a reversal changes how
  /// the original shows, not only the new entry.
  Future<void> _act(
    LedgerEntryAction action,
    Emitter<LedgerEntryState> emit,
    Future<LedgerEntry> Function(int projectId, int entryId) call,
  ) async {
    final projectId = state.projectId;
    final entryId = state.entryId;
    if (projectId == null || entryId == null) return;
    final l10n = LocalizationService.localization;
    emit(
      state.copyWith(
        actionStatus: GenericStatus.loading,
        actionErrorMessage: null,
        lastAction: action,
      ),
    );
    try {
      await call(projectId, entryId);
      final entry = await _ledgerRepository.fetchEntry(projectId, entryId);
      emit(state.copyWith(entry: entry, actionStatus: GenericStatus.success));
    } catch (e) {
      log('LedgerEntryBloc._act error: $e');
      emit(
        state.copyWith(
          actionStatus: GenericStatus.failure,
          actionErrorMessage: _message(e, l10n, fallback: l10n.errorLedgerSave),
        ),
      );
    }
  }

  void _onResetFlowStep(
    _ResetFlowStep event,
    Emitter<LedgerEntryState> emit,
  ) {
    emit(
      state.copyWith(
        actionStatus: GenericStatus.initial,
        actionErrorMessage: null,
      ),
    );
  }

  /// The message for [error], also when it comes from a parallel wait.
  String _message(Object error, AppLocalizations l10n, {String? fallback}) {
    final cause = error is ParallelWaitError
        ? (error.errors as Iterable).firstWhere(
            (e) => e != null,
            orElse: () => error,
          )
        : error;
    return switch (cause) {
      HttpException400(:final code) => code.message(l10n),
      HttpException401() => l10n.errorUnauthorized,
      NetworkException() => l10n.networkError,
      _ => fallback ?? l10n.errorLedgerLoad,
    };
  }

  LedgerEntryState _loadFailure(String message) => state.copyWith(
    loadStatus: GenericStatus.failure,
    loadErrorMessage: message,
  );
}
