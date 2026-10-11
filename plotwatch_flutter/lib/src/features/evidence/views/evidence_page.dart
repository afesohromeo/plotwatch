import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// One capture: the photo, its badge, each check explained, what the phone
/// and the server recorded, and the reminder that verification proves where
/// and when, not quality (VER-03, VER-10). Its author can retract it with a
/// reason (CAP-09, doc/04d M4-11).
class EvidencePage extends StatefulWidget {
  const EvidencePage({
    super.key,
    required this.projectId,
    required this.stageId,
    required this.evidenceId,
  });

  final int projectId;
  final int stageId;
  final int evidenceId;

  static const retractButtonKey = Key('evidence.retract');
  static const retractReasonFieldKey = Key('evidence.retractReason');

  @override
  State<EvidencePage> createState() => _EvidencePageState();
}

class _EvidencePageState extends State<EvidencePage> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() => context.read<EvidenceBloc>().add(
    EvidenceEvent.load(
      projectId: widget.projectId,
      stageId: widget.stageId,
      evidenceId: widget.evidenceId,
    ),
  );

  void _backToStage() => context.goNamed(
    stageRouteName,
    pathParameters: {
      'projectId': '${widget.projectId}',
      'stageId': '${widget.stageId}',
    },
  );

  Future<void> _retract() async {
    final bloc = context.read<EvidenceBloc>();
    final reason = await showDialog<String>(
      context: context,
      builder: (_) => const _RetractReasonDialog(),
    );
    if (reason != null) {
      bloc.add(EvidenceEvent.retractRequested(reason: reason));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<EvidenceBloc>();

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        leading: BackButton(onPressed: _backToStage),
        // The checklist item it was taken for (canvas P-Photo).
        title: BlocSelector<EvidenceBloc, EvidenceState, String?>(
          selector: (state) => state.itemLabel,
          builder: (context, label) => Text(
            label ?? l10n.evidenceTitle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        bottom: _EvidenceBreadcrumb(
          projectId: widget.projectId,
          stageId: widget.stageId,
        ),
      ),
      mobileBody: BlocConsumer<EvidenceBloc, EvidenceState>(
        listenWhen: (previous, current) =>
            previous.actionStatus != current.actionStatus,
        listener: (context, state) {
          void reset() => bloc.add(const EvidenceEvent.resetFlowStep());
          if (state.actionStatus == GenericStatus.success) {
            DialogUtils.handleSuccess(
              context,
              l10n.captureRetractedDone,
              // Back to the stage, as after deleting a stage (M4-F5).
              postActions: [reset, _backToStage],
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
          final evidence = state.evidence;
          return switch (state.loadStatus) {
            GenericStatus.failure => ErrorrWidget(
              errorMessage: state.loadErrorMessage ?? l10n.errorEvidenceLoad,
              refreshText: l10n.refresh,
              onPressed: _load,
            ),
            _ when evidence != null => _EvidenceBody(
              evidence: evidence,
              daysLate: daysAfterPlannedEnd(
                evidence.deviceCapturedAt,
                state.stage?.plannedEnd,
              ),
              plannedEnd: state.stage?.plannedEnd,
              canRetract: state.canRetract,
              isRetracting: state.actionStatus == GenericStatus.loading,
              onRetract: _retract,
            ),
            _ => const EvidenceSkeleton(),
          };
        },
      ),
    );
  }
}

class _EvidenceBody extends StatelessWidget {
  const _EvidenceBody({
    required this.evidence,
    required this.daysLate,
    required this.plannedEnd,
    required this.canRetract,
    required this.isRetracting,
    required this.onRetract,
  });

  final Evidence evidence;

  /// Days after the stage's planned end it was taken, if any (M5-10).
  final int? daysLate;
  final DateTime? plannedEnd;
  final bool canRetract;
  final bool isRetracting;
  final VoidCallback onRetract;

  static const checksToggleKey = Key('evidence.checks');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final retracted = evidence.status == EvidenceStatus.retracted;
    final received =
        evidence.status == EvidenceStatus.finalized ||
        (retracted && evidence.finalizedAt != null);
    String time(DateTime value) => dayAndTime(value, l10n);
    final lat = evidence.lat;
    final lng = evidence.lng;
    final accuracy = evidence.accuracyM;
    final distance = evidence.distanceFromSiteM;
    final checks = evidence.checks ?? const <VerificationCheck>[];
    final passed = checks.where((c) => c.passed).length;
    final level = evidence.verificationLevel;

    // The design's verdict block: the badge's colour, the result in words.
    final verdict = received && !retracted
        ? Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: switch (level) {
                VerificationLevel.verified => customColors.verifiedSoft,
                VerificationLevel.partiallyVerified => customColors.partialSoft,
                VerificationLevel.unverified => customColors.unverifiedSoft,
                VerificationLevel.pending => customColors.lineSoft,
              },
              borderRadius: BorderRadius.circular(PlotwatchTheme.cardRadius),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: level.color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(switch (level) {
                    VerificationLevel.verified => Icons.check_rounded,
                    VerificationLevel.partiallyVerified =>
                      Icons.priority_high_rounded,
                    VerificationLevel.unverified => Icons.close_rounded,
                    VerificationLevel.pending => Icons.hourglass_top_rounded,
                  }, color: customColors.onPrimary),
                ),
                const Gap.horizontal(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        level.label(l10n),
                        style: context.textTheme.titleMedium?.copyWith(
                          color: level.color,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (checks.isNotEmpty)
                        Text(
                          [
                            l10n.checksPassed(passed, checks.length),
                            if (distance != null)
                              l10n.distanceFromCentre(distance.round()),
                          ].join(' · '),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: customColors.ink,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : null;

    final notReceived = received
        ? null
        : Text(
            l10n.captureNeverReceived,
            style: context.textTheme.bodyLarge?.copyWith(
              color: customColors.unverified,
            ),
          );
    final reason = retracted
        ? Text(
            l10n.captureRetractedReason(evidence.retractedReason ?? ''),
            style: context.textTheme.bodyLarge?.copyWith(
              color: customColors.unverified,
            ),
          )
        : null;
    // Information only: lateness never changes the badge (M5-10).
    final late = switch (daysLate) {
      final days? => Text(
        l10n.takenAfterPlannedEnd(days, formatDate(plannedEnd!)),
        style: context.textTheme.bodyMedium?.copyWith(
          color: customColors.partial,
        ),
      ),
      null => null,
    };

    final details = AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Column(
        children: [
          if (evidence.capturedByName case final name?)
            _InfoRow(
              label: l10n.labelTakenBy,
              value: personLabel(l10n, name, former: evidence.capturedByFormer),
            ),
          _InfoRow(
            label: l10n.labelTakenAt,
            value: time(evidence.deviceCapturedAt),
          ),
          _InfoRow(
            label: l10n.labelReceivedAt,
            value: time(evidence.serverCommittedAt),
          ),
          _InfoRow(
            label: l10n.labelPosition,
            value: lat == null || lng == null
                ? l10n.notSet
                : '${lat.toStringAsFixed(5)}, ${lng.toStringAsFixed(5)}',
          ),
          if (accuracy != null)
            _InfoRow(
              label: l10n.labelAccuracy,
              value: l10n.accuracyMeters(accuracy.round()),
            ),
          _InfoRow(
            label: l10n.labelDevice,
            value: '${evidence.deviceModel} · ${evidence.osVersion}',
          ),
          _InfoRow(
            label: l10n.labelAppVersion,
            value: evidence.appVersion,
            last: true,
          ),
        ],
      ),
    );

    final checksCard = received && checks.isNotEmpty
        ? _ChecksCard(checks: checks)
        : null;
    final retract = canRetract
        ? PrimaryButton(
            key: EvidencePage.retractButtonKey,
            withBg: false,
            width: double.infinity,
            onPressed: isRetracting ? null : onRetract,
            child: Text(l10n.retractAction),
          )
        : null;

    Widget photo({required double height, required bool rounded}) => ClipRRect(
      borderRadius: BorderRadius.circular(
        rounded ? PlotwatchTheme.cardRadius : 0,
      ),
      child: ColoredBox(
        color: customColors.ink,
        child: Opacity(
          opacity: retracted ? .4 : 1,
          child: EvidenceImage(
            projectId: evidence.projectId,
            evidenceId: evidence.id!,
            variant: MediaVariant.photo,
            width: double.infinity,
            height: height,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 840) {
          // The photo and its verdict, the details beside (DP-8).
          return ContentLayout(
            main: [
              if (evidence.caption case final caption?)
                Text(caption, style: context.textTheme.bodyLarge),
              ?notReceived,
              if (received) photo(height: 480, rounded: true),
              ?verdict,
              ?reason,
            ],
            side: [?late, details, ?checksCard, ?retract],
          );
        }
        // On a phone the photo runs edge to edge (doc/05 §9.3).
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (received) photo(height: 260, rounded: false),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final part in [
                      if (evidence.caption case final caption?)
                        Text(caption, style: context.textTheme.bodyLarge),
                      ?notReceived,
                      ?verdict,
                      ?reason,
                      // Details · Checks, one at a time (doc/05 §9.4).
                      if (received && checks.isNotEmpty)
                        SegmentedPanels(
                          panels: [
                            Panel(
                              label: l10n.evidenceDetailsTitle,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  if (late != null) ...[
                                    late,
                                    const Gap.vertical(height: 12),
                                  ],
                                  details,
                                ],
                              ),
                            ),
                            Panel(
                              label: l10n.checksTitle,
                              child: AppCard(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    VerificationBreakdown(checks: checks),
                                    Text(
                                      l10n.verificationNotice,
                                      style: context.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      else ...[
                        ?late,
                        details,
                      ],
                      ?retract,
                    ]) ...[part, const Gap.vertical(height: 12)],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// A label on the left, its value on the right in bold (doc/05 §9.3).
class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value, this.last = false});

  final String label;
  final String value;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: last
            ? null
            : Border(bottom: BorderSide(color: customColors.lineSoft)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(fontSize: 14),
          ),
          const Gap.horizontal(width: AppSpacing.md),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: context.textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}

/// "See the 8 checks": opens the list of checks under it.
class _ChecksCard extends StatefulWidget {
  const _ChecksCard({required this.checks});

  final List<VerificationCheck> checks;

  @override
  State<_ChecksCard> createState() => _ChecksCardState();
}

class _ChecksCardState extends State<_ChecksCard> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            key: _EvidenceBody.checksToggleKey,
            onTap: () => setState(() => _open = !_open),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.seeChecks(widget.checks.length),
                      style: context.textTheme.titleSmall?.copyWith(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Icon(
                    _open
                        ? Icons.expand_less_rounded
                        : Icons.chevron_right_rounded,
                    color: customColors.muted,
                  ),
                ],
              ),
            ),
          ),
          if (_open) ...[
            VerificationBreakdown(checks: widget.checks),
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Text(
                l10n.verificationNotice,
                style: context.textTheme.bodySmall,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Asks for the reason before retracting; it is required (CAP-09). Owns its
/// text controller, so it is disposed only once the dialog is gone.
class _RetractReasonDialog extends StatefulWidget {
  const _RetractReasonDialog();

  @override
  State<_RetractReasonDialog> createState() => _RetractReasonDialogState();
}

class _RetractReasonDialogState extends State<_RetractReasonDialog> {
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
      title: Text(l10n.retractTitle),
      content: Form(
        key: _formKey,
        child: TextFormField(
          key: EvidencePage.retractReasonFieldKey,
          controller: _reason,
          maxLength: 500,
          decoration: InputDecoration(labelText: l10n.retractReasonLabel),
          validator: (value) => (value?.trim().isEmpty ?? true)
              ? l10n.validateRetractReasonRequired
              : null,
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

/// Projects › {project} › Stages › {stage} › Photo (doc/05 §9 DP-5), with
/// the names once the page has loaded them.
class _EvidenceBreadcrumb extends StatelessWidget
    implements PreferredSizeWidget {
  const _EvidenceBreadcrumb({required this.projectId, required this.stageId});

  final int projectId;
  final int stageId;

  @override
  Size get preferredSize => const Size.fromHeight(36);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<EvidenceBloc, EvidenceState>(
      buildWhen: (previous, current) =>
          previous.stage != current.stage ||
          previous.overview != current.overview,
      builder: (context, state) => ProjectBreadcrumbBar(
        projectId: projectId,
        projectName: state.overview?.project.name,
        section: ProjectTab.stages,
        stage: (id: stageId, name: state.stage?.name),
        leaf: l10n.evidenceTitle,
      ),
    );
  }
}
