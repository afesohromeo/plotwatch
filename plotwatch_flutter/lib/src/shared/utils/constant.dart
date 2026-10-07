import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

bool isStandalone = false;
GlobalKey<NavigatorState>? rootNavKey;

const String defaultAddress = '';
const String fakeTenant = '';

/// The "Calm Ledger" palette (doc/05-design-system.md §2).
const customColors = MyAppColors(
  primary: Color(0xFF0E5A52),
  onPrimary: Color(0xFFFFFFFF),
  accent: Color(0xFFA44A24),
  accentSoft: Color(0xFFF6E7DE),
  ink: Color(0xFF15201E),
  muted: Color(0xFF55625F),
  line: Color(0xFFD3DAD7),
  ground: Color(0xFFF4F6F4),
  surfaceWhite: Color(0xFFFFFFFF),
  verified: Color(0xFF1D6A45),
  verifiedSoft: Color(0xFFE1F1E7),
  partial: Color(0xFF7A4F00),
  partialSoft: Color(0xFFFBEFD5),
  unverified: Color(0xFFA3262A),
  unverifiedSoft: Color(0xFFFBE4E4),
);
String? formatDateForApi(DateTime? dateTime) {
  return dateTime == null
      ? null
      : DateFormat('yyyy-MM-dd', 'fr_FR').format(dateTime);
}

DateTime? convertJsonDate(value) {
  if (value == null || value.toString().isEmpty || value.toString() == 'null') {
    return null;
  }

  final str = value.toString();

  // 1. Try ISO 8601 parsing
  final isoDate = DateTime.tryParse(str);
  if (isoDate != null) return isoDate;

  // 2. Try custom format (dd/MM/yyyy HH:mm:ss)
  try {
    return DateFormat('dd/MM/yyyy HH:mm:ss').parse(str);
  } catch (_) {
    // ignore and continue
  }

  // 3. Try Unix timestamp (seconds or milliseconds)
  try {
    final num ts = num.parse(str);
    if (str.length == 10) {
      // seconds since epoch
      return DateTime.fromMillisecondsSinceEpoch(ts.toInt() * 1000);
    } else if (str.length == 13) {
      // milliseconds since epoch
      return DateTime.fromMillisecondsSinceEpoch(ts.toInt());
    }
  } catch (_) {
    // not a number
  }

  // 4. If all parsing fails
  return null;
}

double? convertToDouble(value, {bool canBeNull = false}) {
  double? doubleValue = value == null || value == ''
      ? canBeNull
            ? null
            : 0.0
      : (value is int)
      ? value.toDouble()
      : value;
  return doubleValue;
}

String formatPrice(double? price, String currency) {
  if (price == null) {
    return 'N/A';
  }
  return '${NumberFormat('#,###.#').format(price)} $currency';
}

/// [locale] defaults to the app language (AC-7); the kit used French always.
String formatDate(
  DateTime? date, {
  bool withTime = false,
  bool withDay = false,
  String? locale,
}) {
  if (date == null) return '';
  final languageCode = locale ?? LocalizationService.localization.localeName;
  return withTime
      ? DateFormat('d MMM yyyy - HH:mm', languageCode).format(date)
      : withDay
      ? DateFormat('EEE d MMM yyyy', languageCode).format(date)
      : DateFormat('d MMM yyyy', languageCode).format(date);
}

/// App languages (D-8). Mirrors the server's ProfileService.supportedLocales.
const List<String> supportedLanguageCodes = ['en', 'fr'];
const String defaultLanguageCode = 'en';

/// Project currencies (decision M2-13). Mirrors the server's
/// ProjectService.supportedCurrencies.
const List<String> supportedCurrencyCodes = [
  'XAF', 'XOF', 'NGN', 'GHS', 'KES', 'UGX', 'TZS', 'RWF', 'CDF', 'GNF', //
  'ZAR', 'MAD', 'EGP', 'ETB', 'EUR', 'USD', 'GBP', 'CAD', 'CHF',
];

/// Logo D1, full detail, for light backgrounds (doc/04b, group E2).
const String brandMarkAsset = 'assets/brand/mark_full.svg';

/// Site rules, mirrored from the server's SiteService (decisions M2-16,
/// M2-17).
const double maxGpsAccuracyM = 20;
const int minSiteRadiusM = 10;
const int maxSiteRadiusM = 500;
const int defaultSiteRadiusM = 50;
