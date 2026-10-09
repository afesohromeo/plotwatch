import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// One stage: status, budget, planned dates and the checklist of required
/// evidence with its progress (STG-04, STG-08). The owner edits it until it
/// is submitted and deletes it before it starts; the site manager starts it
/// once the site is validated (doc/04c M3-6, M3-8).
class StagePage extends StatefulWidget {
  const StagePage({
    super.key,
    required this.projectId,
    required this.stageId,
    this.isWeb = kIsWeb,
  });

  final int projectId;
  final int stageId;

  /// The web has no camera (check V1): no Take a photo button there.
  final bool isWeb;

  static const editButtonKey = Key('stage.edit');
  static const deleteButtonKey = Key('stage.delete');
  static const startButtonKey = Key('stage.start');
  static const refreshButtonKey = Key('stage.refresh');
  static const submitButtonKey = Key('stage.submit');
  static const approveButtonKey = Key('stage.approve');
  static const requestChangesButtonKey = Key('stage.requestChanges');
  static const reviewCommentFieldKey = Key('stage.reviewComment');
  static Key captureButtonKey(int itemId) => Key('stage.capture.$itemId');
  static Key captureTileKey(int evidenceId) => Key('stage.photo.$evidenceId');

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
                switch (state.action) {
                  StageAction.submit => l10n.stageSubmittedDone,
                  StageAction.approve => l10n.stageApprovedDone,
                  StageAction.requestChanges => l10n.changesRequestedDone,
                  _ => l10n.stageStarted,
                },
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
                canCapture: state.canCapture && !widget.isWeb,
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
    required this.canCapture,
    required this.onRefresh,
  });

  final StageState state;
  final StageView view;

  /// The site manager on the phone, on an open stage (doc/04d M4-9).
  final bool canCapture;
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
          child: Wrap(
            spacing: AppSpacing.xs,
            children: [
              ProjectChip(
                label: stage.status.label(l10n),
                color: stage.status.color,
              ),
              // Schedule status (STG-10, doc/04e M5-10).
              if (stage.isLateOn(DateTime.now()))
                ProjectChip(
                  label: l10n.stageLate,
                  color: customColors.unverified,
                ),
            ],
          ),
        ),
        // What the approver asked for, for the site manager (M5-8).
        if (state.lastChangesRequested case final changes?) ...[
          const Gap.vertical(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: customColors.partial.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Text(
              l10n.changesRequestedBy(
                changes.reviewerName ?? '',
                changes.review.comment ?? '',
              ),
              style: context.textTheme.bodyMedium,
            ),
          ),
        ],
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
          _ChecklistItemRow(
            item: item,
            projectId: stage.projectId,
            stageId: stage.id!,
            captures: state.evidenceFor(item.id!),
            canCapture: canCapture,
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
        if (state.canSubmit) ...[
          const Gap.vertical(height: AppSpacing.lg),
          if (state.missingItems.isEmpty)
            SubmitButton(
              key: StagePage.submitButtonKey,
              label: l10n.submitStageAction,
              isLoading: state.actionStatus == GenericStatus.loading,
              onPressed: () => _submit(context, l10n, bloc),
            )
          else
            Text(
              l10n.submitMissingItems(
                state.missingItems.map((i) => i.label).join(', '),
              ),
              style: context.textTheme.bodyMedium,
            ),
        ],
        if (state.canReview) ...[
          const Gap.vertical(height: AppSpacing.lg),
          SubmitButton(
            key: StagePage.approveButtonKey,
            label: l10n.approveStageAction,
            isLoading: state.actionStatus == GenericStatus.loading,
            onPressed: () => _approve(context, l10n, bloc),
          ),
          const Gap.vertical(height: AppSpacing.sm),
          PrimaryButton(
            key: StagePage.requestChangesButtonKey,
            withBg: false,
            width: double.infinity,
            onPressed: state.actionStatus == GenericStatus.loading
                ? null
                : () => _requestChanges(context, bloc),
            child: Text(l10n.requestChangesAction),
          ),
        ],
        if (state.reviews.isNotEmpty) ...[
          const Gap.vertical(height: AppSpacing.lg),
          Text(l10n.reviewHistoryTitle, style: context.textTheme.titleMedium),
          const Gap.vertical(height: AppSpacing.sm),
          for (final entry in state.reviews.reversed) _ReviewRow(entry: entry),
        ],
      ],
    );
  }

  Future<void> _submit(
    BuildContext context,
    AppLocalizations l10n,
    StageBloc bloc,
  ) async {
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.submitStageAction,
      message: l10n.submitStageMessage,
    );
    if (confirmed) bloc.add(const StageEvent.submitRequested());
  }

  Future<void> _approve(
    BuildContext context,
    AppLocalizations l10n,
    StageBloc bloc,
  ) async {
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.approveStageAction,
      message: l10n.approveStageMessage,
    );
    if (confirmed) {
      bloc.add(
        const StageEvent.reviewRequested(decision: ReviewDecision.approved),
      );
    }
  }

  Future<void> _requestChanges(BuildContext context, StageBloc bloc) async {
    final comment = await showDialog<String>(
      context: context,
      builder: (_) => const _ReviewCommentDialog(),
    );
    if (comment != null) {
      bloc.add(
        StageEvent.reviewRequested(
          decision: ReviewDecision.changesRequested,
          comment: comment,
        ),
      );
    }
  }
}

/// One review decision: what, who, when, and the comment (REV-05).
class _ReviewRow extends StatelessWidget {
  const _ReviewRow({required this.entry});

  final StageReviewView entry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final review = entry.review;
    final approved = review.decision == ReviewDecision.approved;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            approved ? Icons.check_circle_rounded : Icons.replay_rounded,
            size: 20,
            color: approved ? customColors.verified : customColors.partial,
          ),
          const Gap.horizontal(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.reviewDecisionBy(
                    approved
                        ? l10n.reviewApproved
                        : l10n.reviewChangesRequested,
                    entry.reviewerName ?? '',
                    formatDate(review.createdAt.toLocal(), withTime: true),
                  ),
                  style: context.textTheme.bodyMedium,
                ),
                if (review.comment != null)
                  Text(review.comment!, style: context.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Asks what must change; the comment is required (REV-03). Owns its text
/// controller, so it is disposed only once the dialog is gone.
class _ReviewCommentDialog extends StatefulWidget {
  const _ReviewCommentDialog();

  @override
  State<_ReviewCommentDialog> createState() => _ReviewCommentDialogState();
}

class _ReviewCommentDialogState extends State<_ReviewCommentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _comment = TextEditingController();

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.requestChangesAction),
      content: Form(
        key: _formKey,
        child: TextFormField(
          key: StagePage.reviewCommentFieldKey,
          controller: _comment,
          maxLength: 1000,
          minLines: 2,
          maxLines: 4,
          decoration: InputDecoration(labelText: l10n.reviewCommentLabel),
          validator: (value) => (value?.trim().isEmpty ?? true)
              ? l10n.validateReviewCommentRequired
              : null,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop(_comment.text.trim());
            }
          },
          child: Text(l10n.confirm),
        ),
      ],
    );
  }
}

/// One checklist item with its photos, newest first, and for the site
/// manager a Take a photo button (doc/04d group D).
class _ChecklistItemRow extends StatelessWidget {
  const _ChecklistItemRow({
    required this.item,
    required this.projectId,
    required this.stageId,
    required this.captures,
    required this.canCapture,
  });

  final ChecklistItem item;
  final int projectId;
  final int stageId;
  final List<Evidence> captures;
  final bool canCapture;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
          if (captures.isNotEmpty) ...[
            const Gap.vertical(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final capture in captures)
                  _CaptureTile(
                    key: StagePage.captureTileKey(capture.id!),
                    capture: capture,
                    onTap: () => context.goNamed(
                      evidenceRouteName,
                      pathParameters: {
                        'projectId': '$projectId',
                        'stageId': '$stageId',
                        'evidenceId': '${capture.id}',
                      },
                    ),
                  ),
              ],
            ),
          ],
          if (canCapture) ...[
            const Gap.vertical(height: AppSpacing.sm),
            PrimaryButton(
              key: StagePage.captureButtonKey(item.id!),
              withBg: false,
              onPressed: () => context.goNamed(
                captureRouteName,
                pathParameters: {
                  'projectId': '$projectId',
                  'stageId': '$stageId',
                  'itemId': '${item.id}',
                },
              ),
              child: Text(l10n.takePhotoAction),
            ),
          ],
        ],
      ),
    );
  }
}

/// A photo's thumbnail with its badge, or what is happening to it.
class _CaptureTile extends StatelessWidget {
  const _CaptureTile({super.key, required this.capture, required this.onTap});

  final Evidence capture;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // A photo exists only if the capture was finalized, even if withdrawn
    // since (doc/04d M4-F4).
    final shown =
        capture.status == EvidenceStatus.finalized ||
        (capture.status == EvidenceStatus.retracted &&
            capture.finalizedAt != null);

    return InkWell(
      // Every capture opens, also one never received (doc/04d M4-F4).
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: SizedBox(
        width: 132,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              child: Opacity(
                opacity: capture.status == EvidenceStatus.retracted ? .4 : 1,
                child: shown
                    ? EvidenceImage(
                        projectId: capture.projectId,
                        evidenceId: capture.id!,
                        variant: MediaVariant.thumbnail,
                        width: 132,
                        height: 99,
                      )
                    : Container(
                        width: 132,
                        height: 99,
                        color: customColors.muted.withValues(alpha: .15),
                        child: Icon(
                          Icons.cloud_upload_outlined,
                          color: customColors.muted,
                        ),
                      ),
              ),
            ),
            const Gap.vertical(height: AppSpacing.xs),
            switch (capture.status) {
              EvidenceStatus.finalized => VerificationBadge(
                level: capture.verificationLevel,
              ),
              EvidenceStatus.retracted => Text(
                l10n.captureRetracted,
                style: context.textTheme.bodySmall,
              ),
              EvidenceStatus.uploadFailed => Text(
                l10n.captureUploadFailed,
                style: context.textTheme.bodySmall?.copyWith(
                  color: customColors.unverified,
                ),
              ),
              // Nothing uploads once the phone left the capture (M4-F3).
              EvidenceStatus.committed => Text(
                l10n.captureNotReceived,
                style: context.textTheme.bodySmall,
              ),
            },
          ],
        ),
      ),
    );
  }
}
