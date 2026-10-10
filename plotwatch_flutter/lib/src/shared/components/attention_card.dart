import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Something waiting for the user, in terracotta (doc/05 §9 DP-1): "Walls
/// is waiting for your review". Taps through to it.
class AttentionCard extends StatelessWidget {
  const AttentionCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon = Icons.rate_review_outlined,
    required this.onTap,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          IconTile(
            icon: icon,
            color: customColors.accent,
            background: customColors.accentSoft,
          ),
          const Gap.horizontal(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.textTheme.titleSmall),
                if (subtitle != null)
                  Text(subtitle!, style: context.textTheme.bodySmall),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: customColors.muted),
        ],
      ),
    );
  }
}

/// A 40 px rounded square with an icon: the leading mark of a card row.
class IconTile extends StatelessWidget {
  const IconTile({
    super.key,
    required this.icon,
    required this.color,
    required this.background,
    this.size = 40,
  });

  final IconData icon;
  final Color color;
  final Color background;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(size * .3),
      ),
      child: Icon(icon, color: color, size: size / 2),
    );
  }
}
