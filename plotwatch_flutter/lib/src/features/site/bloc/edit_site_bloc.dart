import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'edit_site_event.dart';
part 'edit_site_state.dart';
part 'edit_site_bloc.freezed.dart';

/// The owner changes the radius and the address of the validated site,
/// without a new GPS reading (doc/04b H-3).
class EditSiteBloc extends Bloc<EditSiteEvent, EditSiteState> {
  EditSiteBloc({required this._siteRepository}) : super(const EditSiteState()) {
    on<_Load>(_onLoad);
    on<_RadiusChanged>(_onRadiusChanged);
    on<_SaveRequested>(_onSaveRequested);
  }

  final SiteRepository _siteRepository;

  Future<void> _onLoad(_Load event, Emitter<EditSiteState> emit) async {
    final l10n = LocalizationService.localization;
    emit(
      EditSiteState(
        projectId: event.projectId,
        loadStatus: GenericStatus.loading,
      ),
    );
    try {
      final site = await _siteRepository.fetchSite(event.projectId);
      if (site == null) {
        emit(_loadFailure(l10n.errorSiteNotFound));
        return;
      }
      emit(
        state.copyWith(
          loadStatus: GenericStatus.success,
          site: site,
          radiusM: site.radiusM,
        ),
      );
    } on HttpException400 catch (e) {
      emit(_loadFailure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_loadFailure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_loadFailure(l10n.networkError));
    } catch (e) {
      log('EditSiteBloc._onLoad error: $e');
      emit(_loadFailure(l10n.errorSiteLoad));
    }
  }

  void _onRadiusChanged(_RadiusChanged event, Emitter<EditSiteState> emit) {
    emit(
      state.copyWith(
        radiusM: event.radiusM.clamp(minSiteRadiusM, maxSiteRadiusM),
      ),
    );
  }

  Future<void> _onSaveRequested(
    _SaveRequested event,
    Emitter<EditSiteState> emit,
  ) async {
    final projectId = state.projectId;
    if (projectId == null || state.site == null) return;

    final l10n = LocalizationService.localization;
    emit(
      state.copyWith(
        actionStatus: GenericStatus.loading,
        actionErrorMessage: null,
      ),
    );
    try {
      final site = await _siteRepository.updateSite(
        projectId,
        radiusM: state.radiusM,
        addressText: event.addressText,
      );
      emit(state.copyWith(actionStatus: GenericStatus.success, site: site));
    } on HttpException400 catch (e) {
      emit(_actionFailure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_actionFailure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_actionFailure(l10n.networkError));
    } catch (e) {
      log('EditSiteBloc._onSaveRequested error: $e');
      emit(_actionFailure(l10n.errorSiteSave));
    }
  }

  EditSiteState _loadFailure(String message) => state.copyWith(
    loadStatus: GenericStatus.failure,
    loadErrorMessage: message,
  );

  EditSiteState _actionFailure(String message) => state.copyWith(
    actionStatus: GenericStatus.failure,
    actionErrorMessage: message,
  );
}
