import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// GoRouter with named routes, `NoTransitionPage` and an auth guard on
/// [AuthenticationBloc] (`_standards/07`).
class RouteManager {
  RouteManager(this._authBloc) {
    router = createRouter();
  }

  final AuthenticationBloc _authBloc;

  static GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  late final GoRouter router;

  GoRouter createRouter() {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      debugLogDiagnostics: kDebugMode,
      initialLocation: homePage,
      refreshListenable: GoRouterRefreshStream(_authBloc.stream),
      redirect: (context, state) {
        final status = _authBloc.state.status;
        final location = state.matchedLocation;
        if (status == AuthenticationStatus.unauthenticated &&
            isRememberedTarget(location)) {
          _rememberedTarget = location;
        }
        final target = redirectFor(
          status,
          location,
          rememberedTarget: _rememberedTarget,
        );
        if (target != null && target == _rememberedTarget) {
          _rememberedTarget = null;
        }
        return target;
      },
      routes: [...shellSubRoutes],
    );
  }

  /// An invitation link opened while signed out, kept until the user has
  /// signed in or up (MEMB-03).
  String? _rememberedTarget;

  /// Signed out: only [publicPages]; signed in: never the public pages, and
  /// a [rememberedTarget] (an invitation link) before the home page.
  static String? redirectFor(
    AuthenticationStatus status,
    String location, {
    String? rememberedTarget,
  }) {
    final isPublic = publicPages.contains(location);
    return switch (status) {
      AuthenticationStatus.unknown => null,
      AuthenticationStatus.unauthenticated => isPublic ? null : welcomePage,
      AuthenticationStatus.authenticated =>
        isPublic ? (rememberedTarget ?? homePage) : null,
    };
  }

  /// Pages worth coming back to after signing in: the join links.
  static bool isRememberedTarget(String location) =>
      location == '/$joinPage' || location.startsWith('/$joinPage/');

  /// Nested by hierarchy (doc/04b H-1): going to a page also builds its
  /// parents below it, so Android Back goes up one level. The auth pages
  /// stay at the top level.
  static List<RouteBase> get shellSubRoutes {
    return [
      GoRoute(
        name: welcomeRouteName,
        path: welcomePage,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const WelcomePage(),
        ),
      ),
      GoRoute(
        name: signInRouteName,
        path: signInPage,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) =>
                SignInBloc(authRepository: context.read<AuthRepository>()),
            child: const SignInPage(),
          ),
        ),
      ),
      GoRoute(
        name: signUpRouteName,
        path: signUpPage,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) =>
                SignUpBloc(authRepository: context.read<AuthRepository>()),
            child: const SignUpPage(),
          ),
        ),
      ),
      GoRoute(
        name: passwordResetRouteName,
        path: passwordResetPage,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => PasswordResetBloc(
              authRepository: context.read<AuthRepository>(),
            ),
            child: const PasswordResetPage(),
          ),
        ),
      ),
      GoRoute(
        name: homeRouteName,
        path: homePage,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => ProjectListBloc(
              projectRepository: context.read<ProjectRepository>(),
            ),
            child: const ProjectListPage(),
          ),
        ),
        routes: [
          // Before `projectPage`, so "new" isn't read as a project ID.
          GoRoute(
            name: createProjectRouteName,
            path: createProjectPage,
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: BlocProvider(
                create: (context) => CreateProjectBloc(
                  projectRepository: context.read<ProjectRepository>(),
                ),
                child: const CreateProjectPage(),
              ),
            ),
          ),
          GoRoute(
            name: projectRouteName,
            path: projectPage,
            redirect: _requireProjectId,
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => ProjectOverviewBloc(
                      projectRepository: context.read<ProjectRepository>(),
                    ),
                  ),
                  // The latest activity, live (doc/04e M5-7).
                  BlocProvider(
                    create: (context) => FeedBloc(
                      activityRepository: context.read<ActivityRepository>(),
                    ),
                  ),
                ],
                child: ProjectOverviewPage(projectId: _projectId(state)!),
              ),
            ),
            routes: _projectSubRoutes,
          ),
          GoRoute(
            name: joinRouteName,
            path: joinPage,
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: BlocProvider(
                create: (context) => JoinProjectBloc(
                  membershipRepository: context.read<MembershipRepository>(),
                ),
                child: const JoinProjectPage(),
              ),
            ),
            routes: [
              // The invitation link (decision M2-8).
              GoRoute(
                name: joinWithCodeRouteName,
                path: joinWithCodePage,
                pageBuilder: (context, state) => NoTransitionPage<void>(
                  key: state.pageKey,
                  child: BlocProvider(
                    create: (context) => JoinProjectBloc(
                      membershipRepository: context
                          .read<MembershipRepository>(),
                    ),
                    child: JoinProjectPage(
                      initialCode: state.pathParameters['code'],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // The notification centre, on the app-wide NotificationsBloc
          // (doc/04e M5-4).
          GoRoute(
            name: notificationsRouteName,
            path: notificationsPage,
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: const NotificationsPage(),
            ),
          ),
          GoRoute(
            name: profileRouteName,
            path: profilePage,
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: const ProfilePage(),
            ),
          ),
        ],
      ),
    ];
  }

  /// The pages of one project, under the project page.
  static List<RouteBase> get _projectSubRoutes {
    return [
      // The whole activity feed (doc/04e M5-7).
      GoRoute(
        name: feedRouteName,
        path: feedPage,
        redirect: _requireProjectId,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => FeedBloc(
              activityRepository: context.read<ActivityRepository>(),
            ),
            child: FeedPage(projectId: _projectId(state)!),
          ),
        ),
      ),
      // Progress updates (doc/04e M5-9 b). Before `updatePage`, so "new"
      // isn't read as an update ID.
      GoRoute(
        name: createUpdateRouteName,
        path: createUpdatePage,
        redirect: _requireProjectId,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => UpdateFormBloc(
              updateRepository: context.read<UpdateRepository>(),
              stageRepository: context.read<StageRepository>(),
            ),
            child: UpdateFormPage(projectId: _projectId(state)!),
          ),
        ),
      ),
      GoRoute(
        name: updateRouteName,
        path: updatePage,
        redirect: _requireUpdateId,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => UpdateBloc(
              updateRepository: context.read<UpdateRepository>(),
              stageRepository: context.read<StageRepository>(),
            ),
            child: UpdatePage(
              projectId: _projectId(state)!,
              updateId: _intParameter(state, 'updateId')!,
            ),
          ),
        ),
      ),
      GoRoute(
        name: editProjectRouteName,
        path: editProjectPage,
        redirect: _requireProjectId,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => ProjectOverviewBloc(
              projectRepository: context.read<ProjectRepository>(),
            ),
            child: EditProjectPage(projectId: _projectId(state)!),
          ),
        ),
      ),
      GoRoute(
        name: membersRouteName,
        path: membersPage,
        redirect: _requireProjectId,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => MembersBloc(
              projectRepository: context.read<ProjectRepository>(),
              membershipRepository: context.read<MembershipRepository>(),
            ),
            child: MembersPage(projectId: _projectId(state)!),
          ),
        ),
      ),
      GoRoute(
        name: localizeSiteRouteName,
        path: localizeSitePage,
        redirect: _requireProjectId,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => LocalizeSiteBloc(
              siteRepository: context.read<SiteRepository>(),
              projectRepository: context.read<ProjectRepository>(),
              locationProvider: const LocationProvider(),
            ),
            child: LocalizeSitePage(projectId: _projectId(state)!),
          ),
        ),
      ),
      GoRoute(
        name: validateSiteRouteName,
        path: validateSitePage,
        redirect: _requireProjectId,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => ValidateSiteBloc(
              siteRepository: context.read<SiteRepository>(),
            ),
            child: ValidateSitePage(projectId: _projectId(state)!),
          ),
        ),
      ),
      GoRoute(
        name: editSiteRouteName,
        path: editSitePage,
        redirect: _requireProjectId,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) =>
                EditSiteBloc(siteRepository: context.read<SiteRepository>()),
            child: EditSitePage(projectId: _projectId(state)!),
          ),
        ),
      ),
      // The stage plan (doc/04c M3-11).
      GoRoute(
        name: stagesRouteName,
        path: stagesPage,
        redirect: _requireProjectId,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => StagePlanBloc(
              stageRepository: context.read<StageRepository>(),
              projectRepository: context.read<ProjectRepository>(),
            ),
            child: StagePlanPage(projectId: _projectId(state)!),
          ),
        ),
        routes: [
          // Before `stagePage`, so "new" isn't read as a stage ID.
          GoRoute(
            name: createStageRouteName,
            path: createStagePage,
            redirect: _requireProjectId,
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: _stageForm(context, state),
            ),
          ),
          GoRoute(
            name: stageRouteName,
            path: stagePage,
            redirect: _requireStageId,
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => StageBloc(
                      stageRepository: context.read<StageRepository>(),
                      projectRepository: context.read<ProjectRepository>(),
                      evidenceRepository: context.read<EvidenceRepository>(),
                    ),
                  ),
                  // The thumbnails of the stage's photos (doc/04d M4-4).
                  BlocProvider(
                    create: (context) => EvidenceMediaBloc(
                      evidenceRepository: context.read<EvidenceRepository>(),
                    ),
                  ),
                ],
                child: StagePage(
                  projectId: _projectId(state)!,
                  stageId: _stageId(state)!,
                ),
              ),
            ),
            routes: [
              GoRoute(
                name: editStageRouteName,
                path: editStagePage,
                redirect: _requireStageId,
                pageBuilder: (context, state) => NoTransitionPage<void>(
                  key: state.pageKey,
                  child: _stageForm(context, state),
                ),
              ),
              // Taking a photo for one checklist item (doc/04d group C).
              GoRoute(
                name: captureRouteName,
                path: capturePage,
                redirect: _requireItemId,
                pageBuilder: (context, state) => NoTransitionPage<void>(
                  key: state.pageKey,
                  child: RepositoryProvider(
                    create: (_) => CameraProvider(),
                    child: BlocProvider(
                      create: (context) => CaptureBloc(
                        cameraProvider: context.read<CameraProvider>(),
                        locationProvider: const LocationProvider(),
                        deviceInfoProvider: const DeviceInfoProvider(),
                        evidenceRepository: context.read<EvidenceRepository>(),
                        projectRepository: context.read<ProjectRepository>(),
                        stageRepository: context.read<StageRepository>(),
                      ),
                      child: CapturePage(
                        projectId: _projectId(state)!,
                        stageId: _stageId(state)!,
                        itemId: _intParameter(state, 'itemId')!,
                      ),
                    ),
                  ),
                ),
              ),
              // One photo with its checks (doc/04d group D).
              GoRoute(
                name: evidenceRouteName,
                path: evidencePage,
                redirect: _requireEvidenceId,
                pageBuilder: (context, state) => NoTransitionPage<void>(
                  key: state.pageKey,
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => EvidenceBloc(
                          evidenceRepository: context
                              .read<EvidenceRepository>(),
                          projectRepository: context.read<ProjectRepository>(),
                          authRepository: context.read<AuthRepository>(),
                          stageRepository: context.read<StageRepository>(),
                        ),
                      ),
                      BlocProvider(
                        create: (context) => EvidenceMediaBloc(
                          evidenceRepository: context
                              .read<EvidenceRepository>(),
                        ),
                      ),
                    ],
                    child: EvidencePage(
                      projectId: _projectId(state)!,
                      stageId: _stageId(state)!,
                      evidenceId: _intParameter(state, 'evidenceId')!,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ];
  }

  /// The stage form: a new stage, or the stage in the address (edit).
  static Widget _stageForm(BuildContext context, GoRouterState state) =>
      BlocProvider(
        create: (context) => StageFormBloc(
          stageRepository: context.read<StageRepository>(),
          projectRepository: context.read<ProjectRepository>(),
        ),
        child: StageFormPage(
          projectId: _projectId(state)!,
          stageId: _stageId(state),
        ),
      );

  static int? _stageId(GoRouterState state) => _intParameter(state, 'stageId');

  static int? _intParameter(GoRouterState state, String name) =>
      int.tryParse(state.pathParameters[name] ?? '');

  /// A malformed item ID in the URL goes back to the project list.
  static String? _requireItemId(BuildContext context, GoRouterState state) =>
      _requireStageId(context, state) ??
      (_intParameter(state, 'itemId') == null ? homePage : null);

  /// A malformed capture ID in the URL goes back to the project list.
  static String? _requireEvidenceId(
    BuildContext context,
    GoRouterState state,
  ) =>
      _requireStageId(context, state) ??
      (_intParameter(state, 'evidenceId') == null ? homePage : null);

  /// A malformed update ID in the URL goes back to the project list.
  static String? _requireUpdateId(BuildContext context, GoRouterState state) =>
      _requireProjectId(context, state) ??
      (_intParameter(state, 'updateId') == null ? homePage : null);

  /// A malformed stage ID in the URL goes back to the project list.
  static String? _requireStageId(BuildContext context, GoRouterState state) =>
      _projectId(state) == null || _stageId(state) == null ? homePage : null;

  static int? _projectId(GoRouterState state) =>
      int.tryParse(state.pathParameters['projectId'] ?? '');

  /// A malformed project ID in the URL goes back to the project list.
  static String? _requireProjectId(BuildContext context, GoRouterState state) =>
      _projectId(state) == null ? homePage : null;

  CustomTransitionPage slideTransition(
    GoRouterState state,
    Widget child,
    Offset begin,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            const end = Offset.zero;
            const curve = Curves.easeIn;

            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
    );
  }
}
