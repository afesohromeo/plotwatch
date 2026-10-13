import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'stage_event.dart';
part 'stage_state.dart';
part 'stage_bloc.freezed.dart';

/// One stage with its checklist and the captures of each item: the site
/// manager starts it and takes photos, the owner deletes it (doc/04c M3-6,
/// M3-8; doc/04d group D). Editing is the stage form's job.
class StageBloc extends Bloc<StageEvent, StageState> {
  StageBloc({
    required this._stageRepository,
    required this._projectRepository,
    required this._evidenceRepository,
  }) : super(const StageState()) {
    on<_Load>(_onLoad);
    on<_StartRequested>(_onStartRequested);
    on<_DeleteRequested>(_onDeleteRequested);
    on<_SubmitRequested>(_onSubmitRequested);
    on<_ReviewRequested>(_onReviewRequested);
    on<_ResetFlowStep>(_onResetFlowStep);
  }

  final StageRepository _stageRepository;
  final ProjectRepository _projectRepository;
  final EvidenceRepository _evidenceRepository;

  Future<void> _onLoad(_Load event, Emitter<StageState> emit) async {
    final l10n = LocalizationService.localization;
    emit(
      StageState(
        projectId: event.projectId,
        stageId: event.stageId,
        overview: state.overview,
        view: state.view,
        evidence: state.evidence,
        reviews: state.reviews,
        loadStatus: GenericStatus.loading,
      ),
    );
    try {
      // Together, not one after another: each call costs a round trip
      // (doc/04g step 10b). The first error passes through unchanged.
      final overviewCall = _projectRepository.fetchProject(event.projectId);
      final viewCall = _stageRepository.fetchStage(
        event.projectId,
        event.stageId,
      );
      final evidenceCall = _evidenceRepository.fetchStageEvidence(
        event.projectId,
        event.stageId,
      );
      final reviewsCall = _stageRepository.fetchReviews(
        event.projectId,
        event.stageId,
      );
      await Future.wait<Object?>([
        overviewCall,
        viewCall,
        evidenceCall,
        reviewsCall,
      ], eagerError: true);
      final overview = await overviewCall;
      final view = await viewCall;
      final evidence = await evidenceCall;
      final reviews = await reviewsCall;
      emit(
        state.copyWith(
          loadStatus: GenericStatus.success,
          overview: overview,
          view: view,
          evidence: evidence,
          reviews: reviews,
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
    StageAction.start,
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
    StageAction.delete,
    GenericFlowStep.deletingItem,
    'StageBloc._onDeleteRequested',
    (projectId, stageId) async {
      await _stageRepository.deleteStage(projectId, stageId);
      return state;
    },
  );

  Future<void> _onSubmitRequested(
    _SubmitRequested event,
    Emitter<StageState> emit,
  ) => _runAction(
    emit,
    StageAction.submit,
    GenericFlowStep.updatingItem,
    'StageBloc._onSubmitRequested',
    (projectId, stageId) async {
      final submitted = await _stageRepository.submitStage(projectId, stageId);
      return state.copyWith(view: submitted);
    },
  );

  /// The decision, then the history again so it shows at once.
  Future<void> _onReviewRequested(
    _ReviewRequested event,
    Emitter<StageState> emit,
  ) => _runAction(
    emit,
    event.decision == ReviewDecision.approved
        ? StageAction.approve
        : StageAction.requestChanges,
    GenericFlowStep.updatingItem,
    'StageBloc._onReviewRequested',
    (projectId, stageId) async {
      final reviewed = await _stageRepository.reviewStage(
        projectId,
        stageId,
        event.decision,
        comment: event.comment,
      );
      final reviews = await _stageRepository.fetchReviews(projectId, stageId);
      return state.copyWith(view: reviewed, reviews: reviews);
    },
  );

  /// [action] returns the state to show once it succeeded.
  Future<void> _runAction(
    Emitter<StageState> emit,
    StageAction stageAction,
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
        action: stageAction,
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
        updated.copyWith(
          action: stageAction,
          flowStep: flowStep,
          actionStatus: GenericStatus.success,
        ),
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
