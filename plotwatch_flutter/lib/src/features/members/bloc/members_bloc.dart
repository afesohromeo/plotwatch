import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

part 'members_event.dart';
part 'members_state.dart';
part 'members_bloc.freezed.dart';

/// A project's members and, for the owner, its pending invitations
/// (MEMB-04, MEMB-05).
class MembersBloc extends Bloc<MembersEvent, MembersState> {
  MembersBloc({
    required this._projectRepository,
    required this._membershipRepository,
  }) : super(const MembersState()) {
    on<_FetchMembers>(_onFetchMembers);
    on<_RemoveMember>(_onRemoveMember);
    on<_ChangeRole>(_onChangeRole);
    on<_CancelInvitation>(_onCancelInvitation);
    on<_InvitationCreated>(_onInvitationCreated);
    on<_ResetFlowStep>(_onResetFlowStep);
  }

  final ProjectRepository _projectRepository;
  final MembershipRepository _membershipRepository;

  Future<void> _onFetchMembers(
    _FetchMembers event,
    Emitter<MembersState> emit,
  ) async {
    final l10n = LocalizationService.localization;
    emit(
      state.copyWith(
        membersStatus: GenericStatus.loading,
        membersErrorMessage: null,
      ),
    );
    try {
      final overview = await _projectRepository.fetchProject(event.projectId);
      final members = await _membershipRepository.fetchMembers(event.projectId);
      final invitations = overview.myRole == ProjectRole.owner
          ? await _membershipRepository.fetchInvitations(event.projectId)
          : <Invitation>[];
      emit(
        state.copyWith(
          membersStatus: GenericStatus.success,
          overview: overview,
          members: members,
          invitations: invitations,
        ),
      );
    } on HttpException400 catch (e) {
      emit(_loadFailure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_loadFailure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_loadFailure(l10n.networkError));
    } catch (e) {
      log('MembersBloc._onFetchMembers error: $e');
      emit(_loadFailure(l10n.errorMembersLoad));
    }
  }

  Future<void> _onRemoveMember(
    _RemoveMember event,
    Emitter<MembersState> emit,
  ) => _runAction(emit, 'MembersBloc._onRemoveMember', (projectId) async {
    await _membershipRepository.removeMember(projectId, event.memberId);
    return state.copyWith(
      members: [
        for (final view in state.members)
          if (view.member.id != event.memberId) view,
      ],
    );
  });

  Future<void> _onChangeRole(_ChangeRole event, Emitter<MembersState> emit) =>
      _runAction(emit, 'MembersBloc._onChangeRole', (projectId) async {
        final changed = await _membershipRepository.changeRole(
          projectId,
          event.memberId,
          event.role,
        );
        return state.copyWith(
          members: [
            for (final view in state.members)
              view.member.id == event.memberId
                  ? view.copyWith(member: changed)
                  : view,
          ],
        );
      }, flowStep: GenericFlowStep.updatingItem);

  Future<void> _onCancelInvitation(
    _CancelInvitation event,
    Emitter<MembersState> emit,
  ) => _runAction(emit, 'MembersBloc._onCancelInvitation', (projectId) async {
    await _membershipRepository.cancelInvitation(projectId, event.invitationId);
    return state.copyWith(
      invitations: [
        for (final invitation in state.invitations)
          if (invitation.id != event.invitationId) invitation,
      ],
    );
  });

  void _onInvitationCreated(
    _InvitationCreated event,
    Emitter<MembersState> emit,
  ) {
    emit(state.copyWith(invitations: [event.invitation, ...state.invitations]));
  }

  /// An owner action on the loaded project; [action] returns the new lists.
  Future<void> _runAction(
    Emitter<MembersState> emit,
    String logTag,
    Future<MembersState> Function(int projectId) action, {
    GenericFlowStep flowStep = GenericFlowStep.deletingItem,
  }) async {
    final projectId = state.overview?.project.id;
    if (projectId == null) return;

    final l10n = LocalizationService.localization;
    emit(
      state.copyWith(
        flowStep: flowStep,
        actionStatus: GenericStatus.loading,
        actionErrorMessage: null,
      ),
    );
    try {
      final updated = await action(projectId);
      emit(updated.copyWith(actionStatus: GenericStatus.success));
    } on HttpException400 catch (e) {
      emit(_actionFailure(e.code.message(l10n)));
    } on HttpException401 catch (_) {
      emit(_actionFailure(l10n.errorUnauthorized));
    } on NetworkException catch (_) {
      emit(_actionFailure(l10n.networkError));
    } catch (e) {
      log('$logTag error: $e');
      emit(_actionFailure(l10n.errorMembersSave));
    }
  }

  void _onResetFlowStep(_ResetFlowStep event, Emitter<MembersState> emit) {
    emit(
      state.copyWith(
        flowStep: GenericFlowStep.none,
        actionStatus: GenericStatus.initial,
        actionErrorMessage: null,
      ),
    );
  }

  MembersState _loadFailure(String message) => state.copyWith(
    membersStatus: GenericStatus.failure,
    membersErrorMessage: message,
  );

  MembersState _actionFailure(String message) => state.copyWith(
    actionStatus: GenericStatus.failure,
    actionErrorMessage: message,
  );
}
