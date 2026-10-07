import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Colour tokens of the "Calm Ledger" design system
/// (doc/05-design-system.md §2). Widgets read them through `customColors`
/// or the theme, never as literals.
class MyAppColors extends AppColors {
  const MyAppColors({
    required super.primary,
    required this.onPrimary,
    required this.accent,
    required this.accentSoft,
    required this.ink,
    required this.muted,
    required this.line,
    required this.ground,
    required this.surfaceWhite,
    required this.verified,
    required this.verifiedSoft,
    required this.partial,
    required this.partialSoft,
    required this.unverified,
    required this.unverifiedSoft,
  }) : super(
         secondary: accent,
         background: surfaceWhite,
         surface: muted,
         error: unverified,
       );

  /// Text and icons on [primary].
  final Color onPrimary;

  /// Secondary brand colour: photo thumbnails, highlights. Never errors.
  final Color accent;
  final Color accentSoft;

  /// Main text and icons.
  final Color ink;

  /// Secondary text, hints, captions.
  final Color muted;

  /// Borders, dividers, input outlines.
  final Color line;

  /// Page background behind cards.
  final Color ground;

  /// Cards, app bar, inputs, dialogs.
  final Color surfaceWhite;

  /// Verification status (badges); [unverified] is also the error colour.
  final Color verified;
  final Color verifiedSoft;
  final Color partial;
  final Color partialSoft;
  final Color unverified;
  final Color unverifiedSoft;

  /// Soft ring around a focused input.
  Color get focusRing => primary.withValues(alpha: 0.16);

  // Names used by the flutter_bloc_kit components, mapped to the tokens.
  Color get success => verified;
  Color get warning => partial;
  Color get black1 => ink;
}
