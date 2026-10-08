import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// App name, used as the window/tab title
  ///
  /// In en, this message translates to:
  /// **'Plotwatch'**
  String get appTitle;

  /// Button text to refresh content
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// Placeholder text for country search field
  ///
  /// In en, this message translates to:
  /// **'Search country'**
  String get searchCountry;

  /// Phone number validation text 1
  ///
  /// In en, this message translates to:
  /// **'Invalid Mobile Number'**
  String get validateMobile1;

  /// Label for telephone field
  ///
  /// In en, this message translates to:
  /// **'Tel'**
  String get tel;

  /// Phone number validation text 2
  ///
  /// In en, this message translates to:
  /// **'Phone number must start with 6.'**
  String get validateMobile2;

  /// Dialog title when user needs to authenticate
  ///
  /// In en, this message translates to:
  /// **'Authentication Required'**
  String get authenticationRequired;

  /// Button text for OK action
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get ok;

  /// No data message
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// Generic loading message
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Button text to cancel an action
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Button text to confirm an action
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Button text to proceed with an action
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get proceed;

  /// Search field placeholder
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Generic operation error message
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get operationError;

  /// Screen-reader label of the logo on the welcome page
  ///
  /// In en, this message translates to:
  /// **'Plotwatch logo'**
  String get logoLabel;

  /// Welcome page subtitle under the app name
  ///
  /// In en, this message translates to:
  /// **'Fund construction you can\'t watch, with verified progress.'**
  String get welcomeTagline;

  /// Button and page title to sign in
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// Button to start creating an account
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// Action to sign out
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get labelEmail;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get labelPassword;

  /// New password field label in the password reset flow
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get labelNewPassword;

  /// Full name field label
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get labelFullName;

  /// Field for the code received by email
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get labelVerificationCode;

  /// Hint under password fields, mirrors the server password rule
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters, no spaces at the start or end'**
  String get passwordRuleHint;

  /// Link from sign-in to the password reset flow
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// Link from sign-in to sign-up
  ///
  /// In en, this message translates to:
  /// **'No account yet? Create one'**
  String get noAccountYet;

  /// Link from sign-up to sign-in
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get alreadyHaveAccount;

  /// Button to go to the next step of a form
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// Button to request a new verification code
  ///
  /// In en, this message translates to:
  /// **'Send a new code'**
  String get resendCode;

  /// Sign-up page title
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get signUpTitle;

  /// Shown on the code step of sign-up. The server never says whether an email is already registered.
  ///
  /// In en, this message translates to:
  /// **'If {email} can be registered, we sent it a verification code.'**
  String signUpCodeSent(String email);

  /// Title of the last sign-up step
  ///
  /// In en, this message translates to:
  /// **'Choose a password'**
  String get choosePasswordTitle;

  /// Password reset page title
  ///
  /// In en, this message translates to:
  /// **'Reset your password'**
  String get passwordResetTitle;

  /// Shown on the code step of the password reset
  ///
  /// In en, this message translates to:
  /// **'If {email} has an account, we sent it a reset code.'**
  String passwordResetCodeSent(String email);

  /// Email field left empty
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get validateEmailRequired;

  /// Email field not in email format
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get validateEmailInvalid;

  /// Password field left empty
  ///
  /// In en, this message translates to:
  /// **'Enter a password'**
  String get validatePasswordRequired;

  /// Password shorter than 8 characters
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters'**
  String get validatePasswordTooShort;

  /// Password starts or ends with a space
  ///
  /// In en, this message translates to:
  /// **'Remove spaces at the start or end'**
  String get validatePasswordSpaces;

  /// Verification code field left empty
  ///
  /// In en, this message translates to:
  /// **'Enter the code from the email'**
  String get validateCodeRequired;

  /// Name field left empty
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get validateNameRequired;

  /// Name longer than 100 characters
  ///
  /// In en, this message translates to:
  /// **'Use 100 characters or fewer'**
  String get validateNameTooLong;

  /// AppErrorCode.permissionDenied
  ///
  /// In en, this message translates to:
  /// **'You don\'t have permission to do this.'**
  String get errorPermissionDenied;

  /// AppErrorCode.invalidFullName
  ///
  /// In en, this message translates to:
  /// **'Enter a name of 1 to 100 characters.'**
  String get errorInvalidFullName;

  /// AppErrorCode.invalidCountryCode
  ///
  /// In en, this message translates to:
  /// **'Choose a country from the list.'**
  String get errorInvalidCountryCode;

  /// AppErrorCode.invalidLocale
  ///
  /// In en, this message translates to:
  /// **'Choose English or French.'**
  String get errorInvalidLocale;

  /// AppErrorCode.projectNotFound
  ///
  /// In en, this message translates to:
  /// **'This project doesn\'t exist or you\'re not a member.'**
  String get errorProjectNotFound;

  /// AppErrorCode.invalidProjectName
  ///
  /// In en, this message translates to:
  /// **'Enter a project name of 1 to 100 characters.'**
  String get errorInvalidProjectName;

  /// AppErrorCode.invalidProjectDescription
  ///
  /// In en, this message translates to:
  /// **'Use 1,000 characters at most for the description.'**
  String get errorInvalidProjectDescription;

  /// AppErrorCode.invalidCurrencyCode
  ///
  /// In en, this message translates to:
  /// **'Choose a currency from the list.'**
  String get errorInvalidCurrencyCode;

  /// AppErrorCode.invalidProjectDates
  ///
  /// In en, this message translates to:
  /// **'The planned end must be on or after the planned start.'**
  String get errorInvalidProjectDates;

  /// AppErrorCode.invalidStatusTransition
  ///
  /// In en, this message translates to:
  /// **'The project can\'t move to this status from its current one.'**
  String get errorInvalidStatusTransition;

  /// AppErrorCode.invalidSiteLocation
  ///
  /// In en, this message translates to:
  /// **'Choose a valid location for the site.'**
  String get errorInvalidSiteLocation;

  /// AppErrorCode.invalidSiteRadius
  ///
  /// In en, this message translates to:
  /// **'The site radius must be between 10 and 500 metres.'**
  String get errorInvalidSiteRadius;

  /// AppErrorCode.invitationNotFound
  ///
  /// In en, this message translates to:
  /// **'No invitation has this code. Check it and try again.'**
  String get errorInvitationNotFound;

  /// AppErrorCode.invitationExpired
  ///
  /// In en, this message translates to:
  /// **'This invitation has expired. Ask for a new one.'**
  String get errorInvitationExpired;

  /// AppErrorCode.invitationUsed
  ///
  /// In en, this message translates to:
  /// **'This invitation has already been used or cancelled.'**
  String get errorInvitationUsed;

  /// AppErrorCode.invalidInvitationRole
  ///
  /// In en, this message translates to:
  /// **'Choose site manager, co-funder or viewer.'**
  String get errorInvalidInvitationRole;

  /// AppErrorCode.alreadyMember
  ///
  /// In en, this message translates to:
  /// **'You\'re already a member of this project.'**
  String get errorAlreadyMember;

  /// AppErrorCode.cannotRemoveOwner
  ///
  /// In en, this message translates to:
  /// **'The project owner can\'t be removed.'**
  String get errorCannotRemoveOwner;

  /// AppErrorCode.memberNotFound
  ///
  /// In en, this message translates to:
  /// **'This person isn\'t a member of the project.'**
  String get errorMemberNotFound;

  /// AppErrorCode.siteProposalNotFound
  ///
  /// In en, this message translates to:
  /// **'This location proposal doesn\'t exist in this project.'**
  String get errorSiteProposalNotFound;

  /// AppErrorCode.siteProposalNotPending
  ///
  /// In en, this message translates to:
  /// **'This location proposal has already been decided or replaced.'**
  String get errorSiteProposalNotPending;

  /// AppErrorCode.siteAccuracyTooLow
  ///
  /// In en, this message translates to:
  /// **'The GPS position isn\'t precise enough. Move to open sky and wait until the accuracy is 20 m or better.'**
  String get errorSiteAccuracyTooLow;

  /// AppErrorCode.siteMockLocation
  ///
  /// In en, this message translates to:
  /// **'Your phone reports a simulated location. Turn off any location-faking app and try again.'**
  String get errorSiteMockLocation;

  /// AppErrorCode.textTooLong
  ///
  /// In en, this message translates to:
  /// **'This text is too long.'**
  String get errorTextTooLong;

  /// AppErrorCode.authInvalidCredentials
  ///
  /// In en, this message translates to:
  /// **'Wrong email or password.'**
  String get errorAuthInvalidCredentials;

  /// AppErrorCode.authTooManyAttempts
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Try again in a few minutes.'**
  String get errorAuthTooManyAttempts;

  /// AppErrorCode.authRequestExpired
  ///
  /// In en, this message translates to:
  /// **'This code has expired. Request a new one.'**
  String get errorAuthRequestExpired;

  /// AppErrorCode.authRequestInvalid
  ///
  /// In en, this message translates to:
  /// **'This code is not valid. Check it and try again.'**
  String get errorAuthRequestInvalid;

  /// AppErrorCode.authPasswordPolicy
  ///
  /// In en, this message translates to:
  /// **'This password isn\'t allowed. Use at least 8 characters, with no spaces at the start or end.'**
  String get errorAuthPasswordPolicy;

  /// AppErrorCode.authUserBlocked
  ///
  /// In en, this message translates to:
  /// **'This account is blocked.'**
  String get errorAuthUserBlocked;

  /// AppErrorCode.authUnknown
  ///
  /// In en, this message translates to:
  /// **'Authentication failed. Try again.'**
  String get errorAuthUnknown;

  /// HttpException401
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Sign in again.'**
  String get errorUnauthorized;

  /// NetworkException
  ///
  /// In en, this message translates to:
  /// **'No connection. Check your internet and try again.'**
  String get networkError;

  /// Unexpected error while signing in
  ///
  /// In en, this message translates to:
  /// **'Could not sign in. Try again.'**
  String get errorSignIn;

  /// Unexpected error during sign-up
  ///
  /// In en, this message translates to:
  /// **'Could not create the account. Try again.'**
  String get errorSignUp;

  /// Unexpected error during password reset
  ///
  /// In en, this message translates to:
  /// **'Could not reset the password. Try again.'**
  String get errorPasswordReset;

  /// Unexpected error while signing out
  ///
  /// In en, this message translates to:
  /// **'Could not sign out. Try again.'**
  String get errorSignOut;

  /// Second password field on sign-up, must match the first
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get labelConfirmPassword;

  /// Second password field on password reset, must match the first
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get labelConfirmNewPassword;

  /// Confirm-password field left empty
  ///
  /// In en, this message translates to:
  /// **'Enter the password again'**
  String get validateConfirmPasswordRequired;

  /// Confirm-password field differs from the password field
  ///
  /// In en, this message translates to:
  /// **'The passwords don\'t match'**
  String get validatePasswordMismatch;

  /// Heading on the sign-in page (the app bar says Sign in)
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get signInHeading;

  /// Tooltip of the eye button that reveals a password
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPassword;

  /// Tooltip of the eye button that hides a password again
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePassword;

  /// Profile page title and the home action that opens it
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// Country field label on the profile page
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get labelCountry;

  /// Hint of the country picker
  ///
  /// In en, this message translates to:
  /// **'Select your country'**
  String get selectCountry;

  /// Language selector label on the profile page
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get labelLanguage;

  /// Language option; shown in its own language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// Language option; shown in its own language
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get languageFrench;

  /// Save button on the profile page
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// Success dialog after saving the profile
  ///
  /// In en, this message translates to:
  /// **'Your profile has been saved.'**
  String get profileSaved;

  /// Unexpected error while loading the profile
  ///
  /// In en, this message translates to:
  /// **'Could not load your profile. Try again.'**
  String get errorProfileLoad;

  /// Unexpected error while saving the profile
  ///
  /// In en, this message translates to:
  /// **'Could not save your profile. Try again.'**
  String get errorProfileSave;

  /// Title of the project list (signed-in home page)
  ///
  /// In en, this message translates to:
  /// **'My projects'**
  String get projectsTitle;

  /// Button and page title for creating a project
  ///
  /// In en, this message translates to:
  /// **'New project'**
  String get newProject;

  /// Project list when the user has no projects
  ///
  /// In en, this message translates to:
  /// **'No projects yet. Create one, or join a project with the invitation code you received.'**
  String get projectsEmpty;

  /// Unexpected error while loading the project list
  ///
  /// In en, this message translates to:
  /// **'Could not load your projects. Try again.'**
  String get errorProjectsLoad;

  /// Unexpected error while loading one project
  ///
  /// In en, this message translates to:
  /// **'Could not load this project. Try again.'**
  String get errorProjectLoad;

  /// Unexpected error while creating a project
  ///
  /// In en, this message translates to:
  /// **'Could not create the project. Try again.'**
  String get errorProjectCreate;

  /// Unexpected error while saving project details or status
  ///
  /// In en, this message translates to:
  /// **'Could not save the project. Try again.'**
  String get errorProjectSave;

  /// ProjectType.newHouse
  ///
  /// In en, this message translates to:
  /// **'New house'**
  String get projectTypeNewHouse;

  /// ProjectType.expansion (an extension to an existing building)
  ///
  /// In en, this message translates to:
  /// **'Extension'**
  String get projectTypeExpansion;

  /// ProjectType.renovation
  ///
  /// In en, this message translates to:
  /// **'Renovation'**
  String get projectTypeRenovation;

  /// ProjectType.communityBuilding
  ///
  /// In en, this message translates to:
  /// **'Community building'**
  String get projectTypeCommunityBuilding;

  /// ProjectType.other
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get projectTypeOther;

  /// ProjectStatus.draft (waiting for its site)
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get projectStatusDraft;

  /// ProjectStatus.active
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get projectStatusActive;

  /// ProjectStatus.paused
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get projectStatusPaused;

  /// ProjectStatus.completed
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get projectStatusCompleted;

  /// ProjectStatus.archived
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get projectStatusArchived;

  /// ProjectRole.owner
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get projectRoleOwner;

  /// ProjectRole.coFunder
  ///
  /// In en, this message translates to:
  /// **'Co-funder'**
  String get projectRoleCoFunder;

  /// ProjectRole.viewer
  ///
  /// In en, this message translates to:
  /// **'Viewer'**
  String get projectRoleViewer;

  /// ProjectRole.siteManager
  ///
  /// In en, this message translates to:
  /// **'Site manager'**
  String get projectRoleSiteManager;

  /// Project form: name field label
  ///
  /// In en, this message translates to:
  /// **'Project name'**
  String get labelProjectName;

  /// Project form: description field label
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get labelDescription;

  /// Project form: type of work field label
  ///
  /// In en, this message translates to:
  /// **'Type of work'**
  String get labelProjectType;

  /// Project form: type of work field placeholder
  ///
  /// In en, this message translates to:
  /// **'Choose the type of work'**
  String get selectProjectType;

  /// Project form: currency field label
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get labelCurrency;

  /// Project form: currency field placeholder
  ///
  /// In en, this message translates to:
  /// **'Choose a currency'**
  String get selectCurrency;

  /// Project form: planned start date field label
  ///
  /// In en, this message translates to:
  /// **'Planned start (optional)'**
  String get labelPlannedStart;

  /// Project form: planned end date field label
  ///
  /// In en, this message translates to:
  /// **'Planned end (optional)'**
  String get labelPlannedEnd;

  /// Project form: name is empty
  ///
  /// In en, this message translates to:
  /// **'Enter a project name'**
  String get validateProjectNameRequired;

  /// Project form: name longer than 100 characters
  ///
  /// In en, this message translates to:
  /// **'Use 100 characters at most'**
  String get validateProjectNameTooLong;

  /// Project form: description longer than 1,000 characters
  ///
  /// In en, this message translates to:
  /// **'Use 1,000 characters at most'**
  String get validateDescriptionTooLong;

  /// Project form: no type of work chosen
  ///
  /// In en, this message translates to:
  /// **'Choose a type of work to continue'**
  String get validateProjectTypeRequired;

  /// Project form: no currency chosen
  ///
  /// In en, this message translates to:
  /// **'Choose a currency to continue'**
  String get validateCurrencyRequired;

  /// Project form: planned end before planned start
  ///
  /// In en, this message translates to:
  /// **'The end must be on or after the start'**
  String get validateDatesOrder;

  /// Create-project wizard: progress above the step title
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String stepOf(int current, int total);

  /// Create-project wizard: title of the details step
  ///
  /// In en, this message translates to:
  /// **'Project details'**
  String get stepDetailsTitle;

  /// Create-project wizard: title of the review step
  ///
  /// In en, this message translates to:
  /// **'Check and create'**
  String get stepReviewTitle;

  /// Create-project wizard: explains the draft status on the review step
  ///
  /// In en, this message translates to:
  /// **'The project starts as a draft. It becomes active once your site manager has localized the site and you have validated it.'**
  String get reviewDraftNote;

  /// Create-project wizard: final button
  ///
  /// In en, this message translates to:
  /// **'Create project'**
  String get createProjectAction;

  /// Button returning to the previous step
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backAction;

  /// Button opening the edit form
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editAction;

  /// Project page: button opening the status menu
  ///
  /// In en, this message translates to:
  /// **'Change status'**
  String get changeStatus;

  /// Project page: status label
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get labelStatus;

  /// Project page: label of the user's role
  ///
  /// In en, this message translates to:
  /// **'Your role'**
  String get labelYourRole;

  /// Project page: planned dates label
  ///
  /// In en, this message translates to:
  /// **'Planned dates'**
  String get labelPlannedDates;

  /// Shown for an optional value that is empty
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// Project page: heading of the site section
  ///
  /// In en, this message translates to:
  /// **'Site'**
  String get siteTitle;

  /// Project page, other members: no site yet
  ///
  /// In en, this message translates to:
  /// **'Waiting for the site location.'**
  String get siteWaiting;

  /// Project page, owner: no site yet, what happens next
  ///
  /// In en, this message translates to:
  /// **'Invite a site manager to localize the plot, or localize it yourself if you\'re on the plot.'**
  String get siteWaitingOwner;

  /// Project page, site manager: no site yet, what to do
  ///
  /// In en, this message translates to:
  /// **'Go to the plot and localize the site with your phone, so the owner can validate it.'**
  String get siteWaitingManager;

  /// Project page: Plus Code of the site
  ///
  /// In en, this message translates to:
  /// **'Plus Code'**
  String get labelPlusCode;

  /// Project page: address or landmark of the site
  ///
  /// In en, this message translates to:
  /// **'Address or landmark'**
  String get labelAddress;

  /// Project page: radius of the site
  ///
  /// In en, this message translates to:
  /// **'Radius'**
  String get labelRadius;

  /// Site radius in metres
  ///
  /// In en, this message translates to:
  /// **'{radius} m'**
  String radiusMeters(int radius);

  /// Title of the edit-project page
  ///
  /// In en, this message translates to:
  /// **'Edit project'**
  String get editProjectTitle;

  /// Confirmation after the project details were saved
  ///
  /// In en, this message translates to:
  /// **'The project has been saved.'**
  String get projectSaved;

  /// Confirmation after the project status was changed
  ///
  /// In en, this message translates to:
  /// **'The status has been changed.'**
  String get statusChanged;

  /// Title of the members page and the project page's button to it
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get membersTitle;

  /// Screen-reader label of the members page's invite button
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get inviteAction;

  /// Members page, owner: heading of the unused invitations
  ///
  /// In en, this message translates to:
  /// **'Pending invitations'**
  String get pendingInvitations;

  /// Expiry date of an invitation
  ///
  /// In en, this message translates to:
  /// **'Expires {date}'**
  String invitationExpires(String date);

  /// Confirmation dialog title before removing a member
  ///
  /// In en, this message translates to:
  /// **'Remove {name}?'**
  String removeMemberTitle(String name);

  /// Confirmation dialog text before removing a member
  ///
  /// In en, this message translates to:
  /// **'They lose access to the project at once.'**
  String get removeMemberMessage;

  /// Tooltip of the button that cancels a pending invitation
  ///
  /// In en, this message translates to:
  /// **'Cancel the invitation'**
  String get cancelInvitationAction;

  /// Unexpected error while loading members and invitations
  ///
  /// In en, this message translates to:
  /// **'Could not load the members. Try again.'**
  String get errorMembersLoad;

  /// Unexpected error while removing a member or cancelling an invitation
  ///
  /// In en, this message translates to:
  /// **'Could not change the members. Try again.'**
  String get errorMembersSave;

  /// Unexpected error while creating an invitation
  ///
  /// In en, this message translates to:
  /// **'Could not create the invitation. Try again.'**
  String get errorInvitationCreate;

  /// Unexpected error while checking a code or joining
  ///
  /// In en, this message translates to:
  /// **'Could not join the project. Try again.'**
  String get errorJoinProject;

  /// Title of the invite sheet
  ///
  /// In en, this message translates to:
  /// **'Invite someone'**
  String get inviteTitle;

  /// Invite sheet: role selector label
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get labelRole;

  /// Invite sheet: approval rights switch for a co-funder
  ///
  /// In en, this message translates to:
  /// **'Can approve stages and record releases'**
  String get canApproveLabel;

  /// Invite sheet: button that creates the code
  ///
  /// In en, this message translates to:
  /// **'Create the invitation'**
  String get createInvitationAction;

  /// Invite sheet: title once the code exists
  ///
  /// In en, this message translates to:
  /// **'Invitation ready'**
  String get invitationReadyTitle;

  /// Invite sheet: how the code is used
  ///
  /// In en, this message translates to:
  /// **'Send this code or link. It works once and expires in 7 days.'**
  String get invitationReadyText;

  /// Invite sheet: copies the invitation link
  ///
  /// In en, this message translates to:
  /// **'Copy link'**
  String get copyLinkAction;

  /// Invite sheet: the copy button after copying
  ///
  /// In en, this message translates to:
  /// **'Link copied ✓'**
  String get linkCopied;

  /// Members page: tooltip of the button that shares a pending invitation again
  ///
  /// In en, this message translates to:
  /// **'Share the invitation'**
  String get shareInvitationAction;

  /// Button opening the system share sheet
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareAction;

  /// Button closing a sheet
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneAction;

  /// Message shared with the invitation
  ///
  /// In en, this message translates to:
  /// **'Join my construction project on Plotwatch: {link} (invitation code {code})'**
  String invitationShareText(String link, String code);

  /// Title of the join page and the project list's button to it
  ///
  /// In en, this message translates to:
  /// **'Join a project'**
  String get joinTitle;

  /// Join page heading
  ///
  /// In en, this message translates to:
  /// **'Enter your invitation code'**
  String get joinHeading;

  /// Join page: code field label
  ///
  /// In en, this message translates to:
  /// **'Invitation code'**
  String get labelInvitationCode;

  /// Join page: button that previews the invitation
  ///
  /// In en, this message translates to:
  /// **'Check the code'**
  String get checkCodeAction;

  /// Join page: code field left empty
  ///
  /// In en, this message translates to:
  /// **'Enter the code you received'**
  String get validateInvitationCodeRequired;

  /// Join page: who sent the invitation
  ///
  /// In en, this message translates to:
  /// **'Invited by {name}'**
  String invitedBy(String name);

  /// Join page: button that accepts the invitation
  ///
  /// In en, this message translates to:
  /// **'Join the project'**
  String get joinAction;

  /// Title of the localize-site page
  ///
  /// In en, this message translates to:
  /// **'Localize the site'**
  String get localizeSiteTitle;

  /// Localize page: how to get a good reading
  ///
  /// In en, this message translates to:
  /// **'Stand inside the plot, in the open, and wait until the accuracy is 20 m or better.'**
  String get localizeSiteHint;

  /// Localize page on the web app: GPS localization is phone-only
  ///
  /// In en, this message translates to:
  /// **'Localize the site with the Plotwatch app on your phone, standing on the plot.'**
  String get localizePhoneOnly;

  /// Localize page: waiting for the first GPS reading
  ///
  /// In en, this message translates to:
  /// **'Getting your position…'**
  String get gettingPosition;

  /// Localize page: location permission refused
  ///
  /// In en, this message translates to:
  /// **'Plotwatch needs your location to localize the site.'**
  String get locationDenied;

  /// Localize page: asks for the location permission again
  ///
  /// In en, this message translates to:
  /// **'Allow location'**
  String get allowLocation;

  /// Localize page: permission refused for good
  ///
  /// In en, this message translates to:
  /// **'Location is blocked for Plotwatch. Allow it in the app settings.'**
  String get locationDeniedForever;

  /// Localize page: opens the app settings
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSettings;

  /// Localize page: GPS switched off
  ///
  /// In en, this message translates to:
  /// **'Location is turned off on this phone.'**
  String get locationServiceOff;

  /// Localize page: opens the location settings
  ///
  /// In en, this message translates to:
  /// **'Turn on location'**
  String get turnOnLocation;

  /// GPS accuracy of a reading
  ///
  /// In en, this message translates to:
  /// **'± {meters} m'**
  String accuracyMeters(int meters);

  /// Localize page: accuracy is 20 m or better
  ///
  /// In en, this message translates to:
  /// **'Accurate enough. You can save this position.'**
  String get accuracyGood;

  /// Localize page: accuracy not good enough yet
  ///
  /// In en, this message translates to:
  /// **'Wait for 20 m or better, in the open.'**
  String get accuracyWaiting;

  /// Localize page: proposes the current reading
  ///
  /// In en, this message translates to:
  /// **'Save this position'**
  String get saveLocationAction;

  /// After the site manager proposed the location
  ///
  /// In en, this message translates to:
  /// **'Location sent. The owner will review it.'**
  String get siteProposalSent;

  /// Unexpected error while proposing the location
  ///
  /// In en, this message translates to:
  /// **'Could not save the location. Try again.'**
  String get errorSiteProposal;

  /// Unexpected error while loading a proposal
  ///
  /// In en, this message translates to:
  /// **'Could not load the location. Try again.'**
  String get errorSiteLoad;

  /// Unexpected error while validating or rejecting
  ///
  /// In en, this message translates to:
  /// **'Could not save your decision. Try again.'**
  String get errorSiteSave;

  /// The map failed to load (e.g. no Maps key)
  ///
  /// In en, this message translates to:
  /// **'The map can\'t be shown right now.'**
  String get mapUnavailable;

  /// Title of the validate-site page
  ///
  /// In en, this message translates to:
  /// **'Validate the location'**
  String get validateSiteTitle;

  /// Validate page: what to check on the map
  ///
  /// In en, this message translates to:
  /// **'Check that the circle covers the plot, with a few metres to spare.'**
  String get validateSiteHint;

  /// Validate page: nothing to review
  ///
  /// In en, this message translates to:
  /// **'No location is waiting for validation.'**
  String get noPendingProposal;

  /// Validate page: accuracy of the proposed reading
  ///
  /// In en, this message translates to:
  /// **'GPS accuracy'**
  String get labelAccuracy;

  /// Validate page: when the reading was taken
  ///
  /// In en, this message translates to:
  /// **'Read on'**
  String get labelReadAt;

  /// Validate page: address field
  ///
  /// In en, this message translates to:
  /// **'Address or landmark (optional)'**
  String get labelAddressOptional;

  /// Validate page: accepts the location
  ///
  /// In en, this message translates to:
  /// **'Validate'**
  String get validateAction;

  /// Validate page: refuses the location
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get rejectAction;

  /// Reject dialog title
  ///
  /// In en, this message translates to:
  /// **'Reject this location?'**
  String get rejectReasonTitle;

  /// Reject dialog: reason field
  ///
  /// In en, this message translates to:
  /// **'Reason (optional)'**
  String get rejectReasonLabel;

  /// After the owner validated the location
  ///
  /// In en, this message translates to:
  /// **'The site location is validated.'**
  String get siteValidated;

  /// After the owner rejected the location
  ///
  /// In en, this message translates to:
  /// **'The location was rejected. A new one can be proposed.'**
  String get siteRejected;

  /// Project page, owner: a proposal is pending
  ///
  /// In en, this message translates to:
  /// **'A location is waiting for your validation.'**
  String get siteProposalPendingOwner;

  /// Project page, site manager: a proposal is pending
  ///
  /// In en, this message translates to:
  /// **'Waiting for the owner to validate your location.'**
  String get siteProposalPendingManager;

  /// Project page, owner: opens the validate page
  ///
  /// In en, this message translates to:
  /// **'Review the location'**
  String get reviewLocationAction;

  /// Project page: opens the localize page
  ///
  /// In en, this message translates to:
  /// **'Localize the site'**
  String get localizeSiteAction;

  /// Project page, site manager: a new proposal replaces the pending one
  ///
  /// In en, this message translates to:
  /// **'Localize again'**
  String get localizeAgainAction;

  /// Project page, site manager or owner: moving a validated site with a new GPS reading
  ///
  /// In en, this message translates to:
  /// **'Propose a new location'**
  String get proposeNewLocationAction;

  /// AppErrorCode.cannotChangeOwnerRole
  ///
  /// In en, this message translates to:
  /// **'The project owner\'s role can\'t be changed.'**
  String get errorCannotChangeOwnerRole;

  /// AppErrorCode.invalidMemberRole
  ///
  /// In en, this message translates to:
  /// **'A member can\'t be made the owner.'**
  String get errorInvalidMemberRole;

  /// AppErrorCode.siteNotFound
  ///
  /// In en, this message translates to:
  /// **'This project has no validated site yet.'**
  String get errorSiteNotFound;

  /// Project page, owner: change the radius or the address of the validated site
  ///
  /// In en, this message translates to:
  /// **'Edit the site'**
  String get editSiteAction;

  /// Title of the page where the owner changes the radius and the address
  ///
  /// In en, this message translates to:
  /// **'Edit the site'**
  String get editSiteTitle;

  /// Subtitle of the edit site page
  ///
  /// In en, this message translates to:
  /// **'Change the circle or the address. To move the point, propose a new location from the plot.'**
  String get editSiteHint;

  /// After the owner saved the radius and the address
  ///
  /// In en, this message translates to:
  /// **'The site has been updated.'**
  String get siteUpdated;

  /// Members page: title of the role dialog and tooltip of its button
  ///
  /// In en, this message translates to:
  /// **'Change the role of {name}'**
  String changeRoleTitle(String name);

  /// AppErrorCode.stageNotFound
  ///
  /// In en, this message translates to:
  /// **'This stage doesn\'t exist in this project.'**
  String get errorStageNotFound;

  /// AppErrorCode.stageLocked
  ///
  /// In en, this message translates to:
  /// **'This stage can\'t be changed any more: it has started or been submitted.'**
  String get errorStageLocked;

  /// AppErrorCode.invalidStageName
  ///
  /// In en, this message translates to:
  /// **'Enter a stage name of 100 characters at most.'**
  String get errorInvalidStageName;

  /// AppErrorCode.invalidStageDescription
  ///
  /// In en, this message translates to:
  /// **'Use 1,000 characters at most for the description.'**
  String get errorInvalidStageDescription;

  /// AppErrorCode.invalidBudget
  ///
  /// In en, this message translates to:
  /// **'Enter a budget of 0 or more.'**
  String get errorInvalidBudget;

  /// AppErrorCode.invalidStageDates
  ///
  /// In en, this message translates to:
  /// **'The end must be on or after the start.'**
  String get errorInvalidStageDates;

  /// AppErrorCode.invalidChecklistItem
  ///
  /// In en, this message translates to:
  /// **'Each checklist item needs a label of 200 characters at most.'**
  String get errorInvalidChecklistItem;

  /// AppErrorCode.tooManyStages
  ///
  /// In en, this message translates to:
  /// **'A project can have 50 stages at most.'**
  String get errorTooManyStages;

  /// AppErrorCode.tooManyChecklistItems
  ///
  /// In en, this message translates to:
  /// **'A stage can have 30 checklist items at most.'**
  String get errorTooManyChecklistItems;

  /// AppErrorCode.invalidStageOrder
  ///
  /// In en, this message translates to:
  /// **'The stages changed meanwhile. Refresh and try again.'**
  String get errorInvalidStageOrder;

  /// AppErrorCode.stagePlanNotEmpty
  ///
  /// In en, this message translates to:
  /// **'This project already has stages.'**
  String get errorStagePlanNotEmpty;

  /// AppErrorCode.invalidStageTransition
  ///
  /// In en, this message translates to:
  /// **'This stage has already started.'**
  String get errorInvalidStageTransition;

  /// AppErrorCode.projectNotActive
  ///
  /// In en, this message translates to:
  /// **'Work can start once the site location is validated.'**
  String get errorProjectNotActive;

  /// AppErrorCode.projectNotEditable
  ///
  /// In en, this message translates to:
  /// **'A completed or archived project can\'t be changed.'**
  String get errorProjectNotEditable;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
