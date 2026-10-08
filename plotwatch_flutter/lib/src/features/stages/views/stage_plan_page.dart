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
              actions: [
                IconButton(
                  key: StagePlanPage.refreshButtonKey,
                  tooltip: l10n.refresh,
                  color: customColors.primary,
                  icon: const Icon(Icons.refresh_rounded),
                  onPressed: _load,
                ),
              ],
              showFloatingButton: state.canEdit && plan != null,
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

class _PlanBody extends StatelessWidget {
  const _PlanBody({
    required this.state,
    required this.plan,
    required this.onRefresh,
  });

  final StagePlanState state;
  final StagePlan plan;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final bloc = context.read<StagePlanBloc>();
    final overview = state.overview!;
    final isBusy = state.actionStatus == GenericStatus.loading;

    final header = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(overview.project.name, style: context.textTheme.headlineSmall),
        const Gap.vertical(height: AppSpacing.sm),
        Text(l10n.stagesTitle, style: context.textTheme.bodyMedium),
        const Gap.vertical(height: AppSpacing.lg),
        DetailRow(
          label: l10n.labelTotalBudget,
          value: formatMoney(
            plan.budgetTotalMinor,
            state.currencyCode,
            locale: locale,
          ),
        ),
        DetailRow(
          label: l10n.labelProgress,
          value: l10n.progressPercent(plan.progressPercent),
        ),
        const Gap.vertical(height: AppSpacing.md),
        if (plan.stages.isEmpty) ..._empty(context, l10n, bloc, isBusy),
      ],
    );

    // One scroll view for the whole page: a stage dragged near the top or
    // bottom edge scrolls the page with it (doc/04c M3-F3). Same width as
    // AuthFormLayout: 420 px at most, centred.
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final side = math.max(
            AppSpacing.lg,
            (constraints.maxWidth - AuthFormLayout.maxWidth) / 2,
          );
          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(side, AppSpacing.lg, side, 0),
                sliver: SliverToBoxAdapter(child: header),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(side, 0, side, AppSpacing.lg),
                sliver: SliverReorderableList(
                  itemCount: plan.stages.length,
                  onReorderItem: (oldIndex, newIndex) => bloc.add(
                    StagePlanEvent.reorderRequested(
                      oldIndex: oldIndex,
                      newIndex: newIndex,
                    ),
                  ),
                  proxyDecorator: (child, index, animation) => Material(
                    elevation: 4,
                    color: customColors.background,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    child: child,
                  ),
                  itemBuilder: (context, index) {
                    final view = plan.stages[index];
                    return _StageTile(
                      key: StagePlanPage.stageTileKey(view.stage.id!),
                      index: index,
                      view: view,
                      currencyCode: state.currencyCode,
                      canDrag: state.canEdit && !isBusy,
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

/// One stage: position, name, status, budget and checklist progress.
class _StageTile extends StatelessWidget {
  const _StageTile({
    super.key,
    required this.index,
    required this.view,
    required this.currencyCode,
    required this.canDrag,
  });

  final int index;
  final StageView view;
  final String currencyCode;
  final bool canDrag;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final stage = view.stage;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          onTap: () => context.goNamed(
            stageRouteName,
            pathParameters: {
              'projectId': '${stage.projectId}',
              'stageId': '${stage.id}',
            },
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Row(
              children: [
                SizedBox(
                  width: 32,
                  child: Text(
                    '${index + 1}',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: customColors.muted,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(stage.name, style: context.textTheme.bodyLarge),
                      const Gap.vertical(height: AppSpacing.xs),
                      Text(
                        '${formatMoney(stage.budgetMinor, currencyCode, locale: locale)}'
                        ' · ${l10n.itemsCovered(view.itemsCovered, view.items.length)}',
                        style: context.textTheme.bodySmall,
                      ),
                      const Gap.vertical(height: AppSpacing.xs),
                      ProjectChip(
                        label: stage.status.label(l10n),
                        color: stage.status.color,
                      ),
                    ],
                  ),
                ),
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
    );
  }
}
