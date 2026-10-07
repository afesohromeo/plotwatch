import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'validate_site_event.dart';
part 'validate_site_state.dart';
part 'validate_site_bloc.freezed.dart';

/// The owner reviews the proposed location: sets the radius and validates
/// it, or rejects it with a reason (decisions M2-15, M2-16, M2-18).
class ValidateSiteBloc extends Bloc<ValidateSiteEvent, ValidateSiteState> {
  ValidateSiteBloc({required this._siteRepository})
    : super(const ValidateSiteState()) {
    on<_Load>(_onLoad);
    on<_RadiusChanged>(_onRadiusChanged);
    on<_ValidateRequested>(_onValidateRequested);
    on<_RejectRequested>(_onRejectRequested);
    on<_ResetFlowStep>(_onResetFlowStep);
  }

  final SiteRepository _siteRepository;

  Future<void> _onLoad(_Load event, Emitter<ValidateSiteState> emit) async {
    final l10n = LocalizationService.localization;
    emit(
      ValidateSiteState(
        projectId: event.projectId,
        loadStatus: GenericStatus.loading,
      ),
    );
    try {
      final proposals = await _siteRepository.fetchProposals(event.projectId);
      final site = await _siteRepository.fetchSite(event.projectId);
      final pending = proposals
          .where((p) => p.status == SiteProposalStatus.pending)
          .firstOrNull;
      emit(
        state.copyWith(
          loadStatus: GenericStatus.success,
          proposal: pending,
          radiusM: site?.radiusM ?? defaultSiteRadiusM,
        ),
      );
    } on HttpException400 catch (e) {
      emit(_loadFailure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_loadFailure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_loadFailure(l10n.networkError));
    } catch (e) {
      log('ValidateSiteBloc._onLoad error: $e');
      emit(_loadFailure(l10n.errorSiteLoad));
    }
  }

  void _onRadiusChanged(_RadiusChanged event, Emitter<ValidateSiteState> emit) {
    emit(
      state.copyWith(
        radiusM: event.radiusM.clamp(minSiteRadiusM, maxSiteRadiusM),
      ),
    );
  }

  Future<void> _onValidateRequested(
    _ValidateRequested event,
    Emitter<ValidateSiteState> emit,
  ) => _runAction(
    emit,
    GenericFlowStep.updatingItem,
    'ValidateSiteBloc._onValidateRequested',
    (projectId, proposalId) => _siteRepository.validateProposal(
      projectId,
      proposalId,
      radiusM: state.radiusM,
      addressText: event.addressText,
    ),
  );

  Future<void> _onRejectRequested(
    _RejectRequested event,
    Emitter<ValidateSiteState> emit,
  ) => _runAction(
    emit,
    GenericFlowStep.deletingItem,
    'ValidateSiteBloc._onRejectRequested',
    (projectId, proposalId) => _siteRepository.rejectProposal(
      projectId,
      proposalId,
      reason: event.reason,
    ),
  );

  Future<void> _runAction(
    Emitter<ValidateSiteState> emit,
    GenericFlowStep flowStep,
    String logTag,
    Future<void> Function(int projectId, int proposalId) action,
  ) async {
    final projectId = state.projectId;
    final proposalId = state.proposal?.id;
    if (projectId == null || proposalId == null) return;

    final l10n = LocalizationService.localization;
    emit(
      state.copyWith(
        flowStep: flowStep,
        actionStatus: GenericStatus.loading,
        actionErrorMessage: null,
      ),
    );
    try {
      await action(projectId, proposalId);
      emit(state.copyWith(actionStatus: GenericStatus.success));
    } on HttpException400 catch (e) {
      emit(_actionFailure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_actionFailure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_actionFailure(l10n.networkError));
    } catch (e) {
      log('$logTag error: $e');
      emit(_actionFailure(l10n.errorSiteSave));
    }
  }

  void _onResetFlowStep(_ResetFlowStep event, Emitter<ValidateSiteState> emit) {
    emit(
      state.copyWith(
        flowStep: GenericFlowStep.none,
        actionStatus: GenericStatus.initial,
        actionErrorMessage: null,
      ),
    );
  }

  ValidateSiteState _loadFailure(String message) => state.copyWith(
    loadStatus: GenericStatus.failure,
    loadErrorMessage: message,
  );

  ValidateSiteState _actionFailure(String message) => state.copyWith(
    actionStatus: GenericStatus.failure,
    actionErrorMessage: message,
  );
}
