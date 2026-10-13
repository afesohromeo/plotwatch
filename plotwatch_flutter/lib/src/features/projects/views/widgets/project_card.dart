import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// One project of the list (PROJ-03; doc/05 §9): its latest photo as the
/// cover, name, type and the user's role, status, the stage bar, the
/// progress, and what waits for the user.
class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.summary,
    required this.onTap,
    this.compactWhenClosed = true,
  });

  final ProjectSummary summary;
  final VoidCallback onTap;

  /// In the phone list a paused or closed project gets the compact card; in
  /// the grid every card has its cover (doc/05 §9.3).
  final bool compactWhenClosed;

  static const coverHeight = 128.0;
  static Key attentionKey(int projectId) =>
      Key('projectCard.attention.$projectId');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final project = summary.project;
    final stages = summary.stages ?? const <StageBrief>[];
    final approved = stages
        .where((s) => s.status == StageStatus.approved)
        .length;
    final attention = attentionFor(
      stages: stages,
      role: summary.myRole,
      canApprove: summary.myCanApprove,
    );
    final cover = summary.latestEvidenceId;
    final line = progressLine(
      l10n,
      percent: summary.progressPercent,
      approved: approved,
      total: stages.length,
      budgetTotalMinor: summary.budgetTotalMinor,
    );

    // Paused, completed or archived: the design's compact card.
    if (compactWhenClosed &&
        project.status != ProjectStatus.active &&
        project.status != ProjectStatus.draft) {
      return _CompactCard(
        summary: summary,
        approved: approved,
        total: stages.length,
        onTap: onTap,
      );
    }

    // In the grid every cell has the same height: the cover takes what the
    // content leaves, so no card ends with empty white (developer,
    // 2026-10-12).
    final fill = !compactWhenClosed;
    Widget coverArea(Widget child) => ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(PlotwatchTheme.cardRadius),
      ),
      child: fill
          ? child
          : SizedBox(height: coverHeight, child: child),
    );
    final coverImage = cover == null
        ? null
        : coverArea(
            Stack(
                  fit: StackFit.expand,
                  children: [
                    EvidenceImage(
                      projectId: project.id!,
                      evidenceId: cover,
                      variant: MediaVariant.thumbnail,
                    ),
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: _PhotoLabel(text: l10n.latestPhoto),
                    ),
                    if (summary.latestEvidenceLevel case final level?)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: VerificationBadge(
                          level: level,
                          onPhoto: true,
                        ),
                      ),
                  ],
                ),
          );

    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: fill ? MainAxisSize.max : MainAxisSize.min,
        children: [
          if (fill)
            Expanded(child: coverImage ?? coverArea(const NoPhotoYet()))
          else
            ?coverImage,
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.name,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${project.type.label(l10n)} · '
                            '${summary.myRole.label(l10n)}',
                            style: context.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const Gap.horizontal(width: AppSpacing.sm),
                    ProjectChip(
                      label: project.status.label(l10n),
                      color: project.status.color,
                    ),
                  ],
                ),
                if (stages.isNotEmpty) ...[
                  const Gap.vertical(height: 12),
                  StageBar(
                    statuses: [for (final s in stages) s.status],
                    semanticLabel: line,
                  ),
                  const Gap.vertical(height: 10),
                  _ProgressRow(
                    summary: summary,
                    approved: approved,
                    total: stages.length,
                  ),
                ],
                if (attention != null) ...[
                  const Gap.vertical(height: 12),
                  Container(
                    key: attentionKey(project.id!),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: customColors.accentSoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          attention.review
                              ? Icons.rate_review_outlined
                              : Icons.replay_rounded,
                          size: 16,
                          color: customColors.accent,
                        ),
                        const Gap.horizontal(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            attention.review
                                ? l10n.attentionReview(
                                    attention.count,
                                    attention.first.name,
                                  )
                                : l10n.attentionChanges(
                                    attention.count,
                                    attention.first.name,
                                  ),
                            style: context.textTheme.bodySmall?.copyWith(
                              color: customColors.accent,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A project that isn't under way: side photo, name and status, the stage
/// bar, role and progress on one line (doc/05 §9.3).
class _CompactCard extends StatelessWidget {
  const _CompactCard({
    required this.summary,
    required this.approved,
    required this.total,
    required this.onTap,
  });

  final ProjectSummary summary;
  final int approved;
  final int total;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final project = summary.project;
    final cover = summary.latestEvidenceId;
    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(PlotwatchTheme.cardRadius),
              ),
              // Positioned: the photo fills the height the text sets,
              // never the other way round (developer, 2026-10-12).
              child: SizedBox(
                width: 104,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: cover == null
                          ? const NoPhotoYet(iconSize: 28)
                          : EvidenceImage(
                              projectId: project.id!,
                              evidenceId: cover,
                              variant: MediaVariant.thumbnail,
                            ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            project.name,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Gap.horizontal(width: AppSpacing.sm),
                        ProjectChip(
                          label: project.status.label(l10n),
                          color: project.status.color,
                        ),
                      ],
                    ),
                    if ((summary.stages ?? const []).isNotEmpty) ...[
                      const Gap.vertical(height: 10),
                      StageBar(
                        statuses: [for (final s in summary.stages!) s.status],
                        semanticLabel: l10n.progressStagesOnly(approved, total),
                        height: 6,
                      ),
                    ],
                    const Gap.vertical(height: 8),
                    Text(
                      [
                        summary.myRole.label(l10n),
                        if (summary.budgetTotalMinor > 0)
                          '${summary.progressPercent}%',
                        l10n.progressStagesOnly(approved, total),
                      ].join(' · '),
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// "62% of the budget" on the left, "2 of 4 stages approved" on the right;
/// with no budget, only the count (doc/04e M5-F2).
class _ProgressRow extends StatelessWidget {
  const _ProgressRow({
    required this.summary,
    required this.approved,
    required this.total,
  });

  final ProjectSummary summary;
  final int approved;
  final int total;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final count = Text(
      l10n.progressStagesOnly(approved, total),
      style: context.textTheme.bodySmall,
    );
    if (summary.budgetTotalMinor <= 0) return count;
    return Row(
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${summary.progressPercent}% ',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(text: l10n.ofTheBudget),
              ],
            ),
            style: context.textTheme.bodySmall,
          ),
        ),
        count,
      ],
    );
  }
}

/// Where a project's photo goes before it has one: the brand's soft tint
/// with a house, so it reads as a placeholder and not as the page.
class NoPhotoYet extends StatelessWidget {
  const NoPhotoYet({super.key, this.iconSize = 36});

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: customColors.primarySoft,
      child: Center(
        child: Icon(
          Icons.home_work_outlined,
          size: iconSize,
          color: customColors.primary.withValues(alpha: .55),
        ),
      ),
    );
  }
}

/// A dark caption over a photo.
class _PhotoLabel extends StatelessWidget {
  const _PhotoLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: customColors.ink.withValues(alpha: .72),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: context.textTheme.labelSmall?.copyWith(
          color: customColors.onPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// A small label (role, status) in the Calm Ledger style.
class ProjectChip extends StatelessWidget {
  const ProjectChip({super.key, required this.label, this.color});

  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tone = color ?? customColors.muted;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: context.textTheme.labelMedium?.copyWith(color: tone),
      ),
    );
  }
}
