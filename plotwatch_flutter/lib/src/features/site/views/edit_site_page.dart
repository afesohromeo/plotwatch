import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The owner changes the radius and the address of the validated site on
/// the satellite map, without a new GPS reading (doc/04b H-3). Moving the
/// point needs a new reading on the plot (Propose a new location).
class EditSitePage extends StatefulWidget {
  const EditSitePage({super.key, required this.projectId, this.mapBuilder});

  final int projectId;

  /// Replaced in widget tests, where the Google map can't render (G-8).
  final SiteMapBuilder? mapBuilder;

  static const radiusSliderKey = Key('editSite.radius');
  static const addressFieldKey = Key('editSite.address');
  static const saveButtonKey = Key('editSite.save');

  @override
  State<EditSitePage> createState() => _EditSitePageState();
}

class _EditSitePageState extends State<EditSitePage> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() => context.read<EditSiteBloc>().add(
    EditSiteEvent.load(projectId: widget.projectId),
  );

  void _backToProject() => context.goNamed(
    projectRouteName,
    pathParameters: {'projectId': '${widget.projectId}'},
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        leading: BackButton(onPressed: _backToProject),
        title: Text(l10n.editSiteTitle),
        bottom: ProjectBreadcrumbBar(
          projectId: widget.projectId,
          leaf: l10n.editSiteTitle,
        ),
        resizeToAvoidBottomInset: true,
      ),
      mobileBody: BlocConsumer<EditSiteBloc, EditSiteState>(
        listenWhen: (previous, current) =>
            previous.actionStatus != current.actionStatus,
        listener: (context, state) {
          if (state.actionStatus == GenericStatus.success) {
            DialogUtils.handleSuccess(
              context,
              l10n.siteUpdated,
              postActions: [_backToProject],
            );
          } else if (state.actionStatus == GenericStatus.failure &&
              state.actionErrorMessage != null) {
            DialogUtils.handleFailure(context, state.actionErrorMessage!);
          }
        },
        builder: (context, state) {
          final site = state.site;
          return switch (state.loadStatus) {
            GenericStatus.failure => ErrorrWidget(
              errorMessage: state.loadErrorMessage ?? l10n.errorSiteLoad,
              refreshText: l10n.refresh,
              onPressed: _load,
            ),
            GenericStatus.success when site != null => _EditSiteForm(
              site: site,
              state: state,
              mapBuilder: widget.mapBuilder,
            ),
            _ => const Center(child: CircularProgressIndicator()),
          };
        },
      ),
    );
  }
}

/// Owns the address controller, filled once from the loaded site.
class _EditSiteForm extends StatefulWidget {
  const _EditSiteForm({
    required this.site,
    required this.state,
    required this.mapBuilder,
  });

  final Site site;
  final EditSiteState state;
  final SiteMapBuilder? mapBuilder;

  @override
  State<_EditSiteForm> createState() => _EditSiteFormState();
}

class _EditSiteFormState extends State<_EditSiteForm> {
  late final _address = TextEditingController(text: widget.site.addressText);

  @override
  void dispose() {
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<EditSiteBloc>();
    final site = widget.site;
    final radiusM = widget.state.radiusM;
    final map =
        (widget.mapBuilder ??
        (lat, lng, radius) => SiteMap(
          latitude: lat,
          longitude: lng,
          radiusM: radius,
        ))(site.centerLat, site.centerLng, radiusM);

    return AuthFormLayout(
      title: l10n.editSiteTitle,
      subtitle: l10n.editSiteHint,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          child: SizedBox(height: 280, child: map),
        ),
        const Gap.vertical(height: AppSpacing.md),
        DetailRow(label: l10n.labelPlusCode, value: site.plusCode),
        SiteRadiusField(
          sliderKey: EditSitePage.radiusSliderKey,
          radiusM: radiusM,
          onChanged: (radiusM) =>
              bloc.add(EditSiteEvent.radiusChanged(radiusM: radiusM)),
        ),
        const Gap.vertical(height: AppSpacing.md),
        InputField(
          key: EditSitePage.addressFieldKey,
          controller: _address,
          labelText: l10n.labelAddressOptional,
          validator: null,
        ),
        const Gap.vertical(height: AppSpacing.lg),
        SubmitButton(
          key: EditSitePage.saveButtonKey,
          label: l10n.saveChanges,
          isLoading: widget.state.actionStatus == GenericStatus.loading,
          onPressed: () {
            final address = _address.text.trim();
            bloc.add(
              EditSiteEvent.saveRequested(
                addressText: address.isEmpty ? null : address,
              ),
            );
          },
        ),
      ],
    );
  }
}
