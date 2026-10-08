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
  String get logoLabel => 'Plotwatch logo';

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
      'Invite a site manager to localize the plot, or localize it yourself if you\'re on the plot.';

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

  @override
  String get membersTitle => 'Members';

  @override
  String get inviteAction => 'Invite';

  @override
  String get pendingInvitations => 'Pending invitations';

  @override
  String invitationExpires(String date) {
    return 'Expires $date';
  }

  @override
  String removeMemberTitle(String name) {
    return 'Remove $name?';
  }

  @override
  String get removeMemberMessage => 'They lose access to the project at once.';

  @override
  String get cancelInvitationAction => 'Cancel the invitation';

  @override
  String get errorMembersLoad => 'Could not load the members. Try again.';

  @override
  String get errorMembersSave => 'Could not change the members. Try again.';

  @override
  String get errorInvitationCreate =>
      'Could not create the invitation. Try again.';

  @override
  String get errorJoinProject => 'Could not join the project. Try again.';

  @override
  String get inviteTitle => 'Invite someone';

  @override
  String get labelRole => 'Role';

  @override
  String get canApproveLabel => 'Can approve stages and record releases';

  @override
  String get createInvitationAction => 'Create the invitation';

  @override
  String get invitationReadyTitle => 'Invitation ready';

  @override
  String get invitationReadyText =>
      'Send this code or link. It works once and expires in 7 days.';

  @override
  String get copyLinkAction => 'Copy link';

  @override
  String get linkCopied => 'Link copied ✓';

  @override
  String get shareInvitationAction => 'Share the invitation';

  @override
  String get shareAction => 'Share';

  @override
  String get doneAction => 'Done';

  @override
  String invitationShareText(String link, String code) {
    return 'Join my construction project on Plotwatch: $link (invitation code $code)';
  }

  @override
  String get joinTitle => 'Join a project';

  @override
  String get joinHeading => 'Enter your invitation code';

  @override
  String get labelInvitationCode => 'Invitation code';

  @override
  String get checkCodeAction => 'Check the code';

  @override
  String get validateInvitationCodeRequired => 'Enter the code you received';

  @override
  String invitedBy(String name) {
    return 'Invited by $name';
  }

  @override
  String get joinAction => 'Join the project';

  @override
  String get localizeSiteTitle => 'Localize the site';

  @override
  String get localizeSiteHint =>
      'Stand inside the plot, in the open, and wait until the accuracy is 20 m or better.';

  @override
  String get localizePhoneOnly =>
      'Localize the site with the Plotwatch app on your phone, standing on the plot.';

  @override
  String get gettingPosition => 'Getting your position…';

  @override
  String get locationDenied =>
      'Plotwatch needs your location to localize the site.';

  @override
  String get allowLocation => 'Allow location';

  @override
  String get locationDeniedForever =>
      'Location is blocked for Plotwatch. Allow it in the app settings.';

  @override
  String get openSettings => 'Open settings';

  @override
  String get locationServiceOff => 'Location is turned off on this phone.';

  @override
  String get turnOnLocation => 'Turn on location';

  @override
  String accuracyMeters(int meters) {
    return '± $meters m';
  }

  @override
  String get accuracyGood => 'Accurate enough. You can save this position.';

  @override
  String get accuracyWaiting => 'Wait for 20 m or better, in the open.';

  @override
  String get saveLocationAction => 'Save this position';

  @override
  String get siteProposalSent => 'Location sent. The owner will review it.';

  @override
  String get errorSiteProposal => 'Could not save the location. Try again.';

  @override
  String get errorSiteLoad => 'Could not load the location. Try again.';

  @override
  String get errorSiteSave => 'Could not save your decision. Try again.';

  @override
  String get mapUnavailable => 'The map can\'t be shown right now.';

  @override
  String get validateSiteTitle => 'Validate the location';

  @override
  String get validateSiteHint =>
      'Check that the circle covers the plot, with a few metres to spare.';

  @override
  String get noPendingProposal => 'No location is waiting for validation.';

  @override
  String get labelAccuracy => 'GPS accuracy';

  @override
  String get labelReadAt => 'Read on';

  @override
  String get labelAddressOptional => 'Address or landmark (optional)';

  @override
  String get validateAction => 'Validate';

  @override
  String get rejectAction => 'Reject';

  @override
  String get rejectReasonTitle => 'Reject this location?';

  @override
  String get rejectReasonLabel => 'Reason (optional)';

  @override
  String get siteValidated => 'The site location is validated.';

  @override
  String get siteRejected =>
      'The location was rejected. A new one can be proposed.';

  @override
  String get siteProposalPendingOwner =>
      'A location is waiting for your validation.';

  @override
  String get siteProposalPendingManager =>
      'Waiting for the owner to validate your location.';

  @override
  String get reviewLocationAction => 'Review the location';

  @override
  String get localizeSiteAction => 'Localize the site';

  @override
  String get localizeAgainAction => 'Localize again';

  @override
  String get proposeNewLocationAction => 'Propose a new location';

  @override
  String get errorCannotChangeOwnerRole =>
      'The project owner\'s role can\'t be changed.';

  @override
  String get errorInvalidMemberRole => 'A member can\'t be made the owner.';

  @override
  String get errorSiteNotFound => 'This project has no validated site yet.';

  @override
  String get editSiteAction => 'Edit the site';

  @override
  String get editSiteTitle => 'Edit the site';

  @override
  String get editSiteHint =>
      'Change the circle or the address. To move the point, propose a new location from the plot.';

  @override
  String get siteUpdated => 'The site has been updated.';

  @override
  String changeRoleTitle(String name) {
    return 'Change the role of $name';
  }

  @override
  String get errorStageNotFound => 'This stage doesn\'t exist in this project.';

  @override
  String get errorStageLocked =>
      'This stage can\'t be changed any more: it has started or been submitted.';

  @override
  String get errorInvalidStageName =>
      'Enter a stage name of 100 characters at most.';

  @override
  String get errorInvalidStageDescription =>
      'Use 1,000 characters at most for the description.';

  @override
  String get errorInvalidBudget => 'Enter a budget of 0 or more.';

  @override
  String get errorInvalidStageDates => 'The end must be on or after the start.';

  @override
  String get errorInvalidChecklistItem =>
      'Each checklist item needs a label of 200 characters at most.';

  @override
  String get errorTooManyStages => 'A project can have 50 stages at most.';

  @override
  String get errorTooManyChecklistItems =>
      'A stage can have 30 checklist items at most.';

  @override
  String get errorInvalidStageOrder =>
      'The stages changed meanwhile. Refresh and try again.';

  @override
  String get errorStagePlanNotEmpty => 'This project already has stages.';

  @override
  String get errorInvalidStageTransition => 'This stage has already started.';

  @override
  String get errorProjectNotActive =>
      'Work can start once the site location is validated.';

  @override
  String get errorProjectNotEditable =>
      'A completed or archived project can\'t be changed.';

  @override
  String get labelBudget => 'Budget';

  @override
  String get validateBudgetInvalid => 'Enter an amount, e.g. 1500000';

  @override
  String get stageStatusNotStarted => 'Not started';

  @override
  String get stageStatusInProgress => 'In progress';

  @override
  String get stageStatusSubmitted => 'Submitted';

  @override
  String get stageStatusChangesRequested => 'Changes requested';

  @override
  String get stageStatusApproved => 'Approved';

  @override
  String get templateHouse => 'Single-storey house';

  @override
  String get templateHouseHint =>
      '10 stages, from site preparation to finishing';

  @override
  String get templateRenovation => 'Renovation';

  @override
  String get templateRenovationHint =>
      '6 stages, from the condition before work to handover';

  @override
  String get templateCustom => 'Custom';

  @override
  String get templateCustomHint => 'Start empty and add your own stages';

  @override
  String get tplHouse1 => 'Site preparation and setting out';

  @override
  String get tplHouse1a => 'Cleared plot (wide shot)';

  @override
  String get tplHouse1b => 'Setting-out pegs and lines';

  @override
  String get tplHouse2 => 'Foundation excavation';

  @override
  String get tplHouse2a => 'Trenches with a measuring tape showing the depth';

  @override
  String get tplHouse2b => 'All four corners of the trenches';

  @override
  String get tplHouse3 => 'Foundation and substructure';

  @override
  String get tplHouse3a => 'Reinforcement before pouring';

  @override
  String get tplHouse3b => 'Poured footing';

  @override
  String get tplHouse4 => 'Walls to lintel level';

  @override
  String get tplHouse4a => 'Each external wall';

  @override
  String get tplHouse4b => 'Openings for doors and windows';

  @override
  String get tplHouse5 => 'Lintel and ring beam';

  @override
  String get tplHouse5a => 'Reinforcement before pouring';

  @override
  String get tplHouse5b => 'Finished beam';

  @override
  String get tplHouse6 => 'Roofing';

  @override
  String get tplHouse6a => 'Roof structure (trusses)';

  @override
  String get tplHouse6b => 'Roof covering complete';

  @override
  String get tplHouse7 => 'Doors and windows';

  @override
  String get tplHouse7a => 'Installed frames';

  @override
  String get tplHouse7b => 'Installed doors and windows';

  @override
  String get tplHouse8 => 'Electrical and plumbing (first fix)';

  @override
  String get tplHouse8a => 'Conduits and pipes in the walls before plastering';

  @override
  String get tplHouse9 => 'Plastering and screeding';

  @override
  String get tplHouse9a => 'Interior walls';

  @override
  String get tplHouse9b => 'Floors';

  @override
  String get tplHouse10 => 'Finishing';

  @override
  String get tplHouse10a => 'Painting, tiling and fittings';

  @override
  String get tplHouse10b => 'Final walkthrough';

  @override
  String get tplReno1 => 'Condition before renovation';

  @override
  String get tplReno1a => 'Every room before work starts';

  @override
  String get tplReno1b => 'Existing damage close up';

  @override
  String get tplReno2 => 'Demolition and removal';

  @override
  String get tplReno2a => 'Areas cleared';

  @override
  String get tplReno2b => 'Debris removed from the site';

  @override
  String get tplReno3 => 'Structural repairs';

  @override
  String get tplReno3a => 'Repairs before they are covered';

  @override
  String get tplReno3b => 'Finished repairs';

  @override
  String get tplReno4 => 'Services (electrical and plumbing)';

  @override
  String get tplReno4a => 'New wiring and pipes before the walls are closed';

  @override
  String get tplReno5 => 'Finishing';

  @override
  String get tplReno5a => 'Painting, tiling and fittings';

  @override
  String get tplReno6 => 'Final handover';

  @override
  String get tplReno6a => 'Every room after the work';

  @override
  String get tplReno6b => 'Keys and documents handed over';

  @override
  String get stepStagesTitle => 'Stages';

  @override
  String get templateCustomEmpty =>
      'The plan starts empty. Add stages after creating the project.';

  @override
  String get templateEditableNote =>
      'You can change, add, move or delete stages after creating the project.';

  @override
  String get labelStages => 'Stages';

  @override
  String templateWithCount(String name, int count) {
    return '$name ($count stages)';
  }

  @override
  String get stagesTitle => 'Stages';

  @override
  String get addStageAction => 'Add a stage';

  @override
  String get labelTotalBudget => 'Total budget';

  @override
  String get labelProgress => 'Progress';

  @override
  String progressPercent(int percent) {
    return '$percent% approved';
  }

  @override
  String get stagesEmpty => 'No stages yet. The owner plans them.';

  @override
  String get stagesEmptyOwner =>
      'No stages yet. Start from a template or add your own.';

  @override
  String useTemplateAction(String name) {
    return 'Start from “$name”';
  }

  @override
  String itemsCovered(int covered, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$covered of $total items covered',
      one: '$covered of 1 item covered',
      zero: 'No checklist items',
    );
    return '$_temp0';
  }

  @override
  String get reorderStageHint => 'Drag to move the stage';

  @override
  String get errorStagesLoad => 'Could not load the stages. Try again.';

  @override
  String get errorStagesSave => 'Could not save the stages. Try again.';

  @override
  String stageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count stages',
      one: '1 stage',
      zero: 'No stages yet',
    );
    return '$_temp0';
  }

  @override
  String get editStageAction => 'Edit the stage';

  @override
  String deleteStageTitle(String name) {
    return 'Delete $name?';
  }

  @override
  String get deleteStageMessage => 'Its checklist is deleted too.';

  @override
  String get stageStarted => 'The stage has started.';

  @override
  String stageNumber(int number) {
    return 'Stage $number';
  }

  @override
  String get checklistTitle => 'Required evidence';

  @override
  String get checklistOptional => 'Optional';

  @override
  String get checklistRequired => 'Required';

  @override
  String get startStageAction => 'Start the stage';

  @override
  String get stageStartNeedsSite =>
      'The stage can start once the owner has validated the site location.';

  @override
  String get labelStageName => 'Stage name';

  @override
  String get checklistHint =>
      'The photos the site manager must take for this stage.';

  @override
  String labelChecklistItem(int number) {
    return 'Item $number';
  }

  @override
  String get moveUpAction => 'Move up';

  @override
  String get removeItemAction => 'Remove';

  @override
  String get addChecklistItemAction => 'Add an item';

  @override
  String get validateStageNameRequired => 'Enter a stage name';

  @override
  String get validateStageNameTooLong => 'Use 100 characters at most';

  @override
  String get validateChecklistLabelRequired => 'Describe the photo needed';

  @override
  String get validateChecklistLabelTooLong => 'Use 200 characters at most';

  @override
  String get errorEvidenceNotFound =>
      'This photo doesn\'t exist in this project.';

  @override
  String get errorChecklistItemNotFound =>
      'This checklist item doesn\'t exist in this stage.';

  @override
  String get errorEvidenceNotCommitted => 'This photo has already been sent.';

  @override
  String get errorUploadMissing =>
      'The photo didn\'t arrive. Try sending it again.';

  @override
  String get errorEvidenceFileTooLarge => 'The photo is larger than 10 MB.';

  @override
  String get errorInvalidEvidenceMetadata =>
      'The photo\'s details are incomplete. Take it again.';

  @override
  String get errorEvidenceAlreadyRetracted =>
      'This photo has already been withdrawn.';

  @override
  String get errorNotYourCapture =>
      'Only the person who took this photo can do this.';

  @override
  String get errorChecklistItemHasEvidence =>
      'This checklist item has photos, so it can\'t be removed. You can still rename it.';
}
