import 'package:freezed_annotation/freezed_annotation.dart';

part 'gps_reading.freezed.dart';

/// One position from the phone's GPS while localizing the site (doc/04b G-5).
@freezed
abstract class GpsReading with _$GpsReading {
  const factory GpsReading({
    required double latitude,
    required double longitude,

    /// Radius of the 68 % confidence circle, in metres.
    required double accuracyM,

    /// Android reports positions from location-faking apps.
    required bool isMocked,
  }) = _GpsReading;
}

/// Whether the app may read the position (doc/04b G-5).
enum LocationAccess { granted, denied, deniedForever, serviceDisabled }
