import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'stage_form_event.dart';
part 'stage_form_state.dart';
part 'stage_form_bloc.freezed.dart';

/// The owner creates a stage or edits one with its checklist (STG-01,
/// STG-04; doc/04c M3-4, M3-5). The form itself holds the field values.
class StageFormBloc extends Bloc<StageFormEvent, StageFormState> {
  StageFormBloc({
    required this._stageRepository,
    required this._projectRepository,
  }) : super(const StageFormState()) {
    on<_Load>(_onLoad);
    on<_SaveRequested>(_onSaveRequested);
    on<_ResetFlowStep>(_onResetFlowStep);
  }

  final StageRepository _stageRepository;
  final ProjectRepository _projectRepository;

  /// Loads the project (for its currency) and, when editing, the stage.
  Future<void> _onLoad(_Load event, Emitter<StageFormState> emit) async {
    final l10n = LocalizationService.localization;
    emit(
      StageFormState(
        projectId: event.projectId,
        stageId: event.stageId,
        loadStatus: GenericStatus.loading,
      ),
    );
    try {
      final overview = await _projectRepository.fetchProject(event.projectId);
      final stageId = event.stageId;
      final view = stageId == null
          ? null
          : await _stageRepository.fetchStage(event.projectId, stageId);
      emit(
        state.copyWith(
          loadStatus: GenericStatus.success,
          overview: overview,
          view: view,
        ),
      );
    } on HttpException400 catch (e) {
      emit(_loadFailure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_loadFailure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_loadFailure(l10n.networkError));
    } catch (e) {
      log('StageFormBloc._onLoad error: $e');
      emit(_loadFailure(l10n.errorStagesLoad));
    }
  }

  Future<void> _onSaveRequested(
    _SaveRequested event,
    Emitter<StageFormState> emit,
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
      final stageId = state.stageId;
      final saved = stageId == null
          ? await _stageRepository.createStage(projectId, event.draft)
          : await _stageRepository.updateStage(projectId, stageId, event.draft);
      emit(state.copyWith(actionStatus: GenericStatus.success, saved: saved));
    } on HttpException400 catch (e) {
      emit(_actionFailure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_actionFailure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_actionFailure(l10n.networkError));
    } catch (e) {
      log('StageFormBloc._onSaveRequested error: $e');
      emit(_actionFailure(l10n.errorStagesSave));
    }
  }

  void _onResetFlowStep(_ResetFlowStep event, Emitter<StageFormState> emit) {
    emit(
      state.copyWith(
        actionStatus: GenericStatus.initial,
        actionErrorMessage: null,
      ),
    );
  }

  StageFormState _loadFailure(String message) => state.copyWith(
    loadStatus: GenericStatus.failure,
    loadErrorMessage: message,
  );

  StageFormState _actionFailure(String message) => state.copyWith(
    actionStatus: GenericStatus.failure,
    actionErrorMessage: message,
  );
}
