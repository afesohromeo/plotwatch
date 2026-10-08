import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

// Plan: doc/04c-m3-stages.md, decision M3-2: the built-in templates of
// doc/02 §12.1 live in the app, with their texts in English and French.
void main() {
  for (final locale in const [Locale('en'), Locale('fr')]) {
    group('Given the ${locale.languageCode} localization', () {
      final l10n = lookupAppLocalizations(locale);

      test('then the single-storey house has 10 stages and renovation 6, '
          'custom none', () {
        expect(StageTemplate.singleStoreyHouse.stages(l10n), hasLength(10));
        expect(StageTemplate.renovation.stages(l10n), hasLength(6));
        expect(StageTemplate.custom.stages(l10n), isEmpty);
      });

      test('then every template has a name and a description', () {
        for (final template in StageTemplate.values) {
          expect(template.label(l10n), isNotEmpty);
          expect(template.description(l10n), isNotEmpty);
        }
      });

      test('then every stage has a name, a zero budget, no dates, and at '
          'least one required checklist item with a label', () {
        for (final template in StageTemplate.values) {
          for (final stage in template.stages(l10n)) {
            expect(stage.name, isNotEmpty);
            expect(stage.name.length, lessThanOrEqualTo(100));
            expect(stage.budgetMinor, 0);
            expect(stage.plannedStart, isNull);
            expect(stage.items, isNotEmpty);
            for (final item in stage.items) {
              expect(item.label, isNotEmpty);
              expect(item.label.length, lessThanOrEqualTo(200));
              expect(item.isRequired, isTrue);
              expect(item.itemId, isNull);
            }
          }
        }
      });
    });
  }

  test('Given a template then its English and French stage names differ', () {
    final en = lookupAppLocalizations(const Locale('en'));
    final fr = lookupAppLocalizations(const Locale('fr'));

    expect(
      StageTemplate.singleStoreyHouse.stages(fr).first.name,
      isNot(StageTemplate.singleStoreyHouse.stages(en).first.name),
    );
  });
}
