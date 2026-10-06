const String rootPage = '/';
const String welcomePage = '/welcome';
const String signInPage = '/sign-in';
const String signUpPage = '/sign-up';
const String passwordResetPage = '/forgot-password';
const String homePage = '/home';
const String profilePage = '/profile';
const String createProjectPage = '/projects/new';
const String projectPage = '/projects/:projectId';
const String editProjectPage = '/projects/:projectId/edit';

/// Pages reachable without signing in (auth guard in `route_manager.dart`).
const Set<String> publicPages = {
  welcomePage,
  signInPage,
  signUpPage,
  passwordResetPage,
};
