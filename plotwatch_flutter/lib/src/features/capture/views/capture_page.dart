import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The site manager takes a photo for one checklist item: the in-app camera
/// with the GPS accuracy and inside/outside the site shown live, a review
/// with an optional caption, the sending steps, and the badge with each
/// check (CAP-01–06, VER-03, VER-10; doc/04d group C). No gallery anywhere.
class CapturePage extends StatefulWidget {
  const CapturePage({
    super.key,
    required this.projectId,
    required this.stageId,
    required this.itemId,
    this.isWeb = kIsWeb,
  });

  final int projectId;
  final int stageId;
  final int itemId;

  /// The web has no camera flow (check V1); photos come from the phone app.
  final bool isWeb;

  static const shutterKey = Key('capture.shutter');
  static const allowCameraKey = Key('capture.allowCamera');
  static const captionFieldKey = Key('capture.caption');
  static const sendKey = Key('capture.send');
  static const retakeKey = Key('capture.retake');
  static const retryKey = Key('capture.retry');
  static const doneKey = Key('capture.done');

  @override
  State<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  final _caption = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (!widget.isWeb) _start();
  }

  void _start() => context.read<CaptureBloc>().add(
    CaptureEvent.started(
      projectId: widget.projectId,
      stageId: widget.stageId,
      itemId: widget.itemId,
    ),
  );

  @override
  void dispose() {
    _caption.dispose();
    super.dispose();
  }

  void _backToStage() => context.goNamed(
    stageRouteName,
    pathParameters: {
      'projectId': '${widget.projectId}',
      'stageId': '${widget.stageId}',
    },
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        leading: BackButton(onPressed: _backToStage),
        title: Text(l10n.captureTitle),
        resizeToAvoidBottomInset: true,
      ),
      mobileBody: widget.isWeb
          ? AuthFormLayout(
              title: l10n.captureTitle,
              children: [
                Text(l10n.capturePhoneOnly, style: context.textTheme.bodyLarge),
              ],
            )
          : BlocBuilder<CaptureBloc, CaptureState>(
              builder: (context, state) => switch (state.loadStatus) {
                GenericStatus.failure => ErrorrWidget(
                  errorMessage: state.loadErrorMessage ?? l10n.errorStagesLoad,
                  refreshText: l10n.refresh,
                  onPressed: _start,
                ),
                GenericStatus.success => switch (state.step) {
                  CaptureStep.camera => _camera(context, state, l10n),
                  CaptureStep.review => _review(context, state, l10n),
                  CaptureStep.sending => _sending(context, state, l10n),
                  CaptureStep.done => _result(context, state, l10n),
                },
                _ => const Center(child: CircularProgressIndicator()),
              },
            ),
    );
  }

  Widget _camera(
    BuildContext context,
    CaptureState state,
    AppLocalizations l10n,
  ) {
    final bloc = context.read<CaptureBloc>();
    return switch (state.cameraAccess) {
      null => const Center(child: CircularProgressIndicator()),
      CameraAccess.denied => AuthFormLayout(
        title: l10n.captureTitle,
        children: [
          Text(l10n.cameraDenied, style: context.textTheme.bodyLarge),
          const Gap.vertical(height: AppSpacing.lg),
          PrimaryButton(
            key: CapturePage.allowCameraKey,
            width: double.infinity,
            onPressed: () =>
                bloc.add(const CaptureEvent.cameraSettingsRequested()),
            child: Text(l10n.allowCamera),
          ),
        ],
      ),
      CameraAccess.unavailable => AuthFormLayout(
        title: l10n.captureTitle,
        children: [
          Text(l10n.cameraUnavailable, style: context.textTheme.bodyLarge),
        ],
      ),
      CameraAccess.ready => Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(
            color: Colors.black,
            child: Center(child: context.read<CameraProvider>().preview()),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: _GpsOverlay(state: state),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: AppSpacing.lg,
            child: Center(
              child: Semantics(
                button: true,
                label: l10n.takePhotoAction,
                child: GestureDetector(
                  key: CapturePage.shutterKey,
                  onTap: state.canShoot
                      ? () => bloc.add(const CaptureEvent.shutterPressed())
                      : null,
                  child: Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.white54, width: 6),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    };
  }

  Widget _review(
    BuildContext context,
    CaptureState state,
    AppLocalizations l10n,
  ) {
    final bloc = context.read<CaptureBloc>();
    return AuthFormLayout(
      title: state.itemLabel ?? l10n.captureTitle,
      subtitle: l10n.captureReviewHint,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          child: Image.memory(
            state.photo!,
            height: 320,
            fit: BoxFit.contain,
            gaplessPlayback: true,
          ),
        ),
        const Gap.vertical(height: AppSpacing.md),
        InputField(
          key: CapturePage.captionFieldKey,
          controller: _caption,
          labelText: l10n.labelCaptionOptional,
          maxlines: 2,
          validator: null,
        ),
        const Gap.vertical(height: AppSpacing.lg),
        SubmitButton(
          key: CapturePage.sendKey,
          label: l10n.usePhotoAction,
          onPressed: () =>
              bloc.add(CaptureEvent.sendRequested(caption: _caption.text)),
        ),
        const Gap.vertical(height: AppSpacing.sm),
        PrimaryButton(
          key: CapturePage.retakeKey,
          withBg: false,
          width: double.infinity,
          onPressed: () => bloc.add(const CaptureEvent.retakeRequested()),
          child: Text(l10n.retakeAction),
        ),
      ],
    );
  }

  Widget _sending(
    BuildContext context,
    CaptureState state,
    AppLocalizations l10n,
  ) {
    final bloc = context.read<CaptureBloc>();
    final stepLabel = switch (state.sendStep) {
      SendStep.committing => l10n.sendStepCommitting,
      SendStep.uploading => l10n.sendStepUploading,
      SendStep.checking => l10n.sendStepChecking,
    };
    final failed = state.sendStatus == GenericStatus.failure;
    return AuthFormLayout(
      title: state.itemLabel ?? l10n.captureTitle,
      children: [
        if (failed) ...[
          Text(
            state.sendErrorMessage ?? l10n.errorCaptureSend,
            style: context.textTheme.bodyLarge,
          ),
          const Gap.vertical(height: AppSpacing.lg),
          SubmitButton(
            key: CapturePage.retryKey,
            label: l10n.retryAction,
            onPressed: () => bloc.add(const CaptureEvent.retryRequested()),
          ),
        ] else ...[
          const Center(child: CircularProgressIndicator()),
          const Gap.vertical(height: AppSpacing.md),
          Text(
            stepLabel,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyLarge,
          ),
        ],
      ],
    );
  }

  Widget _result(
    BuildContext context,
    CaptureState state,
    AppLocalizations l10n,
  ) {
    final evidence = state.evidence!;
    return AuthFormLayout(
      title: l10n.captureResultTitle,
      subtitle: state.itemLabel,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: VerificationBadge(level: evidence.verificationLevel),
        ),
        const Gap.vertical(height: AppSpacing.md),
        VerificationBreakdown(checks: evidence.checks ?? const []),
        const Gap.vertical(height: AppSpacing.sm),
        Text(l10n.verificationNotice, style: context.textTheme.bodySmall),
        const Gap.vertical(height: AppSpacing.lg),
        SubmitButton(
          key: CapturePage.doneKey,
          label: l10n.doneAction,
          onPressed: _backToStage,
        ),
      ],
    );
  }
}

/// The item, the GPS accuracy and inside/outside the site, over the camera.
class _GpsOverlay extends StatelessWidget {
  const _GpsOverlay({required this.state});

  final CaptureState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final reading = state.reading;
    final inside = state.isInsideSite;
    final white = context.textTheme.bodyMedium?.copyWith(color: Colors.white);

    final (String gps, Color? tone) = switch (state.locationAccess) {
      LocationAccess.granted when reading == null => (l10n.captureNoFix, null),
      LocationAccess.granted => switch (inside) {
        true => (l10n.captureInsideSite, customColors.verified),
        false => (
          l10n.captureOutsideSite((state.distanceFromSiteM ?? 0).round()),
          customColors.unverified,
        ),
        null => ('', null),
      },
      null => (l10n.captureNoFix, null),
      _ => (l10n.captureLocationOff, customColors.unverified),
    };

    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (state.itemLabel != null)
            Text(
              state.itemLabel!,
              style: context.textTheme.titleMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          const Gap.vertical(height: AppSpacing.xs),
          Row(
            children: [
              if (reading != null) ...[
                Text(
                  l10n.captureAccuracy(reading.accuracyM.round()),
                  style: white,
                ),
                const Gap.horizontal(width: AppSpacing.md),
              ],
              if (gps.isNotEmpty)
                Flexible(
                  child: Text(
                    gps,
                    style: white?.copyWith(
                      color: tone ?? Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
