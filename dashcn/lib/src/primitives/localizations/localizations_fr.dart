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
}
