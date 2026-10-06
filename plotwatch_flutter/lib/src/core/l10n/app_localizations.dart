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

  /// Title of the signed-in home page
  ///
  /// In en, this message translates to:
  /// **'Your projects'**
  String get homeTitle;

  /// Home page text until projects exist (M2)
  ///
  /// In en, this message translates to:
  /// **'Your construction projects will appear here.'**
  String get homePlaceholder;

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
