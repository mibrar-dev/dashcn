import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

/// Dutch (`nl`) locale data.
///
/// Translations only: anything this table does not override falls
/// through to the English default on [ComponentLocalizations]. Text
/// direction is not handled here - Flutter resolves it from
/// [WidgetsLocalizations] and [Directionality].
class ComponentLocalizationsNl extends ComponentLocalizations {
  /// Creates the Dutch strings.
  const ComponentLocalizationsNl([super.locale = const Locale('nl')]);

  /// Formats [value] as a number in this locale, or returns it
  /// verbatim when it is not a number.
  String _number(Object? value) {
    if (value is! num) return '$value';
    return intl.NumberFormat.decimalPattern(localeName).format(value);
  }

  @override
  String get formNotEmpty => 'Dit veld mag niet leeg zijn';

  @override
  String get invalidValue => 'Ongeldige waarde';

  @override
  String get invalidEmail => 'Ongeldig e-mailadres';

  @override
  String get invalidURL => 'Ongeldige URL';

  @override
  String formLessThan(Object? value) =>
      'Moet kleiner zijn dan ${_number(value)}';

  @override
  String formGreaterThan(Object? value) =>
      'Moet groter zijn dan ${_number(value)}';

  @override
  String formLessThanOrEqualTo(Object? value) =>
      'Moet kleiner dan of gelijk zijn aan ${_number(value)}';

  @override
  String get formPhoneNumberInvalid => 'Het telefoonnummer is ongeldig';

  @override
  String get formPhoneNumberEmpty => 'Het telefoonnummer is verplicht';

  @override
  String formGreaterThanOrEqualTo(Object? value) =>
      'Moet groter dan of gelijk zijn aan ${_number(value)}';

  @override
  String formBetweenInclusively(Object? min, Object? max) =>
      'Moet tussen ${_number(min)} en ${_number(max)} liggen (inclusief)';

  @override
  String formEqualTo(Object? value) => 'Moet gelijk zijn aan ${_number(value)}';

  @override
  String formBetweenExclusively(Object? min, Object? max) =>
      'Moet tussen ${_number(min)} en ${_number(max)} liggen (exclusief)';

  @override
  String formLengthLessThan(int limit) =>
      'Moet minstens $limit tekens bevatten';

  @override
  String formLengthGreaterThan(int limit) =>
      'Mag hoogstens $limit tekens bevatten';

  @override
  String get formPasswordDigits => 'Moet minstens één cijfer bevatten';

  @override
  String get formPasswordLowercase =>
      'Moet minstens één kleine letter bevatten';

  @override
  String get formPasswordUppercase => 'Moet minstens één hoofdletter bevatten';

  @override
  String get formPasswordSpecial => 'Moet minstens één speciaal teken bevatten';

  @override
  String get commandSearch => 'Typ een opdracht of zoek...';

  @override
  String get commandEmpty => 'Geen resultaten gevonden.';

  @override
  String get datePickerSelectYear => 'Selecteer een jaar';

  @override
  String get abbreviatedMonday => 'Ma';

  @override
  String get abbreviatedTuesday => 'Di';

  @override
  String get abbreviatedWednesday => 'Wo';

  @override
  String get abbreviatedThursday => 'Do';

  @override
  String get abbreviatedFriday => 'Vr';

  @override
  String get abbreviatedSaturday => 'Za';

  @override
  String get abbreviatedSunday => 'Zo';

  @override
  String get monthJanuary => 'Januari';

  @override
  String get monthFebruary => 'Februari';

  @override
  String get monthMarch => 'Maart';

  @override
  String get monthApril => 'April';

  @override
  String get monthMay => 'Mei';

  @override
  String get monthJune => 'Juni';

  @override
  String get monthJuly => 'Juli';

  @override
  String get monthAugust => 'Augustus';

  @override
  String get monthSeptember => 'September';

  @override
  String get monthOctober => 'Oktober';

  @override
  String get monthNovember => 'November';

  @override
  String get monthDecember => 'December';

  @override
  String get abbreviatedJanuary => 'Jan';

  @override
  String get abbreviatedFebruary => 'Feb';

  @override
  String get abbreviatedMarch => 'Mrt';

  @override
  String get abbreviatedApril => 'Apr';

  @override
  String get abbreviatedMay => 'Mei';

  @override
  String get abbreviatedJune => 'Jun';

  @override
  String get abbreviatedJuly => 'Jul';

  @override
  String get abbreviatedAugust => 'Aug';

  @override
  String get abbreviatedSeptember => 'Sep';

  @override
  String get abbreviatedOctober => 'Okt';

  @override
  String get abbreviatedNovember => 'Nov';

  @override
  String get abbreviatedDecember => 'Dec';

  @override
  String get dialogDismiss => 'Sluiten';

  @override
  String get chipInputRemoveChip => 'Verwijderen';

  @override
  String get buttonCancel => 'Annuleren';

  @override
  String get buttonSave => 'Opslaan';

  @override
  String get timeHour => 'Uur';

  @override
  String get timeMinute => 'Minuut';

  @override
  String get timeSecond => 'Seconde';

  @override
  String get timeAM => 'AM';

  @override
  String get timePM => 'PM';

  @override
  String get colorRed => 'Rood';

  @override
  String get colorGreen => 'Groen';

  @override
  String get colorBlue => 'Blauw';

  @override
  String get colorAlpha => 'Alfa';

  @override
  String get colorHue => 'Tint';

  @override
  String get colorSaturation => 'Verz';

  @override
  String get colorValue => 'Wrd';

  @override
  String get colorLightness => 'Lum';

  @override
  String get menuCut => 'Knippen';

  @override
  String get menuCopy => 'Kopiëren';

  @override
  String get menuPaste => 'Plakken';

  @override
  String get menuSelectAll => 'Alles selecteren';

  @override
  String get menuUndo => 'Ongedaan maken';

  @override
  String get menuRedo => 'Opnieuw';

  @override
  String get menuDelete => 'Verwijderen';

  @override
  String get menuShare => 'Delen';

  @override
  String get menuSearchWeb => 'Op het web zoeken';

  @override
  String get menuLiveTextInput => 'Live tekst';

  @override
  String get placeholderDatePicker => 'Selecteer een datum';

  @override
  String get placeholderTimePicker => 'Selecteer een tijd';

  @override
  String get placeholderColorPicker => 'Selecteer een kleur';

  @override
  String get buttonPrevious => 'Vorige';

  @override
  String get buttonNext => 'Volgende';

  @override
  String get refreshTriggerPull => 'Trek om te vernieuwen';

  @override
  String get refreshTriggerRelease => 'Laat los om te vernieuwen';

  @override
  String get refreshTriggerRefreshing => 'Vernieuwen...';

  @override
  String get refreshTriggerComplete => 'Vernieuwen voltooid';

  @override
  String get colorPickerTabRGB => 'RGB';

  @override
  String get colorPickerTabHSV => 'HSV';

  @override
  String get colorPickerTabHSL => 'HSL';

  @override
  String get colorPickerTabHEX => 'HEX';

  @override
  String get commandMoveUp => 'Omhoog';

  @override
  String get commandMoveDown => 'Omlaag';

  @override
  String get commandActivate => 'Selecteren';

  @override
  String get timeDaysAbbreviation => 'DD';

  @override
  String get timeHoursAbbreviation => 'UU';

  @override
  String get timeMinutesAbbreviation => 'MM';

  @override
  String get timeSecondsAbbreviation => 'SS';

  @override
  String get placeholderDurationPicker => 'Selecteer een duur';

  @override
  String get durationDay => 'Dag';

  @override
  String get durationHour => 'Uur';

  @override
  String get durationMinute => 'Minuut';

  @override
  String get durationSecond => 'Seconde';

  @override
  String get dropzoneIdle => 'Bladeren om bestanden te uploaden';

  @override
  String get dropzoneDragging => 'Zet bestanden neer om te uploaden';

  @override
  String get dropzoneUploading => 'Bestanden uploaden...';

  @override
  String get dropzoneSuccess => 'Bestanden zijn klaar';

  @override
  String get dropzoneError => 'Los fouten op om door te gaan';

  @override
  String get dropzoneDisabled => 'Bestandsuploads uitgeschakeld';

  @override
  String get dropzoneBrowse => 'Blader door bestanden';

  @override
  String get emptyStateEmptyTitle => 'Hier is nog niets';

  @override
  String get emptyStateEmptyDescription =>
      'Maak je eerste item om te beginnen.';

  @override
  String get emptyStateNoResultsTitle => 'Geen resultaten gevonden';

  @override
  String get emptyStateNoResultsDescription =>
      'Pas je filters of zoektermen aan.';

  @override
  String get emptyStateErrorTitle => 'Er is iets misgegaan';

  @override
  String get emptyStateErrorDescription =>
      'We konden deze gegevens niet laden. Probeer het zo opnieuw.';

  @override
  String get filterSearch => 'Zoeken';

  @override
  String get filterSort => 'Sorteren';

  @override
  String get filterDateRange => 'Datumbereik';

  @override
  String get filterClearAll => 'Alles wissen';

  @override
  String get filterFilters => 'Filters';

  @override
  String filterActiveCount(int count) => '${_number(count)} actieve filters';

  @override
  String filterResultsCount(int count) => '${_number(count)} resultaten';

  @override
  String get fileUploadChoose => 'Kies bestand';

  @override
  String get fileUploadNoFile => 'Geen bestand gekozen';

  @override
  String get fileUploadPickFailed => 'Bestand kiezen is mislukt.';

  @override
  String get fileUploadTooMany => 'Te veel bestanden geselecteerd.';

  @override
  String get fileUploadTooLarge => 'Bestand is te groot.';

  @override
  String get fileUploadInvalidType => 'Bestandstype is niet toegestaan.';

  @override
  String get fileUploadUploadFailed => 'Upload mislukt.';

  @override
  String fileUploadUploadFailedFor(String name) => 'Upload mislukt voor $name.';

  @override
  String get fileUploadStatusQueued => 'In wachtrij';

  @override
  String get fileUploadStatusUploading => 'Uploaden';

  @override
  String get fileUploadStatusCompleted => 'Voltooid';

  @override
  String get fileUploadStatusFailed => 'Mislukt';

  @override
  String get fileUploadUnknownType => 'Bestand';

  @override
  String get fileUploadRemove => 'Bestand verwijderen';

  @override
  String get fileUploadRetry => 'Upload opnieuw proberen';

  @override
  String get fileUploadPreview => 'Voorbeeld van bestand';

  @override
  String get fileUploadDownload => 'Bestand downloaden';

  @override
  String get errorSomethingWentWrong => 'Er is iets misgegaan';

  @override
  String get errorUnexpectedMessage =>
      'Probeer het opnieuw of neem contact op met support als het probleem aanhoudt.';

  @override
  String get errorActionRetry => 'Opnieuw proberen';

  @override
  String get errorActionReport => 'Rapporteren';

  @override
  String get errorActionBack => 'Ga terug';

  @override
  String get errorActionLogin => 'Inloggen';

  @override
  String get errorActionSettings => 'Instellingen';

  @override
  String get errorActionContactSupport => 'Contact opnemen met support';

  @override
  String get errorBadRequest => 'Ongeldig verzoek';

  @override
  String get errorBadRequestMessage =>
      'Het verzoek was ongeldig. Controleer het en probeer het opnieuw.';

  @override
  String get errorUnauthorized => 'Niet geautoriseerd';

  @override
  String get errorLoginRequiredMessage => 'Log in om door te gaan.';

  @override
  String get errorAccessDenied => 'Toegang geweigerd';

  @override
  String get errorAccessDeniedMessage =>
      'Je hebt geen toestemming om deze actie uit te voeren.';

  @override
  String get errorNotFound => 'Niet gevonden';

  @override
  String get errorNotFoundMessage =>
      'We konden niet vinden waar je naar zocht.';

  @override
  String get errorConflict => 'Conflict';

  @override
  String get errorConflictMessage =>
      'Deze actie is in strijd met bestaande gegevens.';

  @override
  String get errorInvalidData => 'Ongeldige gegevens';

  @override
  String get errorInvalidDataMessage =>
      'Sommige velden hebben je aandacht nodig.';

  @override
  String get errorTooManyRequests => 'Te veel verzoeken';

  @override
  String get errorTooManyRequestsMessage =>
      'Wacht even en probeer het opnieuw.';

  @override
  String get errorServerError => 'Serverfout';

  @override
  String get errorServerErrorMessage =>
      'De server heeft een probleem ondervonden. Probeer het opnieuw.';

  @override
  String get errorRequestTimedOut => 'Verzoek time-out';

  @override
  String get errorRequestTimedOutMessage =>
      'De server doet er te lang over om te reageren.';

  @override
  String get errorAuthenticationRequired => 'Authenticatie vereist';

  @override
  String get errorInvalidInput => 'Ongeldige invoer';

  @override
  String get errorReviewFieldsMessage => 'Controleer de gemarkeerde velden.';

  @override
  String get errorPlatformError => 'Platformfout';

  @override
  String get errorDeviceErrorMessage => 'Er is iets misgegaan op dit apparaat.';

  @override
  String get errorConnectionFailed => 'Verbinding mislukt';

  @override
  String get errorConnectionFailedMessage =>
      'Controleer je internetverbinding en probeer het opnieuw.';

  @override
  String get errorSecureConnectionFailed => 'Beveiligde verbinding mislukt';

  @override
  String get errorSecureConnectionMessage =>
      'We konden geen beveiligde verbinding tot stand brengen.';

  @override
  String get tableResizeColumn => 'Kolomgrootte aanpassen';

  @override
  String get tableResizeRow => 'Rijgrootte aanpassen';

  @override
  String get resizableHandle => 'Greep voor grootte aanpassen';

  @override
  String get spellCheckNoSuggestions => 'Geen suggesties';

  @override
  String get announcementLoading => 'Laden';

  @override
  String get announcementSuccess => 'Gelukt';

  @override
  String get announcementFailure => 'Mislukt';

  @override
  String get toolbarMore => 'Meer';

  @override
  String get toolbarMoreActions => 'Meer acties';

  @override
  String get treeCollapse => 'Samenvouwen';

  @override
  String get treeExpand => 'Uitvouwen';

  @override
  String get markdownDetails => 'Details';

  @override
  String get carouselLabel => 'Uitgelichte carrousel';

  @override
  String get carouselPrimaryAction => 'Toevoegen aan chat';

  @override
  String carouselItemPreview(Object? title) =>
      'Uitgelicht voorbeeld: ${title ?? mediaUntitled}';

  @override
  String carouselPageOf(int position, int length) =>
      'Pagina ${_number(position)} van ${_number(length)}';

  @override
  String stepperStep(int index) => 'Stap ${_number(index + 1)}';

  @override
  String paginationPage(Object? page) => 'Pagina ${_number(page)}';

  @override
  String chartSeriesDefault(int index) => 'Reeks ${_number(index + 1)}';

  @override
  String chartSliceDefault(int index) => 'Segment ${_number(index)}';

  @override
  String chartCategoryDefault(int index) => 'Categorie ${_number(index)}';

  @override
  String get chartValueDefault => 'Waarde';

  @override
  String get chartKindLine => 'Lijn';

  @override
  String get chartKindArea => 'Gebied';

  @override
  String get chartKindBar => 'Staaf';

  @override
  String get chartKindDonut => 'Donut';

  @override
  String get chartKindPie => 'Taart';

  @override
  String get chartKindSparkline => 'Sparkline';

  @override
  String get chartKindScatter => 'Spreiding';

  @override
  String get chartKindRadar => 'Radar';

  @override
  String get chartKindRadial => 'Radiaal';

  @override
  String chartSummaryEmpty(Object? kind) => '$kind-diagram zonder gegevens';

  @override
  String chartSummary(int series, int points, Object? kind) =>
      '$kind-diagram met ${_number(series)} reeksen en ${_number(points)} punten';

  @override
  String get colorFieldHsv => 'HSV-kleurveld';

  @override
  String get colorFieldHsl => 'HSL-kleurveld';

  @override
  String get actionClear => 'Wissen';

  @override
  String get actionApply => 'Toepassen';

  @override
  String get actionVerify => 'Verifiëren';

  @override
  String get actionResend => 'Opnieuw verzenden';

  @override
  String resendInSeconds(int seconds) =>
      'Over ${_number(seconds)} s opnieuw verzenden';

  @override
  String get authCode => 'Code';

  @override
  String get authEmail => 'E-mail';

  @override
  String get authPassword => 'Wachtwoord';

  @override
  String get authName => 'Naam';

  @override
  String get authSignIn => 'Inloggen';

  @override
  String get authForgotPassword => 'Wachtwoord vergeten?';

  @override
  String get authRememberMe => 'Onthoud mij';

  @override
  String get authCreateAccount => 'Account aanmaken';

  @override
  String get actionClose => 'Sluiten';

  @override
  String get mediaPlay => 'Afspelen';

  @override
  String get mediaPause => 'Pauzeren';

  @override
  String get mediaMute => 'Dempen';

  @override
  String get mediaUnmute => 'Dempen opheffen';

  @override
  String get mediaVolume => 'Volume';

  @override
  String get mediaSeek => 'Zoeken';

  @override
  String get mediaDownload => 'Downloaden';

  @override
  String get mediaAudioPlayer => 'Audospeler';

  @override
  String get mediaVideoPlayer => 'Videospeler';

  @override
  String get mediaUntitled => 'Zonder titel';

  @override
  String get mediaPlaybackFailed => 'Afspelen mislukt';

  @override
  String get mediaPreviousTrack => 'Vorig nummer';

  @override
  String get mediaNextTrack => 'Volgend nummer';

  @override
  String get mediaShuffleDisable => 'Shuffle uitschakelen';

  @override
  String get mediaShuffleEnable => 'Shuffle inschakelen';

  @override
  String get mediaRepeatDisable => 'Herhalen uitschakelen';

  @override
  String get mediaRepeatEnable => 'Herhalen inschakelen';

  @override
  String mediaPlaybackSpeed(Object? speed) =>
      'Afspeelsnelheid ${speed}x, tik om te wijzigen';

  @override
  String mediaPositionOf(Object position, Object duration) =>
      '$position van $duration';

  @override
  String mediaHours(int count) =>
      count == 1 ? '1 uur' : '${_number(count)} uur';

  @override
  String mediaMinutes(int count) =>
      count == 1 ? '1 minuut' : '${_number(count)} minuten';

  @override
  String mediaSeconds(int count) =>
      count == 1 ? '1 seconde' : '${_number(count)} seconden';

  @override
  String get signaturePadLabel => 'Handtekeningveld';

  @override
  String get qrCodeLabel => 'QR-code';

  @override
  String get marqueeContent => 'Scrollende inhoud';

  @override
  String mediaSkipBack(int seconds) => '${_number(seconds)} seconden terug';

  @override
  String mediaSkipForward(int seconds) =>
      '${_number(seconds)} seconden vooruit';

  @override
  String get mediaCaptionsShow => 'Ondertiteling tonen';

  @override
  String get mediaCaptionsHide => 'Ondertiteling verbergen';

  @override
  String get mediaCaptionsOn => 'Ondertiteling aan';

  @override
  String get mediaCaptionsOff => 'Ondertiteling uit';

  @override
  String get mediaFullscreen => 'Volledig scherm';

  @override
  String mediaMoreOptionsSpeed(Object? speed) =>
      'Meer opties, afspeelsnelheid: ${speed}x';

  @override
  String mediaSpeed(Object? speed) => 'Snelheid: ${speed}x';

  @override
  String get actionStartTrial => 'Gratis proefperiode starten';

  @override
  String get authFirstName => 'Voornaam';

  @override
  String get authLastName => 'Achternaam';

  @override
  String get authPasswordHint => 'Minimaal 8 tekens.';

  @override
  String get authUseDifferentEmail => 'Een ander e-mailadres gebruiken';

  @override
  String get authWorkEmail => 'Werk-e-mail';

  @override
  String get chartTotalLabel => 'Totaal';

  @override
  String get mediaQualityAuto => 'Kwaliteit Auto';

  @override
  String get blockDontHaveAccount => 'Nog geen account?';

  @override
  String get blockAlreadyHaveAccount => 'Heb je al een account?';

  @override
  String get blockNoAccountYet => 'Nog geen account?';

  @override
  String get blockHaveAnAccount => 'Heb je een account?';

  @override
  String get blockCreateOne => 'Maak er een';

  @override
  String get blockCreateAccount => 'Account aanmaken';

  @override
  String get blockCreateYourAccount => 'Maak je account aan';

  @override
  String get blockForgotYourPassword => 'Wachtwoord vergeten?';

  @override
  String get blockBackToSignIn => 'Terug naar inloggen';

  @override
  String get blockEnterCredentialsWorkspace =>
      'Voer je inloggegevens in voor toegang tot je werkruimte.';

  @override
  String get blockEnterCredentialsContinue =>
      'Voer je inloggegevens in om door te gaan.';

  @override
  String get blockEnterDetailsContinue =>
      'Voer hieronder je gegevens in om door te gaan.';

  @override
  String get blockEnterEmailCreateAccount =>
      'Voer hieronder je e-mailadres in om je account aan te maken.';

  @override
  String get blockSignedInWelcomeBack => 'Ingelogd — welkom terug.';

  @override
  String get blockAccountCreatedVerify =>
      'Account aangemaakt — controleer je inbox om het te verifiëren.';

  @override
  String get blockTrialStartedVerify =>
      'Proefperiode gestart — controleer je inbox om deze te verifiëren.';

  @override
  String get blockPasswordsDoNotMatch => 'Wachtwoorden komen niet overeen.';

  @override
  String get blockCurrentPassword => 'Huidig wachtwoord';

  @override
  String get blockNewPassword => 'Nieuw wachtwoord';

  @override
  String get blockConfirmNewPassword => 'Bevestig nieuw wachtwoord';

  @override
  String get blockUpdatePassword => 'Wachtwoord bijwerken';

  @override
  String get blockPasswordUpdated => 'Wachtwoord bijgewerkt.';

  @override
  String get blockPasswordHintChange =>
      'Minimaal 8 tekens. Wijzigen meldt je elders af.';

  @override
  String get blockUsername => 'Gebruikersnaam';

  @override
  String get blockUsernameHint => 'Kleine letters, cijfers, underscores.';

  @override
  String get blockYourAvatar => 'Je avatar';

  @override
  String get blockUploadImage => 'Afbeelding uploaden';

  @override
  String get blockBio => 'Bio';

  @override
  String get blockBioHint => 'Vertel ons iets over jezelf';

  @override
  String get blockBioCounterHint => 'Maximaal 160 tekens.';

  @override
  String get blockProfileSaved => 'Profiel opgeslagen.';

  @override
  String get blockSaveChanges => 'Wijzigingen opslaan';

  @override
  String get blockInviteMember => 'Lid uitnodigen';

  @override
  String get blockRoleAdmin => 'Beheerder';

  @override
  String get blockRoleOwner => 'Eigenaar';

  @override
  String get blockRoleMember => 'Lid';

  @override
  String get blockTeam => 'Team';

  @override
  String get blockProfile => 'Profiel';

  @override
  String get blockSignInWithEmail => 'Inloggen met e-mail';

  @override
  String get blockSignUp => 'Aanmelden';

  @override
  String get blockPickWayYouPrefer => 'Kies de gewenste methode.';

  @override
  String blockContinueWith(Object? provider) => 'Doorgaan met $provider';

  @override
  String get blockCreating => 'Wordt gemaakt…';

  @override
  String get blockSigningIn => 'Wordt ingelogd…';

  @override
  String get blockSending => 'Wordt verzonden…';

  @override
  String get blockSaving => 'Wordt opgeslagen…';

  @override
  String get blockPaying => 'Wordt betaald…';

  @override
  String get blockSendResetLink => 'Link voor opnieuw instellen verzenden';

  @override
  String get blockResetPassword => 'Wachtwoord opnieuw instellen';

  @override
  String get blockResetLinkSent =>
      'Link voor opnieuw instellen verzonden. Controleer je inbox om door te gaan.';

  @override
  String get blockWeWillEmailReset =>
      'We mailen je een link voor opnieuw instellen.';

  @override
  String get blockMustAcceptTerms =>
      'Je moet de voorwaarden accepteren om door te gaan.';

  @override
  String get blockCheckInbox => 'Controleer je inbox';

  @override
  String get blockEnterSixDigitCode =>
      'Voer de 6-cijferige code in die we je hebben gestuurd.';

  @override
  String get blockCodeVerifiedSignedIn =>
      'Code geverifieerd. Je bent ingelogd.';

  @override
  String get blockEmailVerifiedSet => 'E-mail geverifieerd — alles is klaar.';

  @override
  String get blockVerifyYourEmail => 'Verifieer je e-mailadres';

  @override
  String blockWeSentCodeTo(Object? email) =>
      'We hebben een 6-cijferige code naar $email gestuurd.';

  @override
  String get blockDidntGetCode => 'Geen code ontvangen?';

  @override
  String get blockBack => 'Terug';

  @override
  String get blockBackToCart => 'Terug naar winkelwagen';

  @override
  String get blockBackToSettings => 'Terug naar instellingen';

  @override
  String get blockOneAccountEverything => 'Eén account voor alles.';

  @override
  String get blockStartTrialNoCard =>
      'Start je proefperiode van 14 dagen. Geen creditcard nodig.';

  @override
  String get blockNotifications => 'Meldingen';

  @override
  String get blockNotifChoose => 'Kies waarover en waar je wilt horen.';

  @override
  String get blockEmailNotifications => 'E-mailmeldingen';

  @override
  String get blockPushNotifications => 'Pushmeldingen';

  @override
  String get blockMentionsReplies => 'Vermeldingen en antwoorden';

  @override
  String get blockDeliveredToDevices => 'Bezorgd op je apparaten';

  @override
  String blockEmailChannel(Object? channel) => 'E-mail · $channel';

  @override
  String blockPushChannel(Object? channel) => 'Push · $channel';

  @override
  String get blockQuietHours => 'Stille uren';

  @override
  String get blockWeeklyDigest => 'Wekelijks overzicht';

  @override
  String get blockWeeklyDigestBlurb =>
      'Elke maandag één e-mail met alles wat er is gebeurd.';

  @override
  String get blockPreferencesSaved => 'Voorkeuren opgeslagen.';

  @override
  String get blockSavePreferences => 'Voorkeuren opslaan';

  @override
  String get blockReset => 'Opnieuw instellen';

  @override
  String get blockWelcomeAboard => 'Welkom aan boord';

  @override
  String get blockQuickTour =>
      'Een korte rondleiding voordat je de app gebruikt.';

  @override
  String get blockStayInLoop => 'Blijf op de hoogte';

  @override
  String get blockMessagesArriveMoment =>
      'Berichten en updates komen aan zodra ze gebeuren.';

  @override
  String get blockNeverMissThing => 'Mis niets';

  @override
  String get blockNotifPermissionBlurb =>
      'We sturen alleen wat ertoe doet: antwoorden, herinneringen en beveiligingswaarschuwingen. Je kunt dit later wijzigen.';

  @override
  String get blockEnableNotifications => 'Meldingen inschakelen?';

  @override
  String get blockAllowNotifications => 'Meldingen toestaan';

  @override
  String get blockAllowNotificationsBlurb =>
      'Sta meldingen toe om het meeste uit de app te halen.';

  @override
  String get blockNotNow => 'Nu niet';

  @override
  String get blockSkip => 'Overslaan';

  @override
  String get blockGetStarted => 'Aan de slag';

  @override
  String get blockMessages => 'Berichten';

  @override
  String get blockNoConversations => 'Geen gesprekken';

  @override
  String get blockPullRefreshChat =>
      'Trek om te vernieuwen of start een nieuwe chat.';

  @override
  String get blockMute => 'Dempen';

  @override
  String get blockMuted => 'Gedempt';

  @override
  String get blockAttach => 'Bijvoegen';

  @override
  String get blockAttachFile => 'Bestand';

  @override
  String get blockAttachPhoto => 'Foto';

  @override
  String get blockWriteMessage => 'Schrijf een bericht…';

  @override
  String get blockYourCart => 'Je winkelwagen';

  @override
  String get blockAddSomethingFirst => 'Voeg eerst iets toe wat je leuk vindt.';

  @override
  String get blockCartEmpty => 'Winkelwagen is leeg';

  @override
  String get blockCheckout => 'Afrekenen';

  @override
  String blockQty(int quantity) => 'Aantal $quantity';

  @override
  String blockPayTotal(Object? amount) => 'Betaal $amount';

  @override
  String get blockPayment => 'Betaling';

  @override
  String get blockCardNumber => 'Kaartnummer';

  @override
  String get blockExpiry => 'Vervaldatum';

  @override
  String get blockCvc => 'CVC';

  @override
  String get blockDeliveryAddress => 'Bezorgadres';

  @override
  String get blockStreet => 'Straat';

  @override
  String get blockCity => 'Plaats';

  @override
  String get blockSaveAndContinue => 'Opslaan en doorgaan';

  @override
  String get blockOrderPlaced => 'Bestelling geplaatst';

  @override
  String get blockOrderThanks =>
      'Bedankt voor je aankoop. Een bevestiging is onderweg.';

  @override
  String get blockContinueShopping => 'Verder winkelen';

  @override
  String get blockSchedule => 'Planning';

  @override
  String get blockPickDateRangeReport =>
      'Kies een datumbereik voor je rapport.';

  @override
  String get blockPickDateRange => 'Kies een datumbereik';

  @override
  String get blockTapAnotherDay =>
      'tik op een andere dag om het bereik te verlengen';

  @override
  String get blockBookMeeting => 'Vergadering boeken';

  @override
  String get blockPickDayTime =>
      'Kies een dag en daarna een geschikt tijdstip.';

  @override
  String get blockFourSlots => 'Nog vier plekken van 30 minuten. Kies er een.';

  @override
  String blockPickedSlot(Object? slot) => '$slot gekozen, 30 minuten.';

  @override
  String get blockOverview => 'Overzicht';

  @override
  String get blockRevenueOrdersBlurb =>
      'Omzet, abonnementen en de meest recente bestellingen.';

  @override
  String get blockTotalRevenue => 'Totale omzet';

  @override
  String get blockSubscriptions => 'Abonnementen';

  @override
  String get blockSales => 'Verkopen';

  @override
  String get blockRevenueByMonth => 'Omzet per maand';

  @override
  String get blockRecentSales => 'Recente verkopen';

  @override
  String get blockViewAll => 'Alles bekijken';

  @override
  String get blockTransactions => 'Transacties';

  @override
  String get blockFilterTransactions => 'Transacties filteren';

  @override
  String get blockCustomer => 'Klant';

  @override
  String get blockAmount => 'Bedrag';

  @override
  String get blockMethod => 'Methode';

  @override
  String get blockStatus => 'Status';

  @override
  String get blockPaid => 'Betaald';

  @override
  String get blockPending => 'In behandeling';

  @override
  String get blockRefunded => 'Terugbetaald';

  @override
  String blockNoTransactions(Object? query) =>
      'Geen transacties komen overeen met "$query".';

  @override
  String blockDeltaFromLastMonth(Object? delta) =>
      '$delta ten opzichte van vorige maand';

  @override
  String get blockAnalytics => 'Analyse';

  @override
  String get blockSessionsDevicesBlurb =>
      'Sessies, apparaten en waar het verkeer vandaan kwam.';

  @override
  String get blockSearchReports => 'Rapporten zoeken';

  @override
  String get blockLast30Days => 'Laatste 30 dagen';

  @override
  String get blockAllDevices => 'Alle apparaten';

  @override
  String get blockSessions => 'Sessies';

  @override
  String get blockUsers => 'Gebruikers';

  @override
  String get blockAvgSession => 'Gem. sessie';

  @override
  String get blockBounceRate => 'Bouncepercentage';

  @override
  String get blockConversions => 'Conversies';

  @override
  String get blockByDevice => 'Per apparaat';

  @override
  String get blockDesktop => 'Desktop';

  @override
  String get blockMobile => 'Mobiel';

  @override
  String get blockTablet => 'Tablet';

  @override
  String get blockDirect => 'Direct';

  @override
  String get blockReferral => 'Verwijzing';

  @override
  String get blockSocial => 'Sociaal';

  @override
  String get blockTrafficSources => 'Verkeersbronnen';

  @override
  String get blockVisitors => 'Bezoekers';

  @override
  String get blockHome => 'Home';

  @override
  String get blockInbox => 'Inbox';

  @override
  String get blockCalendar => 'Agenda';

  @override
  String get blockCompose => 'Opstellen';

  @override
  String get blockMarkAllRead => 'Alles als gelezen markeren';

  @override
  String get blockStarred => 'Met ster';

  @override
  String get blockSnoozed => 'Gesnoozed';

  @override
  String get blockUnread => 'Ongelezen';

  @override
  String get blockDocuments => 'Documenten';

  @override
  String get blockReports => 'Rapporten';

  @override
  String get blockDashboard => 'Dashboard';

  @override
  String get blockStorage => 'Opslag';

  @override
  String get blockNavigation => 'Navigatie';

  @override
  String get blockSharedWithYou => 'Met je gedeeld';

  @override
  String get blockRecentProjects => 'Recente projecten';

  @override
  String get blockStorageUsed => 'Gebruikte opslag';

  @override
  String get blockOpen => 'Openen';

  @override
  String get blockLive => 'Live';

  @override
  String get blockMembers => 'Leden';

  @override
  String get blockProjects => 'Projecten';

  @override
  String get blockDeploys => 'Deployments';

  @override
  String get blockActivity => 'Activiteit';

  @override
  String get blockRecentFiles => 'Recente bestanden';

  @override
  String get blockUsageThisMonth => 'Gebruik deze maand';

  @override
  String get blockUpgradePlan => 'Abonnement upgraden';

  @override
  String blockNoMatches(Object? query) => 'Geen resultaten voor "$query".';

  @override
  String get blockWorkspaces => 'Werkruimten';

  @override
  String get blockPricing => 'Prijzen';

  @override
  String get blockPlansScale => 'Abonnementen die met je meegroeien';

  @override
  String get blockPlansBlurb =>
      'Begin gratis en upgrade wanneer je team groeit. Elk abonnement bevat de volledige componentenbibliotheek en de themapresets.';

  @override
  String get blockPerUserMonth => 'per gebruiker / maand';

  @override
  String get blockSubscribe => 'Abonneren';

  @override
  String get blockContactSales => 'Neem contact op met verkoop';

  @override
  String get blockPromoCode => 'Promotiecode';

  @override
  String get blockApplyCode => 'Code toepassen';

  @override
  String get blockHaveCodeEnter => 'Heb je een code? Voer deze hieronder in.';

  @override
  String get blockCodeAppliedDiscount =>
      'Code toegepast — je korting is zichtbaar bij het afrekenen.';

  @override
  String get blockFaqTitle => 'Vragen';

  @override
  String get blockFaqChangePlans => 'Kan ik later van abonnement wisselen?';

  @override
  String get blockFaqChangePlansAnswer =>
      'Ja. Upgrades gelden direct, downgrades vanaf de volgende cyclus.';

  @override
  String get blockFaqFreeTrial => 'Is er een gratis proefperiode?';

  @override
  String get blockFaqFreeTrialAnswer =>
      'Elk abonnement begint met 14 dagen, geen kaart nodig.';

  @override
  String get blockAccount => 'Account';

  @override
  String get blockGeneral => 'Algemeen';

  @override
  String get blockAppearance => 'Weergave';

  @override
  String get blockDarkMode => 'Donkere modus';

  @override
  String get blockPreferences => 'Voorkeuren';

  @override
  String get blockSignOut => 'Uitloggen';

  @override
  String get blockSignOutConfirm => 'Uitloggen?';

  @override
  String get blockSignOutBlurb => 'Je kunt je later altijd weer aanmelden.';

  @override
  String get blockSounds => 'Geluiden';

  @override
  String get blockWhatYouGet => 'Wat je krijgt';

  @override
  String get blockAllComponentCategories => 'Alle componentcategorieën';

  @override
  String get blockPrioritySupport => 'Prioriteitsondersteuning';

  @override
  String get blockUnlimitedProjectsTrial =>
      'Onbeperkt projecten tijdens de proefperiode';

  @override
  String get blockTrialDaysLeft => 'Nog 14 dagen proefperiode';

  @override
  String get blockStarterChat => 'Chat';

  @override
  String get blockStarterShop => 'Winkel';

  @override
  String get blockStarterCart => 'Winkelwagen';

  @override
  String get blockAddToCart => 'In winkelwagen';
}
