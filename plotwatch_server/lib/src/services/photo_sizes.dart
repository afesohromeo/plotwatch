import 'dart:isolate';
import 'dart:typed_data';

import 'package:image/image.dart' as img;

/// The smaller JPEGs of a photo, made on another isolate (doc/04g step 10b).
/// Decoding and encoding are pure CPU work: on the server's own isolate they
/// held up every other request (developer, 2026-10-14: every call took about
/// 15 s on Cloud while photos were being resized).
class PhotoSizes {
  const PhotoSizes._();

  /// The thumbnail and the display size from one decoding; null when the
  /// photo can't be decoded.
  static Future<({Uint8List thumbnail, Uint8List display})?> both(
    Uint8List photo, {
    required int thumbnailWidth,
    required int displayWidth,
  }) => Isolate.run(() {
    final decoded = img.decodeImage(photo);
    if (decoded == null) return null;
    return (
      thumbnail: _jpeg(decoded, thumbnailWidth, 75),
      display: _jpeg(decoded, displayWidth, 80),
    );
  });

  /// One size; null when the photo can't be decoded.
  static Future<Uint8List?> one(
    Uint8List photo, {
    required int width,
    required int quality,
  }) => Isolate.run(() {
    final decoded = img.decodeImage(photo);
    return decoded == null ? null : _jpeg(decoded, width, quality);
  });

  /// [width] at most: a smaller photo is never enlarged.
  static Uint8List _jpeg(img.Image decoded, int width, int quality) =>
      Uint8List.fromList(
        img.encodeJpg(
          decoded.width > width
              ? img.copyResize(decoded, width: width)
              : decoded,
          quality: quality,
        ),
      );
}
