import 'dart:math' as math;

import 'package:intl/intl.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The largest amount the server accepts, in minor units (doc/04c M3-4).
const maxMoneyMinor = 1000000000000000;

/// Decimal digits of a currency's minor unit: 0 for XAF, 2 for EUR and USD
/// (ISO 4217, from `intl`).
int currencyDigits(String currencyCode) =>
    NumberFormat.currency(locale: 'en', name: currencyCode).decimalDigits ?? 2;

/// [minor] units of [currencyCode] with its symbol, in the app language:
/// `FCFA 1,500,000`, `1 500 000 FCFA`, `€1,250.50` (decision M3-9).
String formatMoney(int minor, String currencyCode, {String? locale}) {
  final format = NumberFormat.simpleCurrency(
    locale: locale ?? _appLocale,
    name: currencyCode,
    decimalDigits: currencyDigits(currencyCode),
  );
  // English puts a symbol made of letters right against the digits
  // ("FCFA1,500"); a no-break space keeps them apart.
  return format
      .format(_major(minor, currencyCode))
      .replaceFirstMapped(
        RegExp(r'^([A-Za-z]+)(\d)'),
        (m) => '${m[1]} ${m[2]}',
      );
}

/// [minor] units as the owner types them, without the symbol: `1,250.50`.
String formatMoneyInput(int minor, String currencyCode, {String? locale}) =>
    NumberFormat.decimalPatternDigits(
      locale: locale ?? _appLocale,
      decimalDigits: currencyDigits(currencyCode),
    ).format(_major(minor, currencyCode));

/// The minor units in typed [text], or null when it isn't a valid amount of
/// [currencyCode] between 0 and [maxMoneyMinor]. Spaces and the language's
/// group separator are ignored; French also accepts a dot for the decimals,
/// as phone keypads often offer one.
int? parseMoney(String text, String currencyCode, {String? locale}) {
  final symbols = NumberFormat.decimalPattern(locale ?? _appLocale).symbols;
  var cleaned = text.replaceAll(RegExp(r'\s'), '');
  if (symbols.GROUP_SEP.trim().isNotEmpty) {
    cleaned = cleaned.replaceAll(symbols.GROUP_SEP, '');
  }
  cleaned = cleaned.replaceAll(symbols.DECIMAL_SEP, '.');

  final digits = currencyDigits(currencyCode);
  final pattern = digits == 0
      ? RegExp(r'^\d+$')
      : RegExp('^\\d+(\\.\\d{1,$digits})?\$');
  if (!pattern.hasMatch(cleaned)) return null;

  final parts = cleaned.split('.');
  final whole = parts.first;
  final fraction = (parts.length > 1 ? parts[1] : '').padRight(digits, '0');
  // Checked on the digits, so a huge amount can't overflow an int.
  if (whole.length > 16) return null;
  final minor =
      int.parse(whole) * math.pow(10, digits).toInt() +
      (fraction.isEmpty ? 0 : int.parse(fraction));
  return minor > maxMoneyMinor ? null : minor;
}

num _major(int minor, String currencyCode) {
  final digits = currencyDigits(currencyCode);
  return digits == 0 ? minor : minor / math.pow(10, digits);
}

String get _appLocale => LocalizationService.localization.localeName;

/// A large amount in short, for figures: "12.5 M XAF", "850 k XAF"
/// (doc/05 §9.3). Below ten thousand it is [formatMoney].
String formatMoneyShort(int minor, String currencyCode, {String? locale}) {
  final major = _major(minor, currencyCode);
  final (value, unit) = switch (major.abs()) {
    >= 1000000 => (major / 1000000, 'M'),
    >= 10000 => (major / 1000, 'k'),
    _ => (0.0, ''),
  };
  if (unit.isEmpty) return formatMoney(minor, currencyCode, locale: locale);
  final number = NumberFormat.decimalPatternDigits(
    locale: locale ?? _appLocale,
    decimalDigits: value.abs() >= 100 ? 0 : 1,
  ).format(value);
  // "12.0" reads as "12".
  final trimmed = number.replaceFirst(RegExp(r'[.,]0$'), '');
  return '$trimmed\u00A0$unit $currencyCode';
}
