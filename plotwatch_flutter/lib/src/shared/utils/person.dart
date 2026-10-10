import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// A person's name, marked when they have left the project: what they did
/// stays on record (doc/04e C-2d).
String personLabel(AppLocalizations l10n, String name, {bool? former}) =>
    former ?? false ? l10n.formerMemberName(name) : name;
