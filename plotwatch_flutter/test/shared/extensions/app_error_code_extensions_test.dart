import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

// _standards/14 §2.6: one localized message per error code.
void main() {
  for (final locale in const [Locale('en'), Locale('fr')]) {
    group('Given the ${locale.languageCode} localization', () {
      final l10n = lookupAppLocalizations(locale);

      for (final code in AppErrorCode.values) {
        test('when ${code.name} is shown then it has a message', () {
          expect(code.message(l10n), isNotEmpty);
        });
      }
    });
  }

  test('Given an auth error when shown in English and French then the '
      'messages differ', () {
    final en = lookupAppLocalizations(const Locale('en'));
    final fr = lookupAppLocalizations(const Locale('fr'));

    expect(
      AppErrorCode.authInvalidCredentials.message(fr),
      isNot(AppErrorCode.authInvalidCredentials.message(en)),
    );
  });
}
