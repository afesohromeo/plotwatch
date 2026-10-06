import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The "Calm Ledger" theme (doc/05-design-system.md). Light only for the
/// MVP. Replaces `AppTheme.light` from app_theme_kit, whose text theme
/// colours body text with the secondary colour and downloads its font at
/// runtime.
class PlotwatchTheme {
  PlotwatchTheme._();

  /// Bundled in assets/fonts (SIL Open Font License).
  static const fontFamily = 'Manrope';

  static const double radius = 12;
  static const double dialogRadius = 20;
  static const double controlHeight = 52;

  static ThemeData light(MyAppColors c) {
    final textTheme = _textTheme(c);
    final controlShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    );

    OutlineInputBorder outline(Color color, double width) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: color, width: width),
        );

    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      colorScheme: ColorScheme.light(
        primary: c.primary,
        onPrimary: c.onPrimary,
        secondary: c.accent,
        onSecondary: c.onPrimary,
        error: c.unverified,
        onError: c.onPrimary,
        surface: c.surfaceWhite,
        onSurface: c.ink,
        onSurfaceVariant: c.muted,
        outline: c.line,
        outlineVariant: c.line,
      ),
      scaffoldBackgroundColor: c.surfaceWhite,
      textTheme: textTheme,
      dividerTheme: DividerThemeData(color: c.line, thickness: 1, space: 1),
      appBarTheme: AppBarTheme(
        backgroundColor: c.surfaceWhite,
        foregroundColor: c.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
        iconTheme: IconThemeData(color: c.ink),
        actionsIconTheme: IconThemeData(color: c.primary),
        shape: Border(bottom: BorderSide(color: c.line)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surfaceWhite,
        isDense: false,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        hintStyle: textTheme.bodyLarge?.copyWith(color: c.muted),
        labelStyle: textTheme.labelMedium,
        floatingLabelStyle: textTheme.labelMedium?.copyWith(color: c.primary),
        errorStyle: textTheme.bodySmall?.copyWith(
          color: c.unverified,
          fontWeight: FontWeight.w600,
        ),
        errorMaxLines: 2,
        border: outline(c.line, 1),
        enabledBorder: outline(c.line, 1),
        disabledBorder: outline(c.line, 1),
        focusedBorder: outline(c.primary, 2),
        errorBorder: outline(c.unverified, 2),
        focusedErrorBorder: outline(c.unverified, 2),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) =>
              states.contains(WidgetState.disabled) ? c.line : c.primary),
          foregroundColor: WidgetStateProperty.resolveWith((states) =>
              states.contains(WidgetState.disabled) ? c.muted : c.onPrimary),
          minimumSize:
              const WidgetStatePropertyAll(Size(64, controlHeight)),
          shape: WidgetStatePropertyAll(controlShape),
          textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
          elevation: const WidgetStatePropertyAll(0),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(c.primary),
          minimumSize:
              const WidgetStatePropertyAll(Size(64, controlHeight)),
          shape: WidgetStatePropertyAll(controlShape),
          side: WidgetStatePropertyAll(BorderSide(color: c.primary, width: 1.5)),
          textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(c.primary),
          minimumSize: const WidgetStatePropertyAll(Size(48, 48)),
          textStyle: WidgetStatePropertyAll(
            textTheme.labelLarge?.copyWith(fontSize: 15),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.surfaceWhite,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(dialogRadius),
        ),
        barrierColor: const Color(0x7A0E1614),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: c.primary,
        linearTrackColor: c.line,
      ),
    );
  }

  /// §3 of the design system: one family, ink text, muted secondary text.
  static TextTheme _textTheme(MyAppColors c) {
    TextStyle style(double size, FontWeight weight, Color color,
            {double? height, double? letterSpacing}) =>
        TextStyle(
          fontFamily: fontFamily,
          fontSize: size,
          fontWeight: weight,
          color: color,
          height: height,
          letterSpacing: letterSpacing,
        );

    return TextTheme(
      displaySmall:
          style(34, FontWeight.w800, c.ink, height: 1.15, letterSpacing: -0.5),
      headlineSmall: style(26, FontWeight.w800, c.ink, height: 1.2),
      titleLarge: style(18, FontWeight.w700, c.ink),
      titleMedium: style(16, FontWeight.w700, c.ink),
      titleSmall: style(14, FontWeight.w700, c.ink),
      bodyLarge: style(16, FontWeight.w500, c.ink, height: 1.4),
      bodyMedium: style(15, FontWeight.w400, c.muted, height: 1.5),
      bodySmall: style(13, FontWeight.w500, c.muted, height: 1.4),
      labelLarge: style(16, FontWeight.w700, c.ink),
      labelMedium: style(14, FontWeight.w600, c.ink),
      labelSmall: style(12, FontWeight.w700, c.ink),
    );
  }
}
