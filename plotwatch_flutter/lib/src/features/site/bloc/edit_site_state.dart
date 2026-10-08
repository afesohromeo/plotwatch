part of 'edit_site_bloc.dart';

@freezed
sealed class EditSiteState with _$EditSiteState {
  const factory EditSiteState({
    int? projectId,

    /// The validated site; null until loaded.
    Site? site,
    @Default(defaultSiteRadiusM) int radiusM,
    @Default(GenericStatus.initial) GenericStatus loadStatus,
    String? loadErrorMessage,
    @Default(GenericStatus.initial) GenericStatus actionStatus,
    String? actionErrorMessage,
  }) = _EditSiteState;
}
