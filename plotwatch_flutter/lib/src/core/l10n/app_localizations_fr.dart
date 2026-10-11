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
  String get projectsTitle => 'Projets';

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

  @override
  String get errorCannotChangeOwnerRole =>
      'Le rôle du propriétaire du projet ne peut pas être modifié.';

  @override
  String get errorInvalidMemberRole =>
      'Un membre ne peut pas devenir propriétaire.';

  @override
  String get errorSiteNotFound =>
      'Ce projet n\'a pas encore de chantier validé.';

  @override
  String get editSiteAction => 'Modifier le chantier';

  @override
  String get editSiteTitle => 'Modifier le chantier';

  @override
  String get editSiteHint =>
      'Modifiez le cercle ou l\'adresse. Pour déplacer le point, proposez un nouvel emplacement depuis le terrain.';

  @override
  String get siteUpdated => 'Le chantier a été mis à jour.';

  @override
  String changeRoleTitle(String name) {
    return 'Changer le rôle de $name';
  }

  @override
  String get errorStageNotFound => 'Cette étape n\'existe pas dans ce projet.';

  @override
  String get errorStageLocked =>
      'Cette étape ne peut plus être modifiée : elle a commencé ou a été soumise.';

  @override
  String get errorInvalidStageName =>
      'Saisissez un nom d\'étape de 100 caractères au plus.';

  @override
  String get errorInvalidStageDescription =>
      'Utilisez 1 000 caractères au plus pour la description.';

  @override
  String get errorInvalidBudget => 'Saisissez un budget de 0 ou plus.';

  @override
  String get errorInvalidStageDates =>
      'La fin doit être le même jour que le début ou après.';

  @override
  String get errorInvalidChecklistItem =>
      'Chaque élément de la liste doit avoir un libellé de 200 caractères au plus.';

  @override
  String get errorTooManyStages => 'Un projet peut avoir 50 étapes au plus.';

  @override
  String get errorTooManyChecklistItems =>
      'Une étape peut avoir 30 éléments de liste au plus.';

  @override
  String get errorInvalidStageOrder =>
      'Les étapes ont changé entre-temps. Actualisez et réessayez.';

  @override
  String get errorStagePlanNotEmpty => 'Ce projet a déjà des étapes.';

  @override
  String get errorInvalidStageTransition => 'Cette étape a déjà commencé.';

  @override
  String get errorProjectNotActive =>
      'Les travaux peuvent commencer une fois l\'emplacement du chantier validé.';

  @override
  String get errorProjectNotEditable =>
      'Un projet terminé ou archivé ne peut pas être modifié.';

  @override
  String get labelBudget => 'Budget';

  @override
  String get validateBudgetInvalid => 'Saisissez un montant, par ex. 1500000';

  @override
  String get stageStatusNotStarted => 'Pas commencée';

  @override
  String get stageStatusInProgress => 'En cours';

  @override
  String get stageStatusSubmitted => 'Soumise';

  @override
  String get stageStatusChangesRequested => 'Modifications demandées';

  @override
  String get stageStatusApproved => 'Approuvée';

  @override
  String get templateHouse => 'Maison de plain-pied';

  @override
  String get templateHouseHint =>
      '10 étapes, de la préparation du terrain aux finitions';

  @override
  String get templateRenovation => 'Rénovation';

  @override
  String get templateRenovationHint =>
      '6 étapes, de l\'état avant travaux à la remise';

  @override
  String get templateCustom => 'Personnalisé';

  @override
  String get templateCustomHint => 'Commencez sans étape et ajoutez les vôtres';

  @override
  String get tplHouse1 => 'Préparation du terrain et implantation';

  @override
  String get tplHouse1a => 'Terrain dégagé (vue d\'ensemble)';

  @override
  String get tplHouse1b => 'Piquets et cordeaux d\'implantation';

  @override
  String get tplHouse2 => 'Fouilles des fondations';

  @override
  String get tplHouse2a => 'Tranchées avec un mètre montrant la profondeur';

  @override
  String get tplHouse2b => 'Les quatre coins des tranchées';

  @override
  String get tplHouse3 => 'Fondations et soubassement';

  @override
  String get tplHouse3a => 'Ferraillage avant coulage';

  @override
  String get tplHouse3b => 'Semelle coulée';

  @override
  String get tplHouse4 => 'Murs jusqu\'au niveau des linteaux';

  @override
  String get tplHouse4a => 'Chaque mur extérieur';

  @override
  String get tplHouse4b => 'Ouvertures des portes et fenêtres';

  @override
  String get tplHouse5 => 'Linteaux et chaînage';

  @override
  String get tplHouse5a => 'Ferraillage avant coulage';

  @override
  String get tplHouse5b => 'Chaînage terminé';

  @override
  String get tplHouse6 => 'Toiture';

  @override
  String get tplHouse6a => 'Charpente (fermes)';

  @override
  String get tplHouse6b => 'Couverture terminée';

  @override
  String get tplHouse7 => 'Portes et fenêtres';

  @override
  String get tplHouse7a => 'Cadres posés';

  @override
  String get tplHouse7b => 'Portes et fenêtres posées';

  @override
  String get tplHouse8 => 'Électricité et plomberie (réseaux encastrés)';

  @override
  String get tplHouse8a => 'Gaines et tuyaux dans les murs avant l\'enduit';

  @override
  String get tplHouse9 => 'Enduits et chapes';

  @override
  String get tplHouse9a => 'Murs intérieurs';

  @override
  String get tplHouse9b => 'Sols';

  @override
  String get tplHouse10 => 'Finitions';

  @override
  String get tplHouse10a => 'Peinture, carrelage et équipements';

  @override
  String get tplHouse10b => 'Visite finale';

  @override
  String get tplReno1 => 'État avant rénovation';

  @override
  String get tplReno1a => 'Chaque pièce avant les travaux';

  @override
  String get tplReno1b => 'Dégâts existants en gros plan';

  @override
  String get tplReno2 => 'Démolition et évacuation';

  @override
  String get tplReno2a => 'Zones dégagées';

  @override
  String get tplReno2b => 'Gravats évacués du chantier';

  @override
  String get tplReno3 => 'Réparations structurelles';

  @override
  String get tplReno3a => 'Réparations avant d\'être recouvertes';

  @override
  String get tplReno3b => 'Réparations terminées';

  @override
  String get tplReno4 => 'Réseaux (électricité et plomberie)';

  @override
  String get tplReno4a =>
      'Nouveaux câbles et tuyaux avant la fermeture des murs';

  @override
  String get tplReno5 => 'Finitions';

  @override
  String get tplReno5a => 'Peinture, carrelage et équipements';

  @override
  String get tplReno6 => 'Remise des travaux';

  @override
  String get tplReno6a => 'Chaque pièce après les travaux';

  @override
  String get tplReno6b => 'Clés et documents remis';

  @override
  String get stepStagesTitle => 'Étapes';

  @override
  String get templateCustomEmpty =>
      'Le plan commence vide. Ajoutez des étapes après avoir créé le projet.';

  @override
  String get templateEditableNote =>
      'Vous pourrez modifier, ajouter, déplacer ou supprimer des étapes après la création du projet.';

  @override
  String get labelStages => 'Étapes';

  @override
  String templateWithCount(String name, int count) {
    return '$name ($count étapes)';
  }

  @override
  String get stagesTitle => 'Étapes';

  @override
  String get addStageAction => 'Ajouter une étape';

  @override
  String get labelTotalBudget => 'Budget total';

  @override
  String get labelProgress => 'Avancement';

  @override
  String get stagesEmpty =>
      'Aucune étape pour l\'instant. Le propriétaire les planifie.';

  @override
  String get stagesEmptyOwner =>
      'Aucune étape pour l\'instant. Partez d\'un modèle ou ajoutez les vôtres.';

  @override
  String useTemplateAction(String name) {
    return 'Partir de « $name »';
  }

  @override
  String itemsCovered(int covered, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$covered sur $total éléments couverts',
      one: '$covered sur 1 élément couvert',
      zero: 'Aucun élément de liste',
    );
    return '$_temp0';
  }

  @override
  String get reorderStageHint => 'Faites glisser pour déplacer l\'étape';

  @override
  String get errorStagesLoad => 'Impossible de charger les étapes. Réessayez.';

  @override
  String get errorStagesSave =>
      'Impossible d\'enregistrer les étapes. Réessayez.';

  @override
  String stageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count étapes',
      one: '1 étape',
      zero: 'Aucune étape pour l\'instant',
    );
    return '$_temp0';
  }

  @override
  String get editStageAction => 'Modifier l\'étape';

  @override
  String deleteStageTitle(String name) {
    return 'Supprimer $name ?';
  }

  @override
  String get deleteStageMessage => 'Sa liste d\'éléments est aussi supprimée.';

  @override
  String get stageStarted => 'L\'étape a commencé.';

  @override
  String stageNumber(int number) {
    return 'Étape $number';
  }

  @override
  String get checklistTitle => 'Preuves demandées';

  @override
  String get checklistOptional => 'Facultatif';

  @override
  String get checklistRequired => 'Obligatoire';

  @override
  String get startStageAction => 'Commencer l\'étape';

  @override
  String get stageStartNeedsSite =>
      'L\'étape pourra commencer une fois l\'emplacement du chantier validé par le propriétaire.';

  @override
  String get labelStageName => 'Nom de l\'étape';

  @override
  String get checklistHint =>
      'Les photos que le chef de chantier doit prendre pour cette étape.';

  @override
  String labelChecklistItem(int number) {
    return 'Élément $number';
  }

  @override
  String get moveUpAction => 'Monter';

  @override
  String get removeItemAction => 'Retirer';

  @override
  String get addChecklistItemAction => 'Ajouter un élément';

  @override
  String get validateStageNameRequired => 'Saisissez un nom d\'étape';

  @override
  String get validateStageNameTooLong => 'Utilisez 100 caractères au plus';

  @override
  String get validateChecklistLabelRequired => 'Décrivez la photo attendue';

  @override
  String get validateChecklistLabelTooLong => 'Utilisez 200 caractères au plus';

  @override
  String get errorEvidenceNotFound =>
      'Cette photo n\'existe pas dans ce projet.';

  @override
  String get errorChecklistItemNotFound =>
      'Cet élément de liste n\'existe pas dans cette étape.';

  @override
  String get errorEvidenceNotCommitted => 'Cette photo a déjà été envoyée.';

  @override
  String get errorUploadMissing =>
      'La photo n\'est pas arrivée. Réessayez de l\'envoyer.';

  @override
  String get errorEvidenceFileTooLarge => 'La photo dépasse 10 Mo.';

  @override
  String get errorInvalidEvidenceMetadata =>
      'Les informations de la photo sont incomplètes. Reprenez-la.';

  @override
  String get errorEvidenceAlreadyRetracted => 'Cette photo a déjà été retirée.';

  @override
  String get errorNotYourCapture =>
      'Seule la personne qui a pris cette photo peut faire cela.';

  @override
  String get errorChecklistItemHasEvidence =>
      'Cet élément de liste a des photos : il ne peut pas être retiré. Vous pouvez encore le renommer.';

  @override
  String get verificationPending => 'En cours de vérification';

  @override
  String get verificationVerified => 'Vérifiée';

  @override
  String get verificationPartial => 'Partiellement vérifiée';

  @override
  String get verificationUnverified => 'Non vérifiée';

  @override
  String get checkInAppCaptureTitle => 'Appareil photo Plotwatch';

  @override
  String get checkLocationPresentTitle => 'Position GPS';

  @override
  String get checkLocationAccuracyTitle => 'Précision GPS';

  @override
  String get checkInsideSiteTitle => 'Sur le chantier';

  @override
  String get checkNotMockLocationTitle => 'Position réelle';

  @override
  String get checkHashMatchTitle => 'Photo intacte';

  @override
  String get checkClockConsistencyTitle => 'Horloge du téléphone';

  @override
  String get checkPromptCommitTitle => 'Envoyée rapidement';

  @override
  String get checkInAppCapturePassed =>
      'Prise avec l\'appareil photo de Plotwatch';

  @override
  String get checkInAppCaptureFailed =>
      'Pas prise avec l\'appareil photo de Plotwatch';

  @override
  String get checkLocationPresentPassed => 'Une position GPS a été enregistrée';

  @override
  String get checkLocationPresentFailed =>
      'Aucune position GPS n\'a été enregistrée';

  @override
  String checkLocationAccuracyPassed(int accuracy, int allowed) {
    return 'Précise à $accuracy m (autorisé : $allowed m)';
  }

  @override
  String checkLocationAccuracyFailed(int accuracy, int allowed) {
    return 'Précise à $accuracy m seulement (autorisé : $allowed m)';
  }

  @override
  String get checkLocationAccuracyUnknown => 'La précision GPS est inconnue';

  @override
  String checkInsideSitePassed(int distance, int allowed) {
    return 'Prise à $distance m du centre du chantier ; autorisé : $allowed m';
  }

  @override
  String checkInsideSiteFailed(int distance, int allowed) {
    return 'Prise à $distance m du chantier ; autorisé : $allowed m';
  }

  @override
  String get checkInsideSiteUnknown =>
      'Pas de position : impossible de la situer sur le chantier';

  @override
  String get checkNotMockLocationPassed => 'La position n\'a pas été falsifiée';

  @override
  String get checkNotMockLocationFailed =>
      'Le téléphone a signalé une position falsifiée';

  @override
  String get checkHashMatchPassed =>
      'La photo enregistrée est exactement celle qui a été prise';

  @override
  String get checkHashMatchFailed =>
      'La photo enregistrée diffère de celle qui a été prise';

  @override
  String checkClockConsistencyPassed(int allowed) {
    return 'L\'horloge du téléphone était juste (à $allowed min près)';
  }

  @override
  String checkClockConsistencyFailed(int skew, int allowed) {
    return 'L\'horloge du téléphone avait $skew min d\'écart (autorisé : $allowed min)';
  }

  @override
  String checkPromptCommitPassed(int allowed) {
    return 'Envoyée dans les $allowed min suivant la prise';
  }

  @override
  String checkPromptCommitFailed(int delay, int allowed) {
    return 'Envoyée $delay min après la prise (autorisé : $allowed min)';
  }

  @override
  String get captureTitle => 'Prendre une photo';

  @override
  String get capturePhoneOnly =>
      'Les photos se prennent avec l\'application Plotwatch sur le téléphone, sur le terrain.';

  @override
  String get cameraDenied =>
      'Plotwatch a besoin de l\'appareil photo pour prendre la photo. Autorisez-le dans les réglages de l\'application.';

  @override
  String get allowCamera => 'Autoriser l\'appareil photo';

  @override
  String get cameraUnavailable =>
      'Aucun appareil photo n\'est disponible sur cet appareil.';

  @override
  String get takePhotoAction => 'Prendre une photo';

  @override
  String get captureReviewHint => 'Vérifiez la photo avant de l\'envoyer.';

  @override
  String get labelCaptionOptional => 'Légende (facultatif)';

  @override
  String get usePhotoAction => 'Utiliser cette photo';

  @override
  String get retakeAction => 'La reprendre';

  @override
  String get sendStepCommitting => 'Enregistrement de la photo…';

  @override
  String get sendStepUploading => 'Envoi de la photo…';

  @override
  String get sendStepChecking =>
      'Vérification du lieu et de l\'heure de la prise…';

  @override
  String get errorUploadFailed =>
      'La photo n\'a pas pu être envoyée. Vérifiez la connexion et réessayez.';

  @override
  String get errorCaptureSend =>
      'La photo n\'a pas pu être envoyée. Réessayez.';

  @override
  String get retryAction => 'Réessayer';

  @override
  String get captureResultTitle => 'Photo vérifiée';

  @override
  String get verificationNotice =>
      'La vérification prouve où et quand cette photo a été prise, pas la qualité des travaux.';

  @override
  String get captureNoFix => 'Recherche du GPS…';

  @override
  String get captureInsideSite => 'Sur le chantier';

  @override
  String captureOutsideSite(int distance) {
    return 'Hors du chantier (≈ $distance m)';
  }

  @override
  String get captureLocationOff =>
      'Localisation désactivée : la photo ne sera pas vérifiée';

  @override
  String captureAccuracy(int accuracy) {
    return 'GPS ± $accuracy m';
  }

  @override
  String get captureRetracted => 'Retirée';

  @override
  String get captureUploadFailed => 'Échec de l\'envoi';

  @override
  String get captureNotReceived => 'Pas encore reçue';

  @override
  String get evidenceTitle => 'Photo';

  @override
  String get captureRetractedDone => 'La photo a été retirée.';

  @override
  String get errorEvidenceLoad => 'Impossible de charger la photo. Réessayez.';

  @override
  String captureRetractedReason(String reason) {
    return 'Retirée : $reason';
  }

  @override
  String get checksTitle => 'Vérifications';

  @override
  String get evidenceDetailsTitle => 'Détails';

  @override
  String get labelTakenAt => 'Prise (heure du téléphone)';

  @override
  String get labelReceivedAt => 'Reçue (heure du serveur)';

  @override
  String get labelPosition => 'Position';

  @override
  String get labelDistanceToSite => 'Distance au centre du chantier';

  @override
  String distanceMeters(int distance) {
    return '$distance m';
  }

  @override
  String get labelDevice => 'Appareil';

  @override
  String get labelAppVersion => 'Version de l\'application';

  @override
  String get retractAction => 'Retirer cette photo';

  @override
  String get retractTitle => 'Retirer cette photo ?';

  @override
  String get retractReasonLabel => 'Pourquoi ? (reste dans l\'historique)';

  @override
  String get validateRetractReasonRequired =>
      'Indiquez pourquoi la photo est retirée';

  @override
  String get capturePhotoLabel => 'Photo du chantier';

  @override
  String get capturePhotoUnavailable => 'Photo indisponible';

  @override
  String get captureNeverReceived =>
      'Cette photo n\'a jamais été reçue. Reprenez-la si elle est encore utile.';

  @override
  String get errorChecklistIncomplete =>
      'Chaque élément obligatoire doit avoir au moins une photo avant de soumettre l\'étape.';

  @override
  String get errorReviewCommentRequired => 'Indiquez ce qui doit changer.';

  @override
  String get errorNotificationNotFound => 'Cette notification n\'existe pas.';

  @override
  String get errorInvalidProgressUpdate =>
      'Vérifiez la mise à jour : texte de 2 000 caractères au plus, 0 à 999 ouvriers, problèmes de 1 000 caractères au plus.';

  @override
  String get errorUpdateNotFound =>
      'Cette mise à jour n\'existe pas dans ce projet.';

  @override
  String get stageSubmittedDone => 'Étape envoyée pour validation.';

  @override
  String get stageApprovedDone => 'Étape approuvée.';

  @override
  String get changesRequestedDone =>
      'Modifications demandées. Le chef de chantier a été prévenu.';

  @override
  String changesRequestedBy(String name, String comment) {
    return '$name a demandé des modifications : $comment';
  }

  @override
  String get submitStageAction => 'Soumettre pour validation';

  @override
  String submitMissingItems(String items) {
    return 'Avant de soumettre, ajoutez une photo pour : $items';
  }

  @override
  String get submitStageMessage =>
      'Les validateurs seront prévenus. Pendant la validation, vous ne pouvez ni modifier l\'étape ni ajouter de photos.';

  @override
  String get approveStageAction => 'Approuver';

  @override
  String get approveStageMessage =>
      'Approuver cette étape ? Le chef de chantier sera prévenu et l\'avancement du projet augmentera.';

  @override
  String get requestChangesAction => 'Demander des modifications';

  @override
  String get reviewHistoryTitle => 'Historique des validations';

  @override
  String reviewDecisionBy(String decision, String name, String date) {
    return '$decision par $name, $date';
  }

  @override
  String get reviewApproved => 'Approuvée';

  @override
  String get reviewChangesRequested => 'Modifications demandées';

  @override
  String get reviewCommentLabel => 'Que faut-il changer ?';

  @override
  String get validateReviewCommentRequired => 'Indiquez ce qui doit changer';

  @override
  String get someone => 'Quelqu\'un';

  @override
  String get activityTitle => 'Activité';

  @override
  String get latestActivityTitle => 'Activité récente';

  @override
  String get activityEmpty => 'Rien ne s\'est encore passé.';

  @override
  String get seeAll => 'Tout voir';

  @override
  String get reconnecting => 'Reconnexion…';

  @override
  String get errorActivityLoad => 'Impossible de charger l\'activité.';

  @override
  String activityProjectCreated(String actor, String name) {
    return '$actor a créé le projet $name';
  }

  @override
  String activityProjectUpdated(String actor) {
    return '$actor a modifié les informations du projet';
  }

  @override
  String activityProjectStatusChanged(String actor, String status) {
    return '$actor a passé le projet à « $status »';
  }

  @override
  String activitySiteProposed(String actor) {
    return '$actor a proposé l\'emplacement du chantier';
  }

  @override
  String activitySiteProposalRejected(String actor) {
    return '$actor a refusé l\'emplacement proposé';
  }

  @override
  String activitySiteChanged(String actor) {
    return '$actor a fixé l\'emplacement du chantier';
  }

  @override
  String activityMemberJoined(String actor, String role) {
    return '$actor a rejoint le projet comme $role';
  }

  @override
  String activityStageChanged(String actor, String name) {
    return '$actor a modifié l\'étape $name';
  }

  @override
  String activityPlanCreated(String actor, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count étapes',
      one: '1 étape',
    );
    return '$actor a créé un plan de $_temp0';
  }

  @override
  String activityPlanChanged(String actor) {
    return '$actor a réordonné les étapes';
  }

  @override
  String activityStageStarted(String actor, String name) {
    return '$actor a commencé $name';
  }

  @override
  String activityEvidenceCaptured(String actor, String level) {
    return '$actor a ajouté une photo : $level';
  }

  @override
  String activityEvidenceRetracted(String actor) {
    return '$actor a retiré une photo';
  }

  @override
  String activityStageSubmitted(String actor, String name) {
    return '$actor a soumis $name pour validation';
  }

  @override
  String activityStageApproved(String actor, String name) {
    return '$actor a approuvé $name';
  }

  @override
  String activityChangesRequested(String actor, String name) {
    return '$actor a demandé des modifications sur $name';
  }

  @override
  String activityUpdatePosted(String actor, String excerpt) {
    return '$actor a publié une mise à jour : $excerpt';
  }

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsEmpty => 'Aucune notification pour l\'instant.';

  @override
  String get markAllReadAction => 'Tout marquer comme lu';

  @override
  String get errorNotificationsLoad =>
      'Impossible de charger les notifications.';

  @override
  String notificationStageSubmitted(
    String actor,
    String stage,
    String project,
  ) {
    return '$actor a soumis $stage pour validation ($project)';
  }

  @override
  String notificationStageApproved(
    String reviewer,
    String stage,
    String project,
  ) {
    return '$reviewer a approuvé $stage ($project)';
  }

  @override
  String notificationChangesRequested(
    String reviewer,
    String stage,
    String comment,
  ) {
    return '$reviewer a demandé des modifications sur $stage : $comment';
  }

  @override
  String notificationMemberJoined(String member, String project, String role) {
    return '$member a rejoint $project comme $role';
  }

  @override
  String get postUpdateAction => 'Publier une mise à jour';

  @override
  String get updatePosted => 'Mise à jour publiée.';

  @override
  String get updateTitle => 'Mise à jour du chantier';

  @override
  String get labelUpdateText => 'Qu\'est-ce qui a été fait aujourd\'hui ?';

  @override
  String get labelUpdateStage => 'Étape';

  @override
  String get noStage => 'Aucune étape en particulier';

  @override
  String get labelWorkersCount => 'Ouvriers sur le chantier';

  @override
  String get labelWeather => 'Météo';

  @override
  String get labelUpdateIssues => 'Problèmes';

  @override
  String get weatherSunny => 'Ensoleillé';

  @override
  String get weatherCloudy => 'Nuageux';

  @override
  String get weatherRain => 'Pluie';

  @override
  String get weatherStorm => 'Orage';

  @override
  String get validateUpdateTextRequired => 'Indiquez ce qui a été fait';

  @override
  String get validateUpdateTextTooLong => '2 000 caractères au plus';

  @override
  String get validateWorkersCount => 'Un nombre entier de 0 à 999';

  @override
  String get validateUpdateIssuesTooLong => '1 000 caractères au plus';

  @override
  String get errorUpdateSave => 'Impossible de publier la mise à jour.';

  @override
  String get errorUpdateLoad => 'Impossible de charger la mise à jour.';

  @override
  String get stageLate => 'En retard';

  @override
  String takenAfterPlannedEnd(int days, String date) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days jours',
      one: '1 jour',
    );
    return 'Prise $_temp0 après la fin prévue de l\'étape, le $date';
  }

  @override
  String progressBudgetAndStages(int percent, int approved, int total) {
    return '$percent % du budget · $approved étapes approuvées sur $total';
  }

  @override
  String progressStagesOnly(int approved, int total) {
    return '$approved étapes approuvées sur $total';
  }

  @override
  String notificationUpdatePosted(
    String actor,
    String project,
    String excerpt,
  ) {
    return '$actor a publié une mise à jour sur $project : $excerpt';
  }

  @override
  String activityMemberRemoved(String actor, String member, String role) {
    return '$actor a retiré $member ($role)';
  }

  @override
  String activityMemberRoleChanged(
    String actor,
    String member,
    String from,
    String to,
  ) {
    return '$actor a changé le rôle de $member de $from à $to';
  }

  @override
  String get aMember => 'un membre';

  @override
  String get projectCompletedBanner =>
      'Ce projet est terminé. Il ne peut plus être modifié.';

  @override
  String get projectArchivedBanner =>
      'Ce projet est archivé. Il ne peut plus être modifié.';

  @override
  String get formerMembersTitle => 'Anciens membres';

  @override
  String formerMemberRemovedBy(String joined, String removed, String by) {
    return 'Arrivé le $joined · retiré le $removed par $by';
  }

  @override
  String formerMemberRemoved(String joined, String removed) {
    return 'Arrivé le $joined · retiré le $removed';
  }

  @override
  String formerMemberName(String name) {
    return '$name (ancien membre)';
  }

  @override
  String get labelTakenBy => 'Prise par';

  @override
  String get labelProposedBy => 'Proposé par';

  @override
  String get labelPostedBy => 'Publiée par';

  @override
  String completeProjectTitle(String name) {
    return 'Terminer $name ?';
  }

  @override
  String get completeProjectAction => 'Terminer';

  @override
  String completeProjectUnfinished(int count, int total) {
    return '$count étapes sur $total ne sont pas encore approuvées. Leurs photos et leur historique restent, mais plus rien ne pourra être ajouté, soumis ou validé.';
  }

  @override
  String get completeProjectReopen =>
      'Vous pourrez rouvrir le projet plus tard.';

  @override
  String archiveProjectTitle(String name) {
    return 'Archiver $name ?';
  }

  @override
  String get archiveProjectMessage =>
      'Un projet archivé ne peut plus jamais être rouvert ni modifié. Les membres peuvent toujours tout consulter.';

  @override
  String get archiveProjectTypeName =>
      'Saisissez le nom du projet pour confirmer';

  @override
  String get archiveProjectAction => 'Archiver';

  @override
  String get breadcrumbLabel => 'Où vous êtes';

  @override
  String get overviewTab => 'Aperçu';

  @override
  String get allProjects => 'Tous les projets';

  @override
  String get latestPhoto => 'Dernière photo';

  @override
  String get latestPhotosTitle => 'Dernières photos';

  @override
  String get ofTheBudget => 'du budget';

  @override
  String get budgetApprovedCaption => 'du budget approuvé';

  @override
  String get stagesApprovedCaption => 'des étapes approuvées';

  @override
  String stagesOfTotal(int approved, int total) {
    return '$approved sur $total';
  }

  @override
  String get figureBudget => 'Budget';

  @override
  String get figureEnds => 'Fin';

  @override
  String attentionReview(int count, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count étapes attendent votre validation',
      one: '$name attend votre validation',
    );
    return '$_temp0';
  }

  @override
  String attentionChanges(int count, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Des modifications sont demandées sur $count étapes',
      one: 'Des modifications sont demandées sur $name',
    );
    return '$_temp0';
  }

  @override
  String get waitingForYourReview => 'Attend votre validation';

  @override
  String membersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count membres',
      one: '1 membre',
    );
    return '$_temp0';
  }

  @override
  String get aboutTitle => 'À propos du projet';

  @override
  String get todayLabel => 'Aujourd\'hui';

  @override
  String get yesterdayLabel => 'Hier';

  @override
  String get notificationsNew => 'Nouvelles';

  @override
  String get notificationsEarlier => 'Plus anciennes';

  @override
  String checksPassed(int passed, int total) {
    return '$passed contrôles réussis sur $total';
  }

  @override
  String get stagePhotosTitle => 'Photos de cette étape';

  @override
  String get joinWithCode => 'Rejoindre avec un code';

  @override
  String projectsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count projets',
      one: '1 projet',
      zero: 'Aucun projet pour l\'instant',
    );
    return '$_temp0';
  }

  @override
  String stagesWaitingForReview(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count étapes attendent votre validation',
      one: '1 étape attend votre validation',
    );
    return '$_temp0';
  }

  @override
  String get startProjectTitle => 'Démarrer un projet';

  @override
  String get startProjectHint => 'À partir d\'un modèle ou de zéro';

  @override
  String get moreActions => 'Plus d\'actions';

  @override
  String photoCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count photos',
      one: '1 photo',
      zero: 'pas encore de photo',
    );
    return '$_temp0';
  }

  @override
  String distanceFromCentre(int meters) {
    return 'à $meters m du centre du chantier';
  }

  @override
  String seeChecks(int count) {
    return 'Voir les $count contrôles';
  }

  @override
  String peopleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count personnes',
      one: '1 personne',
    );
    return '$_temp0';
  }

  @override
  String get canApproveShort => 'Peut approuver les étapes';

  @override
  String get liveLabel => 'En direct';

  @override
  String get postedAnUpdate => 'a publié une mise à jour';

  @override
  String get aboutShort => 'À propos';

  @override
  String get checklistShort => 'Liste';

  @override
  String get photosTitle => 'Photos';

  @override
  String get historyTitle => 'Historique';

  @override
  String get searchProjects => 'Rechercher un projet';

  @override
  String get filterAll => 'Tout';

  @override
  String get sortAction => 'Trier';

  @override
  String get sortRecent => 'Activité récente';

  @override
  String get sortName => 'Nom';

  @override
  String get sortProgress => 'Avancement';

  @override
  String get noMatches => 'Rien ne correspond à ces filtres.';

  @override
  String get clearFilters => 'Effacer les filtres';

  @override
  String get kindPhotos => 'Photos';

  @override
  String get kindReviews => 'Validations';

  @override
  String get kindUpdates => 'Nouvelles';

  @override
  String get kindMembers => 'Membres';

  @override
  String get kindSite => 'Terrain';

  @override
  String get allStages => 'Toutes les étapes';

  @override
  String get notificationsUnread => 'Non lues';

  @override
  String get stageFilterNeedsYou => 'Pour vous';

  @override
  String get noStageHere => 'Aucune étape ici.';

  @override
  String get allItems => 'Tous les éléments';

  @override
  String get badgePartial => 'Partiel';

  @override
  String get noPhotoHere => 'Aucune photo ici.';

  @override
  String get showLess => 'Voir moins';

  @override
  String get updateIssuesTitle => 'Problèmes sur le chantier';

  @override
  String get updateOnSite => 'Sur le chantier';

  @override
  String get labelPosted => 'Publié';

  @override
  String openStageTitle(String stage) {
    return 'Ouvrir l’étape $stage';
  }

  @override
  String get openStageHint => 'Sa liste et ses photos';

  @override
  String get updateGone => 'Cette mise à jour n’est plus disponible.';

  @override
  String get backToActivity => 'Retour à l’activité';

  @override
  String updateFormSubtitle(String project) {
    return '$project · les financeurs sont prévenus';
  }

  @override
  String get postUpdateSave => 'Publier';

  @override
  String get closeWithoutPosting => 'Fermer sans publier';

  @override
  String get fewerWorkers => 'Un de moins';

  @override
  String get moreWorkers => 'Un de plus';

  @override
  String get labelUpdateIssuesOptional => 'Problèmes (facultatif)';

  @override
  String get updateIssuesHint =>
      'Retards, manques, tout ce que les financeurs doivent savoir';

  @override
  String get updateTextHint => 'Murs, livraisons, la suite…';

  @override
  String activityPhotoAdded(String actor) {
    return '$actor a ajouté une photo';
  }

  @override
  String get reviewShort => 'Examiner';

  @override
  String get errorInvalidLedgerEntry =>
      'Vérifiez l’écriture : un montant supérieur à zéro, une date qui n’est pas dans le futur et les informations requises.';

  @override
  String get errorLedgerEntryNotFound =>
      'Cette écriture n’existe pas dans ce projet.';

  @override
  String get errorAlreadyReversed => 'Cette écriture a déjà été annulée.';

  @override
  String get errorAlreadyConfirmed => 'Ce versement a déjà été confirmé.';

  @override
  String get errorNotEntryAuthor =>
      'Seule la personne qui a saisi cette écriture peut l’annuler.';

  @override
  String activityFundReleased(String actor, String amount) {
    return '$actor a enregistré un versement de $amount';
  }

  @override
  String activityReleaseConfirmed(String actor, String amount) {
    return '$actor a confirmé avoir reçu $amount';
  }

  @override
  String activityExpenseRecorded(String actor, String amount) {
    return '$actor a enregistré une dépense de $amount';
  }

  @override
  String activityEntryReversed(String actor, String amount) {
    return '$actor a annulé une écriture de $amount';
  }

  @override
  String notificationFundReleased(String actor, String amount, String project) {
    return '$actor a enregistré un versement de $amount pour $project';
  }

  @override
  String notificationReleaseConfirmed(
    String actor,
    String amount,
    String project,
  ) {
    return '$actor a confirmé avoir reçu $amount ($project)';
  }

  @override
  String notificationExpenseRecorded(
    String actor,
    String amount,
    String project,
  ) {
    return '$actor a enregistré une dépense de $amount sur $project';
  }

  @override
  String notificationEntryReversed(
    String actor,
    String amount,
    String project,
  ) {
    return '$actor a annulé une écriture de $amount sur $project';
  }

  @override
  String get kindMoney => 'Argent';
}
