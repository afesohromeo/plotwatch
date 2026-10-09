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
        color: customColors.primary,
        onPressed: () => context.goNamed(notificationsRouteName),
        icon: Badge(
          isLabelVisible: unread > 0,
          label: Text(unread > 99 ? '99+' : '$unread'),
          child: Icon(
            unread > 0
                ? Icons.notifications_rounded
                : Icons.notifications_none_rounded,
          ),
        ),
      ),
    );
  }
}
