import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// One ledger entry (canvas M-Entry): the amount and what it was, the
/// receipt photo, the details, and what can be done: **Confirm received**
/// for the site manager on a release (LED-02), **Reverse this entry** for
/// its recorder (LED-06). Entries are never edited.
class LedgerEntryPage extends StatefulWidget {
  const LedgerEntryPage({
    super.key,
    required this.projectId,
    required this.entryId,
  });

  final int projectId;
  final int entryId;

  static const confirmButtonKey = Key('entry.confirm');
  static const reverseButtonKey = Key('entry.reverse');
  static const reasonFieldKey = Key('entry.reverseReason');
  static const originalKey = Key('entry.original');

  @override
  State<LedgerEntryPage> createState() => _LedgerEntryPageState();
}

class _LedgerEntryPageState extends State<LedgerEntryPage> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() => context.read<LedgerEntryBloc>().add(
    LedgerEntryEvent.load(projectId: widget.projectId, entryId: widget.entryId),
  );

  void _toMoney() => context.goNamed(
    moneyRouteName,
    pathParameters: {'projectId': '${widget.projectId}'},
  );

  Future<void> _reverse(BuildContext context, LedgerEntryBloc bloc) async {
    final reason = await showDialog<String>(
      context: context,
      builder: (_) => const _ReverseDialog(),
    );
    if (reason != null) bloc.add(LedgerEntryEvent.reverseRequested(reason));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<LedgerEntryBloc>();

    return BlocConsumer<LedgerEntryBloc, LedgerEntryState>(
      listenWhen: (previous, current) =>
          previous.actionStatus != current.actionStatus,
      listener: (context, state) {
        void reset() => bloc.add(const LedgerEntryEvent.resetFlowStep());
        if (state.actionStatus == GenericStatus.success) {
          DialogUtils.handleSuccess(
            context,
            state.lastAction == LedgerEntryAction.confirm
                ? l10n.releaseConfirmedMessage
                : l10n.entryReversedMessage,
            postActions: [reset],
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
      builder: (context, state) {
        final entry = state.entry;
        final title = entry?.kindLabel(l10n) ?? l10n.moneyTab;
        return ResponsiveScaffoldWrapper(
          props: ScaffoldWrapperProps(
            leading: BackButton(onPressed: _toMoney),
            title: Text(title),
            bottom: ProjectBreadcrumbBar(
              projectId: widget.projectId,
              section: ProjectTab.money,
              leaf: title,
            ),
          ),
          mobileBody: switch (state.loadStatus) {
            _ when entry != null => _EntryBody(
              projectId: widget.projectId,
              state: state,
              onConfirm: () =>
                  bloc.add(const LedgerEntryEvent.confirmRequested()),
              onReverse: () => _reverse(context, bloc),
            ),
            GenericStatus.failure => ErrorrWidget(
              errorMessage: state.loadErrorMessage ?? l10n.errorLedgerLoad,
              refreshText: l10n.refresh,
              onPressed: _load,
            ),
            _ => const LedgerEntrySkeleton(),
          },
        );
      },
    );
  }
}

class _EntryBody extends StatelessWidget {
  const _EntryBody({
    required this.projectId,
    required this.state,
    required this.onConfirm,
    required this.onReverse,
  });

  final int projectId;
  final LedgerEntryState state;
  final VoidCallback onConfirm;
  final VoidCallback onReverse;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final entry = state.entry!;
    final code = state.overview?.project.currencyCode ?? 'XAF';
    final busy = state.actionStatus == GenericStatus.loading;
    final stageName = projectStagesOf(context)
        .where((s) => s.id == entry.stageId)
        .firstOrNull
        ?.name;
    final kindLine = [
      if (entry.isRelease) ?entry.method?.label(l10n) else ?entry.category?.label(l10n),
      ?stageName,
    ].join(' · ');

    final rows = <(String, String)>[
      if (entry.vendor case final vendor?) (l10n.labelPaidTo, vendor),
      if (entry.reference case final reference?)
        (l10n.labelReference, reference),
      if (!entry.isReversal && entry.note != null)
        (l10n.labelNote, entry.note!),
      (l10n.labelEntryDate, formatDate(entryDay(entry))),
      (
        l10n.labelRecordedBy,
        '${entry.recordedByName ?? l10n.someone}, '
            '${dayAndTime(entry.createdAt, l10n)}',
      ),
      if (entry.isRelease && !entry.isReversal)
        (
          l10n.labelConfirmation,
          entry.confirmedAt == null
              ? l10n.tagNotConfirmed
              : dayAndTime(entry.confirmedAt!, l10n),
        ),
    ];

    final content = ContentLayout(
      onRefresh: () async => context.read<LedgerEntryBloc>().add(
        LedgerEntryEvent.load(projectId: projectId, entryId: entry.id!),
      ),
      maxWidth: 720,
      main: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (kindLine.isNotEmpty)
                Text(
                  kindLine,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              Text(
                formatMoney(entry.amountMinor, code),
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  decoration: entry.isReversed
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              if (entry.description case final description?)
                Text(description, style: context.textTheme.bodyLarge),
              const Gap.vertical(height: 8),
              LedgerTag.of(entry, l10n),
            ],
          ),
        ),
        // A reversed entry says why; a reversal opens what it corrects.
        if (entry.isReversed)
          _Banner(text: l10n.reversedBanner(entry.reversalReason ?? '')),
        if (entry.reversesId case final original?)
          AppCard(
            key: LedgerEntryPage.originalKey,
            onTap: () => context.goNamed(
              ledgerEntryRouteName,
              pathParameters: {
                'projectId': '$projectId',
                'entryId': '$original',
              },
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${l10n.reversalOf(entry.note ?? '')}\n'
                    '${l10n.openOriginal}',
                    style: context.textTheme.bodyMedium,
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: customColors.muted),
              ],
            ),
          ),
        if (entry.hasReceipt) _Receipt(state: state),
        AppCard(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Column(
            children: [
              for (var i = 0; i < rows.length; i++)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: i == rows.length - 1
                        ? null
                        : Border(
                            bottom: BorderSide(color: customColors.lineSoft),
                          ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(rows[i].$1, style: context.textTheme.bodyMedium),
                      const Gap.horizontal(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          rows[i].$2,
                          textAlign: TextAlign.end,
                          style: context.textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        Text(l10n.entryNeverEdited, style: context.textTheme.bodySmall),
      ],
    );

    if (!state.canConfirm && !state.canReverse) return content;
    // The action stays in reach (as on the stage page, DP-9).
    return Column(
      children: [
        Expanded(child: content),
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
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: state.canConfirm
                      ? SubmitButton(
                          key: LedgerEntryPage.confirmButtonKey,
                          label: l10n.confirmReceivedAction,
                          isLoading: busy,
                          onPressed: onConfirm,
                        )
                      : OutlinedButton(
                          key: LedgerEntryPage.reverseButtonKey,
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                            foregroundColor: customColors.unverified,
                            side: BorderSide(
                              color: customColors.unverified,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: busy ? null : onReverse,
                          child: Text(l10n.reverseAction),
                        ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// The receipt photo, once loaded.
class _Receipt extends StatelessWidget {
  const _Receipt({required this.state});

  final LedgerEntryState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bytes = state.receipt;
    return ClipRRect(
      borderRadius: BorderRadius.circular(PlotwatchTheme.cardRadius),
      child: Container(
        height: 240,
        color: customColors.lineSoft,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (bytes == null)
              const Center(child: CircularProgressIndicator.adaptive())
            else
              Image.memory(
                bytes,
                fit: BoxFit.cover,
                semanticLabel: l10n.receiptTitle,
              ),
            Positioned(
              left: 12,
              bottom: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: customColors.ink.withValues(alpha: .72),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  l10n.receiptTitle,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: customColors.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: customColors.lineSoft,
        borderRadius: BorderRadius.circular(PlotwatchTheme.cardRadius),
      ),
      child: Row(
        children: [
          Icon(Icons.undo_rounded, color: customColors.muted),
          const Gap.horizontal(width: AppSpacing.sm),
          Expanded(child: Text(text, style: context.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}

/// Asks why before reversing; a reason is required (LED-06).
class _ReverseDialog extends StatefulWidget {
  const _ReverseDialog();

  @override
  State<_ReverseDialog> createState() => _ReverseDialogState();
}

class _ReverseDialogState extends State<_ReverseDialog> {
  final _formKey = GlobalKey<FormState>();
  final _reason = TextEditingController();

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.reverseTitle),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.reverseMessage, style: context.textTheme.bodyMedium),
            const Gap.vertical(height: AppSpacing.sm),
            TextFormField(
              key: LedgerEntryPage.reasonFieldKey,
              controller: _reason,
              maxLength: 300,
              decoration: InputDecoration(labelText: l10n.reverseReasonLabel),
              validator: (value) => (value?.trim().isEmpty ?? true)
                  ? l10n.reverseReasonRequired
                  : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: customColors.unverified,
            minimumSize: const Size(0, 44),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop(_reason.text.trim());
            }
          },
          child: Text(l10n.confirm),
        ),
      ],
    );
  }
}
