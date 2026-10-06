import 'package:open_location_code/open_location_code.dart';
import 'package:plotwatch_server/src/services/geo_service.dart';
import 'package:test/test.dart';

// Plan: doc/04b-m2-projects-site-members.md, group A.
void main() {
  // One degree of arc on a sphere of radius 6,371,000 m.
  const oneDegreeM = 111194.93;
  // 50 m (the default site radius) expressed in degrees of latitude.
  const fiftyMetresInDegrees = 50 / oneDegreeM;

  group('Given two points', () {
    test('when they are the same then the distance is 0 m', () {
      expect(GeoService.distanceM(3.848, 11.502, 3.848, 11.502), 0);
    });

    test(
      'when they are one degree apart on a meridian then it is ~111.2 km',
      () {
        expect(GeoService.distanceM(0, 0, 1, 0), closeTo(oneDegreeM, 1));
      },
    );

    test(
      'when they are one degree apart on the equator then it is ~111.2 km',
      () {
        expect(GeoService.distanceM(0, 0, 0, 1), closeTo(oneDegreeM, 1));
      },
    );

    test('when one is 50 m north of the other then it is 50 m', () {
      expect(
        GeoService.distanceM(
          3.848,
          11.502,
          3.848 + fiftyMetresInDegrees,
          11.502,
        ),
        closeTo(50, 0.01),
      );
    });

    test('when they straddle the antimeridian then the short way is used', () {
      expect(GeoService.distanceM(0, 179.5, 0, -179.5), closeTo(oneDegreeM, 1));
    });
  });

  group('Given a site centre', () {
    test('when its Plus Code is computed then it is the 10-digit code', () {
      // Example from the Open Location Code documentation (Nairobi).
      final centre = PlusCode('6GCRPR6C+24').decode().center;

      expect(
        GeoService.plusCodeFor(centre.latitude, centre.longitude),
        '6GCRPR6C+24',
      );
    });
  });
}
