import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// One feed event: what happened, who, when; tapping opens what it is
/// about (FEED-01, doc/04e M5-7).
class ActivityTile extends StatelessWidget {
  const ActivityTile({super.key, required this.entry});

  final ActivityEntry entry;

  static Key keyFor(int id) => Key('activity.$id');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final source = entry.source;

    return InkWell(
      key: keyFor(entry.event.id!),
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      onTap: source == null
          ? null
          : () => context.goNamed(
              source.name,
              pathParameters: source.pathParameters,
            ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: customColors.primary.withValues(alpha: .1),
              child: Icon(entry.icon, size: 18, color: customColors.primary),
            ),
            const Gap.horizontal(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.sentence(l10n),
                    style: context.textTheme.bodyMedium,
                  ),
                  Text(
                    formatDate(entry.event.createdAt.toLocal(), withTime: true),
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// "Reconnecting…" while a live stream is down (doc/04e M5-6).
class ReconnectingLine extends StatelessWidget {
  const ReconnectingLine({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          const SizedBox.square(
            dimension: 12,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const Gap.horizontal(width: AppSpacing.sm),
          Text(l10n.reconnecting, style: context.textTheme.bodySmall),
        ],
      ),
    );
  }
}
