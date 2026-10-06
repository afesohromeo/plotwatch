const String rootPage = '/';
const String welcomePage = '/welcome';
const String signInPage = '/sign-in';
const String signUpPage = '/sign-up';
const String passwordResetPage = '/forgot-password';
const String homePage = '/home';
const String profilePage = '/profile';

/// Pages reachable without signing in (auth guard in `route_manager.dart`).
const Set<String> publicPages = {
  welcomePage,
  signInPage,
  signUpPage,
  passwordResetPage,
};
