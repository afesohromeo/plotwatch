part of 'members_bloc.dart';

@freezed
sealed class MembersEvent with _$MembersEvent {
  /// Loads the project (for the caller's role), its members and, for the
  /// owner, the pending invitations.
  const factory MembersEvent.fetchMembers({required int projectId}) =
      _FetchMembers;

  const factory MembersEvent.removeMember({required int memberId}) =
      _RemoveMember;

  /// The owner gives a member another role (doc/04b H-4).
  const factory MembersEvent.changeRole({
    required int memberId,
    required ProjectRole role,
  }) = _ChangeRole;

  const factory MembersEvent.cancelInvitation({required int invitationId}) =
      _CancelInvitation;

  /// The invite sheet created [invitation]; show it without reloading.
  const factory MembersEvent.invitationCreated({
    required Invitation invitation,
  }) = _InvitationCreated;

  const factory MembersEvent.resetFlowStep() = _ResetFlowStep;
}
