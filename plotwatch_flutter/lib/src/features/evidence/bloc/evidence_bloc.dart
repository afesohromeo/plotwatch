import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'evidence_event.dart';
part 'evidence_state.dart';
part 'evidence_bloc.freezed.dart';

/// One capture with its badge, checks and details; its author can retract
/// it with a reason (VER-03, CAP-09; doc/04d M4-11).
class EvidenceBloc extends Bloc<EvidenceEvent, EvidenceState> {
  EvidenceBloc({
    required this._evidenceRepository,
    required this._projectRepository,
    required this._authRepository,
  }) : super(const EvidenceState()) {
    on<_Load>(_onLoad);
    on<_RetractRequested>(_onRetractRequested);
    on<_ResetFlowStep>(_onResetFlowStep);
  }

  final EvidenceRepository _evidenceRepository;
  final ProjectRepository _projectRepository;
  final AuthRepository _authRepository;

  Future<void> _onLoad(_Load event, Emitter<EvidenceState> emit) async {
    final l10n = LocalizationService.localization;
    emit(
      EvidenceState(
        projectId: event.projectId,
        stageId: event.stageId,
        evidenceId: event.evidenceId,
        loadStatus: GenericStatus.loading,
      ),
    );
    try {
      final overview = await _projectRepository.fetchProject(event.projectId);
      final evidence = await _evidenceRepository.fetchEvidence(
        event.projectId,
        event.evidenceId,
      );
      emit(
        state.copyWith(
          loadStatus: GenericStatus.success,
          overview: overview,
          evidence: evidence,
          isMine: evidence.capturedBy == _authRepository.currentUserId,
        ),
      );
    } on HttpException400 catch (e) {
      emit(_loadFailure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_loadFailure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_loadFailure(l10n.networkError));
    } catch (e) {
      log('EvidenceBloc._onLoad error: $e');
      emit(_loadFailure(l10n.errorEvidenceLoad));
    }
  }

  Future<void> _onRetractRequested(
    _RetractRequested event,
    Emitter<EvidenceState> emit,
  ) async {
    final projectId = state.projectId;
    final evidenceId = state.evidenceId;
    if (projectId == null || evidenceId == null || !state.canRetract) return;

    final l10n = LocalizationService.localization;
    emit(
      state.copyWith(
        actionStatus: GenericStatus.loading,
        actionErrorMessage: null,
      ),
    );
    try {
      final retracted = await _evidenceRepository.retract(
        projectId,
        evidenceId,
        event.reason,
      );
      emit(
        state.copyWith(
          evidence: retracted,
          actionStatus: GenericStatus.success,
        ),
      );
    } on HttpException400 catch (e) {
      emit(_actionFailure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_actionFailure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_actionFailure(l10n.networkError));
    } catch (e) {
      log('EvidenceBloc._onRetractRequested error: $e');
      emit(_actionFailure(l10n.errorEvidenceLoad));
    }
  }

  void _onResetFlowStep(_ResetFlowStep event, Emitter<EvidenceState> emit) {
    emit(
      state.copyWith(
        actionStatus: GenericStatus.initial,
        actionErrorMessage: null,
      ),
    );
  }

  EvidenceState _loadFailure(String message) => state.copyWith(
    loadStatus: GenericStatus.failure,
    loadErrorMessage: message,
  );

  EvidenceState _actionFailure(String message) => state.copyWith(
    actionStatus: GenericStatus.failure,
    actionErrorMessage: message,
  );
}
