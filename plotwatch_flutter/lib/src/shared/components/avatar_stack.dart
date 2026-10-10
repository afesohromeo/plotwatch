import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The initials of a person: "Ada Lovelace" → "AL", "bob" → "B".
String initialsOf(String name) {
  final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
  if (parts.isEmpty) return '?';
  final first = parts.first.characters.first;
  final last = parts.length > 1 ? parts.last.characters.first : '';
  return (first + last).toUpperCase();
}

/// Overlapping initials, for the members card (doc/05 §9 DP-4): at most
/// [max] circles, then "+N".
class AvatarStack extends StatelessWidget {
  const AvatarStack({
    super.key,
    required this.names,
    this.max = 4,
    this.size = 32,
  });

  final List<String> names;
  final int max;
  final double size;

  static const _tones = [
    (Color(0xFF0E5A52), Color(0xFFFFFFFF)),
    (Color(0xFF15201E), Color(0xFFFFFFFF)),
    (Color(0xFFA44A24), Color(0xFFFFFFFF)),
    (Color(0xFFD3DAD7), Color(0xFF15201E)),
  ];

  @override
  Widget build(BuildContext context) {
    final shown = names.take(max).toList();
    final more = names.length - shown.length;
    Widget circle(String text, (Color, Color) tone) => Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: tone.$1,
        shape: BoxShape.circle,
        border: Border.all(color: customColors.surfaceWhite, width: 2),
      ),
      child: Text(
        text,
        style: context.textTheme.labelSmall?.copyWith(
          color: tone.$2,
          fontSize: size * .34,
          fontWeight: FontWeight.w800,
        ),
      ),
    );

    final circles = [
      for (var i = 0; i < shown.length; i++)
        circle(initialsOf(shown[i]), _tones[i % _tones.length]),
      if (more > 0)
        circle('+$more', (customColors.primarySoft, customColors.primary)),
    ];
    // Each circle overlaps the previous one by 8 px.
    final step = size - 8;
    return ExcludeSemantics(
      child: SizedBox(
        width: circles.isEmpty ? 0 : size + step * (circles.length - 1),
        height: size,
        child: Stack(
          children: [
            for (var i = 0; i < circles.length; i++)
              Positioned(left: step * i, child: circles[i]),
          ],
        ),
      ),
    );
  }
}
