import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Standing on the plot, the site manager or the owner saves the phone's GPS
/// position as the site location (decisions M2-15, M2-17; doc/04b G-4, G-5,
/// G-12). Phone app only: browsers' GPS is coarse and can't report mocked
/// positions.
class LocalizeSitePage extends StatefulWidget {
  const LocalizeSitePage({
    super.key,
    required this.projectId,
    this.isWeb = kIsWeb,
  });

  final int projectId;

  /// Set in tests; the web app only shows the "use your phone" message.
  final bool isWeb;

  static const saveButtonKey = Key('localize.save');
  static const allowButtonKey = Key('localize.allow');
  static const settingsButtonKey = Key('localize.settings');

  @override
  State<LocalizeSitePage> createState() => _LocalizeSitePageState();
}

class _LocalizeSitePageState extends State<LocalizeSitePage> {
  @override
  void initState() {
    super.initState();
    if (!widget.isWeb) _start();
  }

  void _start() => context.read<LocalizeSiteBloc>().add(
    LocalizeSiteEvent.started(projectId: widget.projectId),
  );

  void _backToProject() => context.goNamed(
    projectRouteName,
    pathParameters: {'projectId': '${widget.projectId}'},
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<LocalizeSiteBloc>();

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        leading: BackButton(onPressed: _backToProject),
        title: Text(l10n.localizeSiteTitle),
        bottom: ProjectBreadcrumbBar(
          projectId: widget.projectId,
          leaf: l10n.localizeSiteTitle,
        ),
      ),
      mobileBody: widget.isWeb
          ? AuthFormLayout(
              title: l10n.localizeSiteTitle,
              children: [
                Text(
                  l10n.localizePhoneOnly,
                  style: context.textTheme.bodyLarge,
                ),
              ],
            )
          : BlocConsumer<LocalizeSiteBloc, LocalizeSiteState>(
              listenWhen: (previous, current) =>
                  previous.proposeStatus != current.proposeStatus,
              listener: (context, state) {
                void reset() =>
                    bloc.add(const LocalizeSiteEvent.resetFlowStep());
                if (state.proposeStatus == GenericStatus.success) {
                  if (state.myRole == ProjectRole.owner) {
                    // The owner validates at once (G-12).
                    context.goNamed(
                      validateSiteRouteName,
                      pathParameters: {'projectId': '${widget.projectId}'},
                    );
                  } else {
                    DialogUtils.handleSuccess(
                      context,
                      l10n.siteProposalSent,
                      postActions: [reset, _backToProject],
                    );
                  }
                } else if (state.proposeStatus == GenericStatus.failure &&
                    state.proposeErrorMessage != null) {
                  DialogUtils.handleFailure(
                    context,
                    state.proposeErrorMessage!,
                    postActions: [reset],
                  );
                }
              },
              builder: (context, state) => AuthFormLayout(
                title: l10n.localizeSiteTitle,
                subtitle: l10n.localizeSiteHint,
                children: _body(context, state, bloc, l10n),
              ),
            ),
    );
  }

  List<Widget> _body(
    BuildContext context,
    LocalizeSiteState state,
    LocalizeSiteBloc bloc,
    AppLocalizations l10n,
  ) {
    if (state.loadErrorMessage != null) {
      return [
        Text(state.loadErrorMessage!, style: context.textTheme.bodyLarge),
      ];
    }
    void openSettings() =>
        bloc.add(const LocalizeSiteEvent.settingsRequested());

    return switch (state.access) {
      null => [
        const Center(child: CircularProgressIndicator()),
        const Gap.vertical(height: AppSpacing.md),
        Text(l10n.gettingPosition, textAlign: TextAlign.center),
      ],
      LocationAccess.denied => _blocked(
        context,
        l10n.locationDenied,
        SubmitButton(
          key: LocalizeSitePage.allowButtonKey,
          label: l10n.allowLocation,
          onPressed: _start,
        ),
      ),
      LocationAccess.deniedForever => _blocked(
        context,
        l10n.locationDeniedForever,
        SubmitButton(
          key: LocalizeSitePage.settingsButtonKey,
          label: l10n.openSettings,
          onPressed: openSettings,
        ),
      ),
      LocationAccess.serviceDisabled => _blocked(
        context,
        l10n.locationServiceOff,
        SubmitButton(
          key: LocalizeSitePage.settingsButtonKey,
          label: l10n.turnOnLocation,
          onPressed: openSettings,
        ),
      ),
      LocationAccess.granted => _reading(context, state, bloc, l10n),
    };
  }

  List<Widget> _blocked(BuildContext context, String message, Widget action) =>
      [
        Text(message, style: context.textTheme.bodyLarge),
        const Gap.vertical(height: AppSpacing.lg),
        action,
      ];

  List<Widget> _reading(
    BuildContext context,
    LocalizeSiteState state,
    LocalizeSiteBloc bloc,
    AppLocalizations l10n,
  ) {
    final reading = state.reading;
    if (reading == null) {
      return [
        const Center(child: CircularProgressIndicator()),
        const Gap.vertical(height: AppSpacing.md),
        Text(l10n.gettingPosition, textAlign: TextAlign.center),
      ];
    }
    final accurate = reading.accuracyM <= maxGpsAccuracyM;
    final tone = accurate ? customColors.verified : customColors.partial;

    return [
      Center(
        child: Text(
          l10n.accuracyMeters(reading.accuracyM.round()),
          style: context.textTheme.displaySmall?.copyWith(color: tone),
        ),
      ),
      const Gap.vertical(height: AppSpacing.sm),
      Text(
        reading.isMocked
            ? l10n.errorSiteMockLocation
            : accurate
            ? l10n.accuracyGood
            : l10n.accuracyWaiting,
        textAlign: TextAlign.center,
        style: context.textTheme.bodyMedium?.copyWith(
          color: reading.isMocked ? customColors.unverified : null,
        ),
      ),
      const Gap.vertical(height: AppSpacing.sm),
      Text(
        '${reading.latitude.toStringAsFixed(6)}, '
        '${reading.longitude.toStringAsFixed(6)}',
        textAlign: TextAlign.center,
        style: context.textTheme.bodySmall,
      ),
      const Gap.vertical(height: AppSpacing.lg),
      SubmitButton(
        key: LocalizeSitePage.saveButtonKey,
        label: l10n.saveLocationAction,
        isLoading: state.proposeStatus == GenericStatus.loading,
        onPressed: state.canPropose
            ? () => bloc.add(
                LocalizeSiteEvent.proposeRequested(projectId: widget.projectId),
              )
            : null,
      ),
    ];
  }
}
