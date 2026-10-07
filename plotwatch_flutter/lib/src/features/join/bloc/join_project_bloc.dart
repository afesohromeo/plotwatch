import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'join_project_event.dart';
part 'join_project_state.dart';
part 'join_project_bloc.freezed.dart';

/// Joining a project with an invitation code: check it, see what it joins,
/// then join (MEMB-03, AC-2).
class JoinProjectBloc extends Bloc<JoinProjectEvent, JoinProjectState> {
  JoinProjectBloc({required this._membershipRepository})
      : super(const JoinProjectState()) {
    on<_PreviewRequested>(_onPreviewRequested);
    on<_JoinRequested>(_onJoinRequested);
    on<_ResetFlowStep>(_onResetFlowStep);
  }

  final MembershipRepository _membershipRepository;

  Future<void> _onPreviewRequested(
    _PreviewRequested event,
    Emitter<JoinProjectState> emit,
  ) async {
    final l10n = LocalizationService.localization;
    emit(JoinProjectState(code: event.code, previewStatus: GenericStatus.loading));
    try {
      final preview = await _membershipRepository.previewInvitation(event.code);
      emit(state.copyWith(
        previewStatus: GenericStatus.success,
        preview: preview,
      ));
    } on HttpException400 catch (e) {
      emit(_previewFailure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_previewFailure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_previewFailure(l10n.networkError));
    } catch (e) {
      log('JoinProjectBloc._onPreviewRequested error: $e');
      emit(_previewFailure(l10n.errorJoinProject));
    }
  }

  Future<void> _onJoinRequested(
    _JoinRequested event,
    Emitter<JoinProjectState> emit,
  ) async {
    if (state.preview == null) return;

    final l10n = LocalizationService.localization;
    emit(state.copyWith(
      joinStatus: GenericStatus.loading,
      joinErrorMessage: null,
    ));
    try {
      final joined = await _membershipRepository.acceptInvitation(state.code);
      emit(state.copyWith(joinStatus: GenericStatus.success, joined: joined));
    } on HttpException400 catch (e) {
      emit(_joinFailure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_joinFailure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_joinFailure(l10n.networkError));
    } catch (e) {
      log('JoinProjectBloc._onJoinRequested error: $e');
      emit(_joinFailure(l10n.errorJoinProject));
    }
  }

  void _onResetFlowStep(
    _ResetFlowStep event,
    Emitter<JoinProjectState> emit,
  ) {
    emit(state.copyWith(
      joinStatus: GenericStatus.initial,
      joinErrorMessage: null,
    ));
  }

  JoinProjectState _previewFailure(String message) => state.copyWith(
        previewStatus: GenericStatus.failure,
        previewErrorMessage: message,
      );

  JoinProjectState _joinFailure(String message) => state.copyWith(
        joinStatus: GenericStatus.failure,
        joinErrorMessage: message,
      );
}
