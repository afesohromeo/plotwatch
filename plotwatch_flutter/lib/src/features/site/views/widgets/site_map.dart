import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Satellite map of a proposed site: the point and the circle the captures
/// will be checked against (doc/04b G-6). The zoom follows the radius.
class SiteMap extends StatelessWidget {
  const SiteMap({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.radiusM,
  });

  final double latitude;
  final double longitude;
  final int radiusM;

  /// About 18 for 50 m, 15 for 500 m: the circle fills the map.
  static double zoomFor(int radiusM) =>
      18 - math.log(radiusM / defaultSiteRadiusM) / math.ln2;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final centre = LatLng(latitude, longitude);

    return FutureBuilder<void>(
      future: ensureMapsLoaded(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(l10n.mapUnavailable));
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: centre,
            zoom: zoomFor(radiusM),
          ),
          mapType: MapType.hybrid,
          myLocationButtonEnabled: false,
          markers: {Marker(markerId: const MarkerId('site'), position: centre)},
          circles: {
            Circle(
              circleId: const CircleId('radius'),
              center: centre,
              radius: radiusM.toDouble(),
              strokeWidth: 2,
              strokeColor: customColors.primary,
              fillColor: customColors.primary.withValues(alpha: .18),
            ),
          },
        );
      },
    );
  }
}
