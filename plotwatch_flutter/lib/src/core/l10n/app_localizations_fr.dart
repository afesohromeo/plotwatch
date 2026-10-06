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
  String get homeTitle => 'Vos projets';

  @override
  String get homePlaceholder => 'Vos projets de construction apparaîtront ici.';

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
}
