import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The notification centre: newest first, live, mark one or all read; tap
/// opens what it is about (NOT-01, `_standards/14` §3.3; doc/04e M5-4).
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  static const markAllReadButtonKey = Key('notifications.markAllRead');

  static Key tileKey(int id) => Key('notification.$id');

  /// The All / Unread chips (doc/05 §9.5): `notifications.filter.0`, `.1`.
  static const filterChipsPrefix = 'notifications.filter';

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final PagingController<int, AppNotification> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(_fetchPage);
  }

  /// Only the unread ones, on the server (doc/05 §9.5). One read by tapping
  /// it stays until the list is refreshed, so nothing moves under the
  /// finger.
  bool _unreadOnly = false;

  void _fetchPage(int pageKey) {
    if (!mounted) return;
    context.read<NotificationsBloc>().add(
      NotificationsEvent.fetchNotifications(
        pageKey: pageKey,
        unreadOnly: _unreadOnly,
      ),
    );
  }

  void _chooseUnread(bool unreadOnly) {
    setState(() => _unreadOnly = unreadOnly);
    _refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void _refresh() => context.read<NotificationsBloc>().add(
    const NotificationsEvent.refreshNotifications(),
  );

  /// The BLoC's list is the truth: live ones on top, then the pages.
  void _show(NotificationsState state) {
    _pagingController.value = PagingState(
      itemList: state.notifications,
      nextPageKey: state.maxNotifications ? null : state.notificationsPageKey,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<NotificationsBloc>();

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        // Back to the page the bell was tapped on; home when opened directly.
        leading: BackButton(
          onPressed: () =>
              context.canPop() ? context.pop() : context.goNamed(homeRouteName),
        ),
        title: Text(l10n.notificationsTitle),
        showBell: false,
        actions: [
          TextButton(
            key: NotificationsPage.markAllReadButtonKey,
            onPressed: () => bloc.add(const NotificationsEvent.markAllRead()),
            child: Text(l10n.markAllReadAction),
          ),
        ],
      ),
      mobileBody: BlocConsumer<NotificationsBloc, NotificationsState>(
        listenWhen: (previous, current) =>
            previous.notificationsListStatus !=
                current.notificationsListStatus ||
            previous.notificationsRefreshController !=
                current.notificationsRefreshController ||
            previous.revision != current.revision,
        listener: (context, state) {
          if (state.notificationsRefreshController) {
            _pagingController.refresh();
            return;
          }
          if (state.notificationsListStatus == GenericStatus.success) {
            _show(state);
          } else if (state.notificationsListStatus == GenericStatus.failure) {
            _pagingController.error =
                state.notificationsListError ?? l10n.errorNotificationsLoad;
          }
        },
        buildWhen: (previous, current) =>
            previous.reconnecting != current.reconnecting,
        builder: (context, state) => RefreshIndicator(
          onRefresh: () async => _refresh(),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AuthFormLayout.maxWidth * 2,
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  children: [
                    if (state.reconnecting) const ReconnectingLine(),
                    FilterChips<bool>(
                      keyPrefix: NotificationsPage.filterChipsPrefix,
                      choices: [
                        FilterChoice(false, l10n.filterAll),
                        FilterChoice(true, l10n.notificationsUnread),
                      ],
                      selected: _unreadOnly,
                      onSelected: _chooseUnread,
                    ),
                    const Gap.vertical(height: AppSpacing.md),
                    Expanded(
                      child: CustomPaginatedList<AppNotification>(
                        pagingController: _pagingController,
                        pagedChildBuilderDelegate:
                            PagedChildBuilderDelegate<AppNotification>(
                              // "New", then "Earlier" (doc/05 §9).
                              itemBuilder: (context, notification, index) {
                                final items =
                                    _pagingController.itemList ?? const [];
                                final previous =
                                    index > 0 && index - 1 < items.length
                                    ? items[index - 1]
                                    : null;
                                final heading =
                                    previous == null ||
                                    previous.isUnread != notification.isUnread;
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    if (heading)
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: index == 0 ? 0 : AppSpacing.sm,
                                          bottom: AppSpacing.sm,
                                          left: AppSpacing.xs,
                                        ),
                                        child: Text(
                                          notification.isUnread
                                              ? l10n.notificationsNew
                                              : l10n.notificationsEarlier,
                                          style: context.textTheme.labelMedium
                                              ?.copyWith(
                                                color: customColors.muted,
                                              ),
                                        ),
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: AppSpacing.sm,
                                      ),
                                      child: _NotificationTile(
                                        notification: notification,
                                      ),
                                    ),
                                  ],
                                );
                              },
                              firstPageProgressIndicatorBuilder: (context) =>
                                  const RowsSkeleton(),
                              newPageProgressIndicatorBuilder: (context) =>
    const Padding(
      padding: EdgeInsets.only(top: AppSpacing.sm),
      child: RowsSkeleton(count: 2),
    ),
                              firstPageErrorIndicatorBuilder: (context) =>
                                  ErrorrWidget(
                                    errorMessage:
                                        _pagingController.error?.toString() ??
                                        l10n.errorNotificationsLoad,
                                    refreshText: l10n.refresh,
                                    onPressed: _refresh,
                                  ),
                              newPageErrorIndicatorBuilder: (context) =>
                                  ErrorrWidget(
                                    errorMessage:
                                        _pagingController.error?.toString() ??
                                        l10n.errorNotificationsLoad,
                                    refreshText: l10n.refresh,
                                    onPressed: () => _pagingController
                                        .retryLastFailedRequest(),
                                  ),
                              noItemsFoundIndicatorBuilder: (context) =>
                                  _unreadOnly
                                  ? EmptyWidget(
                                      emptyText: l10n.noMatches,
                                      actionText: l10n.clearFilters,
                                      onPressed: () => _chooseUnread(false),
                                    )
                                  : EmptyWidget(
                                      emptyText: l10n.notificationsEmpty,
                                      onPressed: _refresh,
                                    ),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification});

  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final unread = notification.isUnread;
    final source = notification.source;

    // A card, outlined while unread (doc/05 §9).
    return AppCard(
      key: NotificationsPage.tileKey(notification.id!),
      borderColor: unread ? customColors.primary : null,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      onTap: () {
        if (unread) {
          context.read<NotificationsBloc>().add(
            NotificationsEvent.markRead(notification.id!),
          );
        }
        if (source != null) {
          context.goNamed(source.name, pathParameters: source.pathParameters);
        }
      },
      // The design's row (doc/05 §9.3): an icon tile by kind, the sentence
      // in bold while unread, the project and the time, the unread dot.
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconTile(
              icon: switch (notification.type) {
                NotificationType.stageSubmitted => Icons.rate_review_outlined,
                NotificationType.stageApproved => Icons.check_rounded,
                NotificationType.stageChangesRequested => Icons.replay_rounded,
                NotificationType.memberJoined =>
                  Icons.person_add_alt_1_outlined,
                NotificationType.progressUpdatePosted =>
                  Icons.campaign_outlined,
                NotificationType.fundReleased ||
                NotificationType.releaseConfirmed => Icons.payments_outlined,
                NotificationType.expenseRecorded =>
                  Icons.receipt_long_outlined,
                NotificationType.entryReversed => Icons.undo_rounded,
              },
              color: switch (notification.type) {
                NotificationType.stageSubmitted => customColors.accent,
                NotificationType.stageApproved => customColors.verified,
                NotificationType.stageChangesRequested => customColors.partial,
                _ => customColors.primary,
              },
              background: switch (notification.type) {
                NotificationType.stageSubmitted => customColors.accentSoft,
                NotificationType.stageApproved => customColors.verifiedSoft,
                NotificationType.stageChangesRequested =>
                  customColors.partialSoft,
                _ => customColors.primarySoft,
              },
            ),
            const Gap.horizontal(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.sentence(l10n),
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontSize: 15,
                      fontWeight: unread ? FontWeight.w800 : FontWeight.w500,
                    ),
                  ),
                  const Gap.vertical(height: 2),
                  Text(
                    [
                      ?notification.payload?['projectName'],
                      dayAndTime(notification.createdAt, l10n),
                    ].join(' · '),
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            if (unread)
              Padding(
                padding: const EdgeInsets.only(left: AppSpacing.sm, top: 4),
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: customColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
