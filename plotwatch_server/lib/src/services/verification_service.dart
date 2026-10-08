import 'dart:math' as math;

import '../generated/protocol.dart';
import 'geo_service.dart';

/// Checks V1–V8 of doc/02 §8.2 as pure functions, and the level rule of
/// VER-02 (doc/04d M4-6). Details carry numbers only; the app writes the
/// sentences (M4-7). Verification proves where and when a photo was taken,
/// not the quality of the work (VER-10).
abstract final class VerificationService {
  /// Thresholds of doc/02 §8.4.
  static const maxAccuracyM = 30.0;
  static const maxAccuracyBufferM = 30.0;
  static const maxClockSkew = Duration(minutes: 10);
  static const maxCommitDelay = Duration(minutes: 15);

  /// V1 (critical): the photo came through the in-app camera. The app
  /// attests it; the web has no camera flow.
  static VerificationCheck inAppCapture(bool capturedInApp) =>
      _check(VerificationCheckName.inAppCapture, capturedInApp, critical: true);

  /// V2 (critical): a GPS fix was recorded.
  static VerificationCheck locationPresent({
    required double? lat,
    required double? lng,
  }) => _check(
    VerificationCheckName.locationPresent,
    lat != null && lng != null,
    critical: true,
  );

  /// V3 (non-critical): the fix is accurate to [maxAccuracyM] or better.
  static VerificationCheck locationAccuracy(double? accuracyM) => _check(
    VerificationCheckName.locationAccuracy,
    accuracyM != null && accuracyM <= maxAccuracyM,
    critical: false,
    details: {
      'accuracyM': ?accuracyM?.round().toString(),
      'allowedM': maxAccuracyM.round().toString(),
    },
  );

  /// V4 (critical): the photo was taken within the site radius, plus the
  /// fix's accuracy capped at [maxAccuracyBufferM].
  static VerificationCheck insideSite({
    required double? lat,
    required double? lng,
    required double? accuracyM,
    required double siteLat,
    required double siteLng,
    required int radiusM,
  }) {
    final allowedM =
        radiusM + math.min(accuracyM ?? 0, maxAccuracyBufferM).toDouble();
    final distanceM = distanceFromSite(
      lat: lat,
      lng: lng,
      siteLat: siteLat,
      siteLng: siteLng,
    );
    return _check(
      VerificationCheckName.insideSite,
      distanceM != null && distanceM <= allowedM,
      critical: true,
      details: {
        'distanceM': ?distanceM?.round().toString(),
        'allowedM': allowedM.round().toString(),
      },
    );
  }

  /// Distance in metres from the site centre, or null without a fix.
  static double? distanceFromSite({
    required double? lat,
    required double? lng,
    required double siteLat,
    required double siteLng,
  }) => lat == null || lng == null
      ? null
      : GeoService.distanceM(lat, lng, siteLat, siteLng);

  /// V5 (critical): Android doesn't report the position as mocked. Other
  /// platforms can't tell (null) and pass.
  static VerificationCheck notMockLocation(bool? isMock) => _check(
    VerificationCheckName.notMockLocation,
    isMock != true,
    critical: true,
  );

  /// V6 (critical): the stored file has the committed hash (VER-04).
  static VerificationCheck hashMatch(String committed, String stored) => _check(
    VerificationCheckName.hashMatch,
    committed.toLowerCase() == stored.toLowerCase(),
    critical: true,
  );

  /// V7 (non-critical): the phone's clock is within [maxClockSkew] of the
  /// server's at commit.
  static VerificationCheck clockConsistency(
    DateTime deviceCapturedAt,
    DateTime serverCommittedAt,
  ) {
    final skew = deviceCapturedAt.difference(serverCommittedAt).abs();
    return _check(
      VerificationCheckName.clockConsistency,
      skew <= maxClockSkew,
      critical: false,
      details: {
        'skewSeconds': '${skew.inSeconds}',
        'allowedSeconds': '${maxClockSkew.inSeconds}',
      },
    );
  }

  /// V8 (non-critical): the photo was sent within [maxCommitDelay] of being
  /// taken.
  static VerificationCheck promptCommit(
    DateTime deviceCapturedAt,
    DateTime serverCommittedAt,
  ) {
    final delay = serverCommittedAt.difference(deviceCapturedAt);
    return _check(
      VerificationCheckName.promptCommit,
      delay <= maxCommitDelay,
      critical: false,
      details: {
        'delaySeconds': '${delay.inSeconds}',
        'allowedSeconds': '${maxCommitDelay.inSeconds}',
      },
    );
  }

  /// All checks for a committed capture whose stored file hashes to
  /// [storedHash], against [site].
  static List<VerificationCheck> runAll(
    Evidence evidence, {
    required String storedHash,
    required Site site,
  }) => [
    inAppCapture(evidence.capturedInApp),
    locationPresent(lat: evidence.lat, lng: evidence.lng),
    locationAccuracy(evidence.accuracyM),
    insideSite(
      lat: evidence.lat,
      lng: evidence.lng,
      accuracyM: evidence.accuracyM,
      siteLat: site.centerLat,
      siteLng: site.centerLng,
      radiusM: site.radiusM,
    ),
    notMockLocation(evidence.isMockLocation),
    hashMatch(evidence.sha256, storedHash),
    clockConsistency(evidence.deviceCapturedAt, evidence.serverCommittedAt),
    promptCommit(evidence.deviceCapturedAt, evidence.serverCommittedAt),
  ];

  /// VER-02: verified if every check passed, partially verified if only
  /// non-critical ones failed, unverified if a critical one failed.
  static VerificationLevel level(List<VerificationCheck> checks) {
    if (checks.any((c) => c.critical && !c.passed)) {
      return VerificationLevel.unverified;
    }
    if (checks.any((c) => !c.passed)) {
      return VerificationLevel.partiallyVerified;
    }
    return VerificationLevel.verified;
  }

  static VerificationCheck _check(
    VerificationCheckName name,
    bool passed, {
    required bool critical,
    Map<String, String>? details,
  }) => VerificationCheck(
    name: name,
    passed: passed,
    critical: critical,
    details: details,
  );
}
