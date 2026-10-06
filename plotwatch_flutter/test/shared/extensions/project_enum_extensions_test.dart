import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

// _standards/14 §1.3: every enum value has a label in each language.
void main() {
  for (final locale in const [Locale('en'), Locale('fr')]) {
    group('Given the ${locale.languageCode} localization', () {
      final l10n = lookupAppLocalizations(locale);

      test('then every project type, status and role has a label', () {
        expect(ProjectType.values.map((v) => v.label(l10n)),
            everyElement(isNotEmpty));
        expect(ProjectStatus.values.map((v) => v.label(l10n)),
            everyElement(isNotEmpty));
        expect(ProjectRole.values.map((v) => v.label(l10n)),
            everyElement(isNotEmpty));
      });
    });
  }

  test('Given the site manager role then English and French differ', () {
    expect(
      ProjectRole.siteManager.label(lookupAppLocalizations(const Locale('fr'))),
      isNot(ProjectRole.siteManager
          .label(lookupAppLocalizations(const Locale('en')))),
    );
  });

  // Mirrors the server's ProjectService transitions (decision M2-4); the
  // server still enforces them.
  final expected = {
    ProjectStatus.draft: <ProjectStatus>[],
    ProjectStatus.active: [ProjectStatus.paused, ProjectStatus.completed],
    ProjectStatus.paused: [ProjectStatus.active, ProjectStatus.completed],
    ProjectStatus.completed: [ProjectStatus.archived],
    ProjectStatus.archived: <ProjectStatus>[],
  };
  for (final MapEntry(key: from, value: targets) in expected.entries) {
    test('Given a ${from.name} project then the owner can move it to '
        '${targets.map((s) => s.name)}', () {
      expect(from.nextStatuses, targets);
    });
  }
}
