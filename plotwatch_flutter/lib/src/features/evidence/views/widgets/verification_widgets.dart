import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// A capture's badge: its level with an icon (VER-02, VER-03).
class VerificationBadge extends StatelessWidget {
  const VerificationBadge({super.key, required this.level});

  final VerificationLevel level;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tone = level.color;
    final icon = switch (level) {
      VerificationLevel.verified => Icons.verified_rounded,
      VerificationLevel.partiallyVerified => Icons.error_outline_rounded,
      VerificationLevel.unverified => Icons.gpp_bad_outlined,
      VerificationLevel.pending => Icons.hourglass_top_rounded,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: tone),
          const Gap.horizontal(width: AppSpacing.xs),
          // Shortened rather than overflowing in a narrow photo tile.
          Flexible(
            child: Text(
              level.label(l10n),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelMedium?.copyWith(color: tone),
            ),
          ),
        ],
      ),
    );
  }
}

/// Each check with its explanation (VER-03): passed, failed (critical) or
/// failed (non-critical).
class VerificationBreakdown extends StatelessWidget {
  const VerificationBreakdown({super.key, required this.checks});

  final List<VerificationCheck> checks;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final check in checks)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  check.passed
                      ? Icons.check_circle_rounded
                      : Icons.cancel_rounded,
                  size: 20,
                  color: check.passed
                      ? customColors.verified
                      : check.critical
                      ? customColors.unverified
                      : customColors.partial,
                ),
                const Gap.horizontal(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        check.title(l10n),
                        style: context.textTheme.titleSmall,
                      ),
                      Text(
                        check.explanation(l10n),
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
