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
}
