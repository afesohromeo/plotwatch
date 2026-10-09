import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'stage_plan_event.dart';
part 'stage_plan_state.dart';
part 'stage_plan_bloc.freezed.dart';

/// A project's stage plan: the stages in order with the total budget and
/// the progress; the owner reorders them and fills an empty plan from a
/// template (doc/04c M3-3, M3-7, M3-11).
class StagePlanBloc extends Bloc<StagePlanEvent, StagePlanState> {
  StagePlanBloc({
    required this._stageRepository,
    required this._projectRepository,
  }) : super(const StagePlanState()) {
    on<_Load>(_onLoad);
    on<_ReorderRequested>(_onReorderRequested);
    on<_TemplateApplied>(_onTemplateApplied);
    on<_ResetFlowStep>(_onResetFlowStep);
  }

  final StageRepository _stageRepository;
  final ProjectRepository _projectRepository;

  Future<void> _onLoad(_Load event, Emitter<StagePlanState> emit) async {
    final l10n = LocalizationService.localization;
    emit(
      StagePlanState(
        projectId: event.projectId,
        overview: state.overview,
        plan: state.plan,
        loadStatus: GenericStatus.loading,
      ),
    );
    try {
      final overview = await _projectRepository.fetchProject(event.projectId);
      final plan = await _stageRepository.fetchPlan(event.projectId);
      emit(
        state.copyWith(
          loadStatus: GenericStatus.success,
          overview: overview,
          plan: plan,
        ),
      );
    } on HttpException400 catch (e) {
      emit(_loadFailure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_loadFailure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_loadFailure(l10n.networkError));
    } catch (e) {
      log('StagePlanBloc._onLoad error: $e');
      emit(_loadFailure(l10n.errorStagesLoad));
    }
  }

  /// Moves the stage at once, then sends the whole order; a refusal puts
  /// the list back (decision M3-7).
  Future<void> _onReorderRequested(
    _ReorderRequested event,
    Emitter<StagePlanState> emit,
  ) async {
    final before = state.plan;
    final projectId = state.projectId;
    if (!state.canEdit || before == null || projectId == null) return;

    if (event.newIndex == event.oldIndex) return;
    final stages = [...before.stages];
    stages.insert(event.newIndex, stages.removeAt(event.oldIndex));

    await _runAction(
      emit,
      GenericFlowStep.updatingItem,
      'StagePlanBloc._onReorderRequested',
      optimistic: before.copyWith(stages: stages),
      restore: before,
      () => _stageRepository.reorderStages(projectId, [
        for (final view in stages) view.stage.id!,
      ]),
    );
  }

  Future<void> _onTemplateApplied(
    _TemplateApplied event,
    Emitter<StagePlanState> emit,
  ) async {
    final projectId = state.projectId;
    if (!state.canEdit || projectId == null) return;

    final l10n = LocalizationService.localization;
    await _runAction(
      emit,
      GenericFlowStep.creatingItem,
      'StagePlanBloc._onTemplateApplied',
      () => _stageRepository.createPlan(projectId, event.template.stages(l10n)),
    );
  }

  /// Runs an owner action that answers with the new plan. [optimistic] is
  /// shown while it runs and [restore] after a failure.
  Future<void> _runAction(
    Emitter<StagePlanState> emit,
    GenericFlowStep flowStep,
    String logTag,
    Future<StagePlan> Function() action, {
    StagePlan? optimistic,
    StagePlan? restore,
  }) async {
    final l10n = LocalizationService.localization;
    emit(
      state.copyWith(
        plan: optimistic ?? state.plan,
        flowStep: flowStep,
        actionStatus: GenericStatus.loading,
        actionErrorMessage: null,
      ),
    );
    try {
      final plan = await action();
      // The flow step is set again: a reload meanwhile resets it (doc/04c
      // M3-F1).
      emit(
        state.copyWith(
          plan: plan,
          flowStep: flowStep,
          actionStatus: GenericStatus.success,
        ),
      );
    } on HttpException400 catch (e) {
      emit(_actionFailure(e.code.message(l10n), flowStep, restore));
    } on HttpException401 catch (_) {
      emit(_actionFailure(l10n.errorUnauthorized, flowStep, restore));
    } on NetworkException catch (_) {
      emit(_actionFailure(l10n.networkError, flowStep, restore));
    } catch (e) {
      log('$logTag error: $e');
      emit(_actionFailure(l10n.errorStagesSave, flowStep, restore));
    }
  }

  void _onResetFlowStep(_ResetFlowStep event, Emitter<StagePlanState> emit) {
    emit(
      state.copyWith(
        flowStep: GenericFlowStep.none,
        actionStatus: GenericStatus.initial,
        actionErrorMessage: null,
      ),
    );
  }

  StagePlanState _loadFailure(String message) => state.copyWith(
    loadStatus: GenericStatus.failure,
    loadErrorMessage: message,
  );

  StagePlanState _actionFailure(
    String message,
    GenericFlowStep flowStep,
    StagePlan? restore,
  ) => state.copyWith(
    plan: restore ?? state.plan,
    flowStep: flowStep,
    actionStatus: GenericStatus.failure,
    actionErrorMessage: message,
  );
}
