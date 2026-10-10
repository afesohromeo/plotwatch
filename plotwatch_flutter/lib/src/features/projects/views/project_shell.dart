import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The destinations inside a project, the same on every width (doc/05 §9
/// DP-3). Money joins with M6. Members is reached from the Overview tab
/// (DP-4).
enum ProjectTab { overview, stages, activity }

/// How the shell shows the tabs at a given size (doc/05 §9 DP-3, DP-8).
enum ShellLayout { bottomBar, rail, sidebar }

/// Wraps every page of a project with its tabs: a bottom bar on a phone, a
/// rail on a tablet, a sidebar on the web (doc/05 §9 DP-3). The pages keep
/// their own app bar. Each tab remembers the last page it showed for this
/// project, so leaving a tab and coming back returns there; tapping the
/// current tab goes to its first page.
class ProjectShell extends StatelessWidget {
  const ProjectShell({
    super.key,
    required this.projectId,
    required this.location,
    required this.child,
  });

  final int projectId;

  /// The address shown, e.g. `/projects/7/stages/3`.
  final String location;
  final Widget child;

  static const bottomBarKey = Key('projectShell.bottomBar');
  static const railKey = Key('projectShell.rail');
  static const sidebarKey = Key('projectShell.sidebar');
  static const logoKey = Key('projectShell.logo');
  static Key tabKey(ProjectTab tab) => Key('projectShell.tab.${tab.name}');

  /// The last address of each tab, per project ("7/stages" → address).
  static final _memory = <String, String>{};

  /// For tests.
  @visibleForTesting
  static void forgetTabs() => _memory.clear();

  static ShellLayout layoutFor(Size size) {
    // A phone held sideways keeps the bottom bar.
    if (size.width < 600 || (size.shortestSide < 600 && size.width <= 900)) {
      return ShellLayout.bottomBar;
    }
    return size.width < 1100 ? ShellLayout.rail : ShellLayout.sidebar;
  }

  /// The tab an address belongs to: the stages and everything under them,
  /// the feed and the updates in it (doc/05 §9.6), or the project's other
  /// pages (members, edit, site, posting an update).
  static ProjectTab tabOf(String location) {
    final path = Uri.parse(location).path;
    final segments = Uri(path: path).pathSegments;
    // projects / {id} / {section} / …
    final section = segments.length > 2 ? segments[2] : null;
    return switch (section) {
      stagesPage => ProjectTab.stages,
      feedPage => ProjectTab.activity,
      _ when section == _updatesSection && !isFocused(location) =>
        ProjectTab.activity,
      _ => ProjectTab.overview,
    };
  }

  static final _updatesSection = createUpdatePage.split('/').first;

  /// A page that takes the whole phone screen, without the bottom bar, so
  /// its own button stays at the bottom: posting an update (doc/05 §9.6).
  /// Never remembered as a tab's last page.
  static bool isFocused(String location) =>
      Uri.parse(location).path.endsWith('/$createUpdatePage');

  String _rootOf(ProjectTab tab) => switch (tab) {
    ProjectTab.overview => '/projects/$projectId',
    ProjectTab.stages => '/projects/$projectId/$stagesPage',
    ProjectTab.activity => '/projects/$projectId/$feedPage',
  };

  void _open(BuildContext context, ProjectTab tab, ProjectTab current) {
    final remembered = _memory['$projectId/${tab.name}'];
    context.go(tab == current ? _rootOf(tab) : remembered ?? _rootOf(tab));
  }

  static String label(ProjectTab tab, AppLocalizations l10n) => switch (tab) {
    ProjectTab.overview => l10n.overviewTab,
    ProjectTab.stages => l10n.stagesTitle,
    ProjectTab.activity => l10n.activityTitle,
  };

  static IconData icon(ProjectTab tab, {required bool selected}) =>
      switch (tab) {
        ProjectTab.overview =>
          selected ? Icons.dashboard_rounded : Icons.dashboard_outlined,
        ProjectTab.stages =>
          selected ? Icons.view_list_rounded : Icons.view_list_outlined,
        ProjectTab.activity => Icons.timeline_rounded,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final current = tabOf(location);
    final focused = isFocused(location);
    if (!focused) _memory['$projectId/${current.name}'] = location;
    final tabs = ProjectTab.values;

    return switch (layoutFor(MediaQuery.sizeOf(context))) {
      ShellLayout.bottomBar when focused => Scaffold(body: child),
      ShellLayout.bottomBar => Scaffold(
        body: child,
        bottomNavigationBar: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: customColors.line)),
          ),
          child: NavigationBar(
            key: bottomBarKey,
            selectedIndex: current.index,
            onDestinationSelected: (i) => _open(context, tabs[i], current),
            destinations: [
              for (final tab in tabs)
                NavigationDestination(
                  key: tabKey(tab),
                  icon: Icon(icon(tab, selected: false)),
                  selectedIcon: Icon(icon(tab, selected: true)),
                  label: label(tab, l10n),
                ),
            ],
          ),
        ),
      ),
      ShellLayout.rail => Scaffold(
        body: Row(
          children: [
            NavigationRail(
              key: railKey,
              selectedIndex: current.index,
              labelType: NavigationRailLabelType.all,
              onDestinationSelected: (i) => _open(context, tabs[i], current),
              // The logo on top, then the way back (developer, 2026-10-10).
              leading: Column(
                children: [
                  SvgPicture.asset(
                    brandMarkAsset,
                    key: logoKey,
                    width: 36,
                    height: 36,
                    semanticsLabel: l10n.logoLabel,
                    colorFilter: ColorFilter.mode(
                      customColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const Gap.vertical(height: AppSpacing.sm),
                  IconButton(
                    tooltip: l10n.allProjects,
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: () => context.goNamed(homeRouteName),
                  ),
                ],
              ),
              destinations: [
                for (final tab in tabs)
                  NavigationRailDestination(
                    icon: Icon(icon(tab, selected: false), key: tabKey(tab)),
                    selectedIcon: Icon(icon(tab, selected: true)),
                    label: Text(label(tab, l10n)),
                  ),
              ],
            ),
            VerticalDivider(width: 1, color: customColors.line),
            Expanded(child: child),
          ],
        ),
      ),
      ShellLayout.sidebar => Scaffold(
        body: Row(
          children: [
            _Sidebar(
              key: sidebarKey,
              current: current,
              onOpen: (tab) => _open(context, tab, current),
            ),
            VerticalDivider(width: 1, color: customColors.line),
            Expanded(child: child),
          ],
        ),
      ),
    };
  }
}

/// The web sidebar: the app, the project and the user's role, the tabs, and
/// the way back to every project (doc/05 §9 DP-3).
class _Sidebar extends StatelessWidget {
  const _Sidebar({super.key, required this.current, required this.onOpen});

  final ProjectTab current;
  final ValueChanged<ProjectTab> onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final overview = context.select(
      (ProjectOverviewBloc bloc) => bloc.state.overview,
    );

    return Container(
      width: 256,
      color: customColors.surfaceWhite,
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 16),
            child: Row(
              children: [
                SvgPicture.asset(
                  brandMarkAsset,
                  key: ProjectShell.logoKey,
                  width: 32,
                  height: 32,
                  semanticsLabel: l10n.logoLabel,
                  colorFilter: ColorFilter.mode(
                    customColors.primary,
                    BlendMode.srcIn,
                  ),
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
            ),
          ),
          if (overview != null)
            Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: customColors.ground,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    overview.project.name,
                    style: context.textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${overview.myRole.label(l10n)} · '
                    '${overview.project.status.label(l10n)}',
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          for (final tab in ProjectTab.values)
            _SidebarRow(
              key: ProjectShell.tabKey(tab),
              icon: ProjectShell.icon(tab, selected: tab == current),
              label: ProjectShell.label(tab, l10n),
              selected: tab == current,
              // What waits for the user, on Stages (doc/05 §9 DP-3).
              count: tab == ProjectTab.stages && overview != null
                  ? attentionFor(
                      stages: overview.stages ?? const [],
                      role: overview.myRole,
                      canApprove: overview.myCanApprove,
                    )?.count
                  : null,
              onTap: () => onOpen(tab),
            ),
          const Spacer(),
          _SidebarRow(
            icon: Icons.arrow_back_rounded,
            label: l10n.allProjects,
            muted: true,
            onTap: () => context.goNamed(homeRouteName),
          ),
        ],
      ),
    );
  }
}

/// A sidebar row of the design: 44 px, 12 px corners, the selected one on
/// the soft primary (doc/05 §9.3).
class _SidebarRow extends StatelessWidget {
  const _SidebarRow({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
    this.muted = false,
    this.count,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool selected;
  final bool muted;
  final int? count;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? customColors.primary
        : muted
        ? customColors.muted
        : customColors.ink;
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: selected ? customColors.primarySoft : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: SizedBox(
            height: 44,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Icon(icon, size: 20, color: color),
                  const Gap.horizontal(width: 12),
                  Expanded(
                    child: Text(
                      label,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: color,
                        fontSize: 15,
                        fontWeight: selected
                            ? FontWeight.w800
                            : muted
                            ? FontWeight.w700
                            : FontWeight.w600,
                      ),
                    ),
                  ),
                  if (count case final n? when n > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: customColors.accentSoft,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '$n',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: customColors.accent,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
