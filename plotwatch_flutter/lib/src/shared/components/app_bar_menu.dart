import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// One entry of an [AppBarMenu]; [key] goes on its menu item.
class AppBarMenuItem {
  const AppBarMenuItem({
    required this.label,
    required this.onTap,
    this.icon,
    this.key,
    this.destructive = false,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final Key? key;

  /// Shown in the error colour (delete, remove).
  final bool destructive;
}

/// A page's app bar actions (doc/05 §9.3, §9.4): a single action is its own
/// icon button; two or more go behind a ⋮. A menu with a single entry is
/// never shown.
class AppBarMenu extends StatelessWidget {
  const AppBarMenu({super.key, required this._items});

  final List<AppBarMenuItem> _items;

  static const buttonKey = Key('appBar.more');

  /// Up to this many actions show as icon buttons.
  static const inline = 1;

  @override
  Widget build(BuildContext context) {
    final items = _items;
    if (items.isEmpty) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context)!;
    if (items.length <= inline) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final item in items)
            IconButton(
              key: item.key,
              tooltip: item.label,
              color: item.destructive
                  ? customColors.unverified
                  : customColors.ink,
              icon: Icon(item.icon ?? Icons.more_horiz_rounded),
              onPressed: item.onTap,
            ),
        ],
      );
    }
    return PopupMenuButton<int>(
      key: buttonKey,
      tooltip: l10n.moreActions,
      icon: Icon(Icons.more_vert_rounded, color: customColors.ink),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: customColors.surfaceWhite,
      surfaceTintColor: Colors.transparent,
      onSelected: (index) => items[index].onTap(),
      itemBuilder: (context) => [
        for (var i = 0; i < items.length; i++)
          PopupMenuItem<int>(
            key: items[i].key,
            value: i,
            child: Row(
              children: [
                if (items[i].icon case final icon?) ...[
                  Icon(
                    icon,
                    size: 20,
                    color: items[i].destructive
                        ? customColors.unverified
                        : customColors.ink,
                  ),
                  const Gap.horizontal(width: AppSpacing.sm),
                ],
                Text(
                  items[i].label,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: items[i].destructive
                        ? customColors.unverified
                        : customColors.ink,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
