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
      redirect: (context, state) =>
          redirectFor(_authBloc.state.status, state.matchedLocation),
      routes: [...shellSubRoutes],
    );
  }

  /// Signed out: only [publicPages]; signed in: never the public pages.
  static String? redirectFor(AuthenticationStatus status, String location) {
    final isPublic = publicPages.contains(location);
    return switch (status) {
      AuthenticationStatus.unknown => null,
      AuthenticationStatus.unauthenticated => isPublic ? null : welcomePage,
      AuthenticationStatus.authenticated => isPublic ? homePage : null,
    };
  }

  static List<RouteBase> get shellSubRoutes {
    return [
      GoRoute(
        name: rootRouteName,
        path: rootPage,
        redirect: (context, state) => homePage,
      ),
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
                authRepository: context.read<AuthRepository>()),
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
                projectRepository: context.read<ProjectRepository>()),
            child: const ProjectListPage(),
          ),
        ),
      ),
      // Before `projectPage`, so "new" isn't read as a project ID.
      GoRoute(
        name: createProjectRouteName,
        path: createProjectPage,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => CreateProjectBloc(
                projectRepository: context.read<ProjectRepository>()),
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
          child: BlocProvider(
            create: (context) => ProjectOverviewBloc(
                projectRepository: context.read<ProjectRepository>()),
            child: ProjectOverviewPage(projectId: _projectId(state)!),
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
                projectRepository: context.read<ProjectRepository>()),
            child: EditProjectPage(projectId: _projectId(state)!),
          ),
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
    ];
  }

  static int? _projectId(GoRouterState state) =>
      int.tryParse(state.pathParameters['projectId'] ?? '');

  /// A malformed project ID in the URL goes back to the project list.
  static String? _requireProjectId(BuildContext context, GoRouterState state) =>
      _projectId(state) == null ? homePage : null;

  CustomTransitionPage slideTransition(
      GoRouterState state, Widget child, Offset begin) {
    return CustomTransitionPage<void>(
        key: state.pageKey,
        child: child,
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          const end = Offset.zero;
          const curve = Curves.easeIn;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }
}
