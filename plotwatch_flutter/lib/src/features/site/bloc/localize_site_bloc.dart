import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'localize_site_event.dart';
part 'localize_site_state.dart';
part 'localize_site_bloc.freezed.dart';

/// The site manager or the owner, standing on the plot, proposes the site
/// from the phone's GPS (decisions M2-15, M2-17; doc/04b G-5, G-12).
class LocalizeSiteBloc extends Bloc<LocalizeSiteEvent, LocalizeSiteState> {
  LocalizeSiteBloc({
    required this._siteRepository,
    required this._projectRepository,
    required this._locationProvider,
  }) : super(const LocalizeSiteState()) {
    // Sent again only after a refusal, when the earlier handler has ended.
    on<_Started>(_onStarted);
    on<_SettingsRequested>(_onSettingsRequested);
    on<_ProposeRequested>(_onProposeRequested);
    on<_ResetFlowStep>(_onResetFlowStep);
  }

  final SiteRepository _siteRepository;
  final ProjectRepository _projectRepository;
  final LocationProvider _locationProvider;

  Future<void> _onStarted(
    _Started event,
    Emitter<LocalizeSiteState> emit,
  ) async {
    final l10n = LocalizationService.localization;
    if (state.myRole == null) {
      try {
        final overview = await _projectRepository.fetchProject(event.projectId);
        emit(state.copyWith(myRole: overview.myRole, loadErrorMessage: null));
      } on HttpException400 catch (e) {
        emit(state.copyWith(loadErrorMessage: e.code.message(l10n)));
        return;
      } on NetworkException catch (_) {
        emit(state.copyWith(loadErrorMessage: l10n.networkError));
        return;
      } catch (e) {
        log('LocalizeSiteBloc._onStarted error: $e');
        emit(state.copyWith(loadErrorMessage: l10n.errorProjectLoad));
        return;
      }
    }

    final access = await _locationProvider.ensureAccess();
    emit(state.copyWith(access: access));
    if (access != LocationAccess.granted) return;

    await emit.forEach<GpsReading>(
      _locationProvider.readings(),
      onData: (reading) => state.copyWith(reading: reading),
      onError: (error, _) {
        log('LocalizeSiteBloc readings error: $error');
        return state.copyWith(access: LocationAccess.denied, reading: null);
      },
    );
  }

  Future<void> _onSettingsRequested(
    _SettingsRequested event,
    Emitter<LocalizeSiteState> emit,
  ) async {
    final access = state.access;
    if (access == null) return;
    await _locationProvider.openSettings(access);
  }

  Future<void> _onProposeRequested(
    _ProposeRequested event,
    Emitter<LocalizeSiteState> emit,
  ) async {
    if (!state.canPropose) return;

    final l10n = LocalizationService.localization;
    emit(
      state.copyWith(
        proposeStatus: GenericStatus.loading,
        proposeErrorMessage: null,
      ),
    );
    try {
      final proposal = await _siteRepository.proposeSite(
        event.projectId,
        state.reading!,
      );
      emit(
        state.copyWith(
          proposeStatus: GenericStatus.success,
          proposal: proposal,
        ),
      );
    } on HttpException400 catch (e) {
      emit(_failure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_failure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_failure(l10n.networkError));
    } catch (e) {
      log('LocalizeSiteBloc._onProposeRequested error: $e');
      emit(_failure(l10n.errorSiteProposal));
    }
  }

  void _onResetFlowStep(_ResetFlowStep event, Emitter<LocalizeSiteState> emit) {
    emit(
      state.copyWith(
        proposeStatus: GenericStatus.initial,
        proposeErrorMessage: null,
      ),
    );
  }

  LocalizeSiteState _failure(String message) => state.copyWith(
    proposeStatus: GenericStatus.failure,
    proposeErrorMessage: message,
  );
}
