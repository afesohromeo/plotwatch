import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The signed-in home page: the user's projects with their role and status
/// (PROJ-03), as an infinite-scroll list (`_standards/13`).
class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  static const newProjectButtonKey = Key('projects.new');
  static const joinButtonKey = Key('projects.join');
  static const profileButtonKey = Key('projects.profile');
  static const signOutButtonKey = Key('projects.signOut');

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  final PagingController<int, ProjectSummary> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(_fetchPage);
  }

  void _fetchPage(int pageKey) {
    if (!mounted) return;
    context.read<ProjectListBloc>().add(
      ProjectListEvent.fetchProjects(pageKey: pageKey),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void _refresh() => context.read<ProjectListBloc>().add(
    const ProjectListEvent.refreshProjects(),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) =>
          previous.signOutStatus != current.signOutStatus,
      listener: (context, state) {
        if (state.signOutStatus == GenericStatus.failure &&
            state.signOutErrorMessage != null) {
          DialogUtils.handleFailure(context, state.signOutErrorMessage!);
        }
      },
      child: ResponsiveScaffoldWrapper(
        props: ScaffoldWrapperProps(
          title: Padding(
            padding: const EdgeInsets.only(left: AppSpacing.md),
            child: Text(l10n.projectsTitle),
          ),
          actions: [
            IconButton(
              key: ProjectListPage.joinButtonKey,
              tooltip: l10n.joinTitle,
              color: customColors.primary,
              onPressed: () => context.goNamed(joinRouteName),
              icon: const Icon(Icons.group_add_outlined),
            ),
            IconButton(
              key: ProjectListPage.profileButtonKey,
              tooltip: l10n.profileTitle,
              color: customColors.primary,
              onPressed: () => context.goNamed(profileRouteName),
              icon: const Icon(Icons.person_outline_rounded),
            ),
            IconButton(
              key: ProjectListPage.signOutButtonKey,
              tooltip: l10n.signOut,
              color: customColors.primary,
              onPressed: () => context.read<AuthenticationBloc>().add(
                const AuthenticationEvent.signOutRequested(),
              ),
              icon: const Icon(Icons.logout),
            ),
          ],
          showFloatingButton: true,
          onPressed: () => context.goNamed(createProjectRouteName),
          buttonIcon: Icon(
            Icons.add,
            key: ProjectListPage.newProjectButtonKey,
            semanticLabel: l10n.newProject,
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
                constraints: const BoxConstraints(
                  maxWidth: AuthFormLayout.maxWidth * 2,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: CustomPaginatedList<ProjectSummary>(
                    pagingController: _pagingController,
                    seperator: const Gap.vertical(height: AppSpacing.sm),
                    pagedChildBuilderDelegate:
                        PagedChildBuilderDelegate<ProjectSummary>(
                          itemBuilder: (context, summary, index) => ProjectCard(
                            summary: summary,
                            onTap: () => context.goNamed(
                              projectRouteName,
                              pathParameters: {
                                'projectId': '${summary.project.id}',
                              },
                            ),
                          ),
                          firstPageProgressIndicatorBuilder: (context) =>
                              LoadingWidget(loadingText: l10n.loading),
                          newPageProgressIndicatorBuilder: (context) =>
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(AppSpacing.md),
                                  child: CircularProgressIndicator.adaptive(),
                                ),
                              ),
                          firstPageErrorIndicatorBuilder: (context) =>
                              ErrorrWidget(
                                errorMessage:
                                    _pagingController.error?.toString() ??
                                    l10n.errorProjectsLoad,
                                refreshText: l10n.refresh,
                                onPressed: _refresh,
                              ),
                          newPageErrorIndicatorBuilder: (context) =>
                              ErrorrWidget(
                                errorMessage:
                                    _pagingController.error?.toString() ??
                                    l10n.errorProjectsLoad,
                                refreshText: l10n.refresh,
                                onPressed: () =>
                                    _pagingController.retryLastFailedRequest(),
                              ),
                          noItemsFoundIndicatorBuilder: (context) =>
                              EmptyWidget(
                                emptyText: l10n.projectsEmpty,
                                onPressed: _refresh,
                              ),
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
}
