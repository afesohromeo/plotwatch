import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Error dialog of the design system (doc/05-design-system.md §5), shown
/// through `DialogUtils.handleFailure`. The button closes the dialog unless
/// [onPressed] is given; [refreshText] replaces its label.
class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.message,
    this.onPressed,
    this.refreshText,
    required this.parentContext,
  });

  final VoidCallback? onPressed;
  final String? refreshText;
  final String message;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    return StatusDialog(
      icon: Icons.close_rounded,
      iconColor: customColors.unverified,
      iconBackground: customColors.unverifiedSoft,
      message: message,
      buttonLabel: refreshText,
      onPressed: onPressed,
    );
  }
}

/// Shared layout of the error and success dialogs.
class StatusDialog extends StatelessWidget {
  const StatusDialog({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.message,
    this.buttonLabel,
    this.onPressed,
  });

  static const iconCircleKey = Key('statusDialog.iconCircle');

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String message;
  final String? buttonLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      contentPadding: const EdgeInsets.all(AppSpacing.lg),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                key: iconCircleKey,
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: iconBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 30),
              ),
            ),
            const Gap.vertical(height: AppSpacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge,
            ),
            const Gap.vertical(height: AppSpacing.lg),
            SizedBox(
              height: PlotwatchTheme.controlHeight,
              child: FilledButton(
                onPressed: onPressed ?? () => Navigator.of(context).pop(),
                child: Text(buttonLabel ?? l10n.ok),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
