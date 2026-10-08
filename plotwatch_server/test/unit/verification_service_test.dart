import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:plotwatch_server/src/services/verification_service.dart';
import 'package:test/test.dart';

// Plan: doc/04d-m4-capture.md, decisions M4-6 and M4-7: checks V1–V8 of
// doc/02 §8.2 with the thresholds of §8.4, each at its limit, and the level
// rule of VER-02. Details carry numbers only.
void main() {
  // A site in Bafoussam with a 50 m radius.
  const siteLat = 5.4778;
  const siteLng = 10.4176;
  const radiusM = 50;
  // About 0.000899° of latitude per 100 m.
  const degreesPer100M = 0.000899;

  VerificationCheck inside({
    double? lat = siteLat,
    double? lng = siteLng,
    double? accuracyM = 8,
  }) => VerificationService.insideSite(
    lat: lat,
    lng: lng,
    accuracyM: accuracyM,
    siteLat: siteLat,
    siteLng: siteLng,
    radiusM: radiusM,
  );

  group('Given V1 in-app capture (critical)', () {
    test('when the app attests it then it passes', () {
      final check = VerificationService.inAppCapture(true);
      expect(check.name, VerificationCheckName.inAppCapture);
      expect(check.passed, isTrue);
      expect(check.critical, isTrue);
    });
    test('when it does not then it fails', () {
      expect(VerificationService.inAppCapture(false).passed, isFalse);
    });
  });

  group('Given V2 location present (critical)', () {
    test('when there is a fix then it passes', () {
      expect(
        VerificationService.locationPresent(lat: siteLat, lng: siteLng).passed,
        isTrue,
      );
    });
    test('when the fix is missing then it fails', () {
      expect(
        VerificationService.locationPresent(lat: null, lng: siteLng).passed,
        isFalse,
      );
      expect(
        VerificationService.locationPresent(lat: null, lng: null).passed,
        isFalse,
      );
    });
  });

  group('Given V3 location accuracy (non-critical)', () {
    test('when it is 30 m then it passes, and says so', () {
      final check = VerificationService.locationAccuracy(30);
      expect(check.passed, isTrue);
      expect(check.critical, isFalse);
      expect(check.details?['accuracyM'], '30');
      expect(check.details?['allowedM'], '30');
    });
    test('when it is 30.1 m then it fails', () {
      expect(VerificationService.locationAccuracy(30.1).passed, isFalse);
    });
    test('when it is unknown then it fails', () {
      expect(VerificationService.locationAccuracy(null).passed, isFalse);
    });
  });

  group('Given V4 inside the site (critical)', () {
    test('when the photo is at the centre then it passes', () {
      final check = inside();
      expect(check.passed, isTrue);
      expect(check.critical, isTrue);
      expect(check.details?['distanceM'], '0');
      // 50 m radius + 8 m accuracy.
      expect(check.details?['allowedM'], '58');
    });

    test('when it is 55 m away with 8 m accuracy then the accuracy buffer '
        'keeps it inside', () {
      expect(inside(lat: siteLat + degreesPer100M * .55).passed, isTrue);
    });

    test('when it is 100 m away then it fails, with the distance and the '
        'allowed distance', () {
      final check = inside(lat: siteLat + degreesPer100M);
      expect(check.passed, isFalse);
      expect(int.parse(check.details!['distanceM']!), closeTo(100, 1));
      expect(check.details?['allowedM'], '58');
    });

    test('when the accuracy is 200 m then the buffer is capped at 30 m', () {
      final check = inside(lat: siteLat + degreesPer100M * .85, accuracyM: 200);
      expect(check.details?['allowedM'], '80');
      expect(check.passed, isFalse);
    });

    test('when there is no fix then it fails without a distance', () {
      final check = inside(lat: null, lng: null);
      expect(check.passed, isFalse);
      expect(check.details?['distanceM'], isNull);
    });
  });

  group('Given V5 not a mock location (critical)', () {
    test('when Android says it is mocked then it fails', () {
      expect(VerificationService.notMockLocation(true).passed, isFalse);
    });
    test(
      'when it is not mocked, or the platform cannot tell, then it passes',
      () {
        expect(VerificationService.notMockLocation(false).passed, isTrue);
        expect(VerificationService.notMockLocation(null).passed, isTrue);
      },
    );
  });

  group('Given V6 hash match (critical)', () {
    final hash = 'a' * 64;
    test('when the stored file has the committed hash then it passes', () {
      expect(VerificationService.hashMatch(hash, hash).passed, isTrue);
    });
    test('when only the letter case differs then it still passes', () {
      expect(
        VerificationService.hashMatch(hash.toUpperCase(), hash).passed,
        isTrue,
      );
    });
    test('when the stored file is different then it fails', () {
      final check = VerificationService.hashMatch(hash, 'b' * 64);
      expect(check.passed, isFalse);
      expect(check.critical, isTrue);
    });
  });

  group('Given V7 clock consistency (non-critical)', () {
    final server = DateTime.utc(2026, 10, 9, 12);
    test('when the device clock is 10 min off then it passes', () {
      final check = VerificationService.clockConsistency(
        server.subtract(const Duration(minutes: 10)),
        server,
      );
      expect(check.passed, isTrue);
      expect(check.critical, isFalse);
      expect(check.details?['skewSeconds'], '600');
    });
    test('when it is 10 min 1 s behind or ahead then it fails', () {
      const skew = Duration(minutes: 10, seconds: 1);
      expect(
        VerificationService.clockConsistency(
          server.subtract(skew),
          server,
        ).passed,
        isFalse,
      );
      expect(
        VerificationService.clockConsistency(server.add(skew), server).passed,
        isFalse,
      );
    });
  });

  group('Given V8 prompt commit (non-critical)', () {
    final server = DateTime.utc(2026, 10, 9, 12);
    test(
      'when the photo was sent 15 min after it was taken then it passes',
      () {
        final check = VerificationService.promptCommit(
          server.subtract(const Duration(minutes: 15)),
          server,
        );
        expect(check.passed, isTrue);
        expect(check.details?['delaySeconds'], '900');
      },
    );
    test('when it was sent 15 min 1 s later then it fails', () {
      expect(
        VerificationService.promptCommit(
          server.subtract(const Duration(minutes: 15, seconds: 1)),
          server,
        ).passed,
        isFalse,
      );
    });
  });

  group('Given the level rule (VER-02)', () {
    VerificationCheck check(bool passed, {required bool critical}) =>
        VerificationCheck(
          name: VerificationCheckName.locationAccuracy,
          passed: passed,
          critical: critical,
        );

    test('when every check passes then it is verified', () {
      expect(
        VerificationService.level([
          check(true, critical: true),
          check(true, critical: false),
        ]),
        VerificationLevel.verified,
      );
    });
    test(
      'when only non-critical checks fail then it is partially verified',
      () {
        expect(
          VerificationService.level([
            check(true, critical: true),
            check(false, critical: false),
          ]),
          VerificationLevel.partiallyVerified,
        );
      },
    );
    test('when a critical check fails then it is unverified', () {
      expect(
        VerificationService.level([
          check(false, critical: true),
          check(true, critical: false),
        ]),
        VerificationLevel.unverified,
      );
    });
  });
}
