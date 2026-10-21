import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

/// French (`fr`) locale data.
///
/// Translations only: anything this table does not override falls
/// through to the English default on [ComponentLocalizations]. Text
/// direction is not handled here - Flutter resolves it from
/// [WidgetsLocalizations] and [Directionality].
class ComponentLocalizationsFr extends ComponentLocalizations {
  /// Creates the French strings.
  const ComponentLocalizationsFr([super.locale = const Locale('fr')]);

  /// Formats [value] as a number in this locale, or returns it
  /// verbatim when it is not a number.
  String _number(Object? value) {
    if (value is! num) return '$value';
    return intl.NumberFormat.decimalPattern(localeName).format(value);
  }

  @override
  String get formNotEmpty => 'Ce champ ne peut pas être vide';

  @override
  String get invalidValue => 'Valeur invalide';

  @override
  String get invalidEmail => 'Adresse e-mail invalide';

  @override
  String get invalidURL => 'URL invalide';

  @override
  String formLessThan(Object? value) =>
      'Doit être inférieur à ${_number(value)}';

  @override
  String formGreaterThan(Object? value) =>
      'Doit être supérieur à ${_number(value)}';

  @override
  String formLessThanOrEqualTo(Object? value) =>
      'Doit être inférieur ou égal à ${_number(value)}';

  @override
  String get formPhoneNumberInvalid => 'Le numéro de téléphone est invalide';

  @override
  String get formPhoneNumberEmpty => 'Le numéro de téléphone est requis';

  @override
  String formGreaterThanOrEqualTo(Object? value) =>
      'Doit être supérieur ou égal à ${_number(value)}';

  @override
  String formBetweenInclusively(Object? min, Object? max) =>
      'Doit être compris entre ${_number(min)} et ${_number(max)} (inclus)';

  @override
  String formEqualTo(Object? value) => 'Doit être égal à ${_number(value)}';

  @override
  String formBetweenExclusively(Object? min, Object? max) =>
      'Doit être compris entre ${_number(min)} et ${_number(max)} (exclus)';

  @override
  String formLengthLessThan(int limit) =>
      'Doit contenir au moins $limit caractères';

  @override
  String formLengthGreaterThan(int limit) =>
      'Doit contenir au plus $limit caractères';

  @override
  String get formPasswordDigits => 'Doit contenir au moins un chiffre';

  @override
  String get formPasswordLowercase =>
      'Doit contenir au moins une lettre minuscule';

  @override
  String get formPasswordUppercase =>
      'Doit contenir au moins une lettre majuscule';

  @override
  String get formPasswordSpecial =>
      'Doit contenir au moins un caractère spécial';

  @override
  String get commandSearch => 'Saisissez une commande ou recherchez...';

  @override
  String get commandEmpty => 'Aucun résultat.';

  @override
  String get datePickerSelectYear => 'Sélectionner une année';

  @override
  String get abbreviatedMonday => 'Lu';

  @override
  String get abbreviatedTuesday => 'Ma';

  @override
  String get abbreviatedWednesday => 'Me';

  @override
  String get abbreviatedThursday => 'Je';

  @override
  String get abbreviatedFriday => 'Ve';

  @override
  String get abbreviatedSaturday => 'Sa';

  @override
  String get abbreviatedSunday => 'Di';

  @override
  String get monthJanuary => 'Janvier';

  @override
  String get monthFebruary => 'Février';

  @override
  String get monthMarch => 'Mars';

  @override
  String get monthApril => 'Avril';

  @override
  String get monthMay => 'Mai';

  @override
  String get monthJune => 'Juin';

  @override
  String get monthJuly => 'Juillet';

  @override
  String get monthAugust => 'Août';

  @override
  String get monthSeptember => 'Septembre';

  @override
  String get monthOctober => 'Octobre';

  @override
  String get monthNovember => 'Novembre';

  @override
  String get monthDecember => 'Décembre';

  @override
  String get abbreviatedJanuary => 'Janv.';

  @override
  String get abbreviatedFebruary => 'Févr.';

  @override
  String get abbreviatedMarch => 'Mars';

  @override
  String get abbreviatedApril => 'Avr.';

  @override
  String get abbreviatedMay => 'Mai';

  @override
  String get abbreviatedJune => 'Juin';

  @override
  String get abbreviatedJuly => 'Juil.';

  @override
  String get abbreviatedAugust => 'Août';

  @override
  String get abbreviatedSeptember => 'Sept.';

  @override
  String get abbreviatedOctober => 'Oct.';

  @override
  String get abbreviatedNovember => 'Nov.';

  @override
  String get abbreviatedDecember => 'Déc.';

  @override
  String get dialogDismiss => 'Ignorer';

  @override
  String get chipInputRemoveChip => 'Supprimer';

  @override
  String get buttonCancel => 'Annuler';

  @override
  String get buttonSave => 'Enregistrer';

  @override
  String get timeHour => 'Heure';

  @override
  String get timeMinute => 'Minute';

  @override
  String get timeSecond => 'Seconde';

  @override
  String get timeAM => 'AM';

  @override
  String get timePM => 'PM';

  @override
  String get colorRed => 'Rouge';

  @override
  String get colorGreen => 'Vert';

  @override
  String get colorBlue => 'Bleu';

  @override
  String get colorAlpha => 'Alpha';

  @override
  String get colorHue => 'Teinte';

  @override
  String get colorSaturation => 'Sat';

  @override
  String get colorValue => 'Val';

  @override
  String get colorLightness => 'Lum';

  @override
  String get menuCut => 'Couper';

  @override
  String get menuCopy => 'Copier';

  @override
  String get menuPaste => 'Coller';

  @override
  String get menuSelectAll => 'Tout sélectionner';

  @override
  String get menuUndo => 'Annuler';

  @override
  String get menuRedo => 'Rétablir';

  @override
  String get menuDelete => 'Supprimer';

  @override
  String get menuShare => 'Partager';

  @override
  String get menuSearchWeb => 'Rechercher sur le Web';

  @override
  String get menuLiveTextInput => 'Texte en direct';

  @override
  String get placeholderDatePicker => 'Sélectionner une date';

  @override
  String get placeholderTimePicker => 'Sélectionner une heure';

  @override
  String get placeholderColorPicker => 'Sélectionner une couleur';

  @override
  String get buttonPrevious => 'Précédent';

  @override
  String get buttonNext => 'Suivant';

  @override
  String get refreshTriggerPull => 'Tirez pour actualiser';

  @override
  String get refreshTriggerRelease => 'Relâchez pour actualiser';

  @override
  String get refreshTriggerRefreshing => 'Actualisation...';

  @override
  String get refreshTriggerComplete => 'Actualisation terminée';

  @override
  String get colorPickerTabRGB => 'RVB';

  @override
  String get colorPickerTabHSV => 'TSV';

  @override
  String get colorPickerTabHSL => 'TSL';

  @override
  String get colorPickerTabHEX => 'HEX';

  @override
  String get commandMoveUp => 'Monter';

  @override
  String get commandMoveDown => 'Descendre';

  @override
  String get commandActivate => 'Sélectionner';

  @override
  String get timeDaysAbbreviation => 'JJ';

  @override
  String get timeHoursAbbreviation => 'HH';

  @override
  String get timeMinutesAbbreviation => 'MM';

  @override
  String get timeSecondsAbbreviation => 'SS';

  @override
  String get placeholderDurationPicker => 'Sélectionner une durée';

  @override
  String get durationDay => 'Jour';

  @override
  String get durationHour => 'Heure';

  @override
  String get durationMinute => 'Minute';

  @override
  String get durationSecond => 'Seconde';

  @override
  String get dropzoneIdle => 'Parcourir pour téléverser des fichiers';

  @override
  String get dropzoneDragging => 'Déposez des fichiers pour les téléverser';

  @override
  String get dropzoneUploading => 'Téléversement des fichiers...';

  @override
  String get dropzoneSuccess => 'Fichiers prêts';

  @override
  String get dropzoneError => 'Corrigez les erreurs pour continuer';

  @override
  String get dropzoneDisabled => 'Téléversement de fichiers désactivé';

  @override
  String get dropzoneBrowse => 'Parcourir les fichiers';

  @override
  String get emptyStateEmptyTitle => 'Rien ici pour le moment';

  @override
  String get emptyStateEmptyDescription =>
      'Créez votre premier élément pour commencer.';

  @override
  String get emptyStateNoResultsTitle => 'Aucun résultat trouvé';

  @override
  String get emptyStateNoResultsDescription =>
      'Essayez d’ajuster vos filtres ou vos termes de recherche.';

  @override
  String get emptyStateErrorTitle => 'Un problème est survenu';

  @override
  String get emptyStateErrorDescription =>
      'Nous n’avons pas pu charger ces données. Réessayez dans un instant.';

  @override
  String get filterSearch => 'Rechercher';

  @override
  String get filterSort => 'Trier';

  @override
  String get filterDateRange => 'Plage de dates';

  @override
  String get filterClearAll => 'Tout effacer';

  @override
  String get filterFilters => 'Filtres';

  @override
  String filterActiveCount(int count) => '${_number(count)} filtres actifs';

  @override
  String filterResultsCount(int count) => '${_number(count)} résultats';

  @override
  String get fileUploadChoose => 'Choisir un fichier';

  @override
  String get fileUploadNoFile => 'Aucun fichier choisi';

  @override
  String get fileUploadPickFailed => 'La sélection du fichier a échoué.';

  @override
  String get fileUploadTooMany => 'Trop de fichiers sélectionnés.';

  @override
  String get fileUploadTooLarge => 'Le fichier est trop volumineux.';

  @override
  String get fileUploadInvalidType => 'Le type de fichier n’est pas autorisé.';

  @override
  String get fileUploadUploadFailed => 'Le téléversement a échoué.';

  @override
  String fileUploadUploadFailedFor(String name) =>
      'Le téléversement a échoué pour $name.';

  @override
  String get fileUploadStatusQueued => 'En file d’attente';

  @override
  String get fileUploadStatusUploading => 'Téléversement en cours';

  @override
  String get fileUploadStatusCompleted => 'Terminé';

  @override
  String get fileUploadStatusFailed => 'Échoué';

  @override
  String get fileUploadUnknownType => 'Fichier';

  @override
  String get fileUploadRemove => 'Supprimer le fichier';

  @override
  String get fileUploadRetry => 'Réessayer le téléversement';

  @override
  String get fileUploadPreview => 'Aperçu du fichier';

  @override
  String get fileUploadDownload => 'Télécharger le fichier';

  @override
  String get errorSomethingWentWrong => 'Un problème est survenu';

  @override
  String get errorUnexpectedMessage =>
      'Veuillez réessayer ou contacter l’assistance si le problème persiste.';

  @override
  String get errorActionRetry => 'Réessayer';

  @override
  String get errorActionReport => 'Signaler';

  @override
  String get errorActionBack => 'Retour';

  @override
  String get errorActionLogin => 'Se connecter';

  @override
  String get errorActionSettings => 'Paramètres';

  @override
  String get errorActionContactSupport => 'Contacter l’assistance';

  @override
  String get errorBadRequest => 'Requête incorrecte';

  @override
  String get errorBadRequestMessage =>
      'La requête n’était pas valide. Vérifiez-la et réessayez.';

  @override
  String get errorUnauthorized => 'Non autorisé';

  @override
  String get errorLoginRequiredMessage =>
      'Veuillez vous connecter pour continuer.';

  @override
  String get errorAccessDenied => 'Accès refusé';

  @override
  String get errorAccessDeniedMessage =>
      'Vous n’avez pas l’autorisation d’effectuer cette action.';

  @override
  String get errorNotFound => 'Introuvable';

  @override
  String get errorNotFoundMessage =>
      'Nous n’avons pas trouvé ce que vous cherchiez.';

  @override
  String get errorConflict => 'Conflit';

  @override
  String get errorConflictMessage =>
      'Cette action est en conflit avec les données existantes.';

  @override
  String get errorInvalidData => 'Données non valides';

  @override
  String get errorInvalidDataMessage =>
      'Certains champs nécessitent votre attention.';

  @override
  String get errorTooManyRequests => 'Trop de requêtes';

  @override
  String get errorTooManyRequestsMessage =>
      'Veuillez patienter un moment et réessayer.';

  @override
  String get errorServerError => 'Erreur du serveur';

  @override
  String get errorServerErrorMessage =>
      'Le serveur a rencontré un problème. Veuillez réessayer.';

  @override
  String get errorRequestTimedOut => 'Délai de la requête dépassé';

  @override
  String get errorRequestTimedOutMessage =>
      'Le serveur met trop de temps à répondre.';

  @override
  String get errorAuthenticationRequired => 'Authentification requise';

  @override
  String get errorInvalidInput => 'Saisie non valide';

  @override
  String get errorReviewFieldsMessage =>
      'Veuillez vérifier les champs en surbrillance.';

  @override
  String get errorPlatformError => 'Erreur de plateforme';

  @override
  String get errorDeviceErrorMessage =>
      'Un problème est survenu sur cet appareil.';

  @override
  String get errorConnectionFailed => 'Échec de la connexion';

  @override
  String get errorConnectionFailedMessage =>
      'Vérifiez votre connexion Internet et réessayez.';

  @override
  String get errorSecureConnectionFailed => 'Échec de la connexion sécurisée';

  @override
  String get errorSecureConnectionMessage =>
      'Nous n’avons pas pu établir de connexion sécurisée.';

  @override
  String get tableResizeColumn => 'Redimensionner la colonne';

  @override
  String get tableResizeRow => 'Redimensionner la ligne';

  @override
  String get resizableHandle => 'Poignée de redimensionnement';

  @override
  String get spellCheckNoSuggestions => 'Aucune suggestion';

  @override
  String get announcementLoading => 'Chargement';

  @override
  String get announcementSuccess => 'Réussi';

  @override
  String get announcementFailure => 'Échec';

  @override
  String get toolbarMore => 'Plus';

  @override
  String get toolbarMoreActions => 'Plus d’actions';

  @override
  String get treeCollapse => 'Réduire';

  @override
  String get treeExpand => 'Développer';

  @override
  String get markdownDetails => 'Détails';

  @override
  String get carouselLabel => 'Carrousel en vedette';

  @override
  String get carouselPrimaryAction => 'Ajouter à la discussion';

  @override
  String carouselItemPreview(Object? title) =>
      'Aperçu vedette : ${title ?? mediaUntitled}';

  @override
  String carouselPageOf(int position, int length) =>
      'Page ${_number(position)} sur ${_number(length)}';

  @override
  String stepperStep(int index) => 'Étape ${_number(index + 1)}';

  @override
  String paginationPage(Object? page) => 'Page ${_number(page)}';

  @override
  String chartSeriesDefault(int index) => 'Série ${_number(index + 1)}';

  @override
  String chartSliceDefault(int index) => 'Part ${_number(index)}';

  @override
  String chartCategoryDefault(int index) => 'Catégorie ${_number(index)}';

  @override
  String get chartValueDefault => 'Valeur';

  @override
  String get chartKindLine => 'Ligne';

  @override
  String get chartKindArea => 'Zone';

  @override
  String get chartKindBar => 'Barres';

  @override
  String get chartKindDonut => 'Anneau';

  @override
  String get chartKindPie => 'Camembert';

  @override
  String get chartKindSparkline => 'Sparkline';

  @override
  String get chartKindScatter => 'Nuage';

  @override
  String get chartKindRadar => 'Radar';

  @override
  String get chartKindRadial => 'Radial';

  @override
  String chartSummaryEmpty(Object? kind) => 'Graphique $kind sans données';

  @override
  String chartSummary(int series, int points, Object? kind) =>
      'Graphique $kind avec ${_number(series)} séries et ${_number(points)} points';

  @override
  String get colorFieldHsv => 'Champ de couleur HSV';

  @override
  String get colorFieldHsl => 'Champ de couleur HSL';

  @override
  String get actionClear => 'Effacer';

  @override
  String get actionApply => 'Appliquer';

  @override
  String get actionVerify => 'Vérifier';

  @override
  String get actionResend => 'Renvoyer';

  @override
  String resendInSeconds(int seconds) => 'Renvoyer dans ${_number(seconds)} s';

  @override
  String get authCode => 'Code';

  @override
  String get authEmail => 'E-mail';

  @override
  String get authPassword => 'Mot de passe';

  @override
  String get authName => 'Nom';

  @override
  String get authSignIn => 'Se connecter';

  @override
  String get authForgotPassword => 'Mot de passe oublié ?';

  @override
  String get authRememberMe => 'Se souvenir de moi';

  @override
  String get authCreateAccount => 'Créer un compte';

  @override
  String get actionClose => 'Fermer';

  @override
  String get mediaPlay => 'Lecture';

  @override
  String get mediaPause => 'Pause';

  @override
  String get mediaMute => 'Muet';

  @override
  String get mediaUnmute => 'Rétablir le son';

  @override
  String get mediaVolume => 'Volume';

  @override
  String get mediaSeek => 'Rechercher';

  @override
  String get mediaDownload => 'Télécharger';

  @override
  String get mediaAudioPlayer => 'Lecteur audio';

  @override
  String get mediaVideoPlayer => 'Lecteur vidéo';

  @override
  String get mediaUntitled => 'Sans titre';

  @override
  String get mediaPlaybackFailed => 'Échec de la lecture';

  @override
  String get mediaPreviousTrack => 'Piste précédente';

  @override
  String get mediaNextTrack => 'Piste suivante';

  @override
  String get mediaShuffleDisable => 'Désactiver l’aléatoire';

  @override
  String get mediaShuffleEnable => 'Activer l’aléatoire';

  @override
  String get mediaRepeatDisable => 'Désactiver la répétition';

  @override
  String get mediaRepeatEnable => 'Activer la répétition';

  @override
  String mediaPlaybackSpeed(Object? speed) =>
      'Vitesse de lecture : ${speed}x, toucher pour modifier';

  @override
  String mediaPositionOf(Object position, Object duration) =>
      '$position sur $duration';

  @override
  String mediaHours(int count) =>
      count == 1 ? '1 heure' : '${_number(count)} heures';

  @override
  String mediaMinutes(int count) =>
      count == 1 ? '1 minute' : '${_number(count)} minutes';

  @override
  String mediaSeconds(int count) =>
      count == 1 ? '1 seconde' : '${_number(count)} secondes';

  @override
  String get signaturePadLabel => 'Zone de signature';

  @override
  String get qrCodeLabel => 'QR code';

  @override
  String get marqueeContent => 'Contenu défilant';

  @override
  String mediaSkipBack(int seconds) =>
      'Reculer de ${_number(seconds)} secondes';

  @override
  String mediaSkipForward(int seconds) =>
      'Avancer de ${_number(seconds)} secondes';

  @override
  String get mediaCaptionsShow => 'Afficher les sous-titres';

  @override
  String get mediaCaptionsHide => 'Masquer les sous-titres';

  @override
  String get mediaCaptionsOn => 'Sous-titres activés';

  @override
  String get mediaCaptionsOff => 'Sous-titres désactivés';

  @override
  String get mediaFullscreen => 'Plein écran';

  @override
  String mediaMoreOptionsSpeed(Object? speed) =>
      'Plus d’options, vitesse de lecture : ${speed}x';

  @override
  String mediaSpeed(Object? speed) => 'Vitesse : ${speed}x';

  @override
  String get actionStartTrial => 'Démarrer l’essai gratuit';

  @override
  String get authFirstName => 'Prénom';

  @override
  String get authLastName => 'Nom';

  @override
  String get authPasswordHint => '8 caractères minimum.';

  @override
  String get authUseDifferentEmail => 'Utiliser une autre adresse e-mail';

  @override
  String get authWorkEmail => 'E-mail professionnel';

  @override
  String get chartTotalLabel => 'Total';

  @override
  String get mediaQualityAuto => 'Qualité Auto';

  @override
  String get blockDontHaveAccount => 'Pas encore de compte ?';

  @override
  String get blockAlreadyHaveAccount => 'Vous avez déjà un compte ?';

  @override
  String get blockNoAccountYet => 'Pas encore de compte ?';

  @override
  String get blockHaveAnAccount => 'Vous avez un compte ?';

  @override
  String get blockCreateOne => 'Créez-en un';

  @override
  String get blockCreateAccount => 'Créer un compte';

  @override
  String get blockCreateYourAccount => 'Créez votre compte';

  @override
  String get blockForgotYourPassword => 'Mot de passe oublié ?';

  @override
  String get blockBackToSignIn => 'Retour à la connexion';

  @override
  String get blockEnterCredentialsWorkspace =>
      'Saisissez vos identifiants pour accéder à votre espace de travail.';

  @override
  String get blockEnterCredentialsContinue =>
      'Saisissez vos identifiants pour continuer.';

  @override
  String get blockEnterDetailsContinue =>
      'Saisissez vos informations ci-dessous pour continuer.';

  @override
  String get blockEnterEmailCreateAccount =>
      'Saisissez votre e-mail ci-dessous pour créer votre compte.';

  @override
  String get blockSignedInWelcomeBack => 'Connecté — bon retour parmi nous.';

  @override
  String get blockAccountCreatedVerify =>
      'Compte créé — vérifiez votre boîte de réception pour le valider.';

  @override
  String get blockTrialStartedVerify =>
      'Essai démarré — vérifiez votre boîte de réception pour le valider.';

  @override
  String get blockPasswordsDoNotMatch =>
      'Les mots de passe ne correspondent pas.';

  @override
  String get blockCurrentPassword => 'Mot de passe actuel';

  @override
  String get blockNewPassword => 'Nouveau mot de passe';

  @override
  String get blockConfirmNewPassword => 'Confirmer le nouveau mot de passe';

  @override
  String get blockUpdatePassword => 'Mettre à jour le mot de passe';

  @override
  String get blockPasswordUpdated => 'Mot de passe mis à jour.';

  @override
  String get blockPasswordHintChange =>
      '8 caractères minimum. La modifier vous déconnecte ailleurs.';

  @override
  String get blockUsername => 'Nom d’utilisateur';

  @override
  String get blockUsernameHint =>
      'Minuscules, chiffres, traits de soulignement.';

  @override
  String get blockYourAvatar => 'Votre avatar';

  @override
  String get blockUploadImage => 'Importer une image';

  @override
  String get blockBio => 'Biographie';

  @override
  String get blockBioHint => 'Parlez-nous un peu de vous';

  @override
  String get blockBioCounterHint => '160 caractères maximum.';

  @override
  String get blockProfileSaved => 'Profil enregistré.';

  @override
  String get blockSaveChanges => 'Enregistrer les modifications';

  @override
  String get blockInviteMember => 'Inviter un membre';

  @override
  String get blockRoleAdmin => 'Admin';

  @override
  String get blockRoleOwner => 'Propriétaire';

  @override
  String get blockRoleMember => 'Membre';

  @override
  String get blockTeam => 'Équipe';

  @override
  String get blockProfile => 'Profil';

  @override
  String get blockSignInWithEmail => 'Se connecter avec un e-mail';

  @override
  String get blockSignUp => 'S’inscrire';

  @override
  String get blockPickWayYouPrefer =>
      'Choisissez la méthode que vous préférez.';

  @override
  String blockContinueWith(Object? provider) => 'Continuer avec $provider';

  @override
  String get blockCreating => 'Création en cours…';

  @override
  String get blockSigningIn => 'Connexion en cours…';

  @override
  String get blockSending => 'Envoi en cours…';

  @override
  String get blockSaving => 'Enregistrement en cours…';

  @override
  String get blockPaying => 'Paiement en cours…';

  @override
  String get blockSendResetLink => 'Envoyer le lien de réinitialisation';

  @override
  String get blockResetPassword => 'Réinitialiser le mot de passe';

  @override
  String get blockResetLinkSent =>
      'Lien de réinitialisation envoyé. Vérifiez votre boîte de réception pour continuer.';

  @override
  String get blockWeWillEmailReset =>
      'Nous vous enverrons un lien de réinitialisation par e-mail.';

  @override
  String get blockMustAcceptTerms =>
      'Vous devez accepter les conditions pour continuer.';

  @override
  String get blockCheckInbox => 'Vérifiez votre boîte de réception';

  @override
  String get blockEnterSixDigitCode =>
      'Saisissez le code à 6 chiffres que nous vous avons envoyé.';

  @override
  String get blockCodeVerifiedSignedIn => 'Code vérifié. Vous êtes connecté.';

  @override
  String get blockEmailVerifiedSet => 'E-mail vérifié — tout est prêt.';

  @override
  String get blockVerifyYourEmail => 'Vérifiez votre e-mail';

  @override
  String blockWeSentCodeTo(Object? email) =>
      'Nous avons envoyé un code à 6 chiffres à $email.';

  @override
  String get blockDidntGetCode => 'Vous n’avez pas reçu le code ?';

  @override
  String get blockBack => 'Retour';

  @override
  String get blockBackToCart => 'Retour au panier';

  @override
  String get blockBackToSettings => 'Retour aux paramètres';

  @override
  String get blockOneAccountEverything => 'Un seul compte pour tout.';

  @override
  String get blockStartTrialNoCard =>
      'Démarrez votre essai de 14 jours. Aucune carte bancaire requise.';

  @override
  String get blockNotifications => 'Notifications';

  @override
  String get blockNotifChoose =>
      'Choisissez ce dont vous voulez être informé, et où.';

  @override
  String get blockEmailNotifications => 'Notifications par e-mail';

  @override
  String get blockPushNotifications => 'Notifications push';

  @override
  String get blockMentionsReplies => 'Mentions et réponses';

  @override
  String get blockDeliveredToDevices => 'Livré sur vos appareils';

  @override
  String blockEmailChannel(Object? channel) => 'E-mail · $channel';

  @override
  String blockPushChannel(Object? channel) => 'Push · $channel';

  @override
  String get blockQuietHours => 'Heures silencieuses';

  @override
  String get blockWeeklyDigest => 'Résumé hebdomadaire';

  @override
  String get blockWeeklyDigestBlurb =>
      'Un e-mail chaque lundi avec tout ce qui s’est passé.';

  @override
  String get blockPreferencesSaved => 'Préférences enregistrées.';

  @override
  String get blockSavePreferences => 'Enregistrer les préférences';

  @override
  String get blockReset => 'Réinitialiser';

  @override
  String get blockWelcomeAboard => 'Bienvenue à bord';

  @override
  String get blockQuickTour =>
      'Une visite rapide avant d’utiliser l’application.';

  @override
  String get blockStayInLoop => 'Restez informé';

  @override
  String get blockMessagesArriveMoment =>
      'Les messages et nouveautés arrivent dès qu’ils se produisent.';

  @override
  String get blockNeverMissThing => 'Ne manquez rien';

  @override
  String get blockNotifPermissionBlurb =>
      'Nous n’envoyons que l’essentiel : réponses, rappels et alertes de sécurité. Vous pourrez modifier cela plus tard.';

  @override
  String get blockEnableNotifications => 'Activer les notifications ?';

  @override
  String get blockAllowNotifications => 'Autoriser les notifications';

  @override
  String get blockAllowNotificationsBlurb =>
      'Autorisez les notifications pour profiter au mieux de l’application.';

  @override
  String get blockNotNow => 'Pas maintenant';

  @override
  String get blockSkip => 'Passer';

  @override
  String get blockGetStarted => 'Commencer';

  @override
  String get blockMessages => 'Messages';

  @override
  String get blockNoConversations => 'Aucune conversation';

  @override
  String get blockPullRefreshChat =>
      'Tirez pour actualiser ou démarrez une nouvelle discussion.';

  @override
  String get blockMute => 'Mettre en sourdine';

  @override
  String get blockMuted => 'En sourdine';

  @override
  String get blockAttach => 'Joindre';

  @override
  String get blockAttachFile => 'Fichier';

  @override
  String get blockAttachPhoto => 'Photo';

  @override
  String get blockWriteMessage => 'Écrivez un message…';

  @override
  String get blockYourCart => 'Votre panier';

  @override
  String get blockAddSomethingFirst =>
      'Ajoutez d’abord quelque chose que vous aimez.';

  @override
  String get blockCartEmpty => 'Le panier est vide';

  @override
  String get blockCheckout => 'Commander';

  @override
  String blockQty(int quantity) => 'Qté $quantity';

  @override
  String blockPayTotal(Object? amount) => 'Payer $amount';

  @override
  String get blockPayment => 'Paiement';

  @override
  String get blockCardNumber => 'Numéro de carte';

  @override
  String get blockExpiry => 'Expiration';

  @override
  String get blockCvc => 'CVC';

  @override
  String get blockDeliveryAddress => 'Adresse de livraison';

  @override
  String get blockStreet => 'Rue';

  @override
  String get blockCity => 'Ville';

  @override
  String get blockSaveAndContinue => 'Enregistrer et continuer';

  @override
  String get blockOrderPlaced => 'Commande passée';

  @override
  String get blockOrderThanks =>
      'Merci de vos achats. Une confirmation est en route.';

  @override
  String get blockContinueShopping => 'Continuer mes achats';

  @override
  String get blockSchedule => 'Planning';

  @override
  String get blockPickDateRangeReport =>
      'Choisissez une plage de dates pour votre rapport.';

  @override
  String get blockPickDateRange => 'Choisir une plage de dates';

  @override
  String get blockTapAnotherDay =>
      'touchez un autre jour pour étendre la plage';

  @override
  String get blockBookMeeting => 'Réserver une réunion';

  @override
  String get blockPickDayTime =>
      'Choisissez un jour, puis un horaire qui vous convient.';

  @override
  String get blockFourSlots =>
      'Il reste quatre créneaux de 30 minutes. Choisissez-en un.';

  @override
  String blockPickedSlot(Object? slot) => '$slot sélectionné, 30 minutes.';

  @override
  String get blockOverview => 'Aperçu';

  @override
  String get blockRevenueOrdersBlurb =>
      'Revenus, abonnements et commandes les plus récentes.';

  @override
  String get blockTotalRevenue => 'Chiffre d’affaires total';

  @override
  String get blockSubscriptions => 'Abonnements';

  @override
  String get blockSales => 'Ventes';

  @override
  String get blockRevenueByMonth => 'Revenus par mois';

  @override
  String get blockRecentSales => 'Ventes récentes';

  @override
  String get blockViewAll => 'Tout voir';

  @override
  String get blockTransactions => 'Transactions';

  @override
  String get blockFilterTransactions => 'Filtrer les transactions';

  @override
  String get blockCustomer => 'Client';

  @override
  String get blockAmount => 'Montant';

  @override
  String get blockMethod => 'Moyen';

  @override
  String get blockStatus => 'Statut';

  @override
  String get blockPaid => 'Payé';

  @override
  String get blockPending => 'En attente';

  @override
  String get blockRefunded => 'Remboursé';

  @override
  String blockNoTransactions(Object? query) =>
      'Aucune transaction ne correspond à « $query ».';

  @override
  String blockDeltaFromLastMonth(Object? delta) =>
      '$delta par rapport au mois dernier';

  @override
  String get blockAnalytics => 'Statistiques';

  @override
  String get blockSessionsDevicesBlurb =>
      'Sessions, appareils et origine du trafic.';

  @override
  String get blockSearchReports => 'Rechercher dans les rapports';

  @override
  String get blockLast30Days => '30 derniers jours';

  @override
  String get blockAllDevices => 'Tous les appareils';

  @override
  String get blockSessions => 'Sessions';

  @override
  String get blockUsers => 'Utilisateurs';

  @override
  String get blockAvgSession => 'Session moy.';

  @override
  String get blockBounceRate => 'Taux de rebond';

  @override
  String get blockConversions => 'Conversions';

  @override
  String get blockByDevice => 'Par appareil';

  @override
  String get blockDesktop => 'Ordinateur';

  @override
  String get blockMobile => 'Mobile';

  @override
  String get blockTablet => 'Tablette';

  @override
  String get blockDirect => 'Direct';

  @override
  String get blockReferral => 'Parrainage';

  @override
  String get blockSocial => 'Réseaux sociaux';

  @override
  String get blockTrafficSources => 'Sources de trafic';

  @override
  String get blockVisitors => 'Visiteurs';

  @override
  String get blockHome => 'Accueil';

  @override
  String get blockInbox => 'Boîte de réception';

  @override
  String get blockCalendar => 'Calendrier';

  @override
  String get blockCompose => 'Rédiger';

  @override
  String get blockMarkAllRead => 'Tout marquer comme lu';

  @override
  String get blockStarred => 'Suivis';

  @override
  String get blockSnoozed => 'En attente';

  @override
  String get blockUnread => 'Non lus';

  @override
  String get blockDocuments => 'Documents';

  @override
  String get blockReports => 'Rapports';

  @override
  String get blockDashboard => 'Tableau de bord';

  @override
  String get blockStorage => 'Stockage';

  @override
  String get blockNavigation => 'Navigation';

  @override
  String get blockSharedWithYou => 'Partagé avec vous';

  @override
  String get blockRecentProjects => 'Projets récents';

  @override
  String get blockStorageUsed => 'Stockage utilisé';

  @override
  String get blockOpen => 'Ouvrir';

  @override
  String get blockLive => 'En direct';

  @override
  String get blockMembers => 'Membres';

  @override
  String get blockProjects => 'Projets';

  @override
  String get blockDeploys => 'Déploiements';

  @override
  String get blockActivity => 'Activité';

  @override
  String get blockRecentFiles => 'Fichiers récents';

  @override
  String get blockUsageThisMonth => 'Utilisation ce mois-ci';

  @override
  String get blockUpgradePlan => 'Passer au plan supérieur';

  @override
  String blockNoMatches(Object? query) => 'Aucun résultat pour « $query ».';

  @override
  String get blockWorkspaces => 'Espaces de travail';

  @override
  String get blockPricing => 'Tarifs';

  @override
  String get blockPlansScale => 'Des formules qui grandissent avec vous';

  @override
  String get blockPlansBlurb =>
      'Commencez gratuitement, passez au niveau supérieur quand votre équipe grandit. Chaque formule inclut toute la bibliothèque de composants et les préréglages de thème.';

  @override
  String get blockPerUserMonth => 'par utilisateur / mois';

  @override
  String get blockSubscribe => 'S’abonner';

  @override
  String get blockContactSales => 'Contacter les ventes';

  @override
  String get blockPromoCode => 'Code promo';

  @override
  String get blockApplyCode => 'Appliquer le code';

  @override
  String get blockHaveCodeEnter =>
      'Vous avez un code ? Saisissez-le ci-dessous.';

  @override
  String get blockCodeAppliedDiscount =>
      'Code appliqué — votre remise s’affiche au moment du paiement.';

  @override
  String get blockFaqTitle => 'Questions';

  @override
  String get blockFaqChangePlans => 'Puis-je changer de formule plus tard ?';

  @override
  String get blockFaqChangePlansAnswer =>
      'Oui. Les surclassements s’appliquent aussitôt, les rétrogradations au cycle suivant.';

  @override
  String get blockFaqFreeTrial => 'Y a-t-il un essai gratuit ?';

  @override
  String get blockFaqFreeTrialAnswer =>
      'Chaque formule commence par 14 jours, sans carte requise.';

  @override
  String get blockAccount => 'Compte';

  @override
  String get blockGeneral => 'Général';

  @override
  String get blockAppearance => 'Apparence';

  @override
  String get blockDarkMode => 'Mode sombre';

  @override
  String get blockPreferences => 'Préférences';

  @override
  String get blockSignOut => 'Se déconnecter';

  @override
  String get blockSignOutConfirm => 'Se déconnecter ?';

  @override
  String get blockSignOutBlurb =>
      'Vous pourrez toujours vous reconnecter plus tard.';

  @override
  String get blockSounds => 'Sons';

  @override
  String get blockWhatYouGet => 'Ce que vous obtenez';

  @override
  String get blockAllComponentCategories =>
      'Toutes les catégories de composants';

  @override
  String get blockPrioritySupport => 'Assistance prioritaire';

  @override
  String get blockUnlimitedProjectsTrial => 'Projets illimités pendant l’essai';

  @override
  String get blockTrialDaysLeft => 'Plus que 14 jours d’essai';

  @override
  String get blockStarterChat => 'Discussion';

  @override
  String get blockStarterShop => 'Boutique';

  @override
  String get blockStarterCart => 'Panier';

  @override
  String get blockAddToCart => 'Ajouter au panier';
}
