// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Plotwatch';

  @override
  String get refresh => 'Rafraîchir';

  @override
  String get searchCountry => 'Rechercher un pays';

  @override
  String get validateMobile1 => 'Numéro de téléphone invalide';

  @override
  String get tel => 'Tel';

  @override
  String get validateMobile2 => 'Le numéro de téléphone doit commencer par 6.';

  @override
  String get authenticationRequired => 'Authentification Requise';

  @override
  String get ok => 'OK';

  @override
  String get noData => 'Aucune donnée';

  @override
  String get loading => 'Chargement...';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get proceed => 'Procéder';

  @override
  String get search => 'Recherche';

  @override
  String get operationError => 'Une erreur est survenue';

  @override
  String get logoLabel => 'Logo de Plotwatch';

  @override
  String get welcomeTagline =>
      'Financez une construction que vous ne pouvez pas surveiller, avec des preuves vérifiées.';

  @override
  String get signIn => 'Se connecter';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get signOut => 'Se déconnecter';

  @override
  String get labelEmail => 'E-mail';

  @override
  String get labelPassword => 'Mot de passe';

  @override
  String get labelNewPassword => 'Nouveau mot de passe';

  @override
  String get labelFullName => 'Nom complet';

  @override
  String get labelVerificationCode => 'Code de vérification';

  @override
  String get passwordRuleHint =>
      'Au moins 8 caractères, sans espace au début ni à la fin';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get noAccountYet => 'Pas encore de compte ? Créez-en un';

  @override
  String get alreadyHaveAccount => 'Déjà un compte ? Connectez-vous';

  @override
  String get continueAction => 'Continuer';

  @override
  String get resendCode => 'Envoyer un nouveau code';

  @override
  String get signUpTitle => 'Créez votre compte';

  @override
  String signUpCodeSent(String email) {
    return 'Si $email peut être inscrit, nous lui avons envoyé un code de vérification.';
  }

  @override
  String get choosePasswordTitle => 'Choisissez un mot de passe';

  @override
  String get passwordResetTitle => 'Réinitialisez votre mot de passe';

  @override
  String passwordResetCodeSent(String email) {
    return 'Si $email a un compte, nous lui avons envoyé un code de réinitialisation.';
  }

  @override
  String get validateEmailRequired => 'Saisissez votre e-mail';

  @override
  String get validateEmailInvalid => 'Saisissez un e-mail valide';

  @override
  String get validatePasswordRequired => 'Saisissez un mot de passe';

  @override
  String get validatePasswordTooShort => 'Utilisez au moins 8 caractères';

  @override
  String get validatePasswordSpaces =>
      'Supprimez les espaces au début ou à la fin';

  @override
  String get validateCodeRequired => 'Saisissez le code reçu par e-mail';

  @override
  String get validateNameRequired => 'Saisissez votre nom';

  @override
  String get validateNameTooLong => 'Utilisez 100 caractères au maximum';

  @override
  String get errorPermissionDenied =>
      'Vous n\'avez pas l\'autorisation de faire cela.';

  @override
  String get errorInvalidFullName => 'Saisissez un nom de 1 à 100 caractères.';

  @override
  String get errorInvalidCountryCode => 'Choisissez un pays dans la liste.';

  @override
  String get errorInvalidLocale => 'Choisissez l\'anglais ou le français.';

  @override
  String get errorProjectNotFound =>
      'Ce projet n\'existe pas ou vous n\'en êtes pas membre.';

  @override
  String get errorInvalidProjectName =>
      'Saisissez un nom de projet de 1 à 100 caractères.';

  @override
  String get errorInvalidProjectDescription =>
      'Utilisez 1 000 caractères au maximum pour la description.';

  @override
  String get errorInvalidCurrencyCode => 'Choisissez une devise dans la liste.';

  @override
  String get errorInvalidProjectDates =>
      'La fin prévue doit être le même jour ou après le début prévu.';

  @override
  String get errorInvalidStatusTransition =>
      'Le projet ne peut pas passer à ce statut depuis son statut actuel.';

  @override
  String get errorInvalidSiteLocation =>
      'Choisissez un emplacement valide pour le chantier.';

  @override
  String get errorInvalidSiteRadius =>
      'Le rayon du chantier doit être compris entre 10 et 500 mètres.';

  @override
  String get errorInvitationNotFound =>
      'Aucune invitation ne correspond à ce code. Vérifiez-le et réessayez.';

  @override
  String get errorInvitationExpired =>
      'Cette invitation a expiré. Demandez-en une nouvelle.';

  @override
  String get errorInvitationUsed =>
      'Cette invitation a déjà été utilisée ou annulée.';

  @override
  String get errorInvalidInvitationRole =>
      'Choisissez chef de chantier, co-financeur ou observateur.';

  @override
  String get errorAlreadyMember => 'Vous êtes déjà membre de ce projet.';

  @override
  String get errorCannotRemoveOwner =>
      'Le propriétaire du projet ne peut pas être retiré.';

  @override
  String get errorMemberNotFound =>
      'Cette personne n\'est pas membre du projet.';

  @override
  String get errorSiteProposalNotFound =>
      'Cette proposition d\'emplacement n\'existe pas dans ce projet.';

  @override
  String get errorSiteProposalNotPending =>
      'Cette proposition d\'emplacement a déjà été traitée ou remplacée.';

  @override
  String get errorSiteAccuracyTooLow =>
      'La position GPS n\'est pas assez précise. Placez-vous à ciel ouvert et attendez une précision de 20 m ou mieux.';

  @override
  String get errorSiteMockLocation =>
      'Votre téléphone indique une position simulée. Désactivez toute application de fausse localisation et réessayez.';

  @override
  String get errorTextTooLong => 'Ce texte est trop long.';

  @override
  String get errorAuthInvalidCredentials => 'E-mail ou mot de passe incorrect.';

  @override
  String get errorAuthTooManyAttempts =>
      'Trop de tentatives. Réessayez dans quelques minutes.';

  @override
  String get errorAuthRequestExpired =>
      'Ce code a expiré. Demandez-en un nouveau.';

  @override
  String get errorAuthRequestInvalid =>
      'Ce code n\'est pas valide. Vérifiez-le et réessayez.';

  @override
  String get errorAuthPasswordPolicy =>
      'Ce mot de passe n\'est pas autorisé. Utilisez au moins 8 caractères, sans espace au début ni à la fin.';

  @override
  String get errorAuthUserBlocked => 'Ce compte est bloqué.';

  @override
  String get errorAuthUnknown => 'L\'authentification a échoué. Réessayez.';

  @override
  String get errorUnauthorized => 'Votre session a expiré. Reconnectez-vous.';

  @override
  String get networkError =>
      'Pas de connexion. Vérifiez votre accès à internet et réessayez.';

  @override
  String get errorSignIn => 'Impossible de se connecter. Réessayez.';

  @override
  String get errorSignUp => 'Impossible de créer le compte. Réessayez.';

  @override
  String get errorPasswordReset =>
      'Impossible de réinitialiser le mot de passe. Réessayez.';

  @override
  String get errorSignOut => 'Impossible de se déconnecter. Réessayez.';

  @override
  String get labelConfirmPassword => 'Confirmez le mot de passe';

  @override
  String get labelConfirmNewPassword => 'Confirmez le nouveau mot de passe';

  @override
  String get validateConfirmPasswordRequired =>
      'Saisissez à nouveau le mot de passe';

  @override
  String get validatePasswordMismatch =>
      'Les mots de passe ne correspondent pas';

  @override
  String get signInHeading => 'Bon retour';

  @override
  String get showPassword => 'Afficher le mot de passe';

  @override
  String get hidePassword => 'Masquer le mot de passe';

  @override
  String get profileTitle => 'Profil';

  @override
  String get labelCountry => 'Pays';

  @override
  String get selectCountry => 'Sélectionnez votre pays';

  @override
  String get labelLanguage => 'Langue';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageFrench => 'Français';

  @override
  String get saveChanges => 'Enregistrer';

  @override
  String get profileSaved => 'Votre profil a été enregistré.';

  @override
  String get errorProfileLoad =>
      'Impossible de charger votre profil. Réessayez.';

  @override
  String get errorProfileSave =>
      'Impossible d\'enregistrer votre profil. Réessayez.';

  @override
  String get projectsTitle => 'Mes projets';

  @override
  String get newProject => 'Nouveau projet';

  @override
  String get projectsEmpty =>
      'Aucun projet pour l\'instant. Créez-en un, ou rejoignez un projet avec le code d\'invitation reçu.';

  @override
  String get errorProjectsLoad =>
      'Impossible de charger vos projets. Réessayez.';

  @override
  String get errorProjectLoad => 'Impossible de charger ce projet. Réessayez.';

  @override
  String get errorProjectCreate => 'Impossible de créer le projet. Réessayez.';

  @override
  String get errorProjectSave =>
      'Impossible d\'enregistrer le projet. Réessayez.';

  @override
  String get projectTypeNewHouse => 'Maison neuve';

  @override
  String get projectTypeExpansion => 'Extension';

  @override
  String get projectTypeRenovation => 'Rénovation';

  @override
  String get projectTypeCommunityBuilding => 'Bâtiment communautaire';

  @override
  String get projectTypeOther => 'Autre';

  @override
  String get projectStatusDraft => 'Brouillon';

  @override
  String get projectStatusActive => 'Actif';

  @override
  String get projectStatusPaused => 'En pause';

  @override
  String get projectStatusCompleted => 'Terminé';

  @override
  String get projectStatusArchived => 'Archivé';

  @override
  String get projectRoleOwner => 'Propriétaire';

  @override
  String get projectRoleCoFunder => 'Co-financeur';

  @override
  String get projectRoleViewer => 'Observateur';

  @override
  String get projectRoleSiteManager => 'Chef de chantier';

  @override
  String get labelProjectName => 'Nom du projet';

  @override
  String get labelDescription => 'Description (facultative)';

  @override
  String get labelProjectType => 'Type de travaux';

  @override
  String get selectProjectType => 'Choisissez le type de travaux';

  @override
  String get labelCurrency => 'Devise';

  @override
  String get selectCurrency => 'Choisissez une devise';

  @override
  String get labelPlannedStart => 'Début prévu (facultatif)';

  @override
  String get labelPlannedEnd => 'Fin prévue (facultative)';

  @override
  String get validateProjectNameRequired => 'Saisissez un nom de projet';

  @override
  String get validateProjectNameTooLong => 'Utilisez 100 caractères au maximum';

  @override
  String get validateDescriptionTooLong =>
      'Utilisez 1 000 caractères au maximum';

  @override
  String get validateProjectTypeRequired =>
      'Choisissez un type de travaux pour continuer';

  @override
  String get validateCurrencyRequired => 'Choisissez une devise pour continuer';

  @override
  String get validateDatesOrder =>
      'La fin doit être le même jour ou après le début';

  @override
  String stepOf(int current, int total) {
    return 'Étape $current sur $total';
  }

  @override
  String get stepDetailsTitle => 'Détails du projet';

  @override
  String get stepReviewTitle => 'Vérifiez et créez';

  @override
  String get reviewDraftNote =>
      'Le projet commence en brouillon. Il devient actif une fois que votre chef de chantier a localisé le chantier et que vous avez validé l\'emplacement.';

  @override
  String get createProjectAction => 'Créer le projet';

  @override
  String get backAction => 'Retour';

  @override
  String get editAction => 'Modifier';

  @override
  String get changeStatus => 'Changer le statut';

  @override
  String get labelStatus => 'Statut';

  @override
  String get labelYourRole => 'Votre rôle';

  @override
  String get labelPlannedDates => 'Dates prévues';

  @override
  String get notSet => 'Non défini';

  @override
  String get siteTitle => 'Chantier';

  @override
  String get siteWaiting => 'En attente de l\'emplacement du chantier.';

  @override
  String get siteWaitingOwner =>
      'Invitez un chef de chantier à localiser le terrain, ou localisez-le vous-même si vous êtes sur place.';

  @override
  String get siteWaitingManager =>
      'Rendez-vous sur le terrain et localisez le chantier avec votre téléphone, pour que le propriétaire puisse le valider.';

  @override
  String get labelPlusCode => 'Plus Code';

  @override
  String get labelAddress => 'Adresse ou repère';

  @override
  String get labelRadius => 'Rayon';

  @override
  String radiusMeters(int radius) {
    return '$radius m';
  }

  @override
  String get editProjectTitle => 'Modifier le projet';

  @override
  String get projectSaved => 'Le projet a été enregistré.';

  @override
  String get statusChanged => 'Le statut a été modifié.';

  @override
  String get membersTitle => 'Membres';

  @override
  String get inviteAction => 'Inviter';

  @override
  String get pendingInvitations => 'Invitations en attente';

  @override
  String invitationExpires(String date) {
    return 'Expire le $date';
  }

  @override
  String removeMemberTitle(String name) {
    return 'Retirer $name ?';
  }

  @override
  String get removeMemberMessage =>
      'Cette personne perd immédiatement l\'accès au projet.';

  @override
  String get cancelInvitationAction => 'Annuler l\'invitation';

  @override
  String get errorMembersLoad =>
      'Impossible de charger les membres. Réessayez.';

  @override
  String get errorMembersSave =>
      'Impossible de modifier les membres. Réessayez.';

  @override
  String get errorInvitationCreate =>
      'Impossible de créer l\'invitation. Réessayez.';

  @override
  String get errorJoinProject =>
      'Impossible de rejoindre le projet. Réessayez.';

  @override
  String get inviteTitle => 'Inviter une personne';

  @override
  String get labelRole => 'Rôle';

  @override
  String get canApproveLabel =>
      'Peut approuver les étapes et enregistrer les versements';

  @override
  String get createInvitationAction => 'Créer l\'invitation';

  @override
  String get invitationReadyTitle => 'Invitation prête';

  @override
  String get invitationReadyText =>
      'Envoyez ce code ou ce lien. Il ne sert qu\'une fois et expire dans 7 jours.';

  @override
  String get copyLinkAction => 'Copier le lien';

  @override
  String get linkCopied => 'Lien copié ✓';

  @override
  String get shareInvitationAction => 'Partager l\'invitation';

  @override
  String get shareAction => 'Partager';

  @override
  String get doneAction => 'Terminé';

  @override
  String invitationShareText(String link, String code) {
    return 'Rejoignez mon projet de construction sur Plotwatch : $link (code d\'invitation $code)';
  }

  @override
  String get joinTitle => 'Rejoindre un projet';

  @override
  String get joinHeading => 'Saisissez votre code d\'invitation';

  @override
  String get labelInvitationCode => 'Code d\'invitation';

  @override
  String get checkCodeAction => 'Vérifier le code';

  @override
  String get validateInvitationCodeRequired => 'Saisissez le code reçu';

  @override
  String invitedBy(String name) {
    return 'Invité par $name';
  }

  @override
  String get joinAction => 'Rejoindre le projet';

  @override
  String get localizeSiteTitle => 'Localiser le chantier';

  @override
  String get localizeSiteHint =>
      'Placez-vous dans le terrain, à ciel ouvert, et attendez une précision de 20 m ou mieux.';

  @override
  String get localizePhoneOnly =>
      'Localisez le chantier avec l\'application Plotwatch sur votre téléphone, sur le terrain.';

  @override
  String get gettingPosition => 'Recherche de votre position…';

  @override
  String get locationDenied =>
      'Plotwatch a besoin de votre position pour localiser le chantier.';

  @override
  String get allowLocation => 'Autoriser la localisation';

  @override
  String get locationDeniedForever =>
      'La localisation est bloquée pour Plotwatch. Autorisez-la dans les réglages de l\'application.';

  @override
  String get openSettings => 'Ouvrir les réglages';

  @override
  String get locationServiceOff =>
      'La localisation est désactivée sur ce téléphone.';

  @override
  String get turnOnLocation => 'Activer la localisation';

  @override
  String accuracyMeters(int meters) {
    return '± $meters m';
  }

  @override
  String get accuracyGood =>
      'Précision suffisante. Vous pouvez enregistrer cette position.';

  @override
  String get accuracyWaiting => 'Attendez 20 m ou mieux, à ciel ouvert.';

  @override
  String get saveLocationAction => 'Enregistrer cette position';

  @override
  String get siteProposalSent =>
      'Emplacement envoyé. Le propriétaire va le vérifier.';

  @override
  String get errorSiteProposal =>
      'Impossible d\'enregistrer l\'emplacement. Réessayez.';

  @override
  String get errorSiteLoad =>
      'Impossible de charger l\'emplacement. Réessayez.';

  @override
  String get errorSiteSave =>
      'Impossible d\'enregistrer votre décision. Réessayez.';

  @override
  String get mapUnavailable =>
      'La carte ne peut pas être affichée pour le moment.';

  @override
  String get validateSiteTitle => 'Valider l\'emplacement';

  @override
  String get validateSiteHint =>
      'Vérifiez que le cercle couvre le terrain, avec quelques mètres de marge.';

  @override
  String get noPendingProposal => 'Aucun emplacement n\'attend de validation.';

  @override
  String get labelAccuracy => 'Précision GPS';

  @override
  String get labelReadAt => 'Relevé le';

  @override
  String get labelAddressOptional => 'Adresse ou repère (facultatif)';

  @override
  String get validateAction => 'Valider';

  @override
  String get rejectAction => 'Refuser';

  @override
  String get rejectReasonTitle => 'Refuser cet emplacement ?';

  @override
  String get rejectReasonLabel => 'Motif (facultatif)';

  @override
  String get siteValidated => 'L\'emplacement du chantier est validé.';

  @override
  String get siteRejected =>
      'L\'emplacement a été refusé. Un nouveau peut être proposé.';

  @override
  String get siteProposalPendingOwner =>
      'Un emplacement attend votre validation.';

  @override
  String get siteProposalPendingManager =>
      'En attente de la validation de votre emplacement par le propriétaire.';

  @override
  String get reviewLocationAction => 'Vérifier l\'emplacement';

  @override
  String get localizeSiteAction => 'Localiser le chantier';

  @override
  String get localizeAgainAction => 'Localiser à nouveau';

  @override
  String get proposeNewLocationAction => 'Proposer un nouvel emplacement';
}
