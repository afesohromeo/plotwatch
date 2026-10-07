import 'package:geolocator/geolocator.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The phone's GPS through geolocator (doc/04b G-5, G-8). Behind a class so
/// BLoC tests don't need the platform plugin.
class LocationProvider {
  const LocationProvider();

  /// Asks for permission if needed; never throws.
  Future<LocationAccess> ensureAccess() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return LocationAccess.serviceDisabled;
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return switch (permission) {
      LocationPermission.always ||
      LocationPermission.whileInUse => LocationAccess.granted,
      LocationPermission.deniedForever => LocationAccess.deniedForever,
      LocationPermission.denied ||
      LocationPermission.unableToDetermine => LocationAccess.denied,
    };
  }

  /// Best-accuracy readings, about one per second, while listened to.
  Stream<GpsReading> readings() =>
      Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
          distanceFilter: 0,
        ),
      ).map(
        (position) => GpsReading(
          latitude: position.latitude,
          longitude: position.longitude,
          accuracyM: position.accuracy,
          isMocked: position.isMocked,
        ),
      );

  /// The app's settings when permission was refused for good, else the
  /// system location settings (GPS off).
  Future<void> openSettings(LocationAccess access) async {
    if (access == LocationAccess.deniedForever) {
      await Geolocator.openAppSettings();
    } else {
      await Geolocator.openLocationSettings();
    }
  }
}
