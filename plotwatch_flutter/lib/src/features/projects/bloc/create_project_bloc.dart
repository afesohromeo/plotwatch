import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'create_project_event.dart';
part 'create_project_state.dart';
part 'create_project_bloc.freezed.dart';

/// The create-project wizard: Details → Stages → Review, then one create
/// request with the chosen template's stages (PROJ-01, PROJ-08; decisions
/// M2-3, M3-3). The project starts as a draft.
class CreateProjectBloc extends Bloc<CreateProjectEvent, CreateProjectState> {
  CreateProjectBloc({required this._projectRepository})
    : super(const CreateProjectState()) {
    on<_DetailsSubmitted>(_onDetailsSubmitted);
    on<_TemplateChosen>(_onTemplateChosen);
    on<_StagesSubmitted>(_onStagesSubmitted);
    on<_StepBack>(_onStepBack);
    on<_CreateSubmitted>(_onCreateSubmitted);
    on<_ResetFlowStep>(_onResetFlowStep);
  }

  final ProjectRepository _projectRepository;

  void _onDetailsSubmitted(
    _DetailsSubmitted event,
    Emitter<CreateProjectState> emit,
  ) {
    emit(
      state.copyWith(step: CreateProjectStep.stages, details: event.details),
    );
  }

  void _onTemplateChosen(
    _TemplateChosen event,
    Emitter<CreateProjectState> emit,
  ) {
    emit(state.copyWith(template: event.template));
  }

  void _onStagesSubmitted(
    _StagesSubmitted event,
    Emitter<CreateProjectState> emit,
  ) {
    emit(state.copyWith(step: CreateProjectStep.review));
  }

  void _onStepBack(_StepBack event, Emitter<CreateProjectState> emit) {
    final previous = switch (state.step) {
      CreateProjectStep.review => CreateProjectStep.stages,
      _ => CreateProjectStep.details,
    };
    emit(state.copyWith(step: previous));
  }

  Future<void> _onCreateSubmitted(
    _CreateSubmitted event,
    Emitter<CreateProjectState> emit,
  ) async {
    final details = state.details;
    if (details == null) return;

    final l10n = LocalizationService.localization;
    emit(
      state.copyWith(
        createStatus: GenericStatus.loading,
        createErrorMessage: null,
      ),
    );
    try {
      final created = await _projectRepository.createProject(
        details,
        stages: state.template.stages(l10n),
      );
      emit(
        state.copyWith(createStatus: GenericStatus.success, created: created),
      );
    } on HttpException400 catch (e) {
      emit(_failure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_failure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_failure(l10n.networkError));
    } catch (e) {
      log('CreateProjectBloc._onCreateSubmitted error: $e');
      emit(_failure(l10n.errorProjectCreate));
    }
  }

  void _onResetFlowStep(
    _ResetFlowStep event,
    Emitter<CreateProjectState> emit,
  ) {
    emit(
      state.copyWith(
        createStatus: GenericStatus.initial,
        createErrorMessage: null,
      ),
    );
  }

  CreateProjectState _failure(String message) => state.copyWith(
    createStatus: GenericStatus.failure,
    createErrorMessage: message,
  );
}
