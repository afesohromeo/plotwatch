part of 'validate_site_bloc.dart';

@freezed
sealed class ValidateSiteState with _$ValidateSiteState {
  const factory ValidateSiteState({
    int? projectId,

    /// The proposal waiting for the owner; null when none is pending.
    SiteProposal? proposal,
    @Default(defaultSiteRadiusM) int radiusM,
    @Default(GenericStatus.initial) GenericStatus loadStatus,
    String? loadErrorMessage,

    /// `updatingItem` = validating, `deletingItem` = rejecting.
    @Default(GenericFlowStep.none) GenericFlowStep flowStep,
    @Default(GenericStatus.initial) GenericStatus actionStatus,
    String? actionErrorMessage,
  }) = _ValidateSiteState;
}
