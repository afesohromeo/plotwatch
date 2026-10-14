// The demo video's YouTube thumbnail (doc/07-demo-video.md), 1280×720.
// Run with
//   flutter test --update-goldens tool/screenshots/video_thumbnail_test.dart
// and it is written to doc/video/thumbnail.png.
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import 'harness.dart';

void main() {
  setUpAll(loadFonts);

  testWidgets('video thumbnail', (tester) async {
    tester.view.physicalSize = const Size(1280, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    // A demo site photo (generated with Gemini, doc/04g step 7).
    final photo = MemoryImage(
      File(
        '../plotwatch_server/web/seed/photos/ground_floor_1.jpg',
      ).readAsBytesSync(),
    );
    final root = GlobalKey();
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RepaintBoundary(
          key: root,
          child: Material(child: _Thumbnail(photo: photo)),
        ),
      ),
    );
    final context = tester.element(find.byKey(root));
    await tester.runAsync(() async {
      await precacheImage(photo, context);
      await Future<void>.delayed(const Duration(milliseconds: 300));
    });
    await tester.pump();
    await expectLater(
      find.byKey(root),
      matchesGoldenFile('../../../doc/video/thumbnail.png'),
    );
  });
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.photo});

  final ImageProvider photo;

  @override
  Widget build(BuildContext context) {
    TextStyle style(double size, FontWeight weight, Color color) => TextStyle(
      fontFamily: 'Manrope',
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: 1.15,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // The brand side.
        Expanded(
          flex: 11,
          child: ColoredBox(
            color: customColors.primary,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(64, 56, 40, 56),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.string(
                    File('assets/brand/splash_mark.svg').readAsStringSync(),
                    width: 120,
                    height: 120,
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Plotwatch',
                    style: style(84, FontWeight.w800, customColors.onPrimary),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Oversee your construction\nproject from anywhere',
                    style: style(
                      40,
                      FontWeight.w700,
                      customColors.accentOnDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // A site photo, verified.
        Expanded(
          flex: 9,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image(image: photo, fit: BoxFit.cover),
              Positioned(
                left: 28,
                bottom: 32,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: customColors.surfaceWhite,
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x55000000),
                        blurRadius: 14,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        size: 36,
                        color: customColors.verified,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Verified',
                        style: style(
                          34,
                          FontWeight.w800,
                          customColors.verified,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
