import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'ledger_form_event.dart';
part 'ledger_form_state.dart';
part 'ledger_form_bloc.freezed.dart';

/// Recording a release (a funder) or an expense (the site manager), with
/// the receipt photo uploaded first (LED-01, LED-03; doc/04f).
class LedgerFormBloc extends Bloc<LedgerFormEvent, LedgerFormState> {
  LedgerFormBloc({
    required this._ledgerRepository,
    required this._projectRepository,
    required this._stageRepository,
  }) : super(const LedgerFormState()) {
    on<_Load>(_onLoad);
    on<_SaveRelease>(_onSaveRelease);
    on<_SaveExpense>(_onSaveExpense);
    on<_ResetFlowStep>(_onResetFlowStep);
  }

  final LedgerRepository _ledgerRepository;
  final ProjectRepository _projectRepository;
  final StageRepository _stageRepository;

  Future<void> _onLoad(_Load event, Emitter<LedgerFormState> emit) async {
    final l10n = LocalizationService.localization;
    emit(
      LedgerFormState(
        projectId: event.projectId,
        loadStatus: GenericStatus.loading,
      ),
    );
    try {
      final (overview, plan) = await (
        _projectRepository.fetchProject(event.projectId),
        _stageRepository.fetchPlan(event.projectId),
      ).wait;
      emit(
        state.copyWith(
          loadStatus: GenericStatus.success,
          overview: overview,
          stages: [for (final view in plan.stages) view.stage],
        ),
      );
    } catch (e) {
      log('LedgerFormBloc._onLoad error: $e');
      emit(
        state.copyWith(
          loadStatus: GenericStatus.failure,
          loadErrorMessage: _message(e, l10n, l10n.errorLedgerLoad),
        ),
      );
    }
  }

  Future<void> _onSaveRelease(
    _SaveRelease event,
    Emitter<LedgerFormState> emit,
  ) => _save(
    emit,
    (projectId) => _ledgerRepository.recordRelease(projectId, event.draft),
  );

  Future<void> _onSaveExpense(
    _SaveExpense event,
    Emitter<LedgerFormState> emit,
  ) => _save(
    emit,
    (projectId) => _ledgerRepository.recordExpense(
      projectId,
      event.draft,
      receipt: event.receipt,
    ),
  );

  Future<void> _save(
    Emitter<LedgerFormState> emit,
    Future<LedgerEntry> Function(int projectId) call,
  ) async {
    final projectId = state.projectId;
    if (projectId == null) return;
    final l10n = LocalizationService.localization;
    emit(
      state.copyWith(
        actionStatus: GenericStatus.loading,
        actionErrorMessage: null,
      ),
    );
    try {
      final saved = await call(projectId);
      emit(state.copyWith(actionStatus: GenericStatus.success, saved: saved));
    } catch (e) {
      log('LedgerFormBloc._save error: $e');
      emit(
        state.copyWith(
          actionStatus: GenericStatus.failure,
          actionErrorMessage: _message(e, l10n, l10n.errorLedgerSave),
        ),
      );
    }
  }

  void _onResetFlowStep(_ResetFlowStep event, Emitter<LedgerFormState> emit) {
    emit(
      state.copyWith(
        actionStatus: GenericStatus.initial,
        actionErrorMessage: null,
      ),
    );
  }

  /// The message for [error], also when it comes from a parallel wait.
  String _message(Object error, AppLocalizations l10n, String fallback) {
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
      UploadException() => l10n.errorReceiptUpload,
      _ => fallback,
    };
  }
}
