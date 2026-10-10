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
        title: Text(l10n.evidenceTitle),
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
            _ => const Center(child: CircularProgressIndicator()),
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final retracted = evidence.status == EvidenceStatus.retracted;
    final received =
        evidence.status == EvidenceStatus.finalized ||
        (retracted && evidence.finalizedAt != null);
    String time(DateTime value) => formatDate(value.toLocal(), withTime: true);
    final lat = evidence.lat;
    final lng = evidence.lng;
    final accuracy = evidence.accuracyM;
    final distance = evidence.distanceFromSiteM;

    return AuthFormLayout(
      title: l10n.evidenceTitle,
      subtitle: evidence.caption,
      children: [
        // The phone recorded it, but the photo never arrived (M4-F4).
        if (!received) ...[
          Text(
            l10n.captureNeverReceived,
            style: context.textTheme.bodyLarge?.copyWith(
              color: customColors.unverified,
            ),
          ),
          if (retracted) ...[
            const Gap.vertical(height: AppSpacing.sm),
            Text(
              l10n.captureRetractedReason(evidence.retractedReason ?? ''),
              style: context.textTheme.bodyMedium,
            ),
          ],
        ] else ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            child: Opacity(
              opacity: retracted ? .4 : 1,
              child: EvidenceImage(
                projectId: evidence.projectId,
                evidenceId: evidence.id!,
                variant: MediaVariant.photo,
                height: 320,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const Gap.vertical(height: AppSpacing.md),
          if (retracted)
            Text(
              l10n.captureRetractedReason(evidence.retractedReason ?? ''),
              style: context.textTheme.bodyLarge?.copyWith(
                color: customColors.unverified,
              ),
            )
          else
            Align(
              alignment: Alignment.centerLeft,
              child: VerificationBadge(level: evidence.verificationLevel),
            ),
          const Gap.vertical(height: AppSpacing.md),
          Text(l10n.checksTitle, style: context.textTheme.titleMedium),
          const Gap.vertical(height: AppSpacing.sm),
          VerificationBreakdown(checks: evidence.checks ?? const []),
          Text(l10n.verificationNotice, style: context.textTheme.bodySmall),
        ],
        const Gap.vertical(height: AppSpacing.lg),
        Text(l10n.evidenceDetailsTitle, style: context.textTheme.titleMedium),
        // Information only: lateness never changes the badge (M5-10).
        if (daysLate case final days?) ...[
          const Gap.vertical(height: AppSpacing.xs),
          Text(
            l10n.takenAfterPlannedEnd(days, formatDate(plannedEnd!)),
            style: context.textTheme.bodyMedium?.copyWith(
              color: customColors.partial,
            ),
          ),
        ],
        const Gap.vertical(height: AppSpacing.sm),
        if (evidence.capturedByName case final name?)
          DetailRow(
            label: l10n.labelTakenBy,
            value: personLabel(l10n, name, former: evidence.capturedByFormer),
          ),
        DetailRow(
          label: l10n.labelTakenAt,
          value: time(evidence.deviceCapturedAt),
        ),
        DetailRow(
          label: l10n.labelReceivedAt,
          value: time(evidence.serverCommittedAt),
        ),
        DetailRow(
          label: l10n.labelPosition,
          value: lat == null || lng == null
              ? l10n.notSet
              : '${lat.toStringAsFixed(5)}, ${lng.toStringAsFixed(5)}',
        ),
        if (accuracy != null)
          DetailRow(
            label: l10n.labelAccuracy,
            value: l10n.accuracyMeters(accuracy.round()),
          ),
        if (distance != null)
          DetailRow(
            label: l10n.labelDistanceToSite,
            value: l10n.distanceMeters(distance.round()),
          ),
        DetailRow(
          label: l10n.labelDevice,
          value: '${evidence.deviceModel} · ${evidence.osVersion}',
        ),
        DetailRow(label: l10n.labelAppVersion, value: evidence.appVersion),
        if (canRetract) ...[
          const Gap.vertical(height: AppSpacing.lg),
          PrimaryButton(
            key: EvidencePage.retractButtonKey,
            withBg: false,
            width: double.infinity,
            onPressed: isRetracting ? null : onRetract,
            child: Text(l10n.retractAction),
          ),
        ],
      ],
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
