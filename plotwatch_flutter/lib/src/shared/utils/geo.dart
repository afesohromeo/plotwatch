import 'dart:math' as math;

/// Great-circle distance in metres between two WGS84 points (haversine), as
/// the server's `GeoService.distanceM` computes it.
double distanceMeters(double lat1, double lng1, double lat2, double lng2) {
  const earthRadiusM = 6371000.0;
  double radians(double degrees) => degrees * math.pi / 180;
  final dLat = radians(lat2 - lat1);
  final dLng = radians(lng2 - lng1);
  final a =
      math.pow(math.sin(dLat / 2), 2) +
      math.cos(radians(lat1)) *
          math.cos(radians(lat2)) *
          math.pow(math.sin(dLng / 2), 2);
  return 2 * earthRadiusM * math.asin(math.min(1, math.sqrt(a)));
}
