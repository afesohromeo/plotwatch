import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The frame of the two ledger forms (canvas M-Expense): a focused page
/// closed with ✕, the sections scrolling, the save button fixed at the
/// bottom; success goes back to the Money tab.
class LedgerFormFrame extends StatelessWidget {
  const LedgerFormFrame({
    super.key,
    required this.projectId,
    required this.title,
    required this.subtitle,
    required this.savedMessage,
    required this.saveLabel,
    required this.saveKey,
    required this.onSave,
    required this.sections,
  });

  final int projectId;
  final String title;
  final String Function(String project) subtitle;
  final String savedMessage;
  final String saveLabel;
  final Key saveKey;
  final VoidCallback onSave;

  /// Built once the project and its stages are loaded.
  final List<Widget> Function(LedgerFormState state) sections;

  static const closeButtonKey = Key('ledgerForm.close');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<LedgerFormBloc>();
    void back() => context.goNamed(
      moneyRouteName,
      pathParameters: {'projectId': '$projectId'},
    );
    final project = projectNameOf(context);

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        leading: IconButton(
          key: closeButtonKey,
          tooltip: l10n.cancel,
          icon: const Icon(Icons.close_rounded),
          onPressed: back,
        ),
        title: Text(title),
        subtitle: project == null ? null : subtitle(project),
        showBell: false,
        resizeToAvoidBottomInset: true,
      ),
      mobileBody: BlocConsumer<LedgerFormBloc, LedgerFormState>(
        listenWhen: (previous, current) =>
            previous.actionStatus != current.actionStatus,
        listener: (context, state) {
          void reset() => bloc.add(const LedgerFormEvent.resetFlowStep());
          if (state.actionStatus == GenericStatus.success) {
            DialogUtils.handleSuccess(
              context,
              savedMessage,
              postActions: [reset, back],
            );
          } else if (state.actionStatus == GenericStatus.failure &&
              state.actionErrorMessage != null) {
            DialogUtils.handleFailure(
              context,
              state.actionErrorMessage!,
              postActions: [reset],
            );
          }
        },
        builder: (context, state) => switch (state.loadStatus) {
          GenericStatus.failure => ErrorrWidget(
            errorMessage: state.loadErrorMessage ?? l10n.errorLedgerLoad,
            refreshText: l10n.refresh,
            onPressed: () =>
                bloc.add(LedgerFormEvent.load(projectId: projectId)),
          ),
          GenericStatus.success => Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 640),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (final section in sections(state)) ...[
                            section,
                            const Gap.vertical(height: 12),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: customColors.surfaceWhite,
                  border: Border(top: BorderSide(color: customColors.line)),
                ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 640),
                        child: SubmitButton(
                          key: saveKey,
                          label: saveLabel,
                          isLoading:
                              state.actionStatus == GenericStatus.loading,
                          onPressed: onSave,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}

/// Tiles to choose one of a few values, the chosen one framed in the
/// primary colour (as the update form's weather, doc/05 §9.6).
class ChoiceTiles<T> extends StatelessWidget {
  const ChoiceTiles({
    super.key,
    required this.choices,
    required this.selected,
    required this.onSelected,
    required this.keyOf,
    this.columns = 3,
  });

  final List<FilterChoice<T>> choices;
  final T? selected;
  final ValueChanged<T> onSelected;
  final Key Function(T value) keyOf;
  final int columns;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = AppSpacing.sm;
        final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final choice in choices)
              SizedBox(
                width: width,
                child: _Tile(
                  key: keyOf(choice.value),
                  label: choice.label,
                  selected: choice.value == selected,
                  onTap: () => onSelected(choice.value),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? customColors.primarySoft : customColors.surfaceWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: selected ? customColors.primary : customColors.line,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            constraints: const BoxConstraints(minHeight: 44),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: context.textTheme.labelMedium?.copyWith(
                color: selected ? customColors.primary : customColors.ink,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The amount, the date and the stage, the first section of both forms.
class LedgerAmountSection extends StatelessWidget {
  const LedgerAmountSection({
    super.key,
    required this.amount,
    required this.amountError,
    required this.currencyCode,
    required this.date,
    required this.onDate,
    required this.stages,
    required this.stageId,
    required this.onStage,
    this.warnApproved = false,
  });

  final TextEditingController amount;
  final String? amountError;
  final String currencyCode;
  final DateTime date;
  final ValueChanged<DateTime> onDate;
  final List<Stage> stages;
  final int? stageId;
  final ValueChanged<int?> onStage;

  /// Says so when the chosen stage is already approved: the expense still
  /// counts for it (developer, 2026-10-12).
  final bool warnApproved;

  static const approvedWarningKey = Key('ledgerForm.approvedWarning');
  static const amountFieldKey = Key('ledgerForm.amount');
  static const dateFieldKey = Key('ledgerForm.date');
  static const stageFieldKey = Key('ledgerForm.stage');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MoneyField(
            key: amountFieldKey,
            controller: amount,
            currencyCode: currencyCode,
            labelText: l10n.labelAmount,
          ),
          if (amountError != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 4),
              child: Text(
                amountError!,
                style: context.textTheme.bodySmall?.copyWith(
                  color: customColors.unverified,
                ),
              ),
            ),
          const Gap.vertical(height: 12),
          DatePickerField(
            key: dateFieldKey,
            labelText: l10n.labelEntryDate,
            value: date,
            lastDate: DateTime.now(),
            onChanged: (value) {
              if (value != null) onDate(value);
            },
          ),
          const Gap.vertical(height: 12),
          DropdownButtonFormField<int?>(
            key: stageFieldKey,
            initialValue: stageId,
            isExpanded: true,
            decoration: InputDecoration(labelText: l10n.labelUpdateStage),
            items: [
              DropdownMenuItem(value: null, child: Text(l10n.noStage)),
              for (final stage in stages)
                DropdownMenuItem(
                  value: stage.id,
                  child: Text(
                    '${stage.name} · ${stage.status.label(l10n)}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
            onChanged: onStage,
          ),
          if (warnApproved)
            if (stages.where((s) => s.id == stageId).firstOrNull
                case final stage?
                when stage.status == StageStatus.approved)
              Padding(
                key: approvedWarningKey,
                padding: const EdgeInsets.only(top: 8, left: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 18,
                      color: customColors.partial,
                    ),
                    const Gap.horizontal(width: 6),
                    Expanded(
                      child: Text(
                        stage.approvedAt == null
                            ? l10n.stageApprovedWarningUndated(stage.name)
                            : l10n.stageApprovedWarning(
                                stage.name,
                                formatDate(stage.approvedAt!.toLocal()),
                              ),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: customColors.ink,
                        ),
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

/// The day picked, at UTC midnight, as the server keeps it (doc/04f).
DateTime ledgerDay(DateTime picked) =>
    DateTime.utc(picked.year, picked.month, picked.day);
