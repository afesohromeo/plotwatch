import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// One project: details, the user's role, the status and the site. The
/// owner edits it and changes its status (PROJ-04, PROJ-05). Members (group
/// F) and the site localization (group G) are added here later.
class ProjectOverviewPage extends StatefulWidget {
  const ProjectOverviewPage({super.key, required this.projectId});

  final int projectId;

  static const editButtonKey = Key('project.edit');
  static const statusButtonKey = Key('project.status');
  static const membersButtonKey = Key('project.members');
  static const refreshButtonKey = Key('project.refresh');
  static const localizeButtonKey = Key('project.localizeSite');
  static const reviewSiteButtonKey = Key('project.reviewSite');
  static const editSiteButtonKey = Key('project.editSite');
  static const stagesCardKey = Key('project.stages');

  @override
  State<ProjectOverviewPage> createState() => _ProjectOverviewPageState();
}

class _ProjectOverviewPageState extends State<ProjectOverviewPage> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() => context.read<ProjectOverviewBloc>().add(
    ProjectOverviewEvent.fetchProject(projectId: widget.projectId),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<ProjectOverviewBloc>();

    // Changes made on a page above (site, members, edit) show up after
    // coming back (doc/04b H-1a).
    return ReloadOnReturn(
      onReturn: _load,
      child: BlocConsumer<ProjectOverviewBloc, ProjectOverviewState>(
        listenWhen: (previous, current) =>
            previous.actionStatus != current.actionStatus,
        listener: (context, state) {
          void resetFlowStep() =>
              bloc.add(const ProjectOverviewEvent.resetFlowStep());

          if (state.actionStatus == GenericStatus.success) {
            DialogUtils.handleSuccess(
              context,
              l10n.statusChanged,
              postActions: [resetFlowStep],
            );
          } else if (state.actionStatus == GenericStatus.failure &&
              state.actionErrorMessage != null) {
            DialogUtils.handleFailure(
              context,
              state.actionErrorMessage!,
              postActions: [resetFlowStep],
            );
          }
        },
        buildWhen: (previous, current) =>
            previous.overview != current.overview ||
            previous.overviewStatus != current.overviewStatus,
        builder: (context, state) {
          final overview = state.overview;
          return ResponsiveScaffoldWrapper(
            props: ScaffoldWrapperProps(
              leading: BackButton(
                onPressed: () => context.goNamed(homeRouteName),
              ),
              title: Text(overview?.project.name ?? l10n.projectsTitle),
              actions: [
                IconButton(
                  key: ProjectOverviewPage.refreshButtonKey,
                  tooltip: l10n.refresh,
                  color: customColors.primary,
                  icon: const Icon(Icons.refresh_rounded),
                  onPressed: _load,
                ),
                if (overview != null) ...?_ownerActions(overview, l10n),
              ],
            ),
            mobileBody: switch (state.overviewStatus) {
              _ when overview != null => _OverviewBody(
                overview: overview,
                onRefresh: () async => _load(),
              ),
              GenericStatus.failure => ErrorrWidget(
                errorMessage:
                    state.overviewErrorMessage ?? l10n.errorProjectLoad,
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

  /// Edit and status change, for the owner only (doc/02 §3.2; the server
  /// enforces it too).
  List<Widget>? _ownerActions(ProjectOverview overview, AppLocalizations l10n) {
    if (overview.myRole != ProjectRole.owner) return null;
    final nextStatuses = overview.project.status.nextStatuses;

    return [
      IconButton(
        key: ProjectOverviewPage.editButtonKey,
        tooltip: l10n.editAction,
        color: customColors.primary,
        icon: const Icon(Icons.edit_outlined),
        onPressed: () => context.goNamed(
          editProjectRouteName,
          pathParameters: {'projectId': '${widget.projectId}'},
        ),
      ),
      if (nextStatuses.isNotEmpty)
        PopupMenuButton<ProjectStatus>(
          key: ProjectOverviewPage.statusButtonKey,
          tooltip: l10n.changeStatus,
          icon: Icon(Icons.flag_outlined, color: customColors.primary),
          onSelected: (status) => context.read<ProjectOverviewBloc>().add(
            ProjectOverviewEvent.changeStatus(status: status),
          ),
          itemBuilder: (context) => [
            for (final status in nextStatuses)
              PopupMenuItem(value: status, child: Text(status.label(l10n))),
          ],
        ),
    ];
  }
}

class _OverviewBody extends StatelessWidget {
  const _OverviewBody({required this.overview, required this.onRefresh});

  final ProjectOverview overview;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final project = overview.project;
    String date(DateTime? value) =>
        value == null ? l10n.notSet : formatDate(value.toLocal());

    return AuthFormLayout(
      title: project.name,
      subtitle: project.type.label(l10n),
      onRefresh: onRefresh,
      children: [
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.xs,
          children: [
            ProjectChip(label: overview.myRole.label(l10n)),
            ProjectChip(
              label: project.status.label(l10n),
              color: project.status.color,
            ),
          ],
        ),
        const Gap.vertical(height: AppSpacing.lg),
        if (project.description != null)
          DetailRow(label: l10n.labelDescription, value: project.description!),
        DetailRow(label: l10n.labelCurrency, value: project.currencyCode),
        DetailRow(
          label: l10n.labelPlannedDates,
          value: '${date(project.plannedStart)} – ${date(project.plannedEnd)}',
        ),
        const Gap.vertical(height: AppSpacing.md),
        _StagesCard(overview: overview),
        const Gap.vertical(height: AppSpacing.lg),
        Text(l10n.siteTitle, style: context.textTheme.titleMedium),
        const Gap.vertical(height: AppSpacing.sm),
        ..._site(context, l10n),
        const Gap.vertical(height: AppSpacing.lg),
        PrimaryButton(
          key: ProjectOverviewPage.membersButtonKey,
          withBg: false,
          width: double.infinity,
          onPressed: () => context.goNamed(
            membersRouteName,
            pathParameters: {'projectId': '${project.id}'},
          ),
          child: Text(l10n.membersTitle),
        ),
      ],
    );
  }

  /// What each role sees and can do about the site (doc/04b G-7, G-12, H-2,
  /// H-3).
  List<Widget> _site(BuildContext context, AppLocalizations l10n) {
    final site = overview.site;
    final pending = overview.pendingSiteProposal;
    final role = overview.myRole;
    final pathParameters = {'projectId': '${overview.project.id}'};

    Widget button(Key key, String label, String routeName) => Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: PrimaryButton(
        key: key,
        width: double.infinity,
        onPressed: () =>
            context.goNamed(routeName, pathParameters: pathParameters),
        child: Text(label),
      ),
    );
    Widget text(String message) =>
        Text(message, style: context.textTheme.bodyMedium);

    return [
      if (site != null) ...[
        DetailRow(label: l10n.labelPlusCode, value: site.plusCode),
        DetailRow(
          label: l10n.labelRadius,
          value: l10n.radiusMeters(site.radiusM),
        ),
        if (site.addressText != null)
          DetailRow(label: l10n.labelAddress, value: site.addressText!),
      ],
      if (pending != null)
        ...switch (role) {
          ProjectRole.owner => [
            text(l10n.siteProposalPendingOwner),
            button(
              ProjectOverviewPage.reviewSiteButtonKey,
              l10n.reviewLocationAction,
              validateSiteRouteName,
            ),
          ],
          ProjectRole.siteManager => [
            text(l10n.siteProposalPendingManager),
            button(
              ProjectOverviewPage.localizeButtonKey,
              l10n.localizeAgainAction,
              localizeSiteRouteName,
            ),
          ],
          _ => [if (site == null) text(l10n.siteWaiting)],
        }
      else if (site == null)
        ...switch (role) {
          ProjectRole.owner => [
            text(l10n.siteWaitingOwner),
            button(
              ProjectOverviewPage.localizeButtonKey,
              l10n.localizeSiteAction,
              localizeSiteRouteName,
            ),
          ],
          ProjectRole.siteManager => [
            text(l10n.siteWaitingManager),
            button(
              ProjectOverviewPage.localizeButtonKey,
              l10n.localizeSiteAction,
              localizeSiteRouteName,
            ),
          ],
          _ => [text(l10n.siteWaiting)],
        }
      // A validated site, nothing pending: the site manager or the owner
      // can move it with a new reading on the plot.
      else if (role == ProjectRole.siteManager || role == ProjectRole.owner)
        button(
          ProjectOverviewPage.localizeButtonKey,
          l10n.proposeNewLocationAction,
          localizeSiteRouteName,
        ),
      // The owner changes the radius or the address without a new reading.
      if (site != null && role == ProjectRole.owner)
        button(
          ProjectOverviewPage.editSiteButtonKey,
          l10n.editSiteAction,
          editSiteRouteName,
        ),
    ];
  }
}

/// The stage plan in short: count, total budget and progress; opens the
/// plan (doc/04c M3-11).
class _StagesCard extends StatelessWidget {
  const _StagesCard({required this.overview});

  final ProjectOverview overview;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    return InkWell(
      key: ProjectOverviewPage.stagesCardKey,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      onTap: () => context.goNamed(
        stagesRouteName,
        pathParameters: {'projectId': '${overview.project.id}'},
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          border: Border.all(color: customColors.primary.withValues(alpha: .3)),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.stagesTitle, style: context.textTheme.titleMedium),
                  const Gap.vertical(height: AppSpacing.xs),
                  Text(
                    l10n.stageCount(overview.stageCount),
                    style: context.textTheme.bodyMedium,
                  ),
                  Text(
                    formatMoney(
                      overview.budgetTotalMinor,
                      overview.project.currencyCode,
                      locale: locale,
                    ),
                    style: context.textTheme.bodyMedium,
                  ),
                  Text(
                    l10n.progressPercent(overview.progressPercent),
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: customColors.primary),
          ],
        ),
      ),
    );
  }
}
