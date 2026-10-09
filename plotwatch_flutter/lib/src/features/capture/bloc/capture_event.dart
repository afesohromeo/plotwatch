part of 'capture_bloc.dart';

@freezed
sealed class CaptureEvent with _$CaptureEvent {
  /// Opens the screen for one checklist item.
  const factory CaptureEvent.started({
    required int projectId,
    required int stageId,
    required int itemId,
  }) = _Started;

  /// The camera was refused: open the app's settings.
  const factory CaptureEvent.cameraSettingsRequested() =
      _CameraSettingsRequested;

  const factory CaptureEvent.shutterPressed() = _ShutterPressed;

  const factory CaptureEvent.retakeRequested() = _RetakeRequested;

  /// Sends the reviewed photo with an optional caption (CAP-06).
  const factory CaptureEvent.sendRequested({String? caption}) = _SendRequested;

  /// Repeats the sending step that failed.
  const factory CaptureEvent.retryRequested() = _RetryRequested;
}
