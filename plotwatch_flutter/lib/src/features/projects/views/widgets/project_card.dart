import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// One row of the project list: name, the user's role and the status
/// (PROJ-03).
class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.summary, required this.onTap});

  final ProjectSummary summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final project = summary.project;

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(project.name, style: context.textTheme.titleMedium),
              const Gap.vertical(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.xs,
                children: [
                  ProjectChip(label: summary.myRole.label(l10n)),
                  ProjectChip(
                    label: project.status.label(l10n),
                    color: project.status.color,
                  ),
                ],
              ),
            ],
          ),
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
