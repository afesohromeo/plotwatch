import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'project_overview_event.dart';
part 'project_overview_state.dart';
part 'project_overview_bloc.freezed.dart';

/// One project: its details, site and the caller's role; the owner edits it
/// and changes its status (PROJ-04, PROJ-05).
class ProjectOverviewBloc
    extends Bloc<ProjectOverviewEvent, ProjectOverviewState> {
  ProjectOverviewBloc({required this._projectRepository})
    : super(const ProjectOverviewState()) {
    on<_FetchProject>(_onFetchProject);
    on<_UpdateProject>(_onUpdateProject);
    on<_ChangeStatus>(_onChangeStatus);
    on<_ResetFlowStep>(_onResetFlowStep);
  }

  final ProjectRepository _projectRepository;

  Future<void> _onFetchProject(
    _FetchProject event,
    Emitter<ProjectOverviewState> emit,
  ) async {
    final l10n = LocalizationService.localization;
    emit(
      state.copyWith(
        overviewStatus: GenericStatus.loading,
        overviewErrorMessage: null,
      ),
    );
    try {
      final overview = await _projectRepository.fetchProject(event.projectId);
      emit(
        state.copyWith(
          overviewStatus: GenericStatus.success,
          overview: overview,
        ),
      );
    } on HttpException400 catch (e) {
      emit(_loadFailure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_loadFailure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_loadFailure(l10n.networkError));
    } catch (e) {
      log('ProjectOverviewBloc._onFetchProject error: $e');
      emit(_loadFailure(l10n.errorProjectLoad));
    }
  }

  Future<void> _onUpdateProject(
    _UpdateProject event,
    Emitter<ProjectOverviewState> emit,
  ) => _runAction(
    emit,
    (projectId) => _projectRepository.updateProject(projectId, event.details),
    'ProjectOverviewBloc._onUpdateProject',
  );

  Future<void> _onChangeStatus(
    _ChangeStatus event,
    Emitter<ProjectOverviewState> emit,
  ) => _runAction(
    emit,
    (projectId) => _projectRepository.setProjectStatus(projectId, event.status),
    'ProjectOverviewBloc._onChangeStatus',
  );

  /// An owner action on the loaded project; the answer replaces the overview.
  Future<void> _runAction(
    Emitter<ProjectOverviewState> emit,
    Future<ProjectOverview> Function(int projectId) action,
    String logTag,
  ) async {
    final projectId = state.overview?.project.id;
    if (projectId == null) return;

    final l10n = LocalizationService.localization;
    emit(
      state.copyWith(
        flowStep: GenericFlowStep.updatingItem,
        actionStatus: GenericStatus.loading,
        actionErrorMessage: null,
      ),
    );
    try {
      final overview = await action(projectId);
      emit(
        state.copyWith(actionStatus: GenericStatus.success, overview: overview),
      );
    } on HttpException400 catch (e) {
      emit(_actionFailure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_actionFailure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_actionFailure(l10n.networkError));
    } catch (e) {
      log('$logTag error: $e');
      emit(_actionFailure(l10n.errorProjectSave));
    }
  }

  void _onResetFlowStep(
    _ResetFlowStep event,
    Emitter<ProjectOverviewState> emit,
  ) {
    emit(
      state.copyWith(
        flowStep: GenericFlowStep.none,
        actionStatus: GenericStatus.initial,
        actionErrorMessage: null,
      ),
    );
  }

  ProjectOverviewState _loadFailure(String message) => state.copyWith(
    overviewStatus: GenericStatus.failure,
    overviewErrorMessage: message,
  );

  ProjectOverviewState _actionFailure(String message) => state.copyWith(
    actionStatus: GenericStatus.failure,
    actionErrorMessage: message,
  );
}
