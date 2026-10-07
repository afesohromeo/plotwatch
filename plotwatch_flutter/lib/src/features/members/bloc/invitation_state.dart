part of 'invitation_bloc.dart';

@freezed
sealed class InvitationState with _$InvitationState {
  const factory InvitationState({
    @Default(ProjectRole.siteManager) ProjectRole role,
    @Default(false) bool canApprove,
    @Default(GenericStatus.initial) GenericStatus createStatus,
    String? createErrorMessage,

    /// The created invitation; the sheet then shows its code and link.
    Invitation? invitation,
  }) = _InvitationState;
}
