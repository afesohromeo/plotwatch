import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// One feed event: what happened, who, when; tapping opens what it is
/// about (FEED-01, doc/04e M5-7).
class ActivityTile extends StatelessWidget {
  const ActivityTile({super.key, required this.entry, this.rich = false});

  final ActivityEntry entry;

  /// The Activity tab's richer rows: updates as posts, photos with their
  /// thumbnail and badge (doc/05 §9.3).
  final bool rich;

  static Key keyFor(int id) => Key('activity.$id');

  /// Icon and background by kind of event (doc/05 §9): approvals in green,
  /// what needs someone and photos in terracotta, news in ink.
  static (Color, Color) _tone(ActivityType type) => switch (type) {
    ActivityType.stageApproved => (
      customColors.verified,
      customColors.verifiedSoft,
    ),
    ActivityType.stageSubmitted ||
    ActivityType.stageChangesRequested ||
    ActivityType.evidenceCaptured ||
    ActivityType.evidenceRetracted => (
      customColors.accent,
      customColors.accentSoft,
    ),
    ActivityType.progressUpdatePosted => (
      customColors.onPrimary,
      customColors.ink,
    ),
    _ => (customColors.primary, customColors.primarySoft),
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final source = entry.source;

    final open = source == null
        ? null
        : () => context.goNamed(
            source.name,
            pathParameters: source.pathParameters,
          );
    final event = entry.event;
    final payload = event.payload ?? const <String, String>{};
    final timeStyle = context.textTheme.bodySmall?.copyWith(fontSize: 12);
    final text = context.textTheme.bodyMedium?.copyWith(
      color: customColors.ink,
      fontSize: 14,
      height: 1.4,
    );

    if (rich && event.type == ActivityType.progressUpdatePosted) {
      final actor = entry.actorName ?? l10n.someone;
      return InkWell(
        key: keyFor(event.id!),
        onTap: open,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: customColors.ink,
                child: Text(
                  initialsOf(actor),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: customColors.onPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Gap.horizontal(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: actor,
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                          TextSpan(text: ' ${l10n.postedAnUpdate}'),
                          TextSpan(
                            text: ' · ${dayAndTime(event.createdAt, l10n)}',
                            style: timeStyle,
                          ),
                        ],
                      ),
                      style: text,
                    ),
                    if (payload['excerpt'] case final excerpt?)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(excerpt, style: text),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    final photoId = event.targetId;
    final level = VerificationLevel.values
        .asNameMap()[payload['verificationLevel']];
    if (rich &&
        event.type == ActivityType.evidenceCaptured &&
        photoId != null &&
        payload['stageId'] != null) {
      return InkWell(
        key: keyFor(event.id!),
        onTap: open,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: EvidenceImage(
                  projectId: event.projectId,
                  evidenceId: photoId,
                  variant: MediaVariant.thumbnail,
                  width: 56,
                  height: 56,
                ),
              ),
              const Gap.horizontal(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.sentence(l10n), style: text),
                    if (level != null) ...[
                      const Gap.vertical(height: 4),
                      VerificationBadge(level: level),
                    ],
                    const Gap.vertical(height: 2),
                    Text(dayAndTime(event.createdAt, l10n), style: timeStyle),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return InkWell(
      key: keyFor(entry.event.id!),
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      onTap: open,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: _tone(entry.event.type).$2,
              child: Icon(
                entry.icon,
                size: 18,
                color: _tone(entry.event.type).$1,
              ),
            ),
            const Gap.horizontal(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.sentence(l10n),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: customColors.ink,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  Text(
                    dayAndTime(entry.event.createdAt, l10n),
                    style: context.textTheme.bodySmall?.copyWith(fontSize: 12),
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
