// The demo video's cards (doc/07-demo-video.md), 1920×1080, in the app's
// colours, font and logo. Run with
//   flutter test --update-goldens tool/screenshots/video_cards_test.dart
// and they are written to doc/video/.
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import 'harness.dart';

void main() {
  setUpAll(loadFonts);

  final cards = <String, Widget>{
    '01_problem': const _Card(
      dark: true,
      children: [
        _Line("Building something you can't", size: 64),
        _Line('be there for every day?', size: 64),
        SizedBox(height: 40),
        _Line(
          'A house, a family building, a community project.',
          size: 40,
          muted: true,
        ),
        SizedBox(height: 28),
        _Line(
          "What's really done on site? Where does the money go?",
          size: 46,
          accent: true,
        ),
      ],
    ),
    '02_title': const _Card(
      dark: false,
      logo: true,
      children: [
        _Line('Plotwatch', size: 120, weight: FontWeight.w800),
        SizedBox(height: 16),
        _Line(
          'Oversee your construction project from anywhere.',
          size: 48,
          muted: true,
        ),
        SizedBox(height: 56),
        _Line('Verified site photos  ·  Stage approvals  ·  A shared ledger',
            size: 34),
      ],
    ),
    '03_built_with': const _Card(
      dark: true,
      children: [
        _Line('Built with Flutter and Serverpod', size: 64),
        SizedBox(height: 48),
        _Line('Live streams and server events', size: 40, muted: true),
        _Line('Future calls for scheduled work', size: 40, muted: true),
        _Line('Verified file uploads to cloud storage', size: 40, muted: true),
        _Line('Email and Google sign-in', size: 40, muted: true),
        _Line('Hosted on Serverpod Cloud', size: 40, muted: true),
        SizedBox(height: 56),
        _Line('plotwatch.serverpod.space', size: 56, accent: true),
      ],
    ),
  };

  for (final MapEntry(key: name, value: card) in cards.entries) {
    testWidgets('video card $name', (tester) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final root = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: RepaintBoundary(key: root, child: Material(child: card)),
        ),
      );
      // The logo is an SVG: let it load.
      await tester.runAsync(() => Future<void>.delayed(
            const Duration(milliseconds: 300),
          ));
      await tester.pump();
      await expectLater(
        find.byKey(root),
        matchesGoldenFile('../../../doc/video/$name.png'),
      );
    });
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.dark, required this.children, this.logo = false});

  final bool dark;
  final bool logo;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontFamily: 'Manrope',
        color: dark ? customColors.onPrimary : customColors.ink,
      ),
      child: ColoredBox(
        color: dark ? customColors.primary : customColors.ground,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 160),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (logo) ...[
                SvgPicture.asset(brandMarkAsset, width: 140, height: 140),
                const SizedBox(height: 40),
              ],
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line(
    this.text, {
    required this.size,
    this.weight = FontWeight.w700,
    this.muted = false,
    this.accent = false,
  });

  final String text;
  final double size;
  final FontWeight weight;
  final bool muted;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    final base = DefaultTextStyle.of(context).style;
    // On the green cards, the accent made for dark backgrounds.
    final onDark = base.color == customColors.onPrimary;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: base.copyWith(
          fontSize: size,
          fontWeight: muted ? FontWeight.w500 : weight,
          height: 1.25,
          color: accent
              ? (onDark ? customColors.accentOnDark : customColors.accent)
              : muted
              ? base.color!.withValues(alpha: .78)
              : null,
        ),
      ),
    );
  }
}
