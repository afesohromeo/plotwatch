// The LinkedIn post's images (2026-10-19), 1920×1080 like the video cards:
// the developer's screenshots of the Cloud app, cropped and framed.
// Run with
//   flutter test --update-goldens tool/screenshots/post_images_test.dart
// and they are written to `demo images/post/post_*.png`.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import 'harness.dart';

const _folder = '../demo images/post';

/// A part of a screenshot ([source], in its pixels) drawn at [at], [scale]d.
class _Crop {
  const _Crop(this.source, this.at, {this.scale = 1});

  final Rect source;
  final Offset at;
  final double scale;
}

class _Post {
  const _Post(this.name, this.screenshot, this.title, this.text, this.crops);

  final String name;
  final String screenshot;
  final String title;
  final String text;
  final List<_Crop> crops;
}

const _posts = [
  _Post(
    'post_1_evidence',
    'Plotwatch - Google Chrome 10_19_2026 12_40_07 PM.png',
    'Photos you\ncan trust',
    'Every site photo is taken in the app and checked 8 ways: '
        'on the site, real GPS, unchanged, on time.',
    [
      _Crop(Rect.fromLTRB(385, 142, 1258, 938), Offset(760, 110)),
      _Crop(Rect.fromLTRB(1308, 592, 1887, 1040), Offset(1300, 540)),
    ],
  ),
  _Post(
    'post_2_approval',
    'Plotwatch - Google Chrome 10_19_2026 12_41_26 PM.png',
    'Approve stage\nby stage',
    'See the required evidence for each stage, then approve it '
        'or ask for changes.',
    [
      _Crop(Rect.fromLTRB(388, 192, 1256, 975), Offset(760, 90)),
      _Crop(Rect.fromLTRB(1307, 198, 1887, 634), Offset(1300, 400)),
      _Crop(
        Rect.fromLTRB(370, 991, 1903, 1065),
        Offset(760, 920),
        scale: 0.72,
      ),
    ],
  ),
  _Post(
    'post_3_money',
    'Plotwatch - Google Chrome 10_19_2026 12_41_46 PM.png',
    'Know where\nthe money goes',
    'Released, spent, with a receipt, and what is left, '
        'stage by stage.',
    [
      _Crop(
        Rect.fromLTRB(397, 120, 1876, 282),
        Offset(760, 180),
        scale: 0.75,
      ),
      _Crop(
        Rect.fromLTRB(397, 403, 1277, 1047),
        Offset(760, 340),
        scale: 0.8,
      ),
      _Crop(
        Rect.fromLTRB(1327, 327, 1875, 858),
        Offset(1480, 380),
        scale: 0.72,
      ),
    ],
  ),
];

void main() {
  setUpAll(loadFonts);

  for (final post in _posts) {
    testWidgets(post.name, (tester) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final bytes = File('$_folder/${post.screenshot}').readAsBytesSync();
      final image = (await tester.runAsync(() async {
        final codec = await ui.instantiateImageCodec(bytes);
        return (await codec.getNextFrame()).image;
      }))!;
      final root = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: RepaintBoundary(
            key: root,
            child: Material(
              child: _Frame(post: post, image: image),
            ),
          ),
        ),
      );
      await tester.pump();
      await expectLater(
        find.byKey(root),
        matchesGoldenFile('../../$_folder/${post.name}.png'),
      );
    });
  }
}

class _Frame extends StatelessWidget {
  const _Frame({required this.post, required this.image});

  final _Post post;
  final ui.Image image;

  @override
  Widget build(BuildContext context) {
    TextStyle style(double size, FontWeight weight, Color color) => TextStyle(
      fontFamily: 'Manrope',
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: 1.15,
    );
    return ColoredBox(
      color: customColors.primary,
      child: Stack(
        children: [
          // The brand side, as on the thumbnail.
          Positioned(
            left: 90,
            top: 90,
            bottom: 90,
            width: 600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.string(
                      File('assets/brand/splash_mark.svg').readAsStringSync(),
                      width: 64,
                      height: 64,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Plotwatch',
                      style: style(40, FontWeight.w800, customColors.onPrimary),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  post.title,
                  style: style(72, FontWeight.w800, customColors.onPrimary),
                ),
                const SizedBox(height: 28),
                Text(
                  post.text,
                  style: style(
                    32,
                    FontWeight.w600,
                    customColors.accentOnDark,
                  ).copyWith(height: 1.35),
                ),
                const Spacer(),
                Text(
                  'Built with Flutter and Serverpod',
                  style: style(
                    26,
                    FontWeight.w600,
                    customColors.onPrimary.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ),
          for (final crop in post.crops)
            Positioned(
              left: crop.at.dx,
              top: crop.at.dy,
              child: _Shot(image: image, crop: crop),
            ),
        ],
      ),
    );
  }
}

class _Shot extends StatelessWidget {
  const _Shot({required this.image, required this.crop});

  final ui.Image image;
  final _Crop crop;

  @override
  Widget build(BuildContext context) {
    final size = crop.source.size * crop.scale;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 36,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: CustomPaint(
          size: size,
          painter: _CropPainter(image, crop.source),
        ),
      ),
    );
  }
}

class _CropPainter extends CustomPainter {
  const _CropPainter(this.image, this.source);

  final ui.Image image;
  final Rect source;

  @override
  void paint(Canvas canvas, Size size) => canvas.drawImageRect(
    image,
    source,
    Offset.zero & size,
    Paint()..filterQuality = FilterQuality.high,
  );

  @override
  bool shouldRepaint(_CropPainter old) =>
      old.image != image || old.source != source;
}
