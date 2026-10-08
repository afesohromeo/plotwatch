part of 'edit_site_bloc.dart';

@freezed
sealed class EditSiteEvent with _$EditSiteEvent {
  /// Loads the validated site, whose radius is the starting point.
  const factory EditSiteEvent.load({required int projectId}) = _Load;

  /// Kept within 10–500 m (SITE-03).
  const factory EditSiteEvent.radiusChanged({required int radiusM}) =
      _RadiusChanged;

  /// Saves the radius and [addressText]; none removes the address.
  const factory EditSiteEvent.saveRequested({String? addressText}) =
      _SaveRequested;
}
