import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The design system's main button (doc/05-design-system.md §5): filled in
/// `primary` ([withBg] true) or outlined ([withBg] false), 52 px high,
/// 12 px corners, no gradient. Colours and text style come from the theme;
/// [buttonColor] overrides the fill (or outline) colour where needed.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.withBg = true,
    this.buttonColor,
    this.height,
    this.width,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final bool withBg;
  final Color? buttonColor;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final button = withBg
        ? FilledButton(
            onPressed: onPressed,
            style: buttonColor == null
                ? null
                : FilledButton.styleFrom(backgroundColor: buttonColor),
            child: child,
          )
        : OutlinedButton(
            onPressed: onPressed,
            style: buttonColor == null
                ? null
                : OutlinedButton.styleFrom(
                    foregroundColor: buttonColor,
                    side: BorderSide(color: buttonColor!, width: 1.5),
                  ),
            child: child,
          );

    return SizedBox(
      width: width,
      height: height ?? PlotwatchTheme.controlHeight,
      child: button,
    );
  }
}
