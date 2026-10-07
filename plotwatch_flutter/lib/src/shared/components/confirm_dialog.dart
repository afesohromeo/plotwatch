import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Asks before a destructive action (e.g. removing a member). Returns `true`
/// when the user confirms. Styled by the theme's dialog settings.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
}) async {
  final l10n = AppLocalizations.of(context)!;
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: customColors.unverified,
            minimumSize: const Size(0, 44),
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.confirm),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
