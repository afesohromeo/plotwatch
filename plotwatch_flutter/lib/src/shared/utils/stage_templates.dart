import 'package:plotwatch_flutter/plotwatch_flutter.dart';

typedef _Text = String Function(AppLocalizations l10n);

/// The built-in stage plans of doc/02 §12.1 (decision M3-2). They live in
/// the app because their texts are display text; choosing one fills the
/// plan in the owner's language, and the stages are then ordinary, editable
/// text. Budgets and dates start empty.
enum StageTemplate {
  singleStoreyHouse,
  renovation,
  custom;

  String label(AppLocalizations l10n) => switch (this) {
    singleStoreyHouse => l10n.templateHouse,
    renovation => l10n.templateRenovation,
    custom => l10n.templateCustom,
  };

  String description(AppLocalizations l10n) => switch (this) {
    singleStoreyHouse => l10n.templateHouseHint,
    renovation => l10n.templateRenovationHint,
    custom => l10n.templateCustomHint,
  };

  /// The template's stages in [l10n]'s language, ready to send.
  List<StageDraft> stages(AppLocalizations l10n) => [
    for (final (name, items) in _plans[this]!)
      StageDraft(
        name: name(l10n),
        budgetMinor: 0,
        items: [
          for (final label in items)
            ChecklistItemDraft(label: label(l10n), isRequired: true),
        ],
      ),
  ];
}

/// Stage name and required evidence, per template (doc/02 §12.1).
final Map<StageTemplate, List<(_Text, List<_Text>)>> _plans = {
  StageTemplate.singleStoreyHouse: [
    ((l) => l.tplHouse1, [(l) => l.tplHouse1a, (l) => l.tplHouse1b]),
    ((l) => l.tplHouse2, [(l) => l.tplHouse2a, (l) => l.tplHouse2b]),
    ((l) => l.tplHouse3, [(l) => l.tplHouse3a, (l) => l.tplHouse3b]),
    ((l) => l.tplHouse4, [(l) => l.tplHouse4a, (l) => l.tplHouse4b]),
    ((l) => l.tplHouse5, [(l) => l.tplHouse5a, (l) => l.tplHouse5b]),
    ((l) => l.tplHouse6, [(l) => l.tplHouse6a, (l) => l.tplHouse6b]),
    ((l) => l.tplHouse7, [(l) => l.tplHouse7a, (l) => l.tplHouse7b]),
    ((l) => l.tplHouse8, [(l) => l.tplHouse8a]),
    ((l) => l.tplHouse9, [(l) => l.tplHouse9a, (l) => l.tplHouse9b]),
    ((l) => l.tplHouse10, [(l) => l.tplHouse10a, (l) => l.tplHouse10b]),
  ],
  StageTemplate.renovation: [
    ((l) => l.tplReno1, [(l) => l.tplReno1a, (l) => l.tplReno1b]),
    ((l) => l.tplReno2, [(l) => l.tplReno2a, (l) => l.tplReno2b]),
    ((l) => l.tplReno3, [(l) => l.tplReno3a, (l) => l.tplReno3b]),
    ((l) => l.tplReno4, [(l) => l.tplReno4a]),
    ((l) => l.tplReno5, [(l) => l.tplReno5a]),
    ((l) => l.tplReno6, [(l) => l.tplReno6a, (l) => l.tplReno6b]),
  ],
  StageTemplate.custom: [],
};
