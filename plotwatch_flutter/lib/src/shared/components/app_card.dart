import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// A white card on the ground: 1 px line border, 16 px corners and a soft
/// shadow (doc/05 §9 DP-2). With [onTap] the whole card is tappable.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.onTap,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  /// Overrides the line colour, e.g. terracotta for what needs attention.
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(PlotwatchTheme.cardRadius);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: customColors.surfaceWhite,
        borderRadius: radius,
        border: Border.all(
          color: borderColor ?? customColors.line,
          width: borderColor == null ? 1 : 1.5,
        ),
        boxShadow: PlotwatchTheme.cardShadow,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}
