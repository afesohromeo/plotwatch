import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'update_form_event.dart';
part 'update_form_state.dart';
part 'update_form_bloc.freezed.dart';

/// The site manager posts news from the site: text, optional stage,
/// workers, weather and issues (UPD-01; doc/04e M5-9 b).
class UpdateFormBloc extends Bloc<UpdateFormEvent, UpdateFormState> {
  UpdateFormBloc({
    required this._updateRepository,
    required this._stageRepository,
  }) : super(const UpdateFormState()) {
    on<_Load>(_onLoad);
    on<_SaveRequested>(_onSaveRequested);
    on<_ResetFlowStep>(_onResetFlowStep);
  }

  final UpdateRepository _updateRepository;
  final StageRepository _stageRepository;

  /// Loads the stages, for the stage picker.
  Future<void> _onLoad(_Load event, Emitter<UpdateFormState> emit) async {
    final l10n = LocalizationService.localization;
    emit(
      UpdateFormState(
        projectId: event.projectId,
        loadStatus: GenericStatus.loading,
      ),
    );
    try {
      final plan = await _stageRepository.fetchPlan(event.projectId);
      emit(
        state.copyWith(
          loadStatus: GenericStatus.success,
          stages: [for (final view in plan.stages) view.stage],
        ),
      );
    } on HttpException400 catch (e) {
      emit(_loadFailure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_loadFailure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_loadFailure(l10n.networkError));
    } catch (e) {
      log('UpdateFormBloc._onLoad error: $e');
      emit(_loadFailure(l10n.errorStagesLoad));
    }
  }

  Future<void> _onSaveRequested(
    _SaveRequested event,
    Emitter<UpdateFormState> emit,
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
      final saved = await _updateRepository.createUpdate(
        projectId,
        event.draft,
      );
      emit(state.copyWith(actionStatus: GenericStatus.success, saved: saved));
    } on HttpException400 catch (e) {
      emit(_actionFailure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_actionFailure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_actionFailure(l10n.networkError));
    } catch (e) {
      log('UpdateFormBloc._onSaveRequested error: $e');
      emit(_actionFailure(l10n.errorUpdateSave));
    }
  }

  void _onResetFlowStep(_ResetFlowStep event, Emitter<UpdateFormState> emit) {
    emit(
      state.copyWith(
        actionStatus: GenericStatus.initial,
        actionErrorMessage: null,
      ),
    );
  }

  UpdateFormState _loadFailure(String message) => state.copyWith(
    loadStatus: GenericStatus.failure,
    loadErrorMessage: message,
  );

  UpdateFormState _actionFailure(String message) => state.copyWith(
    actionStatus: GenericStatus.failure,
    actionErrorMessage: message,
  );
}
