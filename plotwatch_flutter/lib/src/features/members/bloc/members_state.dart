part of 'members_bloc.dart';

@freezed
sealed class MembersState with _$MembersState {
  const MembersState._();

  const factory MembersState({
    ProjectOverview? overview,
    @Default([]) List<MemberView> members,
    @Default([]) List<Invitation> invitations,

    /// Their actions stay in the history (doc/04e C-2b).
    @Default([]) List<MemberView> formerMembers,
    @Default(GenericStatus.initial) GenericStatus membersStatus,
    String? membersErrorMessage,
    @Default(GenericStatus.initial) GenericStatus actionStatus,
    @Default(GenericFlowStep.none) GenericFlowStep flowStep,
    String? actionErrorMessage,
  }) = _MembersState;

  /// Only the owner invites, removes and sees invitations (doc/02 §3.2; the
  /// server enforces it too).
  bool get isOwner => overview?.myRole == ProjectRole.owner;

  /// A completed or archived project: no invitations or role changes;
  /// removing a member stays possible (doc/04e C-1, C-2).
  bool get isClosed => overview?.project.status.isClosed ?? false;
}
