import 'dart:math';

import 'package:open_location_code/open_location_code.dart';

/// Distance and Plus Code maths for sites and captures (doc/02 §6.3.2).
/// Pure functions: no database, no session.
class GeoService {
  const GeoService._();

  /// Mean Earth radius used by the haversine formula.
  static const earthRadiusM = 6371000.0;

  /// Great-circle distance in metres between two WGS84 points (haversine).
  static double distanceM(double lat1, double lng1, double lat2, double lng2) {
    double radians(double degrees) => degrees * pi / 180;

    final dLat = radians(lat2 - lat1);
    final dLng = radians(lng2 - lng1);
    final a =
        pow(sin(dLat / 2), 2) +
        cos(radians(lat1)) * cos(radians(lat2)) * pow(sin(dLng / 2), 2);
    return 2 * earthRadiusM * asin(min(1, sqrt(a)));
  }

  /// The 10-digit Plus Code (about 14 × 14 m) of a point.
  static String plusCodeFor(double lat, double lng) =>
      PlusCode.encode(LatLng(lat, lng)).toString();
}
