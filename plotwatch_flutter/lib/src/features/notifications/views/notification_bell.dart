import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The bell with the unread count, live (NOT-01, doc/04e M5-4).
class NotificationBell extends StatelessWidget {
  const NotificationBell({super.key});

  static const buttonKey = Key('notifications.bell');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocSelector<NotificationsBloc, NotificationsState, int>(
      selector: (state) => state.unreadCount,
      builder: (context, unread) => IconButton(
        key: buttonKey,
        tooltip: l10n.notificationsTitle,
        color: customColors.ink,
        // On top of the current page, so Back returns there (developer,
        // 2026-10-10).
        onPressed: () => context.pushNamed(notificationsRouteName),
        // The design: an ink outline bell with a red count (doc/05 §9.3).
        icon: Badge(
          isLabelVisible: unread > 0,
          backgroundColor: customColors.unverified,
          textColor: customColors.onPrimary,
          label: Text(
            unread > 99 ? '99+' : '$unread',
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
          ),
          child: const Icon(Icons.notifications_none_rounded),
        ),
      ),
    );
  }
}
