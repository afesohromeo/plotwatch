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
  /// **'Projects'**
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

  /// Stage budget field label (doc/04c M3-9)
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get labelBudget;

  /// An amount that is not valid for the currency
  ///
  /// In en, this message translates to:
  /// **'Enter an amount, e.g. 1500000'**
  String get validateBudgetInvalid;

  /// Stage status
  ///
  /// In en, this message translates to:
  /// **'Not started'**
  String get stageStatusNotStarted;

  /// Stage status
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get stageStatusInProgress;

  /// Stage status
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get stageStatusSubmitted;

  /// Stage status
  ///
  /// In en, this message translates to:
  /// **'Changes requested'**
  String get stageStatusChangesRequested;

  /// Stage status
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get stageStatusApproved;

  /// Built-in stage template name (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Single-storey house'**
  String get templateHouse;

  /// Built-in stage template summary
  ///
  /// In en, this message translates to:
  /// **'10 stages, from site preparation to finishing'**
  String get templateHouseHint;

  /// Built-in stage template name
  ///
  /// In en, this message translates to:
  /// **'Renovation'**
  String get templateRenovation;

  /// Built-in stage template summary
  ///
  /// In en, this message translates to:
  /// **'6 stages, from the condition before work to handover'**
  String get templateRenovationHint;

  /// Built-in stage template name: an empty plan
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get templateCustom;

  /// Built-in stage template summary
  ///
  /// In en, this message translates to:
  /// **'Start empty and add your own stages'**
  String get templateCustomHint;

  /// Template stage name (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Site preparation and setting out'**
  String get tplHouse1;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Cleared plot (wide shot)'**
  String get tplHouse1a;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Setting-out pegs and lines'**
  String get tplHouse1b;

  /// Template stage name (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Foundation excavation'**
  String get tplHouse2;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Trenches with a measuring tape showing the depth'**
  String get tplHouse2a;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'All four corners of the trenches'**
  String get tplHouse2b;

  /// Template stage name (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Foundation and substructure'**
  String get tplHouse3;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Reinforcement before pouring'**
  String get tplHouse3a;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Poured footing'**
  String get tplHouse3b;

  /// Template stage name (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Walls to lintel level'**
  String get tplHouse4;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Each external wall'**
  String get tplHouse4a;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Openings for doors and windows'**
  String get tplHouse4b;

  /// Template stage name (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Lintel and ring beam'**
  String get tplHouse5;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Reinforcement before pouring'**
  String get tplHouse5a;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Finished beam'**
  String get tplHouse5b;

  /// Template stage name (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Roofing'**
  String get tplHouse6;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Roof structure (trusses)'**
  String get tplHouse6a;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Roof covering complete'**
  String get tplHouse6b;

  /// Template stage name (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Doors and windows'**
  String get tplHouse7;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Installed frames'**
  String get tplHouse7a;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Installed doors and windows'**
  String get tplHouse7b;

  /// Template stage name (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Electrical and plumbing (first fix)'**
  String get tplHouse8;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Conduits and pipes in the walls before plastering'**
  String get tplHouse8a;

  /// Template stage name (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Plastering and screeding'**
  String get tplHouse9;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Interior walls'**
  String get tplHouse9a;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Floors'**
  String get tplHouse9b;

  /// Template stage name (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Finishing'**
  String get tplHouse10;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Painting, tiling and fittings'**
  String get tplHouse10a;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Final walkthrough'**
  String get tplHouse10b;

  /// Template stage name (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Condition before renovation'**
  String get tplReno1;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Every room before work starts'**
  String get tplReno1a;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Existing damage close up'**
  String get tplReno1b;

  /// Template stage name (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Demolition and removal'**
  String get tplReno2;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Areas cleared'**
  String get tplReno2a;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Debris removed from the site'**
  String get tplReno2b;

  /// Template stage name (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Structural repairs'**
  String get tplReno3;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Repairs before they are covered'**
  String get tplReno3a;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Finished repairs'**
  String get tplReno3b;

  /// Template stage name (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Services (electrical and plumbing)'**
  String get tplReno4;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'New wiring and pipes before the walls are closed'**
  String get tplReno4a;

  /// Template stage name (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Finishing'**
  String get tplReno5;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Painting, tiling and fittings'**
  String get tplReno5a;

  /// Template stage name (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Final handover'**
  String get tplReno6;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Every room after the work'**
  String get tplReno6a;

  /// Template checklist item (doc/02 §12.1)
  ///
  /// In en, this message translates to:
  /// **'Keys and documents handed over'**
  String get tplReno6b;

  /// Wizard step 2 title (doc/04c M3-3)
  ///
  /// In en, this message translates to:
  /// **'Stages'**
  String get stepStagesTitle;

  /// Wizard: Custom template chosen
  ///
  /// In en, this message translates to:
  /// **'The plan starts empty. Add stages after creating the project.'**
  String get templateCustomEmpty;

  /// Wizard: stages stay editable
  ///
  /// In en, this message translates to:
  /// **'You can change, add, move or delete stages after creating the project.'**
  String get templateEditableNote;

  /// Review row: the chosen template
  ///
  /// In en, this message translates to:
  /// **'Stages'**
  String get labelStages;

  /// Review row value: template and its stage count
  ///
  /// In en, this message translates to:
  /// **'{name} ({count} stages)'**
  String templateWithCount(String name, int count);

  /// Stage plan page title and project page card title
  ///
  /// In en, this message translates to:
  /// **'Stages'**
  String get stagesTitle;

  /// Owner: add a stage (button and form title)
  ///
  /// In en, this message translates to:
  /// **'Add a stage'**
  String get addStageAction;

  /// Sum of the stage budgets (BUD-01)
  ///
  /// In en, this message translates to:
  /// **'Total budget'**
  String get labelTotalBudget;

  /// Budget-weighted share of approved stages (STG-09)
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get labelProgress;

  /// Empty plan, not the owner
  ///
  /// In en, this message translates to:
  /// **'No stages yet. The owner plans them.'**
  String get stagesEmpty;

  /// Empty plan, owner
  ///
  /// In en, this message translates to:
  /// **'No stages yet. Start from a template or add your own.'**
  String get stagesEmptyOwner;

  /// Empty plan: apply a built-in template
  ///
  /// In en, this message translates to:
  /// **'Start from “{name}”'**
  String useTemplateAction(String name);

  /// Stage checklist progress (STG-08)
  ///
  /// In en, this message translates to:
  /// **'{total, plural, =0{No checklist items} =1{{covered} of 1 item covered} other{{covered} of {total} items covered}}'**
  String itemsCovered(int covered, int total);

  /// Screen reader label of the drag handle
  ///
  /// In en, this message translates to:
  /// **'Drag to move the stage'**
  String get reorderStageHint;

  /// Stage plan or stage failed to load
  ///
  /// In en, this message translates to:
  /// **'Could not load the stages. Try again.'**
  String get errorStagesLoad;

  /// A stage change failed for an unexpected reason
  ///
  /// In en, this message translates to:
  /// **'Could not save the stages. Try again.'**
  String get errorStagesSave;

  /// Project page card: number of stages
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No stages yet} =1{1 stage} other{{count} stages}}'**
  String stageCount(int count);

  /// Owner: edit a stage (button and form title)
  ///
  /// In en, this message translates to:
  /// **'Edit the stage'**
  String get editStageAction;

  /// Confirmation before deleting a stage
  ///
  /// In en, this message translates to:
  /// **'Delete {name}?'**
  String deleteStageTitle(String name);

  /// Confirmation message before deleting a stage
  ///
  /// In en, this message translates to:
  /// **'Its checklist is deleted too.'**
  String get deleteStageMessage;

  /// After the site manager started a stage
  ///
  /// In en, this message translates to:
  /// **'The stage has started.'**
  String get stageStarted;

  /// Stage page subtitle: its position
  ///
  /// In en, this message translates to:
  /// **'Stage {number}'**
  String stageNumber(int number);

  /// Stage checklist section title (STG-04)
  ///
  /// In en, this message translates to:
  /// **'Required evidence'**
  String get checklistTitle;

  /// A checklist item that isn't required
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get checklistOptional;

  /// A checklist item that is required
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get checklistRequired;

  /// Site manager: start a stage (STG-06)
  ///
  /// In en, this message translates to:
  /// **'Start the stage'**
  String get startStageAction;

  /// Site manager: the project is not active yet
  ///
  /// In en, this message translates to:
  /// **'The stage can start once the owner has validated the site location.'**
  String get stageStartNeedsSite;

  /// Stage form field
  ///
  /// In en, this message translates to:
  /// **'Stage name'**
  String get labelStageName;

  /// Stage form: checklist explanation
  ///
  /// In en, this message translates to:
  /// **'The photos the site manager must take for this stage.'**
  String get checklistHint;

  /// Stage form: checklist item field
  ///
  /// In en, this message translates to:
  /// **'Item {number}'**
  String labelChecklistItem(int number);

  /// Stage form: move a checklist item up
  ///
  /// In en, this message translates to:
  /// **'Move up'**
  String get moveUpAction;

  /// Stage form: remove a checklist item
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get removeItemAction;

  /// Stage form: add a checklist item
  ///
  /// In en, this message translates to:
  /// **'Add an item'**
  String get addChecklistItemAction;

  /// Stage name empty
  ///
  /// In en, this message translates to:
  /// **'Enter a stage name'**
  String get validateStageNameRequired;

  /// Stage name too long
  ///
  /// In en, this message translates to:
  /// **'Use 100 characters at most'**
  String get validateStageNameTooLong;

  /// Checklist item label empty
  ///
  /// In en, this message translates to:
  /// **'Describe the photo needed'**
  String get validateChecklistLabelRequired;

  /// Checklist item label too long
  ///
  /// In en, this message translates to:
  /// **'Use 200 characters at most'**
  String get validateChecklistLabelTooLong;

  /// AppErrorCode.evidenceNotFound
  ///
  /// In en, this message translates to:
  /// **'This photo doesn\'t exist in this project.'**
  String get errorEvidenceNotFound;

  /// AppErrorCode.checklistItemNotFound
  ///
  /// In en, this message translates to:
  /// **'This checklist item doesn\'t exist in this stage.'**
  String get errorChecklistItemNotFound;

  /// AppErrorCode.evidenceNotCommitted
  ///
  /// In en, this message translates to:
  /// **'This photo has already been sent.'**
  String get errorEvidenceNotCommitted;

  /// AppErrorCode.uploadMissing
  ///
  /// In en, this message translates to:
  /// **'The photo didn\'t arrive. Try sending it again.'**
  String get errorUploadMissing;

  /// AppErrorCode.evidenceFileTooLarge
  ///
  /// In en, this message translates to:
  /// **'The photo is larger than 10 MB.'**
  String get errorEvidenceFileTooLarge;

  /// AppErrorCode.invalidEvidenceMetadata
  ///
  /// In en, this message translates to:
  /// **'The photo\'s details are incomplete. Take it again.'**
  String get errorInvalidEvidenceMetadata;

  /// AppErrorCode.evidenceAlreadyRetracted
  ///
  /// In en, this message translates to:
  /// **'This photo has already been withdrawn.'**
  String get errorEvidenceAlreadyRetracted;

  /// AppErrorCode.notYourCapture
  ///
  /// In en, this message translates to:
  /// **'Only the person who took this photo can do this.'**
  String get errorNotYourCapture;

  /// AppErrorCode.checklistItemHasEvidence
  ///
  /// In en, this message translates to:
  /// **'This checklist item has photos, so it can\'t be removed. You can still rename it.'**
  String get errorChecklistItemHasEvidence;

  /// Capture badge while finalize hasn't run (VER-02)
  ///
  /// In en, this message translates to:
  /// **'Being checked'**
  String get verificationPending;

  /// Capture badge: every check passed
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verificationVerified;

  /// Capture badge: only non-critical checks failed
  ///
  /// In en, this message translates to:
  /// **'Partially verified'**
  String get verificationPartial;

  /// Capture badge: a critical check failed
  ///
  /// In en, this message translates to:
  /// **'Unverified'**
  String get verificationUnverified;

  /// Check V1 title
  ///
  /// In en, this message translates to:
  /// **'Plotwatch camera'**
  String get checkInAppCaptureTitle;

  /// Check V2 title
  ///
  /// In en, this message translates to:
  /// **'GPS position'**
  String get checkLocationPresentTitle;

  /// Check V3 title
  ///
  /// In en, this message translates to:
  /// **'GPS accuracy'**
  String get checkLocationAccuracyTitle;

  /// Check V4 title
  ///
  /// In en, this message translates to:
  /// **'On the site'**
  String get checkInsideSiteTitle;

  /// Check V5 title
  ///
  /// In en, this message translates to:
  /// **'Real position'**
  String get checkNotMockLocationTitle;

  /// Check V6 title
  ///
  /// In en, this message translates to:
  /// **'Unchanged photo'**
  String get checkHashMatchTitle;

  /// Check V7 title
  ///
  /// In en, this message translates to:
  /// **'Phone clock'**
  String get checkClockConsistencyTitle;

  /// Check V8 title
  ///
  /// In en, this message translates to:
  /// **'Sent promptly'**
  String get checkPromptCommitTitle;

  /// Check V1 passed
  ///
  /// In en, this message translates to:
  /// **'Taken with the Plotwatch camera'**
  String get checkInAppCapturePassed;

  /// Check V1 failed
  ///
  /// In en, this message translates to:
  /// **'Not taken with the Plotwatch camera'**
  String get checkInAppCaptureFailed;

  /// Check V2 passed
  ///
  /// In en, this message translates to:
  /// **'A GPS position was recorded'**
  String get checkLocationPresentPassed;

  /// Check V2 failed
  ///
  /// In en, this message translates to:
  /// **'No GPS position was recorded'**
  String get checkLocationPresentFailed;

  /// Check V3 passed
  ///
  /// In en, this message translates to:
  /// **'Accurate to {accuracy} m (allowed: {allowed} m)'**
  String checkLocationAccuracyPassed(int accuracy, int allowed);

  /// Check V3 failed
  ///
  /// In en, this message translates to:
  /// **'Accurate to only {accuracy} m (allowed: {allowed} m)'**
  String checkLocationAccuracyFailed(int accuracy, int allowed);

  /// Check V3 without an accuracy
  ///
  /// In en, this message translates to:
  /// **'The GPS accuracy is unknown'**
  String get checkLocationAccuracyUnknown;

  /// Check V4 passed
  ///
  /// In en, this message translates to:
  /// **'Taken {distance} m from the site centre; allowed: {allowed} m'**
  String checkInsideSitePassed(int distance, int allowed);

  /// Check V4 failed (AC-3 wording)
  ///
  /// In en, this message translates to:
  /// **'Taken {distance} m from the site; allowed: {allowed} m'**
  String checkInsideSiteFailed(int distance, int allowed);

  /// Check V4 without a position
  ///
  /// In en, this message translates to:
  /// **'No position, so it can\'t be placed on the site'**
  String get checkInsideSiteUnknown;

  /// Check V5 passed
  ///
  /// In en, this message translates to:
  /// **'The position wasn\'t faked'**
  String get checkNotMockLocationPassed;

  /// Check V5 failed
  ///
  /// In en, this message translates to:
  /// **'The phone reported a faked position'**
  String get checkNotMockLocationFailed;

  /// Check V6 passed
  ///
  /// In en, this message translates to:
  /// **'The stored photo is exactly the one taken'**
  String get checkHashMatchPassed;

  /// Check V6 failed
  ///
  /// In en, this message translates to:
  /// **'The stored photo differs from the one taken'**
  String get checkHashMatchFailed;

  /// Check V7 passed
  ///
  /// In en, this message translates to:
  /// **'The phone\'s clock was right (within {allowed} min)'**
  String checkClockConsistencyPassed(int allowed);

  /// Check V7 failed
  ///
  /// In en, this message translates to:
  /// **'The phone\'s clock was {skew} min off (allowed: {allowed} min)'**
  String checkClockConsistencyFailed(int skew, int allowed);

  /// Check V8 passed
  ///
  /// In en, this message translates to:
  /// **'Sent within {allowed} min of being taken'**
  String checkPromptCommitPassed(int allowed);

  /// Check V8 failed
  ///
  /// In en, this message translates to:
  /// **'Sent {delay} min after being taken (allowed: {allowed} min)'**
  String checkPromptCommitFailed(int delay, int allowed);

  /// Capture screen title (doc/04d group C)
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get captureTitle;

  /// Capture screen on the web (check V1)
  ///
  /// In en, this message translates to:
  /// **'Photos are taken with the Plotwatch app on the phone, standing on the plot.'**
  String get capturePhoneOnly;

  /// Camera permission refused
  ///
  /// In en, this message translates to:
  /// **'Plotwatch needs the camera to take the photo. Allow it in the app\'s settings.'**
  String get cameraDenied;

  /// Opens the app settings
  ///
  /// In en, this message translates to:
  /// **'Allow the camera'**
  String get allowCamera;

  /// No camera
  ///
  /// In en, this message translates to:
  /// **'No camera is available on this device.'**
  String get cameraUnavailable;

  /// Stage page: capture for an item; shutter button label
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takePhotoAction;

  /// Review step subtitle
  ///
  /// In en, this message translates to:
  /// **'Check the photo before sending it.'**
  String get captureReviewHint;

  /// Caption field (CAP-06)
  ///
  /// In en, this message translates to:
  /// **'Caption (optional)'**
  String get labelCaptionOptional;

  /// Review step: send
  ///
  /// In en, this message translates to:
  /// **'Use this photo'**
  String get usePhotoAction;

  /// Review step: retake
  ///
  /// In en, this message translates to:
  /// **'Take it again'**
  String get retakeAction;

  /// Sending step 1 (commit)
  ///
  /// In en, this message translates to:
  /// **'Recording the photo…'**
  String get sendStepCommitting;

  /// Sending step 2 (upload)
  ///
  /// In en, this message translates to:
  /// **'Uploading the photo…'**
  String get sendStepUploading;

  /// Sending step 3 (finalize)
  ///
  /// In en, this message translates to:
  /// **'Checking where and when it was taken…'**
  String get sendStepChecking;

  /// Upload refused or interrupted
  ///
  /// In en, this message translates to:
  /// **'The photo couldn\'t be uploaded. Check the connection and try again.'**
  String get errorUploadFailed;

  /// Sending failed for an unexpected reason
  ///
  /// In en, this message translates to:
  /// **'The photo couldn\'t be sent. Try again.'**
  String get errorCaptureSend;

  /// Repeats the step that failed
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retryAction;

  /// Capture result title
  ///
  /// In en, this message translates to:
  /// **'Photo checked'**
  String get captureResultTitle;

  /// VER-10 notice
  ///
  /// In en, this message translates to:
  /// **'Verification proves where and when this photo was taken, not the quality of the work.'**
  String get verificationNotice;

  /// Camera overlay: no fix yet
  ///
  /// In en, this message translates to:
  /// **'Looking for GPS…'**
  String get captureNoFix;

  /// Camera overlay: inside the site radius
  ///
  /// In en, this message translates to:
  /// **'Inside the site'**
  String get captureInsideSite;

  /// Camera overlay: outside the site radius
  ///
  /// In en, this message translates to:
  /// **'Outside the site (≈ {distance} m)'**
  String captureOutsideSite(int distance);

  /// Camera overlay: no location permission
  ///
  /// In en, this message translates to:
  /// **'Location off: the photo won\'t be verified'**
  String get captureLocationOff;

  /// Camera overlay: accuracy
  ///
  /// In en, this message translates to:
  /// **'GPS ± {accuracy} m'**
  String captureAccuracy(int accuracy);

  /// Stage page: a retracted capture
  ///
  /// In en, this message translates to:
  /// **'Withdrawn'**
  String get captureRetracted;

  /// Stage page: a capture stuck for 24 h (M4-12)
  ///
  /// In en, this message translates to:
  /// **'Upload failed'**
  String get captureUploadFailed;

  /// Stage page: a capture committed but not finalized (doc/04d M4-F3)
  ///
  /// In en, this message translates to:
  /// **'Not received yet'**
  String get captureNotReceived;

  /// Evidence page title
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get evidenceTitle;

  /// After retracting a capture
  ///
  /// In en, this message translates to:
  /// **'The photo has been withdrawn.'**
  String get captureRetractedDone;

  /// Evidence page failed to load
  ///
  /// In en, this message translates to:
  /// **'Could not load the photo. Try again.'**
  String get errorEvidenceLoad;

  /// Evidence page: a retracted capture and why
  ///
  /// In en, this message translates to:
  /// **'Withdrawn: {reason}'**
  String captureRetractedReason(String reason);

  /// Evidence page: checks section
  ///
  /// In en, this message translates to:
  /// **'Checks'**
  String get checksTitle;

  /// Evidence page: what was recorded
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get evidenceDetailsTitle;

  /// deviceCapturedAt
  ///
  /// In en, this message translates to:
  /// **'Taken (phone time)'**
  String get labelTakenAt;

  /// serverCommittedAt
  ///
  /// In en, this message translates to:
  /// **'Received (server time)'**
  String get labelReceivedAt;

  /// Latitude, longitude
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get labelPosition;

  /// distanceFromSiteM
  ///
  /// In en, this message translates to:
  /// **'Distance to the site centre'**
  String get labelDistanceToSite;

  /// A distance in metres
  ///
  /// In en, this message translates to:
  /// **'{distance} m'**
  String distanceMeters(int distance);

  /// Phone model and OS
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get labelDevice;

  /// App version
  ///
  /// In en, this message translates to:
  /// **'App version'**
  String get labelAppVersion;

  /// Evidence page: retract (CAP-09)
  ///
  /// In en, this message translates to:
  /// **'Withdraw this photo'**
  String get retractAction;

  /// Retract dialog title
  ///
  /// In en, this message translates to:
  /// **'Withdraw this photo?'**
  String get retractTitle;

  /// Retract dialog field
  ///
  /// In en, this message translates to:
  /// **'Why? (stays in the history)'**
  String get retractReasonLabel;

  /// Retract reason empty
  ///
  /// In en, this message translates to:
  /// **'Say why the photo is withdrawn'**
  String get validateRetractReasonRequired;

  /// Screen reader label of a capture
  ///
  /// In en, this message translates to:
  /// **'Site photo'**
  String get capturePhotoLabel;

  /// Screen reader label when a photo can't load
  ///
  /// In en, this message translates to:
  /// **'Photo unavailable'**
  String get capturePhotoUnavailable;

  /// Evidence page: a capture committed but never uploaded (doc/04d M4-F4)
  ///
  /// In en, this message translates to:
  /// **'This photo was never received. Take it again if it\'s still needed.'**
  String get captureNeverReceived;

  /// AppErrorCode.checklistIncomplete
  ///
  /// In en, this message translates to:
  /// **'Every required item needs at least one photo before the stage can be submitted.'**
  String get errorChecklistIncomplete;

  /// AppErrorCode.reviewCommentRequired
  ///
  /// In en, this message translates to:
  /// **'Say what needs to change.'**
  String get errorReviewCommentRequired;

  /// AppErrorCode.notificationNotFound
  ///
  /// In en, this message translates to:
  /// **'This notification doesn\'t exist.'**
  String get errorNotificationNotFound;

  /// AppErrorCode.invalidProgressUpdate
  ///
  /// In en, this message translates to:
  /// **'Check the update: text up to 2,000 characters, 0 to 999 workers, issues up to 1,000 characters.'**
  String get errorInvalidProgressUpdate;

  /// AppErrorCode.updateNotFound
  ///
  /// In en, this message translates to:
  /// **'This update doesn\'t exist in this project.'**
  String get errorUpdateNotFound;

  /// After the site manager submitted a stage
  ///
  /// In en, this message translates to:
  /// **'Stage sent for review.'**
  String get stageSubmittedDone;

  /// After an approver approved a stage
  ///
  /// In en, this message translates to:
  /// **'Stage approved.'**
  String get stageApprovedDone;

  /// After an approver requested changes
  ///
  /// In en, this message translates to:
  /// **'Changes requested. The site manager has been told.'**
  String get changesRequestedDone;

  /// Stage page banner for the site manager
  ///
  /// In en, this message translates to:
  /// **'{name} asked for changes: {comment}'**
  String changesRequestedBy(String name, String comment);

  /// Site manager: submit a stage (button and dialog title)
  ///
  /// In en, this message translates to:
  /// **'Submit for review'**
  String get submitStageAction;

  /// Stage page: required items without a photo
  ///
  /// In en, this message translates to:
  /// **'Before submitting, add a photo for: {items}'**
  String submitMissingItems(String items);

  /// Submit confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'The approvers will be told. You can\'t edit the stage or add photos while it is being reviewed.'**
  String get submitStageMessage;

  /// Approver: approve a stage (button and dialog title)
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approveStageAction;

  /// Approve confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Approve this stage? The site manager will be told and the project\'s progress will go up.'**
  String get approveStageMessage;

  /// Approver: request changes (button and dialog title)
  ///
  /// In en, this message translates to:
  /// **'Request changes'**
  String get requestChangesAction;

  /// Stage page section title
  ///
  /// In en, this message translates to:
  /// **'Review history'**
  String get reviewHistoryTitle;

  /// Review history row
  ///
  /// In en, this message translates to:
  /// **'{decision} by {name}, {date}'**
  String reviewDecisionBy(String decision, String name, String date);

  /// Review decision
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get reviewApproved;

  /// Review decision
  ///
  /// In en, this message translates to:
  /// **'Changes requested'**
  String get reviewChangesRequested;

  /// Request changes dialog field
  ///
  /// In en, this message translates to:
  /// **'What needs to change?'**
  String get reviewCommentLabel;

  /// Request changes comment empty
  ///
  /// In en, this message translates to:
  /// **'Say what needs to change'**
  String get validateReviewCommentRequired;

  /// Feed and notifications: an actor whose name is unknown
  ///
  /// In en, this message translates to:
  /// **'Someone'**
  String get someone;

  /// Feed page title
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activityTitle;

  /// Project page section title
  ///
  /// In en, this message translates to:
  /// **'Latest activity'**
  String get latestActivityTitle;

  /// Feed with no events
  ///
  /// In en, this message translates to:
  /// **'Nothing has happened yet.'**
  String get activityEmpty;

  /// Project page: open the whole feed
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// Live stream down, trying again (doc/04e M5-6)
  ///
  /// In en, this message translates to:
  /// **'Reconnecting…'**
  String get reconnecting;

  /// Feed load failure
  ///
  /// In en, this message translates to:
  /// **'The activity couldn\'t be loaded.'**
  String get errorActivityLoad;

  /// Feed event
  ///
  /// In en, this message translates to:
  /// **'{actor} created the project {name}'**
  String activityProjectCreated(String actor, String name);

  /// Feed event
  ///
  /// In en, this message translates to:
  /// **'{actor} edited the project details'**
  String activityProjectUpdated(String actor);

  /// Feed event
  ///
  /// In en, this message translates to:
  /// **'{actor} set the project to {status}'**
  String activityProjectStatusChanged(String actor, String status);

  /// Feed event
  ///
  /// In en, this message translates to:
  /// **'{actor} proposed the site location'**
  String activitySiteProposed(String actor);

  /// Feed event
  ///
  /// In en, this message translates to:
  /// **'{actor} rejected the proposed site location'**
  String activitySiteProposalRejected(String actor);

  /// Feed event
  ///
  /// In en, this message translates to:
  /// **'{actor} set the site location'**
  String activitySiteChanged(String actor);

  /// Feed event
  ///
  /// In en, this message translates to:
  /// **'{actor} joined as {role}'**
  String activityMemberJoined(String actor, String role);

  /// Feed event: one stage added, edited, deleted or moved
  ///
  /// In en, this message translates to:
  /// **'{actor} changed the stage {name}'**
  String activityStageChanged(String actor, String name);

  /// Feed event
  ///
  /// In en, this message translates to:
  /// **'{actor} created a plan of {count, plural, =1{1 stage} other{{count} stages}}'**
  String activityPlanCreated(String actor, int count);

  /// Feed event
  ///
  /// In en, this message translates to:
  /// **'{actor} reordered the stages'**
  String activityPlanChanged(String actor);

  /// Feed event
  ///
  /// In en, this message translates to:
  /// **'{actor} started {name}'**
  String activityStageStarted(String actor, String name);

  /// Feed event, with the badge
  ///
  /// In en, this message translates to:
  /// **'{actor} added a photo: {level}'**
  String activityEvidenceCaptured(String actor, String level);

  /// Feed event
  ///
  /// In en, this message translates to:
  /// **'{actor} withdrew a photo'**
  String activityEvidenceRetracted(String actor);

  /// Feed event
  ///
  /// In en, this message translates to:
  /// **'{actor} submitted {name} for review'**
  String activityStageSubmitted(String actor, String name);

  /// Feed event
  ///
  /// In en, this message translates to:
  /// **'{actor} approved {name}'**
  String activityStageApproved(String actor, String name);

  /// Feed event
  ///
  /// In en, this message translates to:
  /// **'{actor} requested changes on {name}'**
  String activityChangesRequested(String actor, String name);

  /// Feed event, with the start of the text
  ///
  /// In en, this message translates to:
  /// **'{actor} posted an update: {excerpt}'**
  String activityUpdatePosted(String actor, String excerpt);

  /// Notification centre title and bell tooltip
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// Notification centre empty
  ///
  /// In en, this message translates to:
  /// **'No notifications yet.'**
  String get notificationsEmpty;

  /// Notification centre action
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get markAllReadAction;

  /// Notification centre load failure
  ///
  /// In en, this message translates to:
  /// **'The notifications couldn\'t be loaded.'**
  String get errorNotificationsLoad;

  /// Notification to approvers
  ///
  /// In en, this message translates to:
  /// **'{actor} submitted {stage} for review ({project})'**
  String notificationStageSubmitted(String actor, String stage, String project);

  /// Notification to site managers
  ///
  /// In en, this message translates to:
  /// **'{reviewer} approved {stage} ({project})'**
  String notificationStageApproved(
    String reviewer,
    String stage,
    String project,
  );

  /// Notification to site managers
  ///
  /// In en, this message translates to:
  /// **'{reviewer} requested changes on {stage}: {comment}'**
  String notificationChangesRequested(
    String reviewer,
    String stage,
    String comment,
  );

  /// Notification to the owner
  ///
  /// In en, this message translates to:
  /// **'{member} joined {project} as {role}'**
  String notificationMemberJoined(String member, String project, String role);

  /// Site manager: post a progress update (button and form title)
  ///
  /// In en, this message translates to:
  /// **'Post an update'**
  String get postUpdateAction;

  /// After posting an update
  ///
  /// In en, this message translates to:
  /// **'Update posted.'**
  String get updatePosted;

  /// Update page title
  ///
  /// In en, this message translates to:
  /// **'Progress update'**
  String get updateTitle;

  /// Update form field
  ///
  /// In en, this message translates to:
  /// **'What was done today?'**
  String get labelUpdateText;

  /// Update form field and update page row
  ///
  /// In en, this message translates to:
  /// **'Stage'**
  String get labelUpdateStage;

  /// Update form: no stage chosen
  ///
  /// In en, this message translates to:
  /// **'No particular stage'**
  String get noStage;

  /// Update form field and update page row
  ///
  /// In en, this message translates to:
  /// **'Workers on site'**
  String get labelWorkersCount;

  /// Update form field and update page row
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get labelWeather;

  /// Update form field and update page row
  ///
  /// In en, this message translates to:
  /// **'Issues'**
  String get labelUpdateIssues;

  /// Weather
  ///
  /// In en, this message translates to:
  /// **'Sunny'**
  String get weatherSunny;

  /// Weather
  ///
  /// In en, this message translates to:
  /// **'Cloudy'**
  String get weatherCloudy;

  /// Weather
  ///
  /// In en, this message translates to:
  /// **'Rain'**
  String get weatherRain;

  /// Weather
  ///
  /// In en, this message translates to:
  /// **'Storm'**
  String get weatherStorm;

  /// Update text empty
  ///
  /// In en, this message translates to:
  /// **'Say what was done'**
  String get validateUpdateTextRequired;

  /// Update text too long
  ///
  /// In en, this message translates to:
  /// **'At most 2,000 characters'**
  String get validateUpdateTextTooLong;

  /// Workers count invalid
  ///
  /// In en, this message translates to:
  /// **'A whole number from 0 to 999'**
  String get validateWorkersCount;

  /// Update issues too long
  ///
  /// In en, this message translates to:
  /// **'At most 1,000 characters'**
  String get validateUpdateIssuesTooLong;

  /// Update save failure
  ///
  /// In en, this message translates to:
  /// **'The update couldn\'t be posted.'**
  String get errorUpdateSave;

  /// Update load failure
  ///
  /// In en, this message translates to:
  /// **'The update couldn\'t be loaded.'**
  String get errorUpdateLoad;

  /// Chip: stage past its planned end and not approved (STG-10)
  ///
  /// In en, this message translates to:
  /// **'Late'**
  String get stageLate;

  /// Evidence page information line; never changes the badge (doc/04e M5-10)
  ///
  /// In en, this message translates to:
  /// **'Taken {days, plural, =1{1 day} other{{days} days}} after the stage\'s planned end, {date}'**
  String takenAfterPlannedEnd(int days, String date);

  /// Project progress: budget-weighted share and stage count (doc/04e M5-F2)
  ///
  /// In en, this message translates to:
  /// **'{percent}% of the budget · {approved} of {total} stages approved'**
  String progressBudgetAndStages(int percent, int approved, int total);

  /// Project progress when no stage has a budget (doc/04e M5-F2)
  ///
  /// In en, this message translates to:
  /// **'{approved} of {total} stages approved'**
  String progressStagesOnly(int approved, int total);

  /// Notification to the owner and co-funders (doc/04e M5-F1)
  ///
  /// In en, this message translates to:
  /// **'{actor} posted an update on {project}: {excerpt}'**
  String notificationUpdatePosted(String actor, String project, String excerpt);

  /// Feed event (doc/04e C-2c)
  ///
  /// In en, this message translates to:
  /// **'{actor} removed {member} ({role})'**
  String activityMemberRemoved(String actor, String member, String role);

  /// Feed event (doc/04e C-2c)
  ///
  /// In en, this message translates to:
  /// **'{actor} changed {member}\'s role from {from} to {to}'**
  String activityMemberRoleChanged(
    String actor,
    String member,
    String from,
    String to,
  );

  /// Feed: a member whose name an earlier event didn't record
  ///
  /// In en, this message translates to:
  /// **'a member'**
  String get aMember;

  /// Project page banner (doc/04e C-3)
  ///
  /// In en, this message translates to:
  /// **'This project is completed. It can no longer be changed.'**
  String get projectCompletedBanner;

  /// Project page banner (doc/04e C-3)
  ///
  /// In en, this message translates to:
  /// **'This project is archived. It can no longer be changed.'**
  String get projectArchivedBanner;

  /// Members page section (doc/04e C-2b)
  ///
  /// In en, this message translates to:
  /// **'Former members'**
  String get formerMembersTitle;

  /// Former member row
  ///
  /// In en, this message translates to:
  /// **'Joined {joined} · removed {removed} by {by}'**
  String formerMemberRemovedBy(String joined, String removed, String by);

  /// Former member row, remover unknown
  ///
  /// In en, this message translates to:
  /// **'Joined {joined} · removed {removed}'**
  String formerMemberRemoved(String joined, String removed);

  /// A person who has left the project (doc/04e C-2d)
  ///
  /// In en, this message translates to:
  /// **'{name} (former member)'**
  String formerMemberName(String name);

  /// Evidence page row (doc/04e C-2d)
  ///
  /// In en, this message translates to:
  /// **'Taken by'**
  String get labelTakenBy;

  /// Site proposal row (doc/04e C-2d)
  ///
  /// In en, this message translates to:
  /// **'Proposed by'**
  String get labelProposedBy;

  /// Update page row (doc/04e C-2d)
  ///
  /// In en, this message translates to:
  /// **'Posted by'**
  String get labelPostedBy;

  /// Confirm completing a project (doc/04e D-2)
  ///
  /// In en, this message translates to:
  /// **'Complete {name}?'**
  String completeProjectTitle(String name);

  /// Confirm button
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get completeProjectAction;

  /// Complete dialog when stages are unfinished
  ///
  /// In en, this message translates to:
  /// **'{count} of {total} stages aren\'t approved yet. Their photos and history stay, but nothing more can be added, submitted or reviewed.'**
  String completeProjectUnfinished(int count, int total);

  /// Complete dialog
  ///
  /// In en, this message translates to:
  /// **'You can reopen the project later.'**
  String get completeProjectReopen;

  /// Confirm archiving (doc/04e D-3)
  ///
  /// In en, this message translates to:
  /// **'Archive {name}?'**
  String archiveProjectTitle(String name);

  /// Archive dialog
  ///
  /// In en, this message translates to:
  /// **'An archived project can never be reopened or changed. Members can still read everything.'**
  String get archiveProjectMessage;

  /// Archive dialog field
  ///
  /// In en, this message translates to:
  /// **'Type the project name to confirm'**
  String get archiveProjectTypeName;

  /// Archive dialog button
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archiveProjectAction;

  /// Screen reader label of the breadcrumb trail (doc/05 §9 DP-5)
  ///
  /// In en, this message translates to:
  /// **'Where you are'**
  String get breadcrumbLabel;

  /// Project tab (doc/05 §9 DP-3)
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overviewTab;

  /// Rail and sidebar: back to the project list
  ///
  /// In en, this message translates to:
  /// **'All projects'**
  String get allProjects;

  /// Project card cover label
  ///
  /// In en, this message translates to:
  /// **'Latest photo'**
  String get latestPhoto;

  /// Project page section
  ///
  /// In en, this message translates to:
  /// **'Latest photos'**
  String get latestPhotosTitle;

  /// After the percentage on a project card
  ///
  /// In en, this message translates to:
  /// **'of the budget'**
  String get ofTheBudget;

  /// Hero caption after the percentage
  ///
  /// In en, this message translates to:
  /// **'of the budget approved'**
  String get budgetApprovedCaption;

  /// Hero caption when no stage has a budget
  ///
  /// In en, this message translates to:
  /// **'of the stages approved'**
  String get stagesApprovedCaption;

  /// Hero figure: approved stages
  ///
  /// In en, this message translates to:
  /// **'{approved} of {total}'**
  String stagesOfTotal(int approved, int total);

  /// Hero figure label
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get figureBudget;

  /// Hero figure label: planned end
  ///
  /// In en, this message translates to:
  /// **'Ends'**
  String get figureEnds;

  /// What waits for an approver (doc/05 §9)
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{name} is waiting for your review} other{{count} stages are waiting for your review}}'**
  String attentionReview(int count, String name);

  /// What waits for the site manager (doc/05 §9)
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Changes were requested on {name}} other{Changes were requested on {count} stages}}'**
  String attentionChanges(int count, String name);

  /// Stage chip for an approver
  ///
  /// In en, this message translates to:
  /// **'Waiting for your review'**
  String get waitingForYourReview;

  /// Members card
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 member} other{{count} members}}'**
  String membersCount(int count);

  /// Project page section
  ///
  /// In en, this message translates to:
  /// **'About the project'**
  String get aboutTitle;

  /// Activity day heading
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayLabel;

  /// Activity day heading
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterdayLabel;

  /// Notification centre section
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get notificationsNew;

  /// Notification centre section
  ///
  /// In en, this message translates to:
  /// **'Earlier'**
  String get notificationsEarlier;

  /// Photo page verdict line
  ///
  /// In en, this message translates to:
  /// **'{passed} of {total} checks passed'**
  String checksPassed(int passed, int total);

  /// Stage page section
  ///
  /// In en, this message translates to:
  /// **'Photos of this stage'**
  String get stagePhotosTitle;

  /// Project list: join a project
  ///
  /// In en, this message translates to:
  /// **'Join with a code'**
  String get joinWithCode;

  /// Web project list heading
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No projects yet} =1{1 project} other{{count} projects}}'**
  String projectsCount(int count);

  /// Web project list heading
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 stage waiting for your review} other{{count} stages waiting for your review}}'**
  String stagesWaitingForReview(int count);

  /// Web grid's last tile
  ///
  /// In en, this message translates to:
  /// **'Start a new project'**
  String get startProjectTitle;

  /// Web grid's last tile
  ///
  /// In en, this message translates to:
  /// **'From a template or from scratch'**
  String get startProjectHint;

  /// The ⋮ menu of an app bar
  ///
  /// In en, this message translates to:
  /// **'More actions'**
  String get moreActions;

  /// Checklist row
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{no photo yet} =1{1 photo} other{{count} photos}}'**
  String photoCount(int count);

  /// Photo verdict line
  ///
  /// In en, this message translates to:
  /// **'{meters} m from the site centre'**
  String distanceFromCentre(int meters);

  /// Photo page: open the checks
  ///
  /// In en, this message translates to:
  /// **'See the {count} checks'**
  String seeChecks(int count);

  /// Members page subtitle
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 person} other{{count} people}}'**
  String peopleCount(int count);

  /// Member row of an approving co-funder
  ///
  /// In en, this message translates to:
  /// **'Can approve stages'**
  String get canApproveShort;

  /// Activity tab subtitle
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get liveLabel;

  /// Activity post: after the name
  ///
  /// In en, this message translates to:
  /// **'posted an update'**
  String get postedAnUpdate;

  /// Overview switch on a phone: the project details
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutShort;

  /// Stage page switch on a phone: the required evidence
  ///
  /// In en, this message translates to:
  /// **'Checklist'**
  String get checklistShort;

  /// Stage page switch on a phone: the stage's photos
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photosTitle;

  /// Stage page switch on a phone: the review history
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTitle;

  /// Lists: search, filters, sorting (doc/05 §9.5)
  ///
  /// In en, this message translates to:
  /// **'Search projects'**
  String get searchProjects;

  /// Lists: search, filters, sorting (doc/05 §9.5): the chip that filters nothing
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// Lists: search, filters, sorting (doc/05 §9.5): the sort button
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sortAction;

  /// Lists: search, filters, sorting (doc/05 §9.5)
  ///
  /// In en, this message translates to:
  /// **'Latest activity'**
  String get sortRecent;

  /// Lists: search, filters, sorting (doc/05 §9.5)
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get sortName;

  /// Lists: search, filters, sorting (doc/05 §9.5)
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get sortProgress;

  /// Lists: search, filters, sorting (doc/05 §9.5)
  ///
  /// In en, this message translates to:
  /// **'Nothing matches these filters.'**
  String get noMatches;

  /// Lists: search, filters, sorting (doc/05 §9.5)
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get clearFilters;

  /// Lists: search, filters, sorting (doc/05 §9.5): Activity kind
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get kindPhotos;

  /// Lists: search, filters, sorting (doc/05 §9.5): Activity kind
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get kindReviews;

  /// Lists: search, filters, sorting (doc/05 §9.5): Activity kind
  ///
  /// In en, this message translates to:
  /// **'Updates'**
  String get kindUpdates;

  /// Lists: search, filters, sorting (doc/05 §9.5): Activity kind
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get kindMembers;

  /// Lists: search, filters, sorting (doc/05 §9.5): Activity kind
  ///
  /// In en, this message translates to:
  /// **'Site'**
  String get kindSite;

  /// Lists: search, filters, sorting (doc/05 §9.5): Activity stage picker
  ///
  /// In en, this message translates to:
  /// **'All stages'**
  String get allStages;

  /// Lists: search, filters, sorting (doc/05 §9.5): notifications chip
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get notificationsUnread;

  /// Lists: search, filters, sorting (doc/05 §9.5): Stages tab chip
  ///
  /// In en, this message translates to:
  /// **'Needs you'**
  String get stageFilterNeedsYou;

  /// Lists: search, filters, sorting (doc/05 §9.5): Stages tab, a chip with no stage
  ///
  /// In en, this message translates to:
  /// **'No stage here.'**
  String get noStageHere;

  /// Lists: search, filters, sorting (doc/05 §9.5): a stage's photos, item picker
  ///
  /// In en, this message translates to:
  /// **'All items'**
  String get allItems;

  /// Lists: search, filters, sorting (doc/05 §9.5): a stage's photos, badge chip
  ///
  /// In en, this message translates to:
  /// **'Partial'**
  String get badgePartial;

  /// Lists: search, filters, sorting (doc/05 §9.5): a stage's photos, nothing matches
  ///
  /// In en, this message translates to:
  /// **'No photo here.'**
  String get noPhotoHere;

  /// Lists: search, filters, sorting (doc/05 §9.5): a stage's photos, back to the mosaic
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get showLess;

  /// Progress update page and form (doc/05 §9.6)
  ///
  /// In en, this message translates to:
  /// **'Issues on site'**
  String get updateIssuesTitle;

  /// Progress update page and form (doc/05 §9.6): the web side card
  ///
  /// In en, this message translates to:
  /// **'On site'**
  String get updateOnSite;

  /// Progress update page and form (doc/05 §9.6)
  ///
  /// In en, this message translates to:
  /// **'Posted'**
  String get labelPosted;

  /// Progress update page and form (doc/05 §9.6)
  ///
  /// In en, this message translates to:
  /// **'Open the {stage} stage'**
  String openStageTitle(String stage);

  /// Progress update page and form (doc/05 §9.6)
  ///
  /// In en, this message translates to:
  /// **'Its checklist and photos'**
  String get openStageHint;

  /// Progress update page and form (doc/05 §9.6)
  ///
  /// In en, this message translates to:
  /// **'This update is no longer available.'**
  String get updateGone;

  /// Progress update page and form (doc/05 §9.6)
  ///
  /// In en, this message translates to:
  /// **'Back to Activity'**
  String get backToActivity;

  /// Progress update page and form (doc/05 §9.6)
  ///
  /// In en, this message translates to:
  /// **'{project} · the funders are notified'**
  String updateFormSubtitle(String project);

  /// Progress update page and form (doc/05 §9.6): the form button
  ///
  /// In en, this message translates to:
  /// **'Post update'**
  String get postUpdateSave;

  /// Progress update page and form (doc/05 §9.6)
  ///
  /// In en, this message translates to:
  /// **'Close without posting'**
  String get closeWithoutPosting;

  /// Progress update page and form (doc/05 §9.6): workers stepper
  ///
  /// In en, this message translates to:
  /// **'One fewer'**
  String get fewerWorkers;

  /// Progress update page and form (doc/05 §9.6): workers stepper
  ///
  /// In en, this message translates to:
  /// **'One more'**
  String get moreWorkers;

  /// Progress update page and form (doc/05 §9.6)
  ///
  /// In en, this message translates to:
  /// **'Issues (optional)'**
  String get labelUpdateIssuesOptional;

  /// Progress update page and form (doc/05 §9.6)
  ///
  /// In en, this message translates to:
  /// **'Delays, shortages, anything the funders should know'**
  String get updateIssuesHint;

  /// Progress update page and form (doc/05 §9.6)
  ///
  /// In en, this message translates to:
  /// **'Walls, deliveries, what is next…'**
  String get updateTextHint;

  /// Activity tab photo row; the badge below says the verdict
  ///
  /// In en, this message translates to:
  /// **'{actor} added a photo'**
  String activityPhotoAdded(String actor);

  /// Web overview: the attention card's button (doc/05 §9.3)
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get reviewShort;

  /// Server error code (doc/04f)
  ///
  /// In en, this message translates to:
  /// **'Check the entry: an amount above zero, a date not in the future, and the required details.'**
  String get errorInvalidLedgerEntry;

  /// Server error code (doc/04f)
  ///
  /// In en, this message translates to:
  /// **'This entry doesn’t exist in this project.'**
  String get errorLedgerEntryNotFound;

  /// Server error code (doc/04f)
  ///
  /// In en, this message translates to:
  /// **'This entry has already been reversed.'**
  String get errorAlreadyReversed;

  /// Server error code (doc/04f)
  ///
  /// In en, this message translates to:
  /// **'This release has already been confirmed.'**
  String get errorAlreadyConfirmed;

  /// Server error code (doc/04f)
  ///
  /// In en, this message translates to:
  /// **'Only the person who recorded this entry can reverse it.'**
  String get errorNotEntryAuthor;

  /// The ledger (doc/04f M6-9)
  ///
  /// In en, this message translates to:
  /// **'{actor} recorded a release of {amount}'**
  String activityFundReleased(String actor, String amount);

  /// The ledger (doc/04f M6-9)
  ///
  /// In en, this message translates to:
  /// **'{actor} confirmed receiving {amount}'**
  String activityReleaseConfirmed(String actor, String amount);

  /// The ledger (doc/04f M6-9)
  ///
  /// In en, this message translates to:
  /// **'{actor} recorded an expense of {amount}'**
  String activityExpenseRecorded(String actor, String amount);

  /// The ledger (doc/04f M6-9)
  ///
  /// In en, this message translates to:
  /// **'{actor} reversed an entry of {amount}'**
  String activityEntryReversed(String actor, String amount);

  /// The ledger (doc/04f M6-9)
  ///
  /// In en, this message translates to:
  /// **'{actor} recorded a release of {amount} for {project}'**
  String notificationFundReleased(String actor, String amount, String project);

  /// The ledger (doc/04f M6-9)
  ///
  /// In en, this message translates to:
  /// **'{actor} confirmed receiving {amount} ({project})'**
  String notificationReleaseConfirmed(
    String actor,
    String amount,
    String project,
  );

  /// The ledger (doc/04f M6-9)
  ///
  /// In en, this message translates to:
  /// **'{actor} recorded an expense of {amount} on {project}'**
  String notificationExpenseRecorded(
    String actor,
    String amount,
    String project,
  );

  /// The ledger (doc/04f M6-9)
  ///
  /// In en, this message translates to:
  /// **'{actor} reversed an entry of {amount} on {project}'**
  String notificationEntryReversed(String actor, String amount, String project);

  /// Activity kind chip: ledger events (doc/04f M6-9)
  ///
  /// In en, this message translates to:
  /// **'Money'**
  String get kindMoney;
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
