import 'package:flutter/widgets.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Makes `LocalizationService.localization` usable in BLoC tests (it is
/// normally set by `ApplicationView`), and returns it for expected messages.
AppLocalizations setUpTestLocalization([Locale locale = const Locale('en')]) {
  final l10n = lookupAppLocalizations(locale);
  LocalizationService.setAppLocalizations(l10n);
  return l10n;
}
