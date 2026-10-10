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
  static const membersMenuKey = Key('project.menu.members');
  static Key statusItemKey(ProjectStatus status) =>
      Key('project.status.${status.name}');
  static const membersButtonKey = Key('project.members');
  static const refreshButtonKey = Key('project.refresh');
  static const localizeButtonKey = Key('project.localizeSite');
  static const reviewSiteButtonKey = Key('project.reviewSite');
  static const editSiteButtonKey = Key('project.editSite');
  static const stagesCardKey = Key('project.stages');
  static const postUpdateButtonKey = Key('project.postUpdate');
  static const closedBannerKey = Key('project.closed');
  static const attentionCardKey = Key('project.attention');
  static Key photoKey(int evidenceId) => Key('project.photo.$evidenceId');
  static const archiveNameFieldKey = Key('project.archiveName');
  static const archiveConfirmKey = Key('project.archiveConfirm');

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
            previous.members != current.members ||
            previous.overviewStatus != current.overviewStatus,
        builder: (context, state) {
          final overview = state.overview;
          return ResponsiveScaffoldWrapper(
            props: ScaffoldWrapperProps(
              leading: BackButton(
                onPressed: () => context.goNamed(homeRouteName),
              ),
              title: Text(overview?.project.name ?? l10n.projectsTitle),
              // "New house · Owner · Active" (doc/05 §9.3).
              subtitle: overview == null
                  ? null
                  : [
                      overview.project.type.label(l10n),
                      overview.myRole.label(l10n),
                      overview.project.status.label(l10n),
                    ].join(' · '),
              actions: [
                AppBarMenu(
                  items: [
                    AppBarMenuItem(
                      key: ProjectOverviewPage.membersMenuKey,
                      icon: Icons.group_outlined,
                      label: l10n.membersTitle,
                      onTap: () => context.goNamed(
                        membersRouteName,
                        pathParameters: {'projectId': '${widget.projectId}'},
                      ),
                    ),
                    if (overview != null) ..._ownerActions(overview, l10n),
                    AppBarMenuItem(
                      key: ProjectOverviewPage.refreshButtonKey,
                      icon: Icons.refresh_rounded,
                      label: l10n.refresh,
                      onTap: _load,
                    ),
                  ],
                ),
              ],
            ),
            mobileBody: switch (state.overviewStatus) {
              _ when overview != null => _OverviewBody(
                overview: overview,
                members: state.members,
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

  /// Completing and archiving ask first (doc/04e D-2, D-3); pausing and
  /// reopening are easy to undo.
  Future<void> _changeStatus(
    ProjectOverview overview,
    ProjectStatus status,
    AppLocalizations l10n,
  ) async {
    final bloc = context.read<ProjectOverviewBloc>();
    final name = overview.project.name;
    // One await, after the context is used.
    final confirmed = await switch (status) {
      ProjectStatus.completed => showConfirmDialog(
        context,
        title: l10n.completeProjectTitle(name),
        confirmLabel: l10n.completeProjectAction,
        message: [
          if (overview.approvedStageCount < overview.stageCount)
            l10n.completeProjectUnfinished(
              overview.stageCount - overview.approvedStageCount,
              overview.stageCount,
            ),
          l10n.completeProjectReopen,
        ].join('\n\n'),
      ),
      ProjectStatus.archived => showDialog<bool>(
        context: context,
        builder: (_) => _ArchiveDialog(projectName: name),
      ).then((archived) => archived ?? false),
      _ => Future.value(true),
    };
    if (confirmed && mounted) {
      bloc.add(ProjectOverviewEvent.changeStatus(status: status));
    }
  }

  /// Edit and status change, for the owner only (doc/02 §3.2; the server
  /// enforces it too), as items of the ⋮ menu (doc/05 §9.3).
  List<AppBarMenuItem> _ownerActions(
    ProjectOverview overview,
    AppLocalizations l10n,
  ) {
    if (overview.myRole != ProjectRole.owner) return const [];
    final nextStatuses = overview.project.status.nextStatuses;

    final closed = overview.project.status.isClosed;
    return [
      if (!closed)
        AppBarMenuItem(
          key: ProjectOverviewPage.editButtonKey,
          icon: Icons.edit_outlined,
          label: l10n.editAction,
          onTap: () => context.goNamed(
            editProjectRouteName,
            pathParameters: {'projectId': '${widget.projectId}'},
          ),
        ),
      for (final status in nextStatuses)
        AppBarMenuItem(
          key: ProjectOverviewPage.statusItemKey(status),
          icon: Icons.flag_outlined,
          label: '${l10n.changeStatus}: ${status.label(l10n)}',
          destructive: status == ProjectStatus.archived,
          onTap: () => _changeStatus(overview, status, l10n),
        ),
    ];
  }
}

/// Archiving can't be undone: the owner types the project's name first
/// (doc/04e D-3). Case and outer spaces don't matter.
class _ArchiveDialog extends StatefulWidget {
  const _ArchiveDialog({required this.projectName});

  final String projectName;

  @override
  State<_ArchiveDialog> createState() => _ArchiveDialogState();
}

class _ArchiveDialogState extends State<_ArchiveDialog> {
  final _name = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  bool get _matches =>
      _name.text.trim().toLowerCase() ==
      widget.projectName.trim().toLowerCase();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.archiveProjectTitle(widget.projectName)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.archiveProjectMessage),
          const Gap.vertical(height: AppSpacing.md),
          TextField(
            key: ProjectOverviewPage.archiveNameFieldKey,
            controller: _name,
            autofocus: true,
            decoration: InputDecoration(
              labelText: l10n.archiveProjectTypeName,
              hintText: widget.projectName,
            ),
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          key: ProjectOverviewPage.archiveConfirmKey,
          style: FilledButton.styleFrom(
            backgroundColor: customColors.unverified,
            minimumSize: const Size(0, 44),
          ),
          onPressed: _matches ? () => Navigator.of(context).pop(true) : null,
          child: Text(l10n.archiveProjectAction),
        ),
      ],
    );
  }
}

/// The Overview tab (doc/05 §9 DP-9): the progress at a glance, what waits
/// for the user, the members, the latest photos; beside them on wide
/// screens (below on a phone) the activity, the site and the details.
class _OverviewBody extends StatelessWidget {
  const _OverviewBody({
    required this.overview,
    required this.members,
    required this.onRefresh,
  });

  final ProjectOverview overview;
  final List<MemberView> members;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final project = overview.project;
    final projectId = project.id!;
    final path = {'projectId': '$projectId'};
    final stages = overview.stages ?? const <StageBrief>[];
    final hasBudget = overview.budgetTotalMinor > 0;
    final attention = attentionFor(
      stages: stages,
      role: overview.myRole,
      canApprove: overview.myCanApprove,
    );
    String date(DateTime? value) =>
        value == null ? l10n.notSet : formatDate(value.toLocal());

    return ContentLayout(
      onRefresh: onRefresh,
      main: [
        // Read-only from now on (doc/04e C-3).
        if (project.status.isClosed)
          Container(
            key: ProjectOverviewPage.closedBannerKey,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: customColors.muted.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(PlotwatchTheme.cardRadius),
            ),
            child: Row(
              children: [
                Icon(Icons.lock_outline_rounded, color: customColors.muted),
                const Gap.horizontal(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    project.status == ProjectStatus.archived
                        ? l10n.projectArchivedBanner
                        : l10n.projectCompletedBanner,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        // The progress at a glance; opens the Stages tab (doc/04c M3-11).
        InkWell(
          key: ProjectOverviewPage.stagesCardKey,
          borderRadius: BorderRadius.circular(PlotwatchTheme.heroRadius),
          onTap: () => context.goNamed(stagesRouteName, pathParameters: path),
          child: HeroProgress(
            headline: hasBudget
                ? '${overview.progressPercent}%'
                : '${overview.approvedStageCount}/${overview.stageCount}',
            caption: hasBudget
                ? l10n.budgetApprovedCaption
                : l10n.stagesApprovedCaption,
            statuses: [for (final stage in stages) stage.status],
            stagesSemanticLabel: progressLine(
              l10n,
              percent: overview.progressPercent,
              approved: overview.approvedStageCount,
              total: overview.stageCount,
              budgetTotalMinor: overview.budgetTotalMinor,
            ),
            figures: [
              (
                l10n.figureBudget,
                formatMoneyShort(
                  overview.budgetTotalMinor,
                  project.currencyCode,
                  locale: locale,
                ),
              ),
              (
                l10n.stagesTitle,
                l10n.stagesOfTotal(
                  overview.approvedStageCount,
                  overview.stageCount,
                ),
              ),
              (l10n.figureEnds, date(project.plannedEnd)),
            ],
          ),
        ),
        // What waits for this user (doc/05 §9 DP-1).
        if (attention case final waiting?)
          AttentionCard(
            key: ProjectOverviewPage.attentionCardKey,
            icon: waiting.review
                ? Icons.rate_review_outlined
                : Icons.replay_rounded,
            title: waiting.review
                ? l10n.attentionReview(waiting.count, waiting.first.name)
                : l10n.attentionChanges(waiting.count, waiting.first.name),
            onTap: () => waiting.count == 1
                ? context.goNamed(
                    stageRouteName,
                    pathParameters: {...path, 'stageId': '${waiting.first.id}'},
                  )
                : context.goNamed(stagesRouteName, pathParameters: path),
          ),
        // News from the site, by the site manager (UPD-01, doc/04e M5-9 b).
        if (overview.myRole == ProjectRole.siteManager &&
            project.status == ProjectStatus.active)
          PrimaryButton(
            key: ProjectOverviewPage.postUpdateButtonKey,
            width: double.infinity,
            onPressed: () =>
                context.goNamed(createUpdateRouteName, pathParameters: path),
            child: Text(l10n.postUpdateAction),
          ),
        // Members open from here, not from a tab (doc/05 §9 DP-4).
        _MembersCard(
          members: members,
          canInvite:
              overview.myRole == ProjectRole.owner && !project.status.isClosed,
          onTap: () => context.goNamed(membersRouteName, pathParameters: path),
        ),
        _LatestPhotos(projectId: projectId),
      ],
      // Activity · Site · About behind a switch on a phone (doc/05 §9.4).
      sideLabels: [l10n.activityTitle, l10n.siteTitle, l10n.aboutShort],
      side: [
        LatestActivity(projectId: projectId),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.siteTitle, style: context.textTheme.titleMedium),
              const Gap.vertical(height: AppSpacing.sm),
              ..._site(context, l10n),
            ],
          ),
        ),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.aboutTitle, style: context.textTheme.titleMedium),
              const Gap.vertical(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.xs,
                children: [
                  ProjectChip(label: overview.myRole.label(l10n)),
                  ProjectChip(
                    label: project.status.label(l10n),
                    color: project.status.color,
                  ),
                  ProjectChip(label: project.type.label(l10n)),
                ],
              ),
              const Gap.vertical(height: AppSpacing.sm),
              if (project.description != null)
                DetailRow(
                  label: l10n.labelDescription,
                  value: project.description!,
                ),
              DetailRow(label: l10n.labelCurrency, value: project.currencyCode),
              DetailRow(
                label: l10n.labelPlannedDates,
                value:
                    '${date(project.plannedStart)} – ${date(project.plannedEnd)}',
              ),
            ],
          ),
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

    final details = [
      if (site != null) ...[
        DetailRow(label: l10n.labelPlusCode, value: site.plusCode),
        DetailRow(
          label: l10n.labelRadius,
          value: l10n.radiusMeters(site.radiusM),
        ),
        if (site.addressText != null)
          DetailRow(label: l10n.labelAddress, value: site.addressText!),
      ],
    ];
    if (overview.project.status.isClosed) {
      return [...details, if (site == null) text(l10n.siteWaiting)];
    }
    return [
      ...details,
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

/// The members in short: their initials, how many, their roles; opens the
/// Members page (doc/05 §9 DP-4).
class _MembersCard extends StatelessWidget {
  const _MembersCard({
    required this.members,
    required this.canInvite,
    required this.onTap,
  });

  final List<MemberView> members;
  final bool canInvite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final roles = {for (final m in members) m.member.role}.toList()
      ..sort((a, b) => a.index.compareTo(b.index));

    return AppCard(
      key: ProjectOverviewPage.membersButtonKey,
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          if (members.isEmpty)
            IconTile(
              icon: Icons.group_outlined,
              color: customColors.primary,
              background: customColors.primarySoft,
            )
          else
            AvatarStack(
              names: [for (final m in members) m.fullName ?? m.email ?? '?'],
            ),
          const Gap.horizontal(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  members.isEmpty
                      ? l10n.membersTitle
                      : l10n.membersCount(members.length),
                  style: context.textTheme.titleSmall,
                ),
                if (roles.isNotEmpty)
                  Text(
                    roles.map((role) => role.label(l10n)).join(', '),
                    style: context.textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          if (canInvite)
            Padding(
              padding: const EdgeInsets.only(left: AppSpacing.sm),
              child: Text(
                l10n.inviteAction,
                style: context.textTheme.titleSmall?.copyWith(
                  color: customColors.primary,
                ),
              ),
            ),
          Icon(Icons.chevron_right_rounded, color: customColors.muted),
        ],
      ),
    );
  }
}

/// The project's latest photos, from its feed; each opens its page
/// (doc/05 §9, B's photos).
class _LatestPhotos extends StatelessWidget {
  const _LatestPhotos({required this.projectId});

  final int projectId;

  static const shown = 4;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<FeedBloc, FeedState>(
      buildWhen: (previous, current) => previous.activity != current.activity,
      builder: (context, state) {
        final photos = [
          for (final entry in state.activity)
            if (entry.event.type == ActivityType.evidenceCaptured &&
                entry.event.targetId != null &&
                entry.event.payload?['stageId'] != null)
              entry.event,
        ].take(shown).toList();
        if (photos.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.latestPhotosTitle, style: context.textTheme.titleMedium),
            const Gap.vertical(height: AppSpacing.sm),
            Row(
              children: [
                for (var i = 0; i < shown; i++) ...[
                  if (i > 0) const Gap.horizontal(width: 6),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: i < photos.length
                          ? InkWell(
                              key: ProjectOverviewPage.photoKey(
                                photos[i].targetId!,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => context.goNamed(
                                evidenceRouteName,
                                pathParameters: {
                                  'projectId': '$projectId',
                                  'stageId': photos[i].payload!['stageId']!,
                                  'evidenceId': '${photos[i].targetId}',
                                },
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    EvidenceImage(
                                      projectId: projectId,
                                      evidenceId: photos[i].targetId!,
                                      variant: MediaVariant.thumbnail,
                                    ),
                                    // The badge as a dot (doc/05 §9.3).
                                    if (VerificationLevel.values
                                            .asNameMap()[photos[i]
                                            .payload?['verificationLevel']]
                                        case final level?)
                                      Positioned(
                                        left: 5,
                                        bottom: 5,
                                        child: BadgeDot(level: level),
                                      ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                ],
              ],
            ),
          ],
        );
      },
    );
  }
}
