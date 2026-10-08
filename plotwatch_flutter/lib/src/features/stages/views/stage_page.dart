import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// One stage: status, budget, planned dates and the checklist of required
/// evidence with its progress (STG-04, STG-08). The owner edits it until it
/// is submitted and deletes it before it starts; the site manager starts it
/// once the site is validated (doc/04c M3-6, M3-8).
class StagePage extends StatefulWidget {
  const StagePage({super.key, required this.projectId, required this.stageId});

  final int projectId;
  final int stageId;

  static const editButtonKey = Key('stage.edit');
  static const deleteButtonKey = Key('stage.delete');
  static const startButtonKey = Key('stage.start');
  static const refreshButtonKey = Key('stage.refresh');

  @override
  State<StagePage> createState() => _StagePageState();
}

class _StagePageState extends State<StagePage> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() => context.read<StageBloc>().add(
    StageEvent.load(projectId: widget.projectId, stageId: widget.stageId),
  );

  void _backToPlan() => context.goNamed(
    stagesRouteName,
    pathParameters: {'projectId': '${widget.projectId}'},
  );

  Future<void> _confirmDelete(String name, AppLocalizations l10n) async {
    final bloc = context.read<StageBloc>();
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.deleteStageTitle(name),
      message: l10n.deleteStageMessage,
    );
    if (confirmed) bloc.add(const StageEvent.deleteRequested());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<StageBloc>();

    // An edit made on the form above shows up after coming back
    // (doc/04b H-1a).
    return ReloadOnReturn(
      onReturn: _load,
      child: BlocConsumer<StageBloc, StageState>(
        listenWhen: (previous, current) =>
            previous.actionStatus != current.actionStatus,
        listener: (context, state) {
          void reset() => bloc.add(const StageEvent.resetFlowStep());
          if (state.actionStatus == GenericStatus.success) {
            if (state.flowStep == GenericFlowStep.deletingItem) {
              _backToPlan();
            } else {
              DialogUtils.handleSuccess(
                context,
                l10n.stageStarted,
                postActions: [reset],
              );
            }
          } else if (state.actionStatus == GenericStatus.failure &&
              state.actionErrorMessage != null) {
            DialogUtils.handleFailure(
              context,
              state.actionErrorMessage!,
              postActions: [reset],
            );
          }
        },
        builder: (context, state) {
          final view = state.view;
          return ResponsiveScaffoldWrapper(
            props: ScaffoldWrapperProps(
              leading: BackButton(onPressed: _backToPlan),
              title: Text(view?.stage.name ?? l10n.stagesTitle),
              actions: [
                IconButton(
                  key: StagePage.refreshButtonKey,
                  tooltip: l10n.refresh,
                  color: customColors.primary,
                  icon: const Icon(Icons.refresh_rounded),
                  onPressed: _load,
                ),
                if (state.canEdit)
                  IconButton(
                    key: StagePage.editButtonKey,
                    tooltip: l10n.editStageAction,
                    color: customColors.primary,
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () => context.goNamed(
                      editStageRouteName,
                      pathParameters: {
                        'projectId': '${widget.projectId}',
                        'stageId': '${widget.stageId}',
                      },
                    ),
                  ),
                if (state.canDelete && view != null)
                  IconButton(
                    key: StagePage.deleteButtonKey,
                    tooltip: l10n.deleteStageTitle(view.stage.name),
                    color: customColors.unverified,
                    icon: const Icon(Icons.delete_outline_rounded),
                    onPressed: () => _confirmDelete(view.stage.name, l10n),
                  ),
              ],
            ),
            mobileBody: switch (state.loadStatus) {
              _ when view != null && state.overview != null => _StageBody(
                state: state,
                view: view,
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

class _StageBody extends StatelessWidget {
  const _StageBody({
    required this.state,
    required this.view,
    required this.onRefresh,
  });

  final StageState state;
  final StageView view;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final bloc = context.read<StageBloc>();
    final stage = view.stage;
    String date(DateTime? value) =>
        value == null ? l10n.notSet : formatDate(value.toLocal());

    return AuthFormLayout(
      title: stage.name,
      subtitle: l10n.stageNumber(stage.orderIndex + 1),
      onRefresh: onRefresh,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: ProjectChip(
            label: stage.status.label(l10n),
            color: stage.status.color,
          ),
        ),
        const Gap.vertical(height: AppSpacing.md),
        DetailRow(
          label: l10n.labelBudget,
          value: formatMoney(
            stage.budgetMinor,
            state.currencyCode,
            locale: locale,
          ),
        ),
        DetailRow(
          label: l10n.labelPlannedDates,
          value: '${date(stage.plannedStart)} – ${date(stage.plannedEnd)}',
        ),
        if (stage.description != null)
          DetailRow(label: l10n.labelDescription, value: stage.description!),
        const Gap.vertical(height: AppSpacing.md),
        Text(l10n.checklistTitle, style: context.textTheme.titleMedium),
        const Gap.vertical(height: AppSpacing.xs),
        Text(
          l10n.itemsCovered(view.itemsCovered, view.items.length),
          style: context.textTheme.bodySmall,
        ),
        const Gap.vertical(height: AppSpacing.sm),
        for (final item in view.items)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              children: [
                Icon(Icons.photo_camera_outlined, color: customColors.muted),
                const Gap.horizontal(width: AppSpacing.sm),
                Expanded(
                  child: Text(item.label, style: context.textTheme.bodyMedium),
                ),
                if (!item.isRequired)
                  Text(
                    l10n.checklistOptional,
                    style: context.textTheme.bodySmall,
                  ),
              ],
            ),
          ),
        if (state.canStart) ...[
          const Gap.vertical(height: AppSpacing.lg),
          if (state.isProjectActive)
            SubmitButton(
              key: StagePage.startButtonKey,
              label: l10n.startStageAction,
              isLoading: state.actionStatus == GenericStatus.loading,
              onPressed: () => bloc.add(const StageEvent.startRequested()),
            )
          else
            Text(l10n.stageStartNeedsSite, style: context.textTheme.bodyMedium),
        ],
      ],
    );
  }
}
