import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The project's progress at a glance, on teal (doc/05 §9): the big
/// percentage with its caption, the stage bar, and a row of figures.
class HeroProgress extends StatelessWidget {
  const HeroProgress({
    super.key,
    required this.headline,
    required this.caption,
    required this.statuses,
    required this.stagesSemanticLabel,
    required this.figures,
  });

  /// E.g. "62%", or "2 / 4" when no stage has a budget.
  final String headline;
  final String caption;
  final List<StageStatus> statuses;
  final String stagesSemanticLabel;

  /// Label and value pairs, e.g. ("Budget", "12.5 M XAF").
  final List<(String, String)> figures;

  @override
  Widget build(BuildContext context) {
    final soft = customColors.surfaceWhite.withValues(alpha: .78);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: customColors.primary,
        borderRadius: BorderRadius.circular(PlotwatchTheme.heroRadius),
        boxShadow: [
          BoxShadow(
            color: customColors.primary.withValues(alpha: .22),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            spacing: AppSpacing.sm,
            children: [
              Text(
                headline,
                style: context.textTheme.displaySmall?.copyWith(
                  color: customColors.onPrimary,
                  height: 1,
                ),
              ),
              Text(
                caption,
                style: context.textTheme.bodyMedium?.copyWith(color: soft),
              ),
            ],
          ),
          const Gap.vertical(height: 14),
          StageBar(
            statuses: statuses,
            semanticLabel: stagesSemanticLabel,
            onDark: true,
          ),
          if (figures.isNotEmpty) ...[
            const Gap.vertical(height: 14),
            Divider(color: customColors.surfaceWhite.withValues(alpha: .18)),
            const Gap.vertical(height: 10),
            Row(
              children: [
                for (final (label, value) in figures)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: soft,
                          ),
                        ),
                        Text(
                          value,
                          style: context.textTheme.titleMedium?.copyWith(
                            color: customColors.onPrimary,
                            fontWeight: FontWeight.w800,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
