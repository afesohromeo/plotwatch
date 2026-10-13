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
  static const releaseOfferKey = Key('stage.releaseOffer');
  static const releaseLaterKey = Key('stage.releaseLater');
  static Key photoKey(int evidenceId) => Key('stage.grid.$evidenceId');

  /// The photos' badge chips (doc/05 §9.5): `stage.photos.badge.<index>`
  /// in [photoBadgeChoices] order.
  static const photoBadgeChipsPrefix = 'stage.photos.badge';

  /// The checklist item picker; its choices are `stage.photos.item.<index>`,
  /// "All items" first.
  static const photoItemPickerPrefix = 'stage.photos.item';
  static const morePhotosKey = Key('stage.photos.more');
  static const showLessKey = Key('stage.photos.less');

  static const photoBadgeChoices = <VerificationLevel?>[
    null,
    VerificationLevel.verified,
    VerificationLevel.partiallyVerified,
    VerificationLevel.unverified,
  ];

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

  /// After an approval, the approver may record the release that usually
  /// follows, for the next stage not approved yet (REV-06, doc/04g step 3).
  Future<void> _offerRelease(BuildContext context, StageState state) async {
    final l10n = AppLocalizations.of(context)!;
    final stages = state.overview?.stages ?? const <StageBrief>[];
    final at = stages.indexWhere((s) => s.id == widget.stageId);
    final next = at < 0
        ? null
        : stages
              .skip(at + 1)
              .where((s) => s.status != StageStatus.approved)
              .firstOrNull;
    final record = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.stageApprovedDone),
        content: Text(
          next == null ? l10n.releaseOfferAny : l10n.releaseOfferNext(next.name),
        ),
        actions: [
          TextButton(
            key: StagePage.releaseLaterKey,
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.laterAction),
          ),
          FilledButton(
            key: StagePage.releaseOfferKey,
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.recordReleaseAction),
          ),
        ],
      ),
    );
    if (record != true || !context.mounted) return;
    context.goNamed(
      createReleaseRouteName,
      pathParameters: {'projectId': '${widget.projectId}'},
      queryParameters: {if (next != null) 'stageId': '${next.id}'},
    );
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
            } else if (state.action == StageAction.approve) {
              reset();
              _offerRelease(context, state);
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
              bottom: ProjectBreadcrumbBar(
                projectId: widget.projectId,
                projectName: state.overview?.project.name,
                section: ProjectTab.stages,
                stage: (id: widget.stageId, name: view?.stage.name),
              ),
              actions: [
                AppBarMenu(
                  items: [
                    if (state.canEdit)
                      AppBarMenuItem(
                        key: StagePage.editButtonKey,
                        icon: Icons.edit_outlined,
                        label: l10n.editStageAction,
                        onTap: () => context.goNamed(
                          editStageRouteName,
                          pathParameters: {
                            'projectId': '${widget.projectId}',
                            'stageId': '${widget.stageId}',
                          },
                        ),
                      ),
                    if (state.canDelete && view != null)
                      AppBarMenuItem(
                        key: StagePage.deleteButtonKey,
                        icon: Icons.delete_outline_rounded,
                        label: l10n.deleteStageTitle(view.stage.name),
                        destructive: true,
                        onTap: () => _confirmDelete(view.stage.name, l10n),
                      ),
                    AppBarMenuItem(
                      key: StagePage.refreshButtonKey,
                      icon: Icons.refresh_rounded,
                      label: l10n.refresh,
                      onTap: _load,
                    ),
                  ],
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
              _ => const StageSkeleton(),
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
    final busy = state.actionStatus == GenericStatus.loading;
    String date(DateTime? value) =>
        value == null ? l10n.notSet : formatDate(value.toLocal());
    final photos = [
      for (final capture in state.evidence)
        if (capture.status == EvidenceStatus.finalized) capture,
    ].reversed.toList();

    // The status, the schedule and the budget on one line (doc/05 §9.3).
    final waiting = state.canReview;
    final header = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  ProjectChip(
                    label: waiting
                        ? l10n.waitingForYourReview
                        : stage.status.label(l10n),
                    color: waiting ? customColors.accent : stage.status.color,
                  ),
                  // Schedule status (STG-10, doc/04e M5-10).
                  if (stage.isLateOn(DateTime.now()))
                    ProjectChip(
                      label: stage.plannedEnd == null
                          ? l10n.stageLate
                          : '${l10n.stageLate} · ${formatDate(stage.plannedEnd!)}',
                      color: customColors.unverified,
                    ),
                ],
              ),
            ),
            Text(
              formatMoneyShort(
                stage.budgetMinor,
                state.currencyCode,
                locale: locale,
              ),
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        if (stage.plannedStart != null || stage.plannedEnd != null) ...[
          const Gap.vertical(height: 6),
          Text(
            '${l10n.labelColon(l10n.labelPlannedDates)} '
            '${date(stage.plannedStart)} – ${date(stage.plannedEnd)}',
            style: context.textTheme.bodySmall,
          ),
        ],
        if (stage.description case final description?) ...[
          const Gap.vertical(height: 6),
          Text(description, style: context.textTheme.bodySmall),
        ],
      ],
    );

    // What the approver asked for, for the site manager (M5-8).
    final changesBanner = switch (state.lastChangesRequested) {
      final changes? => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: customColors.accentSoft,
          borderRadius: BorderRadius.circular(PlotwatchTheme.cardRadius),
        ),
        child: Text(
          l10n.changesRequestedBy(
            changes.reviewerName ?? '',
            changes.review.comment ?? '',
          ),
          style: context.textTheme.bodyMedium?.copyWith(
            color: customColors.ink,
          ),
        ),
      ),
      null => null,
    };

    final checklist = AppCard(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${l10n.checklistTitle} · '
            '${l10n.stagesOfTotal(view.itemsCovered, view.items.length)}',
            style: context.textTheme.titleSmall,
          ),
          const Gap.vertical(height: 4),
          for (var i = 0; i < view.items.length; i++)
            _ChecklistItemRow(
              item: view.items[i],
              projectId: stage.projectId,
              stageId: stage.id!,
              captures: state.evidenceFor(view.items[i].id!),
              canCapture: canCapture,
              last: i == view.items.length - 1,
            ),
        ],
      ),
    );

    final actions = <Widget>[
      if (state.canStart)
        state.isProjectActive
            ? SubmitButton(
                key: StagePage.startButtonKey,
                label: l10n.startStageAction,
                isLoading: busy,
                onPressed: () => bloc.add(const StageEvent.startRequested()),
              )
            : Text(
                l10n.stageStartNeedsSite,
                style: context.textTheme.bodyMedium,
              ),
      if (state.canSubmit)
        state.missingItems.isEmpty
            ? SubmitButton(
                key: StagePage.submitButtonKey,
                label: l10n.submitStageAction,
                isLoading: busy,
                onPressed: () => _submit(context, l10n, bloc),
              )
            : Text(
                l10n.submitMissingItems(
                  state.missingItems.map((i) => i.label).join(', '),
                ),
                style: context.textTheme.bodyMedium,
              ),
    ];

    final grid = photos.isEmpty
        ? null
        : _StagePhotos(
            projectId: stage.projectId,
            photos: photos,
            items: view.items,
          );
    final history = state.reviews.isEmpty
        ? null
        : AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.reviewHistoryTitle,
                  style: context.textTheme.titleMedium,
                ),
                const Gap.vertical(height: AppSpacing.sm),
                for (final entry in state.reviews.reversed)
                  _ReviewRow(entry: entry),
              ],
            ),
          );

    final content = LayoutBuilder(
      builder: (context, constraints) => constraints.maxWidth >= 840
          ? ContentLayout(
              onRefresh: onRefresh,
              main: [header, ?changesBanner, checklist, ...actions],
              side: [?grid, ?history],
            )
          : ContentLayout(
              onRefresh: onRefresh,
              main: [
                header,
                ?changesBanner,
                // Checklist · Photos · History, one at a time (doc/05 §9.4).
                SegmentedPanels(
                  panels: [
                    Panel(
                      label: l10n.checklistShort,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          checklist,
                          for (final action in actions) ...[
                            const Gap.vertical(height: 14),
                            action,
                          ],
                        ],
                      ),
                    ),
                    if (grid != null)
                      Panel(label: l10n.photosTitle, child: grid),
                    if (history != null)
                      Panel(label: l10n.historyTitle, child: history),
                  ],
                ),
              ],
            ),
    );

    if (!state.canReview) return content;
    // Approve and Request changes stay in reach (doc/05 §9 DP-9).
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
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      key: StagePage.requestChangesButtonKey,
                      withBg: false,
                      width: double.infinity,
                      onPressed: busy
                          ? null
                          : () => _requestChanges(context, bloc),
                      // Two lines rather than shrunk: French is long
                      // (doc/04g step 5).
                      child: Text(
                        l10n.requestChangesAction,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const Gap.horizontal(width: 10),
                  Expanded(
                    child: SubmitButton(
                      key: StagePage.approveButtonKey,
                      label: l10n.approveStageAction,
                      isLoading: busy,
                      onPressed: () => _approve(context, l10n, bloc),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
    this.last = false,
  });

  final bool last;
  final ChecklistItem item;
  final int projectId;
  final int stageId;
  final List<Evidence> captures;
  final bool canCapture;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final finalized = [
      for (final c in captures)
        if (c.status == EvidenceStatus.finalized) c,
    ];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: BoxDecoration(
        border: last
            ? null
            : Border(bottom: BorderSide(color: customColors.lineSoft)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.label, style: context.textTheme.titleSmall),
                    Text(
                      '${item.isRequired ? l10n.checklistRequired : l10n.checklistOptional}'
                      ' · ${l10n.photoCount(finalized.length)}',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (finalized.isNotEmpty)
                VerificationBadge(level: finalized.last.verificationLevel),
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
                short: true,
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

/// The stage's finalized photos, newest first: the first one large, then
/// small ones, "+N" for the rest; each opens its page (doc/05 §9).
/// The stage's photos, newest first: the five-photo mosaic of the design,
/// or, after "+N" or with a filter, a grid of every matching photo. Filtered
/// by badge and by checklist item in the app: the stage's photos are loaded
/// whole (doc/05 §9.5).
class _StagePhotos extends StatefulWidget {
  const _StagePhotos({
    required this.projectId,
    required this.photos,
    required this.items,
  });

  final int projectId;
  final List<Evidence> photos;
  final List<ChecklistItem> items;

  static const shown = 5;

  @override
  State<_StagePhotos> createState() => _StagePhotosState();
}

class _StagePhotosState extends State<_StagePhotos> {
  VerificationLevel? _level;
  int? _itemId;
  bool _all = false;

  bool get _filtered => _level != null || _itemId != null;

  void _open(Evidence capture) => context.goNamed(
    evidenceRouteName,
    pathParameters: {
      'projectId': '${widget.projectId}',
      'stageId': '${capture.stageId}',
      'evidenceId': '${capture.id}',
    },
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final photos = widget.photos;
    final matching = [
      for (final capture in photos)
        if ((_level == null || capture.verificationLevel == _level) &&
            (_itemId == null || capture.checklistItemId == _itemId))
          capture,
    ];
    final grid = _all || _filtered;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.stagePhotosTitle,
                style: context.textTheme.titleMedium,
              ),
            ),
            if (_all && !_filtered)
              TextButton(
                key: StagePage.showLessKey,
                onPressed: () => setState(() => _all = false),
                child: Text(l10n.showLess),
              ),
          ],
        ),
        const Gap.vertical(height: AppSpacing.sm),
        if (photos.length > 1) ...[
          FilterChips<VerificationLevel?>(
            keyPrefix: StagePage.photoBadgeChipsPrefix,
            choices: [
              for (final level in StagePage.photoBadgeChoices)
                FilterChoice(level, switch (level) {
                  null => l10n.filterAll,
                  VerificationLevel.partiallyVerified => l10n.badgePartial,
                  final level => level.label(l10n),
                }),
            ],
            selected: _level,
            onSelected: (level) => setState(() => _level = level),
            trailing: [
              if (widget.items.length > 1)
                PickerPill<int?>(
                  keyPrefix: StagePage.photoItemPickerPrefix,
                  choices: [
                    FilterChoice(null, l10n.allItems),
                    for (final item in widget.items)
                      FilterChoice(item.id, item.label),
                  ],
                  selected: _itemId,
                  onSelected: (itemId) => setState(() => _itemId = itemId),
                ),
            ],
          ),
          const Gap.vertical(height: AppSpacing.sm),
        ],
        if (!grid)
          _mosaic(context)
        else if (matching.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
            child: Text(
              l10n.noPhotoHere,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium,
            ),
          )
        else
          GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (final capture in matching)
                _Thumbnail(
                  key: StagePage.photoKey(capture.id!),
                  projectId: widget.projectId,
                  capture: capture,
                  onTap: () => _open(capture),
                ),
            ],
          ),
      ],
    );
  }

  /// The design's mosaic: the newest large, four small; the last small one
  /// shows "+N" and opens the grid of all of them.
  Widget _mosaic(BuildContext context) {
    final photos = widget.photos;
    const shown = _StagePhotos.shown;
    final more = photos.length - shown;

    Widget photo(int i, {bool large = false}) {
      final capture = photos[i];
      final last = i == shown - 1 && more > 0;
      return InkWell(
        key: last ? StagePage.morePhotosKey : StagePage.photoKey(capture.id!),
        borderRadius: BorderRadius.circular(12),
        onTap: last ? () => setState(() => _all = true) : () => _open(capture),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              EvidenceImage(
                projectId: widget.projectId,
                evidenceId: capture.id!,
                variant: large ? MediaVariant.photo : MediaVariant.thumbnail,
              ),
              if (large)
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: VerificationBadge(
                    level: capture.verificationLevel,
                    onPhoto: true,
                  ),
                ),
              if (last)
                ColoredBox(
                  color: customColors.ink.withValues(alpha: .55),
                  child: Center(
                    child: Text(
                      '+$more',
                      style: context.textTheme.titleMedium?.copyWith(
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

    final small = [for (var i = 1; i < photos.length && i < shown; i++) i];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(aspectRatio: 4 / 3, child: photo(0, large: true)),
        if (small.isNotEmpty) ...[
          const Gap.vertical(height: 6),
          Row(
            children: [
              for (var k = 0; k < shown - 1; k++) ...[
                if (k > 0) const Gap.horizontal(width: 6),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: k < small.length
                        ? photo(small[k])
                        : const SizedBox.shrink(),
                  ),
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }
}

/// One photo of the grid, its badge as a dot in the corner.
class _Thumbnail extends StatelessWidget {
  const _Thumbnail({
    super.key,
    required this.projectId,
    required this.capture,
    required this.onTap,
  });

  final int projectId;
  final Evidence capture;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            EvidenceImage(
              projectId: projectId,
              evidenceId: capture.id!,
              variant: MediaVariant.thumbnail,
            ),
            Positioned(
              right: 6,
              top: 6,
              child: BadgeDot(level: capture.verificationLevel),
            ),
          ],
        ),
      ),
    );
  }
}
