part of 'localize_site_bloc.dart';

@freezed
sealed class LocalizeSiteState with _$LocalizeSiteState {
  const LocalizeSiteState._();

  const factory LocalizeSiteState({
    /// Decides where saving leads: the owner validates at once (G-12).
    ProjectRole? myRole,
    String? loadErrorMessage,

    /// Null while checking.
    LocationAccess? access,
    GpsReading? reading,
    @Default(GenericStatus.initial) GenericStatus proposeStatus,
    String? proposeErrorMessage,
    SiteProposal? proposal,
  }) = _LocalizeSiteState;

  /// 20 m or better and not mocked, as the server requires (M2-17).
  bool get canPropose {
    final current = reading;
    return access == LocationAccess.granted &&
        current != null &&
        !current.isMocked &&
        current.accuracyM <= maxGpsAccuracyM;
  }
}
