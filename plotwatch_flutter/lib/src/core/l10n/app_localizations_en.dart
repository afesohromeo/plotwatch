// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Plotwatch';

  @override
  String get refresh => 'Refresh';

  @override
  String get searchCountry => 'Search country';

  @override
  String get validateMobile1 => 'Invalid Mobile Number';

  @override
  String get tel => 'Tel';

  @override
  String get validateMobile2 => 'Phone number must start with 6.';

  @override
  String get authenticationRequired => 'Authentication Required';

  @override
  String get ok => 'Close';

  @override
  String get noData => 'No data';

  @override
  String get loading => 'Loading...';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get proceed => 'Proceed';

  @override
  String get search => 'Search';

  @override
  String get operationError => 'An error occurred';

  @override
  String get welcomeTagline =>
      'Fund construction you can\'t watch, with verified progress.';

  @override
  String get signIn => 'Sign in';

  @override
  String get createAccount => 'Create account';

  @override
  String get signOut => 'Sign out';

  @override
  String get labelEmail => 'Email';

  @override
  String get labelPassword => 'Password';

  @override
  String get labelNewPassword => 'New password';

  @override
  String get labelFullName => 'Full name';

  @override
  String get labelVerificationCode => 'Verification code';

  @override
  String get passwordRuleHint =>
      'At least 8 characters, no spaces at the start or end';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get noAccountYet => 'No account yet? Create one';

  @override
  String get alreadyHaveAccount => 'Already have an account? Sign in';

  @override
  String get continueAction => 'Continue';

  @override
  String get resendCode => 'Send a new code';

  @override
  String get signUpTitle => 'Create your account';

  @override
  String signUpCodeSent(String email) {
    return 'If $email can be registered, we sent it a verification code.';
  }

  @override
  String get choosePasswordTitle => 'Choose a password';

  @override
  String get passwordResetTitle => 'Reset your password';

  @override
  String passwordResetCodeSent(String email) {
    return 'If $email has an account, we sent it a reset code.';
  }

  @override
  String get validateEmailRequired => 'Enter your email';

  @override
  String get validateEmailInvalid => 'Enter a valid email';

  @override
  String get validatePasswordRequired => 'Enter a password';

  @override
  String get validatePasswordTooShort => 'Use at least 8 characters';

  @override
  String get validatePasswordSpaces => 'Remove spaces at the start or end';

  @override
  String get validateCodeRequired => 'Enter the code from the email';

  @override
  String get validateNameRequired => 'Enter your name';

  @override
  String get validateNameTooLong => 'Use 100 characters or fewer';

  @override
  String get errorPermissionDenied => 'You don\'t have permission to do this.';

  @override
  String get errorInvalidFullName => 'Enter a name of 1 to 100 characters.';

  @override
  String get errorInvalidCountryCode => 'Choose a country from the list.';

  @override
  String get errorInvalidLocale => 'Choose English or French.';

  @override
  String get errorProjectNotFound =>
      'This project doesn\'t exist or you\'re not a member.';

  @override
  String get errorInvalidProjectName =>
      'Enter a project name of 1 to 100 characters.';

  @override
  String get errorInvalidProjectDescription =>
      'Use 1,000 characters at most for the description.';

  @override
  String get errorInvalidCurrencyCode => 'Choose a currency from the list.';

  @override
  String get errorInvalidProjectDates =>
      'The planned end must be on or after the planned start.';

  @override
  String get errorInvalidStatusTransition =>
      'The project can\'t move to this status from its current one.';

  @override
  String get errorInvalidSiteLocation =>
      'Choose a valid location for the site.';

  @override
  String get errorInvalidSiteRadius =>
      'The site radius must be between 10 and 500 metres.';

  @override
  String get errorInvitationNotFound =>
      'No invitation has this code. Check it and try again.';

  @override
  String get errorInvitationExpired =>
      'This invitation has expired. Ask for a new one.';

  @override
  String get errorInvitationUsed =>
      'This invitation has already been used or cancelled.';

  @override
  String get errorInvalidInvitationRole =>
      'Choose site manager, co-funder or viewer.';

  @override
  String get errorAlreadyMember => 'You\'re already a member of this project.';

  @override
  String get errorCannotRemoveOwner => 'The project owner can\'t be removed.';

  @override
  String get errorMemberNotFound =>
      'This person isn\'t a member of the project.';

  @override
  String get errorSiteProposalNotFound =>
      'This location proposal doesn\'t exist in this project.';

  @override
  String get errorSiteProposalNotPending =>
      'This location proposal has already been decided or replaced.';

  @override
  String get errorSiteAccuracyTooLow =>
      'The GPS position isn\'t precise enough. Move to open sky and wait until the accuracy is 20 m or better.';

  @override
  String get errorSiteMockLocation =>
      'Your phone reports a simulated location. Turn off any location-faking app and try again.';

  @override
  String get errorTextTooLong => 'This text is too long.';

  @override
  String get errorAuthInvalidCredentials => 'Wrong email or password.';

  @override
  String get errorAuthTooManyAttempts =>
      'Too many attempts. Try again in a few minutes.';

  @override
  String get errorAuthRequestExpired =>
      'This code has expired. Request a new one.';

  @override
  String get errorAuthRequestInvalid =>
      'This code is not valid. Check it and try again.';

  @override
  String get errorAuthPasswordPolicy =>
      'This password isn\'t allowed. Use at least 8 characters, with no spaces at the start or end.';

  @override
  String get errorAuthUserBlocked => 'This account is blocked.';

  @override
  String get errorAuthUnknown => 'Authentication failed. Try again.';

  @override
  String get errorUnauthorized => 'Your session has expired. Sign in again.';

  @override
  String get networkError =>
      'No connection. Check your internet and try again.';

  @override
  String get errorSignIn => 'Could not sign in. Try again.';

  @override
  String get errorSignUp => 'Could not create the account. Try again.';

  @override
  String get errorPasswordReset => 'Could not reset the password. Try again.';

  @override
  String get errorSignOut => 'Could not sign out. Try again.';

  @override
  String get labelConfirmPassword => 'Confirm password';

  @override
  String get labelConfirmNewPassword => 'Confirm new password';

  @override
  String get validateConfirmPasswordRequired => 'Enter the password again';

  @override
  String get validatePasswordMismatch => 'The passwords don\'t match';

  @override
  String get signInHeading => 'Welcome back';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get profileTitle => 'Profile';

  @override
  String get labelCountry => 'Country';

  @override
  String get selectCountry => 'Select your country';

  @override
  String get labelLanguage => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageFrench => 'Français';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get profileSaved => 'Your profile has been saved.';

  @override
  String get errorProfileLoad => 'Could not load your profile. Try again.';

  @override
  String get errorProfileSave => 'Could not save your profile. Try again.';

  @override
  String get projectsTitle => 'My projects';

  @override
  String get newProject => 'New project';

  @override
  String get projectsEmpty =>
      'No projects yet. Create one, or join a project with the invitation code you received.';

  @override
  String get errorProjectsLoad => 'Could not load your projects. Try again.';

  @override
  String get errorProjectLoad => 'Could not load this project. Try again.';

  @override
  String get errorProjectCreate => 'Could not create the project. Try again.';

  @override
  String get errorProjectSave => 'Could not save the project. Try again.';

  @override
  String get projectTypeNewHouse => 'New house';

  @override
  String get projectTypeExpansion => 'Extension';

  @override
  String get projectTypeRenovation => 'Renovation';

  @override
  String get projectTypeCommunityBuilding => 'Community building';

  @override
  String get projectTypeOther => 'Other';

  @override
  String get projectStatusDraft => 'Draft';

  @override
  String get projectStatusActive => 'Active';

  @override
  String get projectStatusPaused => 'Paused';

  @override
  String get projectStatusCompleted => 'Completed';

  @override
  String get projectStatusArchived => 'Archived';

  @override
  String get projectRoleOwner => 'Owner';

  @override
  String get projectRoleCoFunder => 'Co-funder';

  @override
  String get projectRoleViewer => 'Viewer';

  @override
  String get projectRoleSiteManager => 'Site manager';

  @override
  String get labelProjectName => 'Project name';

  @override
  String get labelDescription => 'Description (optional)';

  @override
  String get labelProjectType => 'Type of work';

  @override
  String get selectProjectType => 'Choose the type of work';

  @override
  String get labelCurrency => 'Currency';

  @override
  String get selectCurrency => 'Choose a currency';

  @override
  String get labelPlannedStart => 'Planned start (optional)';

  @override
  String get labelPlannedEnd => 'Planned end (optional)';

  @override
  String get validateProjectNameRequired => 'Enter a project name';

  @override
  String get validateProjectNameTooLong => 'Use 100 characters at most';

  @override
  String get validateDescriptionTooLong => 'Use 1,000 characters at most';

  @override
  String get validateProjectTypeRequired => 'Choose a type of work to continue';

  @override
  String get validateCurrencyRequired => 'Choose a currency to continue';

  @override
  String get validateDatesOrder => 'The end must be on or after the start';

  @override
  String stepOf(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get stepDetailsTitle => 'Project details';

  @override
  String get stepReviewTitle => 'Check and create';

  @override
  String get reviewDraftNote =>
      'The project starts as a draft. It becomes active once your site manager has localized the site and you have validated it.';

  @override
  String get createProjectAction => 'Create project';

  @override
  String get backAction => 'Back';

  @override
  String get editAction => 'Edit';

  @override
  String get changeStatus => 'Change status';

  @override
  String get labelStatus => 'Status';

  @override
  String get labelYourRole => 'Your role';

  @override
  String get labelPlannedDates => 'Planned dates';

  @override
  String get notSet => 'Not set';

  @override
  String get siteTitle => 'Site';

  @override
  String get siteWaiting => 'Waiting for the site location.';

  @override
  String get siteWaitingOwner =>
      'Waiting for the site location. Invite a site manager: standing on the plot, they localize it with their phone, then you validate it.';

  @override
  String get siteWaitingManager =>
      'Go to the plot and localize the site with your phone, so the owner can validate it.';

  @override
  String get labelPlusCode => 'Plus Code';

  @override
  String get labelAddress => 'Address or landmark';

  @override
  String get labelRadius => 'Radius';

  @override
  String radiusMeters(int radius) {
    return '$radius m';
  }

  @override
  String get editProjectTitle => 'Edit project';

  @override
  String get projectSaved => 'The project has been saved.';

  @override
  String get statusChanged => 'The status has been changed.';
}
