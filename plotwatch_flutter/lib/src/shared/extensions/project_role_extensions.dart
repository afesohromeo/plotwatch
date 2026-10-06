import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Localized label of a member's role (`_standards/14` §1.3).
extension ProjectRoleX on ProjectRole {
  String label(AppLocalizations l10n) => switch (this) {
        ProjectRole.owner => l10n.projectRoleOwner,
        ProjectRole.coFunder => l10n.projectRoleCoFunder,
        ProjectRole.viewer => l10n.projectRoleViewer,
        ProjectRole.siteManager => l10n.projectRoleSiteManager,
      };
}
