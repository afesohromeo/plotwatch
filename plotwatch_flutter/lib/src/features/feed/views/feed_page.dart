import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// A project's whole activity feed, live: older events load below, new
/// ones appear on top (FEED-01–03, `_standards/14` §3.3; doc/04e M5-7).
/// Filtered by kind and by stage, on the server for the pages and in the
/// BLoC for live events (doc/05 §9.5).
class FeedPage extends StatefulWidget {
  const FeedPage({super.key, required this.projectId});

  final int projectId;

  /// The kind chips are keyed `activity.kind.<index>`, "All" first.
  static const kindChipsPrefix = 'activity.kind';

  /// The stage picker; its choices are `activity.stage.<index>`, "All
  /// stages" first.
  static const stagePickerPrefix = 'activity.stage';

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

  // The choices, sent with every page (_standards/13, "Filter chips").
  ActivityKind? _kind;
  int? _stageId;

  bool get _filtered => _kind != null || _stageId != null;

  void _fetchPage(int pageKey) {
    if (!mounted) return;
    context.read<FeedBloc>().add(
      FeedEvent.fetchActivity(
        projectId: widget.projectId,
        pageKey: pageKey,
        types: _kind?.types.toList(),
        stageId: _stageId,
      ),
    );
  }

  void _choose({required ActivityKind? kind, required int? stageId}) {
    setState(() {
      _kind = kind;
      _stageId = stageId;
    });
    _refresh();
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
    final stages = projectStagesOf(context);

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        leading: BackButton(
          onPressed: () => context.goNamed(
            projectRouteName,
            pathParameters: {'projectId': '${widget.projectId}'},
          ),
        ),
        title: Text(l10n.activityTitle),
        // "Live · Maison Douala" (doc/05 §9.3).
        subtitle: [l10n.liveLabel, ?projectNameOf(context)].join(' · '),
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
                    FilterChips<ActivityKind?>(
                      keyPrefix: FeedPage.kindChipsPrefix,
                      choices: [
                        FilterChoice(null, l10n.filterAll),
                        for (final kind in ActivityKind.values)
                          FilterChoice(kind, kind.label(l10n)),
                      ],
                      selected: _kind,
                      onSelected: (kind) =>
                          _choose(kind: kind, stageId: _stageId),
                      trailing: [
                        if (stages.isNotEmpty)
                          PickerPill<int?>(
                            keyPrefix: FeedPage.stagePickerPrefix,
                            choices: [
                              FilterChoice(null, l10n.allStages),
                              for (final stage in stages)
                                FilterChoice(stage.id, stage.name),
                            ],
                            selected: _stageId,
                            onSelected: (stageId) =>
                                _choose(kind: _kind, stageId: stageId),
                          ),
                      ],
                    ),
                    const Gap.vertical(height: AppSpacing.md),
                    Expanded(
                      child: CustomPaginatedList<ActivityEntry>(
                        pagingController: _pagingController,
                        pagedChildBuilderDelegate:
                            PagedChildBuilderDelegate<ActivityEntry>(
                              // Grouped by day, each event a card
                              // (doc/05 §9).
                              itemBuilder: (context, entry, index) {
                                final items =
                                    _pagingController.itemList ?? const [];
                                final heading =
                                    index == 0 ||
                                    (index - 1 < items.length &&
                                        !sameDay(
                                          items[index - 1].event.createdAt,
                                          entry.event.createdAt,
                                        ));
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
                                          dayHeading(
                                            entry.event.createdAt,
                                            l10n,
                                          ),
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
                                      child: AppCard(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 2,
                                        ),
                                        child: ActivityTile(
                                          entry: entry,
                                          rich: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
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
                                  _filtered
                                  ? EmptyWidget(
                                      emptyText: l10n.noMatches,
                                      actionText: l10n.clearFilters,
                                      onPressed: () =>
                                          _choose(kind: null, stageId: null),
                                    )
                                  : EmptyWidget(
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
