import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Localized label of a project type (`_standards/14` §1.3).
extension ProjectTypeX on ProjectType {
  String label(AppLocalizations l10n) => switch (this) {
    ProjectType.newHouse => l10n.projectTypeNewHouse,
    ProjectType.expansion => l10n.projectTypeExpansion,
    ProjectType.renovation => l10n.projectTypeRenovation,
    ProjectType.communityBuilding => l10n.projectTypeCommunityBuilding,
    ProjectType.other => l10n.projectTypeOther,
  };
}
