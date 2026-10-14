import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The Money tab (doc/04f M6-10; canvas M-Money, M-WebMoney): what was
/// released against the budget, spent, with a receipt, and unaccounted
/// (highlighted above 20 %, LED-05); the same per stage; then the entries,
/// newest first, filtered by kind and stage on the server. Live.
class MoneyPage extends StatefulWidget {
  const MoneyPage({super.key, required this.projectId});

  final int projectId;

  static const recordButtonKey = Key('money.record');
  static const refreshButtonKey = Key('money.refresh');
  static const alertKey = Key('money.alert');
  static const leftKey = Key('money.left');

  /// The phone's switch: Entries (`segment.0`) · By stage (`segment.1`).
  static Key panelKey(int index) => SegmentedSwitch.segmentKey(index);
  static Key stageLineKey(int stageId) => Key('money.stageLine.$stageId');

  /// The kind chips: `money.kind.0` (All), `.1` (Releases), `.2` (Expenses).
  static const kindChipsPrefix = 'money.kind';

  /// The stage picker; its choices are `money.stage.<index>`.
  static const stagePickerPrefix = 'money.stage';

  /// From this width of the page's body, the web layout (canvas
  /// M-WebMoney).
  static const webFrom = 1100.0;

  @override
  State<MoneyPage> createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  final PagingController<int, LedgerEntry> _pagingController =
      PagingController(firstPageKey: 0);

  // The choices, sent with every page (_standards/13, "Filter chips").
  LedgerEntryKind? _kind;

  /// On a phone, the entries (0) or the stages (1), one at a time: a long
  /// plan doesn't push the entries down (developer, 2026-10-12).
  int _panel = 0;
  int? _stageId;

  bool get _filtered => _kind != null || _stageId != null;

  @override
  void initState() {
    super.initState();
    _load();
    _pagingController.addPageRequestListener(_fetchPage);
  }

  void _load() =>
      context.read<MoneyBloc>().add(MoneyEvent.load(projectId: widget.projectId));

  void _fetchPage(int pageKey) {
    if (!mounted) return;
    context.read<MoneyBloc>().add(
      MoneyEvent.fetchEntries(
        projectId: widget.projectId,
        pageKey: pageKey,
        kind: _kind,
        stageId: _stageId,
      ),
    );
  }

  void _refresh() {
    _load();
    context.read<MoneyBloc>().add(const MoneyEvent.refreshEntries());
  }

  void _choose({required LedgerEntryKind? kind, required int? stageId}) {
    setState(() {
      _kind = kind;
      _stageId = stageId;
    });
    context.read<MoneyBloc>().add(const MoneyEvent.refreshEntries());
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  /// The BLoC's list is the truth (as on the Activity page).
  void _show(MoneyState state) {
    _pagingController.value = PagingState(
      itemList: state.entries,
      nextPageKey: state.maxEntries ? null : state.entriesPageKey,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final overview = projectOverviewOf(context);
    final code = overview?.project.currencyCode ?? 'XAF';
    final role = overview?.myRole;
    final open = overview != null && !overview.project.status.isClosed;
    final canRelease =
        open &&
        (role == ProjectRole.owner ||
            (role == ProjectRole.coFunder && overview.myCanApprove));
    final canExpense = open && role == ProjectRole.siteManager;
    final path = {'projectId': '${widget.projectId}'};

    // Back from a form or an entry: what changed shows (doc/04b H-1a).
    return ReloadOnReturn(
      onReturn: _refresh,
      child: BlocConsumer<MoneyBloc, MoneyState>(
        listenWhen: (previous, current) =>
            previous.entriesListStatus != current.entriesListStatus ||
            previous.entriesRefreshController !=
                current.entriesRefreshController,
        listener: (context, state) {
          if (state.entriesRefreshController) {
            _pagingController.refresh();
            return;
          }
          if (state.entriesListStatus == GenericStatus.success) {
            _show(state);
          } else if (state.entriesListStatus == GenericStatus.failure) {
            _pagingController.error =
                state.entriesListError ?? l10n.errorLedgerLoad;
          }
        },
        buildWhen: (previous, current) =>
            previous.summary != current.summary ||
            previous.summaryStatus != current.summaryStatus ||
            previous.reconnecting != current.reconnecting,
        builder: (context, state) {
          final summary = state.summary;
          return ResponsiveScaffoldWrapper(
            props: ScaffoldWrapperProps(
              leading: BackButton(
                onPressed: () =>
                    context.goNamed(projectRouteName, pathParameters: path),
              ),
              title: Text(l10n.moneyTab),
              subtitle: summary == null
                  ? projectNameOf(context)
                  : l10n.moneySubtitle(
                      projectNameOf(context) ?? '',
                      formatMoney(summary.total.budgetMinor, code),
                    ),
              actions: [
                AppBarMenu(
                  items: [
                    AppBarMenuItem(
                      key: MoneyPage.refreshButtonKey,
                      icon: Icons.refresh_rounded,
                      label: l10n.refresh,
                      onTap: _refresh,
                    ),
                  ],
                ),
              ],
              showFloatingButton: canRelease || canExpense,
              buttonLabel: canRelease
                  ? l10n.recordReleaseAction
                  : l10n.recordExpenseAction,
              onPressed: () => context.goNamed(
                canRelease ? createReleaseRouteName : createExpenseRouteName,
                pathParameters: path,
              ),
              buttonIcon: const Icon(
                Icons.add_rounded,
                key: MoneyPage.recordButtonKey,
              ),
            ),
            mobileBody: switch (state.summaryStatus) {
              _ when summary != null => _body(context, l10n, state, code),
              GenericStatus.failure => ErrorrWidget(
                errorMessage: state.summaryError ?? l10n.errorLedgerLoad,
                refreshText: l10n.refresh,
                onPressed: _refresh,
              ),
              _ => const MoneySkeleton(),
            },
          );
        },
      ),
    );
  }

  Widget _body(
    BuildContext context,
    AppLocalizations l10n,
    MoneyState state,
    String code,
  ) {
    final summary = state.summary!;
    final stages = projectStagesOf(context);
    final stageNames = {for (final s in stages) s.id: s.name};
    final chips = FilterChips<LedgerEntryKind?>(
      keyPrefix: MoneyPage.kindChipsPrefix,
      choices: [
        FilterChoice(null, l10n.filterAll),
        FilterChoice(LedgerEntryKind.release, l10n.filterReleases),
        FilterChoice(LedgerEntryKind.expense, l10n.filterExpenses),
      ],
      selected: _kind,
      onSelected: (kind) => _choose(kind: kind, stageId: _stageId),
      trailing: [
        if (stages.isNotEmpty)
          PickerPill<int?>(
            keyPrefix: MoneyPage.stagePickerPrefix,
            choices: [
              FilterChoice(null, l10n.allStages),
              for (final stage in stages) FilterChoice(stage.id, stage.name),
            ],
            selected: _stageId,
            onSelected: (stageId) => _choose(kind: _kind, stageId: stageId),
          ),
      ],
    );
    final delegate = PagedChildBuilderDelegate<LedgerEntry>(
      itemBuilder: (context, entry, index) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: LedgerEntryTile(
          entry: entry,
          currencyCode: code,
          stageName: stageNames[entry.stageId],
          onTap: () => context.goNamed(
            ledgerEntryRouteName,
            pathParameters: {
              'projectId': '${widget.projectId}',
              'entryId': '${entry.id}',
            },
          ),
        ),
      ),
      firstPageProgressIndicatorBuilder: (context) =>
          const RowsSkeleton(count: 4, trailing: true),
      newPageProgressIndicatorBuilder: (context) =>
    const Padding(
      padding: EdgeInsets.only(top: AppSpacing.sm),
      child: RowsSkeleton(count: 2),
    ),
      firstPageErrorIndicatorBuilder: (context) => ErrorrWidget(
        errorMessage:
            _pagingController.error?.toString() ?? l10n.errorLedgerLoad,
        refreshText: l10n.refresh,
        onPressed: _refresh,
      ),
      newPageErrorIndicatorBuilder: (context) => ErrorrWidget(
        errorMessage:
            _pagingController.error?.toString() ?? l10n.errorLedgerLoad,
        refreshText: l10n.refresh,
        onPressed: () => _pagingController.retryLastFailedRequest(),
      ),
      noItemsFoundIndicatorBuilder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        child: _filtered
            ? EmptyWidget(
                emptyText: l10n.noMatches,
                actionText: l10n.clearFilters,
                onPressed: () => _choose(kind: null, stageId: null),
              )
            : Text(
                l10n.ledgerEmpty,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium,
              ),
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final web = constraints.maxWidth >= MoneyPage.webFrom;
        final side = web ? 32.0 : AppSpacing.md;
        final head = [
          if (state.reconnecting) const ReconnectingLine(),
          if (web)
            _Figures(summary: summary, code: code)
          else ...[
            _Hero(summary: summary, code: code),
            if (summary.total.releasedMinor > 0) ...[
              const Gap.vertical(height: 12),
              _Left(summary: summary, code: code),
            ],
          ],
        ];
        final byStage = _ByStage(
          summary: summary,
          code: code,
          // Its entries, at once (and on a phone, back to the entries).
          onStage: (stageId) {
            setState(() => _panel = 0);
            _choose(kind: _kind, stageId: stageId);
          },
        );

        if (web) {
          // The entries on the left, by stage on the right (M-WebMoney).
          return Padding(
            padding: EdgeInsets.fromLTRB(side, 24, side, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...head,
                const Gap.vertical(height: 18),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            chips,
                            const Gap.vertical(height: 12),
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async => _refresh(),
                                child: PagedListView<int, LedgerEntry>(
                                  pagingController: _pagingController,
                                  builderDelegate: delegate,
                                  // Room for the record button below the
                                  // last entry.
                                  padding: const EdgeInsets.only(bottom: 88),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap.horizontal(width: 20),
                      Expanded(
                        flex: 5,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 88),
                          child: byStage,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async => _refresh(),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 840),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(side, AppSpacing.md, side, 0),
                    sliver: SliverList.list(
                      children: [
                        ...head,
                        const Gap.vertical(height: AppSpacing.md),
                        SegmentedSwitch(
                          labels: [l10n.moneyEntries, l10n.moneyByStage],
                          selected: _panel,
                          onSelected: (i) => setState(() => _panel = i),
                        ),
                        const Gap.vertical(height: 12),
                        if (_panel == 0) ...[
                          chips,
                          const Gap.vertical(height: 12),
                        ],
                      ],
                    ),
                  ),
                  SliverPadding(
                    // Room for the record button below the last entry.
                    padding: EdgeInsets.fromLTRB(side, 0, side, 96),
                    sliver: _panel == 0
                        ? PagedSliverList<int, LedgerEntry>(
                            pagingController: _pagingController,
                            builderDelegate: delegate,
                          )
                        : SliverToBoxAdapter(child: byStage),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// The phone's summary card: released against the budget, then spent and
/// spent with a receipt (canvas M-Money).
class _Hero extends StatelessWidget {
  const _Hero({required this.summary, required this.code});

  final LedgerSummary summary;
  final String code;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final total = summary.total;
    // Light teal on the teal card, as in the mockup.
    final soft = context.textTheme.bodySmall?.copyWith(
      color: customColors.onPrimary.withValues(alpha: .78),
    );
    final figure = context.textTheme.titleMedium?.copyWith(
      color: customColors.onPrimary,
      fontWeight: FontWeight.w800,
    );
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: customColors.primary,
        borderRadius: BorderRadius.circular(PlotwatchTheme.heroRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.moneyReleased, style: soft),
          OneLineAmount(
            formatMoney(total.releasedMinor, code),
            style: context.textTheme.headlineSmall?.copyWith(
              color: customColors.onPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            l10n.moneyReleasedOf(
              formatMoneyInput(total.budgetMinor, code),
              formatMoneyInput(
                total.remainingMinor < 0 ? 0 : total.remainingMinor,
                code,
              ),
            ),
            style: soft,
          ),
          const Gap.vertical(height: 12),
          Divider(color: customColors.onPrimary.withValues(alpha: .18)),
          const Gap.vertical(height: 4),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.moneySpent, style: soft),
                    Text(
                      formatMoneyInput(total.spentMinor, code),
                      style: figure,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.moneyWithReceipt, style: soft),
                    Text(
                      formatMoneyInput(total.spentWithReceiptMinor, code),
                      style: figure,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// What is left of the money released (released minus spent), and what was
/// spent without a receipt (developer, 2026-10-14; replaces the unaccounted
/// alert of LED-05).
class _Left extends StatelessWidget {
  const _Left({required this.summary, required this.code});

  final LedgerSummary summary;
  final String code;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final total = summary.total;
    final left = total.releasedMinor - total.spentMinor;
    final noReceipt = total.spentMinor - total.spentWithReceiptMinor;
    return Container(
      key: MoneyPage.leftKey,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: customColors.primarySoft,
        borderRadius: BorderRadius.circular(PlotwatchTheme.cardRadius),
      ),
      child: Row(
        children: [
          IconTile(
            icon: Icons.account_balance_wallet_outlined,
            size: 36,
            color: customColors.primary,
            background: customColors.surfaceWhite,
          ),
          const Gap.horizontal(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.moneyLeft, style: context.textTheme.bodySmall),
                OneLineAmount(
                  formatMoney(left, code),
                  style: context.textTheme.titleMedium?.copyWith(
                    color: left < 0 ? customColors.accent : customColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (noReceipt > 0)
                  Text(
                    l10n.moneySpentNoReceipt(formatMoney(noReceipt, code)),
                    key: MoneyPage.alertKey,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: customColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The web's four figure cards, the last one what is left (canvas
/// M-WebMoney; developer, 2026-10-14).
class _Figures extends StatelessWidget {
  const _Figures({required this.summary, required this.code});

  final LedgerSummary summary;
  final String code;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final total = summary.total;
    final left = total.releasedMinor - total.spentMinor;
    final noReceipt = total.spentMinor - total.spentWithReceiptMinor;
    Widget card(
      String label,
      int amount, {
      String? hint,
      Color? hintColor,
      Key? hintKey,
      Color? background,
      Color? color,
      Key? key,
    }) => Expanded(
      child: Container(
        key: key,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: background ?? customColors.surfaceWhite,
          borderRadius: BorderRadius.circular(PlotwatchTheme.cardRadius),
          border: background == null
              ? Border.all(color: customColors.line)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: context.textTheme.bodySmall?.copyWith(color: color),
            ),
            OneLineAmount(
              formatMoney(amount, code),
              style: context.textTheme.headlineSmall?.copyWith(
                color: color ?? customColors.ink,
                fontWeight: FontWeight.w800,
              ),
            ),
            if (hint != null)
              Text(
                hint,
                key: hintKey,
                style: context.textTheme.bodySmall?.copyWith(
                  color: hintColor ?? color,
                  fontWeight: hintColor != null ? FontWeight.w600 : null,
                ),
              ),
          ],
        ),
      ),
    );
    return Row(
      children: [
        card(
          l10n.moneyReleased,
          total.releasedMinor,
          hint: l10n.moneyReleasedOf(
            formatMoneyInput(total.budgetMinor, code),
            formatMoneyInput(
              total.remainingMinor < 0 ? 0 : total.remainingMinor,
              code,
            ),
          ),
          background: customColors.primary,
          color: customColors.onPrimary,
        ),
        const Gap.horizontal(width: 16),
        card(l10n.moneySpent, total.spentMinor),
        const Gap.horizontal(width: 16),
        card(l10n.moneyWithReceipt, total.spentWithReceiptMinor),
        const Gap.horizontal(width: 16),
        card(
          l10n.moneyLeft,
          left,
          key: MoneyPage.leftKey,
          hint: noReceipt > 0
              ? l10n.moneySpentNoReceipt(formatMoney(noReceipt, code))
              : null,
          hintColor: customColors.accent,
          hintKey: MoneyPage.alertKey,
          background: customColors.primarySoft,
          color: left < 0 ? customColors.accent : customColors.primary,
        ),
      ],
    );
  }
}

/// One row per stage, then the entries without a stage (LED-04).
class _ByStage extends StatelessWidget {
  const _ByStage({
    required this.summary,
    required this.code,
    required this.onStage,
  });

  final LedgerSummary summary;
  final String code;

  /// A stage's line shows its entries; the line without a stage can't be
  /// filtered on.
  final ValueChanged<int> onStage;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final lines = [
      for (var i = 0; i < summary.stages.length; i++)
        ('${i + 1} · ${summary.stages[i].stageName ?? ''}', summary.stages[i]),
      if (summary.unassigned case final line?) (l10n.moneyNotTied, line),
    ];
    if (lines.isEmpty) return const SizedBox.shrink();
    return AppCard(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.moneyByStage, style: context.textTheme.titleSmall),
          for (var i = 0; i < lines.length; i++)
            InkWell(
              key: switch (lines[i].$2.stageId) {
                final id? => MoneyPage.stageLineKey(id),
                _ => null,
              },
              onTap: switch (lines[i].$2.stageId) {
                final id? => () => onStage(id),
                _ => null,
              },
              child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: i == 0
                    ? null
                    : Border(top: BorderSide(color: customColors.lineSoft)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(lines[i].$1, style: context.textTheme.titleSmall),
                        Text(
                          lines[i].$2.releasedMinor == 0 &&
                                  lines[i].$2.spentMinor == 0
                              ? l10n.moneyStageNothing(
                                  formatMoneyInput(lines[i].$2.budgetMinor, code),
                                )
                              : l10n.moneyStageReleasedSpent(
                                  formatMoneyInput(
                                    lines[i].$2.releasedMinor,
                                    code,
                                  ),
                                  formatMoneyInput(
                                    lines[i].$2.spentMinor,
                                    code,
                                  ),
                                ),
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  if (lines[i].$2.releasedMinor > 0)
                    Text(
                      l10n.moneyStageLeft(
                        formatMoneyInput(
                          lines[i].$2.releasedMinor - lines[i].$2.spentMinor,
                          code,
                        ),
                      ),
                      style: context.textTheme.titleSmall?.copyWith(
                        color:
                            lines[i].$2.releasedMinor < lines[i].$2.spentMinor
                            ? customColors.accent
                            : customColors.primary,
                      ),
                    ),
                ],
              ),
            ),
            ),
        ],
      ),
    );
  }
}
