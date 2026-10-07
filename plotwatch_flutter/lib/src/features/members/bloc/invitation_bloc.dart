import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'invitation_event.dart';
part 'invitation_state.dart';
part 'invitation_bloc.freezed.dart';

/// The invite sheet: role, approval right, the created code and sharing it
/// (MEMB-01; decisions M2-6 to M2-8).
class InvitationBloc extends Bloc<InvitationEvent, InvitationState> {
  InvitationBloc({
    required this._membershipRepository,
    required this._shareProvider,
    this._webAppUrl,
  }) : super(const InvitationState()) {
    on<_RoleChanged>(_onRoleChanged);
    on<_CanApproveChanged>(_onCanApproveChanged);
    on<_CreateSubmitted>(_onCreateSubmitted);
    on<_ShareRequested>(_onShareRequested);
  }

  final MembershipRepository _membershipRepository;
  final ShareProvider _shareProvider;

  /// Defaults to [defaultWebAppUrl]; set in tests.
  final String? _webAppUrl;

  void _onRoleChanged(_RoleChanged event, Emitter<InvitationState> emit) {
    emit(state.copyWith(
      role: event.role,
      // Approval rights only exist for co-funders (doc/02 §3.2).
      canApprove: event.role == ProjectRole.coFunder && state.canApprove,
    ));
  }

  void _onCanApproveChanged(
    _CanApproveChanged event,
    Emitter<InvitationState> emit,
  ) {
    emit(state.copyWith(canApprove: event.canApprove));
  }

  Future<void> _onCreateSubmitted(
    _CreateSubmitted event,
    Emitter<InvitationState> emit,
  ) async {
    final l10n = LocalizationService.localization;
    emit(state.copyWith(
      createStatus: GenericStatus.loading,
      createErrorMessage: null,
    ));
    try {
      final invitation = await _membershipRepository.createInvitation(
        event.projectId,
        state.role,
        canApprove: state.canApprove,
      );
      emit(state.copyWith(
        createStatus: GenericStatus.success,
        invitation: invitation,
      ));
    } on HttpException400 catch (e) {
      emit(_failure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_failure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_failure(l10n.networkError));
    } catch (e) {
      log('InvitationBloc._onCreateSubmitted error: $e');
      emit(_failure(l10n.errorInvitationCreate));
    }
  }

  Future<void> _onShareRequested(
    _ShareRequested event,
    Emitter<InvitationState> emit,
  ) async {
    final invitation = state.invitation;
    if (invitation == null) return;

    final l10n = LocalizationService.localization;
    try {
      await _shareProvider.shareText(l10n.invitationShareText(
        invitationLink(invitation.code, webAppUrl: _webAppUrl),
        formatInvitationCode(invitation.code),
      ));
    } catch (e) {
      // The share sheet is a convenience: the code stays on screen.
      log('InvitationBloc._onShareRequested error: $e');
    }
  }

  InvitationState _failure(String message) => state.copyWith(
        createStatus: GenericStatus.failure,
        createErrorMessage: message,
      );
}
