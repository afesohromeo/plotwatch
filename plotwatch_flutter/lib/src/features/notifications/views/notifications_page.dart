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

  void _fetchPage(int pageKey) {
    if (!mounted) return;
    context.read<NotificationsBloc>().add(
      NotificationsEvent.fetchNotifications(pageKey: pageKey),
    );
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
        leading: BackButton(onPressed: () => context.goNamed(homeRouteName)),
        title: Text(l10n.notificationsTitle),
        actions: [
          IconButton(
            key: NotificationsPage.markAllReadButtonKey,
            tooltip: l10n.markAllReadAction,
            color: customColors.primary,
            icon: const Icon(Icons.done_all_rounded),
            onPressed: () => bloc.add(const NotificationsEvent.markAllRead()),
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
                    Expanded(
                      child: CustomPaginatedList<AppNotification>(
                        pagingController: _pagingController,
                        pagedChildBuilderDelegate:
                            PagedChildBuilderDelegate<AppNotification>(
                              itemBuilder: (context, notification, index) =>
                                  _NotificationTile(notification: notification),
                              firstPageProgressIndicatorBuilder: (context) =>
                                  LoadingWidget(loadingText: l10n.loading),
                              newPageProgressIndicatorBuilder: (context) =>
                                  const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(AppSpacing.md),
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    ),
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
                                  EmptyWidget(
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

    return InkWell(
      key: NotificationsPage.tileKey(notification.id!),
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xs),
              child: Icon(
                Icons.circle,
                size: 10,
                color: unread ? customColors.primary : Colors.transparent,
              ),
            ),
            const Gap.horizontal(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.sentence(l10n),
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: unread ? FontWeight.w600 : null,
                    ),
                  ),
                  Text(
                    formatDate(
                      notification.createdAt.toLocal(),
                      withTime: true,
                    ),
                    style: context.textTheme.bodySmall,
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
