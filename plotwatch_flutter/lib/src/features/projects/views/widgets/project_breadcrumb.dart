import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The breadcrumb under a project page's app bar (doc/05 §9 DP-5):
/// Projects › {project} › {tab} › {stage} › {page}. The project's name comes
/// from [projectName] or, without it, from the nearest [ProjectOverviewBloc]
/// (the project shell provides one).
class ProjectBreadcrumbBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProjectBreadcrumbBar({
    super.key,
    required this.projectId,
    this.projectName,
    this.section,
    this.stage,
    this.leaf,
  });

  final int projectId;
  final String? projectName;

  /// The tab the page sits under; none for the project's own pages
  /// (members, edit, site).
  final ProjectTab? section;

  /// The stage the page belongs to, if any.
  final ({int id, String? name})? stage;

  /// The page itself; without it the last part is the stage or the tab.
  final String? leaf;

  @override
  Size get preferredSize => const Size.fromHeight(36);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final project = {'projectId': '$projectId'};
    void go(String name, [Map<String, String> more = const {}]) =>
        context.goNamed(name, pathParameters: {...project, ...more});

    final items = <BreadcrumbItem>[
      BreadcrumbItem(
        l10n.projectsTitle,
        onTap: () => context.goNamed(homeRouteName),
      ),
      BreadcrumbItem(
        projectName ?? projectNameOf(context) ?? '…',
        onTap: () => go(projectRouteName),
      ),
      if (section case final tab? when tab != ProjectTab.overview)
        BreadcrumbItem(
          ProjectShell.label(tab, l10n),
          onTap: () => go(switch (tab) {
            ProjectTab.stages => stagesRouteName,
            ProjectTab.money => moneyRouteName,
            ProjectTab.activity => feedRouteName,
            ProjectTab.overview => projectRouteName,
          }),
        ),
      if (stage case final s?)
        BreadcrumbItem(
          s.name ?? '…',
          onTap: () => go(stageRouteName, {'stageId': '${s.id}'}),
        ),
      if (leaf case final page?) BreadcrumbItem(page),
    ];

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          0,
          AppSpacing.md,
          AppSpacing.xs,
        ),
        child: Breadcrumb(items: items),
      ),
    );
  }
}

/// The current project's name from the nearest [ProjectOverviewBloc] (the
/// project shell provides one), or null outside a project.
String? projectNameOf(BuildContext context) {
  try {
    return context.select(
      (ProjectOverviewBloc bloc) => bloc.state.overview?.project.name,
    );
  } on ProviderNotFoundException {
    return null;
  }
}

/// The project's stages in order, from the project shell (the Activity
/// stage picker, doc/05 §9.5); empty outside a project or until loaded.
List<StageBrief> projectStagesOf(BuildContext context) {
  try {
    return context.select(
          (ProjectOverviewBloc bloc) => bloc.state.overview?.stages,
        ) ??
        const [];
  } on ProviderNotFoundException {
    return const [];
  }
}

/// The current project from the project shell: role, rights, currency
/// (the Money tab, doc/04f M6-10); null outside a project or until loaded.
ProjectOverview? projectOverviewOf(BuildContext context) {
  try {
    return context.select((ProjectOverviewBloc bloc) => bloc.state.overview);
  } on ProviderNotFoundException {
    return null;
  }
}
