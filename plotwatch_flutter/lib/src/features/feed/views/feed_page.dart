import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// A project's whole activity feed, live: older events load below, new
/// ones appear on top (FEED-01–03, `_standards/14` §3.3; doc/04e M5-7).
class FeedPage extends StatefulWidget {
  const FeedPage({super.key, required this.projectId});

  final int projectId;

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final PagingController<int, ActivityEntry> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(_fetchPage);
  }

  void _fetchPage(int pageKey) {
    if (!mounted) return;
    context.read<FeedBloc>().add(
      FeedEvent.fetchActivity(projectId: widget.projectId, pageKey: pageKey),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void _refresh() =>
      context.read<FeedBloc>().add(const FeedEvent.refreshActivity());

  /// The BLoC's list is the truth: live events on top, then the pages.
  void _show(FeedState state) {
    _pagingController.value = PagingState(
      itemList: state.activity,
      nextPageKey: state.maxActivity ? null : state.activityPageKey,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        leading: BackButton(
          onPressed: () => context.goNamed(
            projectRouteName,
            pathParameters: {'projectId': '${widget.projectId}'},
          ),
        ),
        title: Text(l10n.activityTitle),
      ),
      mobileBody: BlocConsumer<FeedBloc, FeedState>(
        listenWhen: (previous, current) =>
            previous.activityListStatus != current.activityListStatus ||
            previous.activityRefreshController !=
                current.activityRefreshController ||
            previous.liveCount != current.liveCount,
        listener: (context, state) {
          if (state.activityRefreshController) {
            _pagingController.refresh();
            return;
          }
          if (state.activityListStatus == GenericStatus.success) {
            _show(state);
          } else if (state.activityListStatus == GenericStatus.failure) {
            _pagingController.error =
                state.activityListError ?? l10n.errorActivityLoad;
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
                      child: CustomPaginatedList<ActivityEntry>(
                        pagingController: _pagingController,
                        pagedChildBuilderDelegate:
                            PagedChildBuilderDelegate<ActivityEntry>(
                              itemBuilder: (context, entry, index) =>
                                  ActivityTile(entry: entry),
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
                                        l10n.errorActivityLoad,
                                    refreshText: l10n.refresh,
                                    onPressed: _refresh,
                                  ),
                              newPageErrorIndicatorBuilder: (context) =>
                                  ErrorrWidget(
                                    errorMessage:
                                        _pagingController.error?.toString() ??
                                        l10n.errorActivityLoad,
                                    refreshText: l10n.refresh,
                                    onPressed: () => _pagingController
                                        .retryLastFailedRequest(),
                                  ),
                              noItemsFoundIndicatorBuilder: (context) =>
                                  EmptyWidget(
                                    emptyText: l10n.activityEmpty,
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
