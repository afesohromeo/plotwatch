import 'package:flutter/painting.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Localized label of a project status (`_standards/14` §1.3).
extension ProjectStatusX on ProjectStatus {
  String label(AppLocalizations l10n) => switch (this) {
        ProjectStatus.draft => l10n.projectStatusDraft,
        ProjectStatus.active => l10n.projectStatusActive,
        ProjectStatus.paused => l10n.projectStatusPaused,
        ProjectStatus.completed => l10n.projectStatusCompleted,
        ProjectStatus.archived => l10n.projectStatusArchived,
      };

  /// The statuses the owner can choose next. Mirrors the server's
  /// `ProjectService` transitions (decision M2-4), which stay the rule: a
  /// draft becomes active only when its site is validated.
  List<ProjectStatus> get nextStatuses => switch (this) {
        ProjectStatus.draft => const [],
        ProjectStatus.active => const [
            ProjectStatus.paused,
            ProjectStatus.completed,
          ],
        ProjectStatus.paused => const [
            ProjectStatus.active,
            ProjectStatus.completed,
          ],
        ProjectStatus.completed => const [ProjectStatus.archived],
        ProjectStatus.archived => const [],
      };

  /// Calm Ledger tone of the status chip (doc/05-design-system.md): a draft
  /// needs action (accent), an active project is the brand colour.
  Color get color => switch (this) {
        ProjectStatus.draft => customColors.accent,
        ProjectStatus.active => customColors.primary,
        ProjectStatus.paused => customColors.partial,
        ProjectStatus.completed => customColors.verified,
        ProjectStatus.archived => customColors.muted,
      };
}
