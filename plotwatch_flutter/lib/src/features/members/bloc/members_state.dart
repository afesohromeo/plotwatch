part of 'members_bloc.dart';

@freezed
sealed class MembersState with _$MembersState {
  const MembersState._();

  const factory MembersState({
    ProjectOverview? overview,
    @Default([]) List<MemberView> members,
    @Default([]) List<Invitation> invitations,
    @Default(GenericStatus.initial) GenericStatus membersStatus,
    String? membersErrorMessage,
    @Default(GenericStatus.initial) GenericStatus actionStatus,
    @Default(GenericFlowStep.none) GenericFlowStep flowStep,
    String? actionErrorMessage,
  }) = _MembersState;

  /// Only the owner invites, removes and sees invitations (doc/02 §3.2; the
  /// server enforces it too).
  bool get isOwner => overview?.myRole == ProjectRole.owner;
}
