import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// One segment per stage, in plan order, coloured by its status (doc/05
/// §9): approved in green, submitted or sent back in terracotta (it needs
/// someone), in progress in a light primary, not started as a track. On the
/// teal hero ([onDark]) the same meanings use white tones. Status is never
/// shown by colour alone: callers give [semanticLabel] and a text line.
class StageBar extends StatelessWidget {
  const StageBar({
    super.key,
    required this.statuses,
    required this.semanticLabel,
    this.onDark = false,
    this.height = 8,
  });

  final List<StageStatus> statuses;
  final String semanticLabel;
  final bool onDark;
  final double height;

  static Color colorOf(StageStatus status, {bool onDark = false}) =>
      switch (status) {
        StageStatus.approved =>
          onDark ? customColors.surfaceWhite : customColors.verified,
        StageStatus.submitted || StageStatus.changesRequested =>
          onDark ? customColors.accentOnDark : customColors.accent,
        StageStatus.inProgress =>
          onDark
              ? customColors.surfaceWhite.withValues(alpha: .55)
              : customColors.primary.withValues(alpha: .45),
        StageStatus.notStarted =>
          onDark
              ? customColors.surfaceWhite.withValues(alpha: .25)
              : customColors.line,
      };

  @override
  Widget build(BuildContext context) {
    if (statuses.isEmpty) return const SizedBox.shrink();
    return Semantics(
      label: semanticLabel,
      child: ExcludeSemantics(
        child: Row(
          children: [
            for (var i = 0; i < statuses.length; i++) ...[
              if (i > 0) const SizedBox(width: 4),
              Expanded(
                child: Container(
                  key: ValueKey('stageBar.$i'),
                  height: height,
                  decoration: BoxDecoration(
                    color: colorOf(statuses[i], onDark: onDark),
                    borderRadius: BorderRadius.circular(height / 2),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
