# Routing

## System Used

**GoRouter** with:
- Named routes (constants in a dedicated file)
- Auth-state-based redirect guard
- `GoRouterRefreshStream` on `AuthenticationBloc`
- Global `NavigatorState` key for programmatic navigation

---

## Route Name Constants

**File:** `lib/src/core/routing/route_names.dart`

```dart
// Pattern: const String {feature}RouteName = 'kebab-case-name';
const String homeRouteName = 'home';
const String dashboardRouteName = 'dashboard';
const String gestionAbsencesRouteName = 'gestion-absences';
const String paramDepartmentRouteName = 'department';
// ...
```

Route path constants (corresponding page paths):
```dart
const String dashboardPage = '/dashboard';
const String gestionAbsencesPage = '/gestion-absences';
const String loginPage = '/login';
// ...
```

---

## Route Manager

**File:** `lib/src/core/routing/route_manager.dart`

```dart
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
      debugLogDiagnostics: true,
      initialLocation: dashboardPage,
      refreshListenable: GoRouterRefreshStream(_authBloc.stream),
      redirect: (context, state) {
        final status = _authBloc.state.status;
        final location = state.matchedLocation;

        if (status == AuthenticationStatus.unknown) {
          return location == loginPage ? null : loginPage;
        }
        if (status == AuthenticationStatus.selectHabilitation) {
          return location == selectHabilitationPage ? null : selectHabilitationPage;
        }
        if (status == AuthenticationStatus.authenticated) {
          if (location == loginPage || location == selectHabilitationPage) {
            return dashboardPage;
          }
          return null;
        }
        if (status == AuthenticationStatus.unauthenticated) {
          if (location == loginPage) return null;
          return loginPage;
        }
        return null;
      },
      routes: [...shellSubRoutes],
    );
  }

  static List<RouteBase> get shellSubRoutes {
    return [
      GoRoute(
        name: dashboardRouteName,
        path: dashboardPage,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const DashboardPage(),
        ),
      ),
      GoRoute(
        name: gestionAbsencesRouteName,
        path: gestionAbsencesPage,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const AbsenceListPage(),
        ),
      ),
      // ...
    ];
  }
}
```

---

## Adding a New Route

1. Add constants to `route_names.dart`:
```dart
const String myFeatureRouteName = 'my-feature';
const String myFeaturePage = '/my-feature';
```

2. Add `GoRoute` entry in `shellSubRoutes`:
```dart
GoRoute(
  name: myFeatureRouteName,
  path: myFeaturePage,
  pageBuilder: (context, state) => NoTransitionPage<void>(
    key: state.pageKey,
    child: const MyFeaturePage(),
  ),
),
```

3. Add drawer entry (if needed) in `app_drawer.dart`

---

## Navigation

```dart
// Named navigation
context.goNamed(myFeatureRouteName);

// With parameters
context.goNamed(myFeatureRouteName, pathParameters: {'id': item.id.toString()});

// Programmatic (from outside widget tree)
RouteManager.rootNavigatorKey.currentContext?.go(myFeaturePage);
```

---

## Authentication States

```dart
enum AuthenticationStatus {
  unknown,               // App just started — redirect to login
  authenticated,         // Valid session — allow all routes
  unauthenticated,       // Logged out — redirect to login
  selectHabilitation,    // Must select a site/habilitation first
}
```
