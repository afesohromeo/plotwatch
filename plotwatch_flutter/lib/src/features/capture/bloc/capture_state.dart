part of 'capture_bloc.dart';

/// Where the capture screen is (doc/04d, group C).
enum CaptureStep { camera, review, sending, done }

/// The sending step in progress, or the one that failed.
enum SendStep { committing, uploading, checking }

@freezed
sealed class CaptureState with _$CaptureState {
  const CaptureState._();

  const factory CaptureState({
    int? projectId,
    int? stageId,
    int? itemId,
    String? itemLabel,

    /// The validated site, for the inside-site indicator.
    Site? site,
    DeviceDetails? device,
    @Default(GenericStatus.initial) GenericStatus loadStatus,
    String? loadErrorMessage,

    /// Null while checking.
    CameraAccess? cameraAccess,
    LocationAccess? locationAccess,

    /// The latest GPS reading; null without a fix.
    GpsReading? reading,
    @Default(CaptureStep.camera) CaptureStep step,

    /// The photo exactly as the camera wrote it (decision M4-2).
    Uint8List? photo,
    DateTime? takenAt,

    /// The position when the shutter was pressed.
    GpsReading? shotReading,
    String? caption,
    @Default(SendStep.committing) SendStep sendStep,
    @Default(GenericStatus.initial) GenericStatus sendStatus,
    String? sendErrorMessage,

    /// Kept so a retry doesn't commit twice.
    EvidenceCommitResult? committed,
    @Default(false) bool uploaded,

    /// An upload failed once: the next one gets a new description.
    @Default(false) bool uploadFailed,

    /// The capture as the server checked it.
    Evidence? evidence,
  }) = _CaptureState;

  bool get canShoot =>
      loadStatus == GenericStatus.success &&
      cameraAccess == CameraAccess.ready &&
      step == CaptureStep.camera;

  double? get distanceFromSiteM {
    final current = reading;
    final site = this.site;
    return current == null || site == null ? null : _distance(current, site);
  }

  /// What the server's inside-site check (V4) will probably say; null while
  /// there is no fix. It informs, the server decides.
  bool? get isInsideSite {
    final current = reading;
    final site = this.site;
    if (current == null || site == null) return null;
    return _distance(current, site) <= _allowed(current, site);
  }
}
