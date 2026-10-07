part of 'invitation_bloc.dart';

@freezed
sealed class InvitationEvent with _$InvitationEvent {
  const factory InvitationEvent.roleChanged({required ProjectRole role}) =
      _RoleChanged;

  /// Approval rights for a co-funder (decision M2-7).
  const factory InvitationEvent.canApproveChanged({required bool canApprove}) =
      _CanApproveChanged;

  const factory InvitationEvent.createSubmitted({required int projectId}) =
      _CreateSubmitted;

  /// Copies the link (doc/04b F3-2).
  const factory InvitationEvent.linkCopyRequested() = _LinkCopyRequested;

  /// Opens the share sheet with the link and the code.
  const factory InvitationEvent.shareRequested() = _ShareRequested;
}
