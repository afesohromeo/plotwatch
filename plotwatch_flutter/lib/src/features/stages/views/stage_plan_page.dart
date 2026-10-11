import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// A project's stage plan: the total budget, the progress and the stages in
/// order. The owner adds stages, drags them into order and fills an empty
/// plan from a template; everybody else reads it (doc/04c M3-11). Not
/// paginated: at most 50 stages.
class StagePlanPage extends StatefulWidget {
  const StagePlanPage({super.key, required this.projectId});

  final int projectId;

  static const addStageButtonKey = Key('stagePlan.add');
  static const refreshButtonKey = Key('stagePlan.refresh');
  static Key stageTileKey(int stageId) => Key('stagePlan.stage.$stageId');
  static Key dragHandleKey(int stageId) => Key('stagePlan.drag.$stageId');
  static Key templateButtonKey(StageTemplate template) =>
      Key('stagePlan.template.${template.name}');

  /// The filter chips (doc/05 §9.5), keyed `stagePlan.filter.<index>` in
  /// [StagePlanFilter] order.
  static const filterChipsPrefix = 'stagePlan.filter';

  @override
  State<StagePlanPage> createState() => _StagePlanPageState();
}

class _StagePlanPageState extends State<StagePlanPage> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() => context.read<StagePlanBloc>().add(
    StagePlanEvent.load(projectId: widget.projectId),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<StagePlanBloc>();
    final pathParameters = {'projectId': '${widget.projectId}'};

    // A stage added or edited on a page above shows up after coming back
    // (doc/04b H-1a).
    return ReloadOnReturn(
      onReturn: _load,
      child: BlocConsumer<StagePlanBloc, StagePlanState>(
        listenWhen: (previous, current) =>
            previous.actionStatus != current.actionStatus,
        listener: (context, state) {
          void reset() => bloc.add(const StagePlanEvent.resetFlowStep());
          if (state.actionStatus == GenericStatus.failure &&
              state.actionErrorMessage != null) {
            DialogUtils.handleFailure(
              context,
              state.actionErrorMessage!,
              postActions: [reset],
            );
          } else if (state.actionStatus == GenericStatus.success) {
            reset();
          }
        },
        builder: (context, state) {
          final plan = state.plan;
          return ResponsiveScaffoldWrapper(
            props: ScaffoldWrapperProps(
              leading: BackButton(
                onPressed: () => context.goNamed(
                  projectRouteName,
                  pathParameters: pathParameters,
                ),
              ),
              title: Text(l10n.stagesTitle),
              // "Maison Douala · 12.5 M FCFA" (doc/05 §9.3).
              subtitle: state.overview == null || plan == null
                  ? null
                  : '${state.overview!.project.name} · '
                        '${formatMoneyShort(plan.budgetTotalMinor, state.currencyCode, locale: Localizations.localeOf(context).languageCode)}',
              actions: [
                AppBarMenu(
                  items: [
                    AppBarMenuItem(
                      key: StagePlanPage.refreshButtonKey,
                      icon: Icons.refresh_rounded,
                      label: l10n.refresh,
                      onTap: _load,
                    ),
                  ],
                ),
              ],
              showFloatingButton: state.canEdit && plan != null,
              buttonLabel: l10n.addStageAction,
              onPressed: () => context.goNamed(
                createStageRouteName,
                pathParameters: pathParameters,
              ),
              buttonIcon: Icon(
                Icons.add_rounded,
                key: StagePlanPage.addStageButtonKey,
                semanticLabel: l10n.addStageAction,
              ),
            ),
            mobileBody: switch (state.loadStatus) {
              _ when plan != null && state.overview != null => _PlanBody(
                state: state,
                plan: plan,
                onRefresh: () async => _load(),
              ),
              GenericStatus.failure => ErrorrWidget(
                errorMessage: state.loadErrorMessage ?? l10n.errorStagesLoad,
                refreshText: l10n.refresh,
                onPressed: _load,
              ),
              _ => const Center(child: CircularProgressIndicator()),
            },
          );
        },
      ),
    );
  }
}

/// The Stages tab's chips, applied in the app: the plan is loaded whole
/// (doc/05 §9.5).
enum StagePlanFilter {
  all,

  /// What waits for this user (the attention rule, DP-1).
  needsYou,

  /// Being worked on: in progress, or changes requested.
  inProgress,

  /// Past its planned end and not approved (M5-10).
  late,
  approved;

  String label(AppLocalizations l10n) => switch (this) {
    StagePlanFilter.all => l10n.filterAll,
    StagePlanFilter.needsYou => l10n.stageFilterNeedsYou,
    StagePlanFilter.inProgress => l10n.stageStatusInProgress,
    StagePlanFilter.late => l10n.stageLate,
    StagePlanFilter.approved => l10n.stageStatusApproved,
  };

  bool keeps(
    Stage stage, {
    required ProjectRole role,
    required bool canApprove,
    required DateTime now,
  }) => switch (this) {
    StagePlanFilter.all => true,
    StagePlanFilter.needsYou => waitsFor(
      stage.status,
      role: role,
      canApprove: canApprove,
    ),
    StagePlanFilter.inProgress =>
      stage.status == StageStatus.inProgress ||
          stage.status == StageStatus.changesRequested,
    StagePlanFilter.late => stage.isLateOn(now),
    StagePlanFilter.approved => stage.status == StageStatus.approved,
  };
}

class _PlanBody extends StatefulWidget {
  const _PlanBody({
    required this.state,
    required this.plan,
    required this.onRefresh,
  });

  final StagePlanState state;
  final StagePlan plan;
  final Future<void> Function() onRefresh;

  @override
  State<_PlanBody> createState() => _PlanBodyState();
}

class _PlanBodyState extends State<_PlanBody> {
  StagePlanFilter _filter = StagePlanFilter.all;

  StagePlanState get state => widget.state;
  StagePlan get plan => widget.plan;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<StagePlanBloc>();
    final isBusy = state.actionStatus == GenericStatus.loading;
    final role = state.overview?.myRole ?? ProjectRole.viewer;
    final canApprove = state.overview?.myCanApprove ?? false;
    final now = DateTime.now();
    // Each stage keeps its number in the plan.
    final shown = [
      for (var i = 0; i < plan.stages.length; i++)
        if (_filter.keeps(
          plan.stages[i].stage,
          role: role,
          canApprove: canApprove,
          now: now,
        ))
          (index: i, view: plan.stages[i]),
    ];
    // Moving stages only makes sense with all of them in sight.
    final canDrag = state.canEdit && !isBusy && _filter == StagePlanFilter.all;

    // One line above the timeline (doc/05 §9.3): the progress, the budget
    // share in bold.
    final approvedCount = plan.stages
        .where((v) => v.stage.status == StageStatus.approved)
        .length;
    final header = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (plan.stages.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 14),
            child: Text.rich(
              TextSpan(
                children: [
                  if (plan.budgetTotalMinor > 0) ...[
                    TextSpan(
                      text: '${plan.progressPercent}% ',
                      style: TextStyle(
                        color: customColors.ink,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextSpan(text: '${l10n.ofTheBudget} · '),
                  ],
                  TextSpan(
                    text: l10n.progressStagesOnly(
                      approvedCount,
                      plan.stages.length,
                    ),
                  ),
                ],
              ),
              style: context.textTheme.bodyMedium?.copyWith(fontSize: 14),
            ),
          ),
        if (plan.stages.isNotEmpty) ...[
          FilterChips<StagePlanFilter>(
            keyPrefix: StagePlanPage.filterChipsPrefix,
            choices: [
              for (final filter in StagePlanFilter.values)
                FilterChoice(filter, filter.label(l10n)),
            ],
            selected: _filter,
            onSelected: (filter) => setState(() => _filter = filter),
          ),
          const Gap.vertical(height: AppSpacing.md),
          if (shown.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: Text(
                l10n.noStageHere,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium,
              ),
            ),
        ],
        if (plan.stages.isEmpty) ..._empty(context, l10n, bloc, isBusy),
      ],
    );

    // One scroll view for the whole page: a stage dragged near the top or
    // bottom edge scrolls the page with it (doc/04c M3-F3). Same width as
    // AuthFormLayout: 420 px at most, centred.
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final side = math.max(
            AppSpacing.lg,
            (constraints.maxWidth - 640) / 2,
          );
          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(side, AppSpacing.md, side, 0),
                sliver: SliverToBoxAdapter(child: header),
              ),
              SliverPadding(
                // Room for the "Add a stage" button below the last stage.
                padding: EdgeInsets.fromLTRB(side, 0, side, 96),
                sliver: SliverReorderableList(
                  itemCount: shown.length,
                  onReorderItem: (oldIndex, newIndex) {
                    if (!canDrag) return;
                    bloc.add(
                      StagePlanEvent.reorderRequested(
                        oldIndex: oldIndex,
                        newIndex: newIndex,
                      ),
                    );
                  },
                  proxyDecorator: (child, index, animation) => Material(
                    elevation: 4,
                    color: customColors.background,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    child: child,
                  ),
                  itemBuilder: (context, position) {
                    final (:index, :view) = shown[position];
                    return _StageTile(
                      key: StagePlanPage.stageTileKey(view.stage.id!),
                      index: index,
                      view: view,
                      currencyCode: state.currencyCode,
                      canDrag: canDrag,
                      isLast: position == shown.length - 1,
                      waitsForMe: waitsFor(
                        view.stage.status,
                        role: role,
                        canApprove: canApprove,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// No stages yet: the owner starts from a template (decision M3-3) or
  /// adds stages one by one; the others wait for the owner.
  List<Widget> _empty(
    BuildContext context,
    AppLocalizations l10n,
    StagePlanBloc bloc,
    bool isBusy,
  ) {
    if (!state.canEdit) {
      return [Text(l10n.stagesEmpty, style: context.textTheme.bodyMedium)];
    }
    return [
      Text(l10n.stagesEmptyOwner, style: context.textTheme.bodyMedium),
      const Gap.vertical(height: AppSpacing.md),
      for (final template in [
        StageTemplate.singleStoreyHouse,
        StageTemplate.renovation,
      ]) ...[
        PrimaryButton(
          key: StagePlanPage.templateButtonKey(template),
          withBg: false,
          width: double.infinity,
          onPressed: isBusy
              ? null
              : () => bloc.add(
                  StagePlanEvent.templateApplied(template: template),
                ),
          child: Text(l10n.useTemplateAction(template.label(l10n))),
        ),
        const Gap.vertical(height: AppSpacing.sm),
      ],
    ];
  }
}

/// One stage on the timeline (doc/05 §9 DP-9): a node coloured by its
/// status joined to the next, then a card with its position and name,
/// budget, checklist progress, status and schedule, and its latest photo.
/// A stage waiting for the user is outlined in terracotta.
class _StageTile extends StatelessWidget {
  const _StageTile({
    super.key,
    required this.index,
    required this.view,
    required this.currencyCode,
    required this.canDrag,
    required this.isLast,
    required this.waitsForMe,
  });

  final int index;
  final StageView view;
  final String currencyCode;
  final bool canDrag;
  final bool isLast;
  final bool waitsForMe;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final stage = view.stage;
    final photo = view.latestEvidenceId;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                const Gap.vertical(height: 18),
                _Node(status: stage.status),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: stage.status == StageStatus.approved
                          ? customColors.verified
                          : customColors.line,
                    ),
                  ),
              ],
            ),
          ),
          const Gap.horizontal(width: AppSpacing.sm),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppCard(
                borderColor: waitsForMe ? customColors.accent : null,
                padding: const EdgeInsets.all(12),
                onTap: () => context.goNamed(
                  stageRouteName,
                  pathParameters: {
                    'projectId': '${stage.projectId}',
                    'stageId': '${stage.id}',
                  },
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1} · ${stage.name}',
                            style: context.textTheme.titleSmall,
                          ),
                          const Gap.vertical(height: 2),
                          Text(
                            '${formatMoney(stage.budgetMinor, currencyCode, locale: locale)}'
                            ' · ${l10n.itemsCovered(view.itemsCovered, view.items.length)}',
                            style: context.textTheme.bodySmall,
                          ),
                          const Gap.vertical(height: AppSpacing.xs),
                          Wrap(
                            spacing: AppSpacing.xs,
                            runSpacing: AppSpacing.xs,
                            children: [
                              ProjectChip(
                                label:
                                    waitsForMe &&
                                        stage.status == StageStatus.submitted
                                    ? l10n.waitingForYourReview
                                    : stage.status.label(l10n),
                                color: waitsForMe
                                    ? customColors.accent
                                    : stage.status.color,
                              ),
                              // Schedule status (STG-10, doc/04e M5-10).
                              if (stage.isLateOn(DateTime.now()))
                                ProjectChip(
                                  label: l10n.stageLate,
                                  color: customColors.unverified,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (photo != null) ...[
                      const Gap.horizontal(width: AppSpacing.sm),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: EvidenceImage(
                          projectId: stage.projectId,
                          evidenceId: photo,
                          variant: MediaVariant.thumbnail,
                          width: 52,
                          height: 52,
                        ),
                      ),
                    ],
                    if (canDrag)
                      ReorderableDragStartListener(
                        key: StagePlanPage.dragHandleKey(stage.id!),
                        index: index,
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          child: Icon(
                            Icons.drag_indicator_rounded,
                            color: customColors.muted,
                            semanticLabel: l10n.reorderStageHint,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A timeline node: a check when approved, a speech mark when it waits for
/// someone, a dot in progress, an empty ring before it starts.
class _Node extends StatelessWidget {
  const _Node({required this.status});

  final StageStatus status;

  @override
  Widget build(BuildContext context) {
    final (fill, border, icon) = switch (status) {
      StageStatus.approved => (
        customColors.verified,
        customColors.verified,
        Icons.check_rounded,
      ),
      StageStatus.submitted || StageStatus.changesRequested => (
        customColors.accent,
        customColors.accent,
        Icons.chat_bubble_outline_rounded,
      ),
      StageStatus.inProgress => (
        customColors.surfaceWhite,
        customColors.primary,
        null,
      ),
      StageStatus.notStarted => (
        customColors.surfaceWhite,
        customColors.line,
        null,
      ),
    };
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: fill,
        shape: BoxShape.circle,
        border: Border.all(color: border, width: 2),
      ),
      child: icon == null
          ? status == StageStatus.inProgress
                ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: customColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                : null
          : Icon(icon, size: 15, color: customColors.onPrimary),
    );
  }
}
