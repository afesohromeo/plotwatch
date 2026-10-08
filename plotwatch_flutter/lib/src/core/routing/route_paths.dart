// Top-level paths start with `/`; child paths are relative to their parent
// route (SmartDrive convention), so `goNamed` builds the page stack and
// Android Back goes up one level (doc/04b H-1).
const String welcomePage = '/welcome';
const String signInPage = '/sign-in';
const String signUpPage = '/sign-up';
const String passwordResetPage = '/forgot-password';

/// The project list.
const String homePage = '/';

// Under the home page.
const String createProjectPage = 'projects/new';
const String projectPage = 'projects/:projectId';
const String joinPage = 'join';
const String profilePage = 'profile';

// Under the project page.
const String editProjectPage = 'edit';
const String membersPage = 'members';
const String localizeSitePage = 'site/localize';
const String validateSitePage = 'site/validate';
const String editSitePage = 'site/edit';
const String stagesPage = 'stages';

// Under the stage plan (doc/04c M3-11).
const String createStagePage = 'new';
const String stagePage = ':stageId';

// Under one stage.
const String editStagePage = 'edit';

// Under the join page: the invitation link (decision M2-8).
const String joinWithCodePage = ':code';

/// Pages reachable without signing in (auth guard in `route_manager.dart`).
const Set<String> publicPages = {
  welcomePage,
  signInPage,
  signUpPage,
  passwordResetPage,
};
