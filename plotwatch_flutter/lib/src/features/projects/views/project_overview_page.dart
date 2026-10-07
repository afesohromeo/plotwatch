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

  @override
  State<ProjectOverviewPage> createState() => _ProjectOverviewPageState();
}

class _ProjectOverviewPageState extends State<ProjectOverviewPage> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() => context
      .read<ProjectOverviewBloc>()
      .add(ProjectOverviewEvent.fetchProject(projectId: widget.projectId));

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<ProjectOverviewBloc>();

    return BlocConsumer<ProjectOverviewBloc, ProjectOverviewState>(
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
            leading:
                BackButton(onPressed: () => context.goNamed(homeRouteName)),
            title: Text(overview?.project.name ?? l10n.projectsTitle),
            actions: overview == null ? null : _ownerActions(overview, l10n),
          ),
          mobileBody: switch (state.overviewStatus) {
            _ when overview != null => _OverviewBody(overview: overview),
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
          onSelected: (status) => context
              .read<ProjectOverviewBloc>()
              .add(ProjectOverviewEvent.changeStatus(status: status)),
          itemBuilder: (context) => [
            for (final status in nextStatuses)
              PopupMenuItem(value: status, child: Text(status.label(l10n))),
          ],
        ),
    ];
  }
}

class _OverviewBody extends StatelessWidget {
  const _OverviewBody({required this.overview});

  final ProjectOverview overview;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final project = overview.project;
    String date(DateTime? value) =>
        value == null ? l10n.notSet : formatDate(value.toLocal());

    return AuthFormLayout(
      title: project.name,
      subtitle: project.type.label(l10n),
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
        const Gap.vertical(height: AppSpacing.sm),
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

  List<Widget> _site(BuildContext context, AppLocalizations l10n) {
    final site = overview.site;
    if (site == null) {
      final message = switch (overview.myRole) {
        ProjectRole.owner => l10n.siteWaitingOwner,
        ProjectRole.siteManager => l10n.siteWaitingManager,
        _ => l10n.siteWaiting,
      };
      return [Text(message, style: context.textTheme.bodyMedium)];
    }
    return [
      DetailRow(label: l10n.labelPlusCode, value: site.plusCode),
      DetailRow(label: l10n.labelRadius, value: l10n.radiusMeters(site.radiusM)),
      if (site.addressText != null)
        DetailRow(label: l10n.labelAddress, value: site.addressText!),
    ];
  }
}
