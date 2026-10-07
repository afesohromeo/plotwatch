part of 'validate_site_bloc.dart';

@freezed
sealed class ValidateSiteEvent with _$ValidateSiteEvent {
  /// Loads the pending proposal and the current site (for its radius).
  const factory ValidateSiteEvent.load({required int projectId}) = _Load;

  /// Kept within 10–500 m (SITE-03).
  const factory ValidateSiteEvent.radiusChanged({required int radiusM}) =
      _RadiusChanged;

  const factory ValidateSiteEvent.validateRequested({String? addressText}) =
      _ValidateRequested;

  const factory ValidateSiteEvent.rejectRequested({String? reason}) =
      _RejectRequested;

  const factory ValidateSiteEvent.resetFlowStep() = _ResetFlowStep;
}
