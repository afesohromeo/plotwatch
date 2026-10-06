import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

// Spec: doc/05-design-system.md (direction A, Calm Ledger).
void main() {
  final theme = PlotwatchTheme.light(customColors);

  group('Given the Plotwatch theme', () {
    test('then the colour scheme uses the brand tokens', () {
      expect(theme.colorScheme.primary, customColors.primary);
      expect(theme.colorScheme.onPrimary, customColors.onPrimary);
      expect(theme.colorScheme.secondary, customColors.accent);
      expect(theme.colorScheme.error, customColors.unverified);
      expect(theme.colorScheme.surface, customColors.surfaceWhite);
      expect(theme.colorScheme.onSurface, customColors.ink);
      expect(theme.scaffoldBackgroundColor, customColors.surfaceWhite);
    });

    test('then the app bar is white with an ink title and no elevation', () {
      final appBar = theme.appBarTheme;

      expect(appBar.backgroundColor, customColors.surfaceWhite);
      expect(appBar.foregroundColor, customColors.ink);
      expect(appBar.elevation, 0);
      expect(appBar.scrolledUnderElevation, 0);
      expect(appBar.surfaceTintColor, Colors.transparent);
      expect(appBar.titleTextStyle?.color, customColors.ink);
      expect(appBar.shape, isA<Border>());
    });

    test('then text uses Manrope in ink, with muted secondary text', () {
      final text = theme.textTheme;

      for (final style in [
        text.displaySmall,
        text.headlineSmall,
        text.titleLarge,
        text.bodyLarge,
        text.labelLarge,
      ]) {
        expect(style?.fontFamily, PlotwatchTheme.fontFamily);
        expect(style?.color, customColors.ink);
      }
      expect(text.bodyMedium?.color, customColors.muted);
      expect(text.bodySmall?.color, customColors.muted);
      expect(text.headlineSmall?.fontWeight, FontWeight.w800);
    });

    group('then inputs', () {
      final inputs = theme.inputDecorationTheme;

      test('have a 1 px line border with 12 px corners when idle', () {
        final enabled = inputs.enabledBorder! as OutlineInputBorder;
        expect(enabled.borderSide.color, customColors.line);
        expect(enabled.borderSide.width, 1);
        expect(enabled.borderRadius, BorderRadius.circular(12));
      });

      test('have a 2 px primary border when focused', () {
        final focused = inputs.focusedBorder! as OutlineInputBorder;
        expect(focused.borderSide.color, customColors.primary);
        expect(focused.borderSide.width, 2);
      });

      test('have a 2 px unverified border when in error', () {
        final error = inputs.errorBorder! as OutlineInputBorder;
        final focusedError = inputs.focusedErrorBorder! as OutlineInputBorder;
        expect(error.borderSide.color, customColors.unverified);
        expect(error.borderSide.width, 2);
        expect(focusedError.borderSide.color, customColors.unverified);
      });

      test('are filled white', () {
        expect(inputs.filled, isTrue);
        expect(inputs.fillColor, customColors.surfaceWhite);
      });
    });

    test('then filled buttons are primary, 52 px high, with 12 px corners', () {
      final style = theme.filledButtonTheme.style!;

      expect(style.backgroundColor?.resolve({}), customColors.primary);
      expect(style.foregroundColor?.resolve({}), customColors.onPrimary);
      expect(style.minimumSize?.resolve({})?.height, 52);
      expect(
        style.shape?.resolve({}),
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      );
    });

    test('then outlined buttons have a 1.5 px primary border', () {
      final side = theme.outlinedButtonTheme.style!.side?.resolve({});

      expect(side?.color, customColors.primary);
      expect(side?.width, 1.5);
    });

    test('then dialogs are white with 20 px corners', () {
      expect(theme.dialogTheme.backgroundColor, customColors.surfaceWhite);
      expect(
        theme.dialogTheme.shape,
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      );
    });
  });
}
