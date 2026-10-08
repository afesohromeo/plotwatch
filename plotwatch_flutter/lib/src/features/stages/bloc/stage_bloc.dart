import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'stage_event.dart';
part 'stage_state.dart';
part 'stage_bloc.freezed.dart';

/// One stage with its checklist: the site manager starts it, the owner
/// deletes it (doc/04c M3-6, M3-8). Editing is the stage form's job.
class StageBloc extends Bloc<StageEvent, StageState> {
  StageBloc({required this._stageRepository, required this._projectRepository})
    : super(const StageState()) {
    on<_Load>(_onLoad);
    on<_StartRequested>(_onStartRequested);
    on<_DeleteRequested>(_onDeleteRequested);
    on<_ResetFlowStep>(_onResetFlowStep);
  }

  final StageRepository _stageRepository;
  final ProjectRepository _projectRepository;

  Future<void> _onLoad(_Load event, Emitter<StageState> emit) async {
    final l10n = LocalizationService.localization;
    emit(
      StageState(
        projectId: event.projectId,
        stageId: event.stageId,
        overview: state.overview,
        view: state.view,
        loadStatus: GenericStatus.loading,
      ),
    );
    try {
      final overview = await _projectRepository.fetchProject(event.projectId);
      final view = await _stageRepository.fetchStage(
        event.projectId,
        event.stageId,
      );
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
      log('StageBloc._onLoad error: $e');
      emit(_loadFailure(l10n.errorStagesLoad));
    }
  }

  Future<void> _onStartRequested(
    _StartRequested event,
    Emitter<StageState> emit,
  ) => _runAction(
    emit,
    GenericFlowStep.updatingItem,
    'StageBloc._onStartRequested',
    (projectId, stageId) async {
      final started = await _stageRepository.startStage(projectId, stageId);
      return state.copyWith(view: started);
    },
  );

  Future<void> _onDeleteRequested(
    _DeleteRequested event,
    Emitter<StageState> emit,
  ) => _runAction(
    emit,
    GenericFlowStep.deletingItem,
    'StageBloc._onDeleteRequested',
    (projectId, stageId) async {
      await _stageRepository.deleteStage(projectId, stageId);
      return state;
    },
  );

  /// [action] returns the state to show once it succeeded.
  Future<void> _runAction(
    Emitter<StageState> emit,
    GenericFlowStep flowStep,
    String logTag,
    Future<StageState> Function(int projectId, int stageId) action,
  ) async {
    final projectId = state.projectId;
    final stageId = state.stageId;
    if (projectId == null || stageId == null) return;

    final l10n = LocalizationService.localization;
    emit(
      state.copyWith(
        flowStep: flowStep,
        actionStatus: GenericStatus.loading,
        actionErrorMessage: null,
      ),
    );
    try {
      final updated = await action(projectId, stageId);
      // The flow step is set again: a reload meanwhile resets it, and the
      // page would take the result for another action (doc/04c M3-F1).
      emit(
        updated.copyWith(flowStep: flowStep, actionStatus: GenericStatus.success),
      );
    } on HttpException400 catch (e) {
      emit(_actionFailure(e.code.message(l10n), flowStep));
    } on HttpException401 catch (_) {
      emit(_actionFailure(l10n.errorUnauthorized, flowStep));
    } on NetworkException catch (_) {
      emit(_actionFailure(l10n.networkError, flowStep));
    } catch (e) {
      log('$logTag error: $e');
      emit(_actionFailure(l10n.errorStagesSave, flowStep));
    }
  }

  void _onResetFlowStep(_ResetFlowStep event, Emitter<StageState> emit) {
    emit(
      state.copyWith(
        flowStep: GenericFlowStep.none,
        actionStatus: GenericStatus.initial,
        actionErrorMessage: null,
      ),
    );
  }

  StageState _loadFailure(String message) => state.copyWith(
    loadStatus: GenericStatus.failure,
    loadErrorMessage: message,
  );

  StageState _actionFailure(String message, GenericFlowStep flowStep) =>
      state.copyWith(
        flowStep: flowStep,
        actionStatus: GenericStatus.failure,
        actionErrorMessage: message,
      );
}
