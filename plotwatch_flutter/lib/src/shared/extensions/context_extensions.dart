import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

extension ThemeDataX on BuildContext {
  Brightness get brightness => Theme.of(this).brightness;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  ThemeData get theme => Theme.of(this);
}

extension MediaQueryX on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => MediaQuery.of(this).size;
}

extension LocalizationX on BuildContext {
  AppLocalizations get localization {
    return LocalizationService.localization;
  }
}
