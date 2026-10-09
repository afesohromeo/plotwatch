import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

// Plan: doc/04d-m4-capture.md, decision M4-7: the server sends numbers only;
// the app writes each check's sentence in the user's language (VER-03).
void main() {
  VerificationCheck check(
    VerificationCheckName name,
    bool passed, [
    Map<String, String>? details,
  ]) => VerificationCheck(
    name: name,
    passed: passed,
    critical: true,
    details: details,
  );

  /// Details as the server fills them, per check.
  final details = <VerificationCheckName, Map<String, String>?>{
    VerificationCheckName.locationAccuracy: {
      'accuracyM': '12',
      'allowedM': '30',
    },
    VerificationCheckName.insideSite: {'distanceM': '137', 'allowedM': '58'},
    VerificationCheckName.clockConsistency: {
      'skewSeconds': '720',
      'allowedSeconds': '600',
    },
    VerificationCheckName.promptCommit: {
      'delaySeconds': '1200',
      'allowedSeconds': '900',
    },
  };

  for (final locale in const [Locale('en'), Locale('fr')]) {
    group('Given the ${locale.languageCode} localization', () {
      final l10n = lookupAppLocalizations(locale);

      test('then every check has a title, and a sentence when it passes and '
          'when it fails', () {
        for (final name in VerificationCheckName.values) {
          for (final passed in [true, false]) {
            final c = check(name, passed, details[name]);
            expect(c.title(l10n), isNotEmpty, reason: '$name');
            expect(c.explanation(l10n), isNotEmpty, reason: '$name $passed');
          }
        }
        expect(
          check(VerificationCheckName.hashMatch, true).explanation(l10n),
          isNot(
            check(VerificationCheckName.hashMatch, false).explanation(l10n),
          ),
        );
      });

      test('then every level has its own label', () {
        expect(
          VerificationLevel.values.map((v) => v.label(l10n)).toSet(),
          hasLength(VerificationLevel.values.length),
        );
      });
    });
  }

  group('Given the English localization', () {
    final l10n = lookupAppLocalizations(const Locale('en'));

    test('when a photo is outside the site then it says how far and what is '
        'allowed (AC-3)', () {
      expect(
        check(
          VerificationCheckName.insideSite,
          false,
          details[VerificationCheckName.insideSite],
        ).explanation(l10n),
        'Taken 137 m from the site; allowed: 58 m',
      );
    });

    test('when the clock is off then it says by how many minutes', () {
      expect(
        check(
          VerificationCheckName.clockConsistency,
          false,
          details[VerificationCheckName.clockConsistency],
        ).explanation(l10n),
        contains('12'),
      );
    });

    test('when there was no position then the site check says so', () {
      expect(
        check(VerificationCheckName.insideSite, false, {
          'allowedM': '58',
        }).explanation(l10n),
        l10n.checkInsideSiteUnknown,
      );
    });
  });
}
