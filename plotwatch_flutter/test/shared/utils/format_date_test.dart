import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../helpers/helpers.dart';

// AC-7: dates follow the app language (the kit formatted them in French
// whatever the language).
void main() {
  final date = DateTime(2026, 11, 1);

  setUpAll(() => initializeDateFormatting());

  test('Given English when a date is formatted then it reads "1 Nov 2026"', () {
    expect(formatDate(date, locale: 'en'), '1 Nov 2026');
  });

  test('Given French when a date is formatted then it reads "1 nov. 2026"', () {
    expect(formatDate(date, locale: 'fr'), '1 nov. 2026');
  });

  test(
    'Given no locale when a date is formatted then the app language is used',
    () {
      setUpTestLocalization(const Locale('en'));

      expect(formatDate(date), '1 Nov 2026');
    },
  );
}
