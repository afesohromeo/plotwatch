import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Builds the map of the proposed point and circle; replaced in widget tests
/// because the Google map can't render there (doc/04b G-8).
typedef SiteMapBuilder =
    Widget Function(double latitude, double longitude, int radiusM);

/// The owner reviews the proposed location on a satellite map, sets the
/// radius and validates it, or rejects it (decisions M2-15, M2-16, M2-18;
/// doc/04b G-6). The first validation makes the project active.
class ValidateSitePage extends StatefulWidget {
  const ValidateSitePage({super.key, required this.projectId, this.mapBuilder});

  final int projectId;
  final SiteMapBuilder? mapBuilder;

  static const radiusSliderKey = Key('validateSite.radius');
  static const addressFieldKey = Key('validateSite.address');
  static const validateButtonKey = Key('validateSite.validate');
  static const rejectButtonKey = Key('validateSite.reject');
  static const rejectReasonFieldKey = Key('validateSite.rejectReason');

  @override
  State<ValidateSitePage> createState() => _ValidateSitePageState();
}

class _ValidateSitePageState extends State<ValidateSitePage> {
  final _address = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ValidateSiteBloc>().add(
      ValidateSiteEvent.load(projectId: widget.projectId),
    );
  }

  @override
  void dispose() {
    _address.dispose();
    super.dispose();
  }

  void _backToProject() => context.goNamed(
    projectRouteName,
    pathParameters: {'projectId': '${widget.projectId}'},
  );

  /// Null when cancelled; an empty reason is allowed (decision M2-18).
  Future<String?> _askRejectReason() => showDialog<String>(
    context: context,
    builder: (context) => const _RejectReasonDialog(),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<ValidateSiteBloc>();

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        leading: BackButton(onPressed: _backToProject),
        title: Text(l10n.validateSiteTitle),
        resizeToAvoidBottomInset: true,
      ),
      mobileBody: BlocConsumer<ValidateSiteBloc, ValidateSiteState>(
        listenWhen: (previous, current) =>
            previous.actionStatus != current.actionStatus,
        listener: (context, state) {
          void reset() => bloc.add(const ValidateSiteEvent.resetFlowStep());
          if (state.actionStatus == GenericStatus.success) {
            DialogUtils.handleSuccess(
              context,
              state.flowStep == GenericFlowStep.deletingItem
                  ? l10n.siteRejected
                  : l10n.siteValidated,
              postActions: [reset, _backToProject],
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
          final proposal = state.proposal;
          return switch (state.loadStatus) {
            GenericStatus.failure => ErrorrWidget(
              errorMessage: state.loadErrorMessage ?? l10n.errorSiteLoad,
              refreshText: l10n.refresh,
              onPressed: () =>
                  bloc.add(ValidateSiteEvent.load(projectId: widget.projectId)),
            ),
            GenericStatus.success when proposal == null => AuthFormLayout(
              title: l10n.validateSiteTitle,
              children: [
                Text(
                  l10n.noPendingProposal,
                  style: context.textTheme.bodyLarge,
                ),
              ],
            ),
            GenericStatus.success => _review(context, state, proposal!, l10n),
            _ => const Center(child: CircularProgressIndicator()),
          };
        },
      ),
    );
  }

  Widget _review(
    BuildContext context,
    ValidateSiteState state,
    SiteProposal proposal,
    AppLocalizations l10n,
  ) {
    final bloc = context.read<ValidateSiteBloc>();
    final isBusy = state.actionStatus == GenericStatus.loading;
    final map =
        (widget.mapBuilder ??
        (lat, lng, radius) => SiteMap(
          latitude: lat,
          longitude: lng,
          radiusM: radius,
        ))(proposal.lat, proposal.lng, state.radiusM);

    return AuthFormLayout(
      title: l10n.validateSiteTitle,
      subtitle: l10n.validateSiteHint,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          child: SizedBox(height: 280, child: map),
        ),
        const Gap.vertical(height: AppSpacing.md),
        DetailRow(
          label: l10n.labelAccuracy,
          value: l10n.accuracyMeters(proposal.accuracyM.round()),
        ),
        DetailRow(
          label: l10n.labelReadAt,
          value: formatDate(proposal.proposedAt.toLocal(), withTime: true),
        ),
        SiteRadiusField(
          sliderKey: ValidateSitePage.radiusSliderKey,
          radiusM: state.radiusM,
          onChanged: (radiusM) =>
              bloc.add(ValidateSiteEvent.radiusChanged(radiusM: radiusM)),
        ),
        const Gap.vertical(height: AppSpacing.md),
        InputField(
          key: ValidateSitePage.addressFieldKey,
          controller: _address,
          labelText: l10n.labelAddressOptional,
          validator: null,
        ),
        const Gap.vertical(height: AppSpacing.lg),
        SubmitButton(
          key: ValidateSitePage.validateButtonKey,
          label: l10n.validateAction,
          isLoading: isBusy && state.flowStep == GenericFlowStep.updatingItem,
          onPressed: () {
            final address = _address.text.trim();
            bloc.add(
              ValidateSiteEvent.validateRequested(
                addressText: address.isEmpty ? null : address,
              ),
            );
          },
        ),
        const Gap.vertical(height: AppSpacing.sm),
        PrimaryButton(
          key: ValidateSitePage.rejectButtonKey,
          withBg: false,
          width: double.infinity,
          onPressed: isBusy
              ? null
              : () async {
                  final reason = await _askRejectReason();
                  if (reason == null) return;
                  bloc.add(
                    ValidateSiteEvent.rejectRequested(
                      reason: reason.isEmpty ? null : reason,
                    ),
                  );
                },
          child: Text(l10n.rejectAction),
        ),
      ],
    );
  }
}

/// Asks for an optional reason before rejecting. Owns its text controller,
/// so it is disposed only once the dialog is gone, after its closing
/// animation (disposing it when the dialog returned broke that animation).
class _RejectReasonDialog extends StatefulWidget {
  const _RejectReasonDialog();

  @override
  State<_RejectReasonDialog> createState() => _RejectReasonDialogState();
}

class _RejectReasonDialogState extends State<_RejectReasonDialog> {
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
      title: Text(l10n.rejectReasonTitle),
      content: TextField(
        key: ValidateSitePage.rejectReasonFieldKey,
        controller: _reason,
        maxLength: 500,
        decoration: InputDecoration(labelText: l10n.rejectReasonLabel),
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
          onPressed: () => Navigator.of(context).pop(_reason.text.trim()),
          child: Text(l10n.confirm),
        ),
      ],
    );
  }
}
