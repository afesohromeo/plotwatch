part of 'join_project_bloc.dart';

@freezed
sealed class JoinProjectState with _$JoinProjectState {
  const factory JoinProjectState({
    @Default('') String code,
    InvitationPreview? preview,
    @Default(GenericStatus.initial) GenericStatus previewStatus,
    String? previewErrorMessage,
    @Default(GenericStatus.initial) GenericStatus joinStatus,
    String? joinErrorMessage,

    /// The new membership; the page then opens the project.
    ProjectMember? joined,
  }) = _JoinProjectState;
}
