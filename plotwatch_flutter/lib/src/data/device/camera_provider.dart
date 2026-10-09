import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

/// Whether the camera can be used (doc/04d, group C).
enum CameraAccess { ready, denied, unavailable }

/// The phone's back camera through the `camera` package (CAP-01: the only
/// way to take a photo; there is no gallery anywhere). Behind a class so
/// BLoC and widget tests don't need the plugin.
class CameraProvider {
  CameraProvider();

  CameraController? _controller;

  /// Asks for permission if needed and starts the back camera at about
  /// 1920 × 1080 (decision M4-2: the photo isn't recompressed afterwards).
  /// Never throws.
  Future<CameraAccess> open() async {
    try {
      final cameras = await availableCameras();
      final camera =
          cameras
              .where((c) => c.lensDirection == CameraLensDirection.back)
              .firstOrNull ??
          cameras.firstOrNull;
      if (camera == null) return CameraAccess.unavailable;
      final controller = CameraController(
        camera,
        ResolutionPreset.veryHigh,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      await controller.initialize();
      _controller = controller;
      return CameraAccess.ready;
    } on CameraException catch (e) {
      // CameraAccessDenied, CameraAccessDeniedWithoutPrompt,
      // CameraAccessRestricted.
      return e.code.startsWith('CameraAccess')
          ? CameraAccess.denied
          : CameraAccess.unavailable;
    }
  }

  /// The live picture; empty until [open] succeeded.
  Widget preview() {
    final controller = _controller;
    return controller == null
        ? const SizedBox.shrink()
        : CameraPreview(controller);
  }

  /// Takes a photo and returns the JPEG the camera wrote to the app's
  /// private cache, unchanged (CAP-04).
  Future<Uint8List> takePicture() async {
    final file = await _controller!.takePicture();
    return file.readAsBytes();
  }

  /// The app's settings, to allow the camera after refusing it.
  Future<void> openSettings() => Geolocator.openAppSettings();

  Future<void> close() async {
    await _controller?.dispose();
    _controller = null;
  }
}
