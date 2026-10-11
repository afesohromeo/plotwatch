import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The signed-in home page: the user's projects with their role and status
/// (PROJ-03), as an infinite-scroll list (`_standards/13`), searched,
/// filtered by status and sorted on the server (doc/05 §9.5).
class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  static const newProjectButtonKey = Key('projects.new');
  static const joinButtonKey = Key('projects.join');
  static const profileButtonKey = Key('projects.profile');
  static const signOutButtonKey = Key('projects.signOut');
  static const accountButtonKey = Key('projects.account');
  static const newProjectTileKey = Key('projects.newTile');
  static const searchFieldKey = Key('projects.search');

  /// The status chips are keyed `projects.status.<index>`.
  static const statusChipsPrefix = 'projects.status';

  /// The status chips, "All" first (doc/05 §9.5). Drafts show under All.
  static const statusChoices = <ProjectStatus?>[
    null,
    ProjectStatus.active,
    ProjectStatus.paused,
    ProjectStatus.completed,
    ProjectStatus.archived,
  ];

  /// Waits this long after the last key before searching (`_standards/06`).
  static const searchDebounce = Duration(milliseconds: 500);

  /// From this width the web layout: brand bar, heading, grid (doc/05 §9).
  static const webFrom = 1100.0;

  /// From this width the projects show as a grid of cards (doc/05 §9).
  static const gridFrom = 700.0;

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  final PagingController<int, ProjectSummary> _pagingController =
      PagingController(firstPageKey: 0);
  final _searchController = TextEditingController();
  Timer? _debounce;

  // The choices, sent with every page (_standards/13, "Filter chips").
  String? _searchTerm;
  ProjectStatus? _status;
  ProjectSort _sort = ProjectSort.recent;

  bool get _filtered => _searchTerm != null || _status != null;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(_fetchPage);
  }

  void _fetchPage(int pageKey) {
    if (!mounted) return;
    context.read<ProjectListBloc>().add(
      ProjectListEvent.fetchProjects(
        pageKey: pageKey,
        searchTerm: _searchTerm,
        statusFilter: _status,
        sort: _sort,
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _pagingController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(ProjectListPage.searchDebounce, () {
      if (!mounted) return;
      final term = value.trim().isEmpty ? null : value.trim();
      if (term == _searchTerm) return;
      setState(() => _searchTerm = term);
      _refresh();
    });
  }

  void _clearFilters() {
    _debounce?.cancel();
    _searchController.clear();
    setState(() {
      _searchTerm = null;
      _status = null;
    });
    _refresh();
  }

  void _refresh() => context.read<ProjectListBloc>().add(
    const ProjectListEvent.refreshProjects(),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final web = MediaQuery.sizeOf(context).width >= ProjectListPage.webFrom;

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) =>
          previous.signOutStatus != current.signOutStatus,
      listener: (context, state) {
        if (state.signOutStatus == GenericStatus.failure &&
            state.signOutErrorMessage != null) {
          DialogUtils.handleFailure(context, state.signOutErrorMessage!);
        }
      },
      // A new or joined project shows up after coming back (doc/04b H-1a).
      child: ReloadOnReturn(
        onReturn: _refresh,
        child: ResponsiveScaffoldWrapper(
          props: ScaffoldWrapperProps(
            // The design's bars (doc/05 §9.3): on the web the brand, "Join
            // with a code", the bell and the account; on a phone the title,
            // the bell and the account (join is in its menu).
            title: web
                ? const _Brand()
                : Text(
                    l10n.projectsTitle,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
            showBell: false,
            actions: [
              if (web)
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: OutlinedButton(
                    key: ProjectListPage.joinButtonKey,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 40),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => context.goNamed(joinRouteName),
                    child: Text(l10n.joinWithCode),
                  ),
                ),
              const NotificationBell(),
              const Gap.horizontal(width: 4),
              _AccountMenu(withJoin: !web),
            ],
            showFloatingButton: !web,
            buttonLabel: l10n.newProject,
            onPressed: () => context.goNamed(createProjectRouteName),
            buttonIcon: Icon(
              Icons.add_rounded,
              key: ProjectListPage.newProjectButtonKey,
            ),
          ),
          mobileBody: BlocConsumer<ProjectListBloc, ProjectListState>(
            listenWhen: (previous, current) =>
                previous.projectsListStatus != current.projectsListStatus ||
                previous.projectsRefreshController !=
                    current.projectsRefreshController,
            listener: (context, state) {
              if (state.projectsRefreshController) {
                _pagingController.refresh();
                return;
              }
              if (state.projectsListStatus == GenericStatus.success) {
                if (state.maxProjects) {
                  _pagingController.appendLastPage(state.paginatedProjects);
                } else {
                  _pagingController.appendPage(
                    state.paginatedProjects,
                    state.projectsPageKey + 1,
                  );
                }
              } else if (state.projectsListStatus == GenericStatus.failure) {
                _pagingController.error =
                    state.projectsListError ?? l10n.errorProjectsLoad;
              }
            },
            builder: (context, state) => RefreshIndicator(
              onRefresh: () async => _refresh(),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1240),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (web) ...[
                          _WebHeading(projects: state.projects),
                          const Gap.vertical(height: 20),
                        ],
                        _toolbar(l10n),
                        const Gap.vertical(height: AppSpacing.md),
                        // A grid of cards on wide screens (doc/05 §9 DP-8).
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) =>
                                constraints.maxWidth >= ProjectListPage.gridFrom
                                ? CustomPaginatedGridList<ProjectSummary>(
                                    pagingController: _pagingController,
                                    showNoMoreItemsIndicatorAsGridChild: web,
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 420,
                                          mainAxisExtent: 340,
                                          mainAxisSpacing: AppSpacing.md,
                                          crossAxisSpacing: AppSpacing.md,
                                        ),
                                    pagedChildBuilderDelegate: _delegate(
                                      l10n,
                                      newProjectTile: web,
                                      grid: true,
                                    ),
                                  )
                                : CustomPaginatedList<ProjectSummary>(
                                    pagingController: _pagingController,
                                    seperator: const Gap.vertical(
                                      height: AppSpacing.md,
                                    ),
                                    pagedChildBuilderDelegate: _delegate(l10n),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Search and sort on one line, the status chips below (doc/05 §9.5).
  Widget _toolbar(AppLocalizations l10n) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Row(
        children: [
          Expanded(
            child: InputField(
              key: ProjectListPage.searchFieldKey,
              controller: _searchController,
              hintText: l10n.searchProjects,
              prefixIcon: Icon(Icons.search_rounded, color: customColors.muted),
              keyboardType: TextInputType.text,
              radius: 12,
              borderRadius: BorderRadius.circular(12),
              validator: null,
              onChanged: _onSearchChanged,
            ),
          ),
          const Gap.horizontal(width: AppSpacing.sm),
          SortButton<ProjectSort>(
            choices: [
              FilterChoice(ProjectSort.recent, l10n.sortRecent),
              FilterChoice(ProjectSort.name, l10n.sortName),
              FilterChoice(ProjectSort.progress, l10n.sortProgress),
            ],
            selected: _sort,
            onSelected: (sort) {
              setState(() => _sort = sort);
              _refresh();
            },
          ),
        ],
      ),
      const Gap.vertical(height: 12),
      FilterChips<ProjectStatus?>(
        keyPrefix: ProjectListPage.statusChipsPrefix,
        choices: [
          for (final status in ProjectListPage.statusChoices)
            FilterChoice(status, status?.label(l10n) ?? l10n.filterAll),
        ],
        selected: _status,
        onSelected: (status) {
          setState(() => _status = status);
          _refresh();
        },
      ),
    ],
  );

  PagedChildBuilderDelegate<ProjectSummary> _delegate(
    AppLocalizations l10n, {
    bool newProjectTile = false,
    bool grid = false,
  }) => PagedChildBuilderDelegate<ProjectSummary>(
    // The web grid ends with "Start a new project".
    noMoreItemsIndicatorBuilder: newProjectTile
        ? (context) => const _NewProjectTile()
        : null,
    itemBuilder: (context, summary, index) => ProjectCard(
      summary: summary,
      compactWhenClosed: !grid,
      onTap: () => context.goNamed(
        projectRouteName,
        pathParameters: {'projectId': '${summary.project.id}'},
      ),
    ),
    firstPageProgressIndicatorBuilder: (context) =>
        const ProjectListSkeleton(),
    newPageProgressIndicatorBuilder: (context) =>
    const Padding(
      padding: EdgeInsets.only(top: AppSpacing.md),
      child: ProjectListSkeleton(count: 1),
    ),
    firstPageErrorIndicatorBuilder: (context) => ErrorrWidget(
      errorMessage:
          _pagingController.error?.toString() ?? l10n.errorProjectsLoad,
      refreshText: l10n.refresh,
      onPressed: _refresh,
    ),
    newPageErrorIndicatorBuilder: (context) => ErrorrWidget(
      errorMessage:
          _pagingController.error?.toString() ?? l10n.errorProjectsLoad,
      refreshText: l10n.refresh,
      onPressed: () => _pagingController.retryLastFailedRequest(),
    ),
    // Nothing matches: offer to clear the filters (doc/05 §9.5).
    noItemsFoundIndicatorBuilder: (context) => _filtered
        ? EmptyWidget(
            emptyText: l10n.noMatches,
            actionText: l10n.clearFilters,
            onPressed: _clearFilters,
          )
        : EmptyWidget(emptyText: l10n.projectsEmpty, onPressed: _refresh),
  );
}

/// The logo and the name, in the primary colour (developer, 2026-10-10).
class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          brandMarkAsset,
          width: 32,
          height: 32,
          semanticsLabel: l10n.logoLabel,
          colorFilter: ColorFilter.mode(customColors.primary, BlendMode.srcIn),
        ),
        const Gap.horizontal(width: 10),
        Text(
          l10n.appTitle,
          style: context.textTheme.titleLarge?.copyWith(
            color: customColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

/// The user's initials; opens the profile, joining with a code (on a
/// phone) and signing out.
class _AccountMenu extends StatelessWidget {
  const _AccountMenu({required this.withJoin});

  final bool withJoin;

  String? _name(BuildContext context) {
    try {
      return context.select((ProfileBloc bloc) => bloc.state.profile?.fullName);
    } on ProviderNotFoundException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final name = _name(context);
    return PopupMenuButton<VoidCallback>(
      key: ProjectListPage.accountButtonKey,
      tooltip: l10n.profileTitle,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: customColors.surfaceWhite,
      surfaceTintColor: Colors.transparent,
      onSelected: (action) => action(),
      itemBuilder: (context) => [
        PopupMenuItem(
          key: ProjectListPage.profileButtonKey,
          value: () => context.goNamed(profileRouteName),
          child: Text(l10n.profileTitle),
        ),
        if (withJoin)
          PopupMenuItem(
            key: ProjectListPage.joinButtonKey,
            value: () => context.goNamed(joinRouteName),
            child: Text(l10n.joinWithCode),
          ),
        PopupMenuItem(
          key: ProjectListPage.signOutButtonKey,
          value: () => context.read<AuthenticationBloc>().add(
            const AuthenticationEvent.signOutRequested(),
          ),
          child: Text(l10n.signOut),
        ),
      ],
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: customColors.primary,
          shape: BoxShape.circle,
        ),
        child: name == null
            ? Icon(
                Icons.person_rounded,
                size: 20,
                color: customColors.onPrimary,
              )
            : Text(
                initialsOf(name),
                style: context.textTheme.labelMedium?.copyWith(
                  color: customColors.onPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
      ),
    );
  }
}

/// "Projects", how many and what waits, and the button (web, doc/05 §9).
class _WebHeading extends StatelessWidget {
  const _WebHeading({required this.projects});

  final List<ProjectSummary> projects;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final waiting = projects.fold<int>(0, (sum, p) {
      final attention = attentionFor(
        stages: p.stages ?? const [],
        role: p.myRole,
        canApprove: p.myCanApprove,
      );
      return attention != null && attention.review
          ? sum + attention.count
          : sum;
    });
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.projectsTitle,
                style: context.textTheme.headlineSmall?.copyWith(fontSize: 28),
              ),
              Text(
                [
                  l10n.projectsCount(projects.length),
                  if (waiting > 0) l10n.stagesWaitingForReview(waiting),
                ].join(' · '),
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        FilledButton.icon(
          key: ProjectListPage.newProjectButtonKey,
          style: FilledButton.styleFrom(
            minimumSize: const Size(0, 48),
            padding: const EdgeInsets.symmetric(horizontal: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => context.goNamed(createProjectRouteName),
          icon: const Icon(Icons.add_rounded),
          label: Text(l10n.newProject),
        ),
      ],
    );
  }
}

/// The grid's last tile: "Start a new project" (web, doc/05 §9).
class _NewProjectTile extends StatelessWidget {
  const _NewProjectTile();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return InkWell(
      key: ProjectListPage.newProjectTileKey,
      borderRadius: BorderRadius.circular(PlotwatchTheme.cardRadius),
      onTap: () => context.goNamed(createProjectRouteName),
      child: CustomPaint(
        painter: _DashedBorder(
          color: customColors.primary.withValues(alpha: .4),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconTile(
                icon: Icons.add_rounded,
                color: customColors.primary,
                background: customColors.primarySoft,
                size: 52,
              ),
              const Gap.vertical(height: AppSpacing.sm),
              Text(
                l10n.startProjectTitle,
                style: context.textTheme.titleMedium?.copyWith(
                  color: customColors.primary,
                ),
              ),
              Text(l10n.startProjectHint, style: context.textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedBorder extends CustomPainter {
  const _DashedBorder({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          const Radius.circular(PlotwatchTheme.cardRadius),
        ),
      );
    for (final metric in path.computeMetrics()) {
      for (double d = 0; d < metric.length; d += 10) {
        canvas.drawPath(metric.extractPath(d, d + 5), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorder old) => old.color != color;
}
