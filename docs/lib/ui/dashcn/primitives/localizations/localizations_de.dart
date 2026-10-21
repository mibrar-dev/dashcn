import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

/// German (`de`) locale data.
///
/// Translations only: anything this table does not override falls
/// through to the English default on [ComponentLocalizations]. Text
/// direction is not handled here - Flutter resolves it from
/// [WidgetsLocalizations] and [Directionality].
class ComponentLocalizationsDe extends ComponentLocalizations {
  /// Creates the German strings.
  const ComponentLocalizationsDe([super.locale = const Locale('de')]);

  /// Formats [value] as a number in this locale, or returns it
  /// verbatim when it is not a number.
  String _number(Object? value) {
    if (value is! num) return '$value';
    return intl.NumberFormat.decimalPattern(localeName).format(value);
  }

  @override
  String get formNotEmpty => 'Dieses Feld darf nicht leer sein';

  @override
  String get invalidValue => 'Ungültiger Wert';

  @override
  String get invalidEmail => 'Ungültige E-Mail-Adresse';

  @override
  String get invalidURL => 'Ungültige URL';

  @override
  String formLessThan(Object? value) =>
      'Muss kleiner als ${_number(value)} sein';

  @override
  String formGreaterThan(Object? value) =>
      'Muss größer als ${_number(value)} sein';

  @override
  String formLessThanOrEqualTo(Object? value) =>
      'Muss kleiner oder gleich ${_number(value)} sein';

  @override
  String get formPhoneNumberInvalid => 'Die Telefonnummer ist ungültig';

  @override
  String get formPhoneNumberEmpty => 'Die Telefonnummer ist erforderlich';

  @override
  String formGreaterThanOrEqualTo(Object? value) =>
      'Muss größer oder gleich ${_number(value)} sein';

  @override
  String formBetweenInclusively(Object? min, Object? max) =>
      'Muss zwischen ${_number(min)} und ${_number(max)} liegen (einschließlich)';

  @override
  String formEqualTo(Object? value) => 'Muss gleich ${_number(value)} sein';

  @override
  String formBetweenExclusively(Object? min, Object? max) =>
      'Muss zwischen ${_number(min)} und ${_number(max)} liegen (ausschließlich)';

  @override
  String formLengthLessThan(int limit) =>
      'Muss mindestens $limit Zeichen lang sein';

  @override
  String formLengthGreaterThan(int limit) =>
      'Darf höchstens $limit Zeichen lang sein';

  @override
  String get formPasswordDigits => 'Muss mindestens eine Ziffer enthalten';

  @override
  String get formPasswordLowercase =>
      'Muss mindestens einen Kleinbuchstaben enthalten';

  @override
  String get formPasswordUppercase =>
      'Muss mindestens einen Großbuchstaben enthalten';

  @override
  String get formPasswordSpecial =>
      'Muss mindestens ein Sonderzeichen enthalten';

  @override
  String get commandSearch => 'Befehl eingeben oder suchen...';

  @override
  String get commandEmpty => 'Keine Ergebnisse gefunden.';

  @override
  String get datePickerSelectYear => 'Jahr auswählen';

  @override
  String get abbreviatedMonday => 'Mo';

  @override
  String get abbreviatedTuesday => 'Di';

  @override
  String get abbreviatedWednesday => 'Mi';

  @override
  String get abbreviatedThursday => 'Do';

  @override
  String get abbreviatedFriday => 'Fr';

  @override
  String get abbreviatedSaturday => 'Sa';

  @override
  String get abbreviatedSunday => 'So';

  @override
  String get monthJanuary => 'Januar';

  @override
  String get monthFebruary => 'Februar';

  @override
  String get monthMarch => 'März';

  @override
  String get monthApril => 'April';

  @override
  String get monthMay => 'Mai';

  @override
  String get monthJune => 'Juni';

  @override
  String get monthJuly => 'Juli';

  @override
  String get monthAugust => 'August';

  @override
  String get monthSeptember => 'September';

  @override
  String get monthOctober => 'Oktober';

  @override
  String get monthNovember => 'November';

  @override
  String get monthDecember => 'Dezember';

  @override
  String get abbreviatedJanuary => 'Jan';

  @override
  String get abbreviatedFebruary => 'Feb';

  @override
  String get abbreviatedMarch => 'Mär';

  @override
  String get abbreviatedApril => 'Apr';

  @override
  String get abbreviatedMay => 'Mai';

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
  String get abbreviatedDecember => 'Dez';

  @override
  String get dialogDismiss => 'Schließen';

  @override
  String get chipInputRemoveChip => 'Löschen';

  @override
  String get buttonCancel => 'Abbrechen';

  @override
  String get buttonSave => 'Speichern';

  @override
  String get timeHour => 'Stunde';

  @override
  String get timeMinute => 'Minute';

  @override
  String get timeSecond => 'Sekunde';

  @override
  String get timeAM => 'AM';

  @override
  String get timePM => 'PM';

  @override
  String get colorRed => 'Rot';

  @override
  String get colorGreen => 'Grün';

  @override
  String get colorBlue => 'Blau';

  @override
  String get colorAlpha => 'Alpha';

  @override
  String get colorHue => 'Farbton';

  @override
  String get colorSaturation => 'Sät';

  @override
  String get colorValue => 'Hell';

  @override
  String get colorLightness => 'Lum';

  @override
  String get menuCut => 'Ausschneiden';

  @override
  String get menuCopy => 'Kopieren';

  @override
  String get menuPaste => 'Einfügen';

  @override
  String get menuSelectAll => 'Alles auswählen';

  @override
  String get menuUndo => 'Rückgängig';

  @override
  String get menuRedo => 'Wiederholen';

  @override
  String get menuDelete => 'Löschen';

  @override
  String get menuShare => 'Teilen';

  @override
  String get menuSearchWeb => 'Im Web suchen';

  @override
  String get menuLiveTextInput => 'Live-Text';

  @override
  String get placeholderDatePicker => 'Datum auswählen';

  @override
  String get placeholderTimePicker => 'Uhrzeit auswählen';

  @override
  String get placeholderColorPicker => 'Farbe auswählen';

  @override
  String get buttonPrevious => 'Zurück';

  @override
  String get buttonNext => 'Weiter';

  @override
  String get refreshTriggerPull => 'Zum Aktualisieren ziehen';

  @override
  String get refreshTriggerRelease => 'Zum Aktualisieren loslassen';

  @override
  String get refreshTriggerRefreshing => 'Wird aktualisiert...';

  @override
  String get refreshTriggerComplete => 'Aktualisierung abgeschlossen';

  @override
  String get colorPickerTabRGB => 'RGB';

  @override
  String get colorPickerTabHSV => 'HSV';

  @override
  String get colorPickerTabHSL => 'HSL';

  @override
  String get colorPickerTabHEX => 'HEX';

  @override
  String get commandMoveUp => 'Nach oben';

  @override
  String get commandMoveDown => 'Nach unten';

  @override
  String get commandActivate => 'Auswählen';

  @override
  String get timeDaysAbbreviation => 'TT';

  @override
  String get timeHoursAbbreviation => 'SS';

  @override
  String get timeMinutesAbbreviation => 'MM';

  @override
  String get timeSecondsAbbreviation => 'SS';

  @override
  String get placeholderDurationPicker => 'Dauer auswählen';

  @override
  String get durationDay => 'Tag';

  @override
  String get durationHour => 'Stunde';

  @override
  String get durationMinute => 'Minute';

  @override
  String get durationSecond => 'Sekunde';

  @override
  String get dropzoneIdle => 'Dateien zum Hochladen suchen';

  @override
  String get dropzoneDragging => 'Dateien zum Hochladen ablegen';

  @override
  String get dropzoneUploading => 'Dateien werden hochgeladen...';

  @override
  String get dropzoneSuccess => 'Dateien bereit';

  @override
  String get dropzoneError => 'Beheben Sie Fehler, um fortzufahren';

  @override
  String get dropzoneDisabled => 'Datei-Uploads deaktiviert';

  @override
  String get dropzoneBrowse => 'Dateien durchsuchen';

  @override
  String get emptyStateEmptyTitle => 'Noch nichts hier';

  @override
  String get emptyStateEmptyDescription =>
      'Erstellen Sie Ihr erstes Element, um zu beginnen.';

  @override
  String get emptyStateNoResultsTitle => 'Keine Ergebnisse gefunden';

  @override
  String get emptyStateNoResultsDescription =>
      'Passen Sie Ihre Filter oder Suchbegriffe an.';

  @override
  String get emptyStateErrorTitle => 'Etwas ist schiefgelaufen';

  @override
  String get emptyStateErrorDescription =>
      'Diese Daten konnten nicht geladen werden. Versuchen Sie es in einem Moment erneut.';

  @override
  String get filterSearch => 'Suchen';

  @override
  String get filterSort => 'Sortieren';

  @override
  String get filterDateRange => 'Datumsbereich';

  @override
  String get filterClearAll => 'Alle löschen';

  @override
  String get filterFilters => 'Filter';

  @override
  String filterActiveCount(int count) => '${_number(count)} aktive Filter';

  @override
  String filterResultsCount(int count) => '${_number(count)} Ergebnisse';

  @override
  String get fileUploadChoose => 'Datei auswählen';

  @override
  String get fileUploadNoFile => 'Keine Datei ausgewählt';

  @override
  String get fileUploadPickFailed => 'Dateiauswahl fehlgeschlagen.';

  @override
  String get fileUploadTooMany => 'Zu viele Dateien ausgewählt.';

  @override
  String get fileUploadTooLarge => 'Datei ist zu groß.';

  @override
  String get fileUploadInvalidType => 'Dateityp ist nicht zulässig.';

  @override
  String get fileUploadUploadFailed => 'Upload fehlgeschlagen.';

  @override
  String fileUploadUploadFailedFor(String name) =>
      'Upload fehlgeschlagen für $name.';

  @override
  String get fileUploadStatusQueued => 'In Warteschlange';

  @override
  String get fileUploadStatusUploading => 'Wird hochgeladen';

  @override
  String get fileUploadStatusCompleted => 'Abgeschlossen';

  @override
  String get fileUploadStatusFailed => 'Fehlgeschlagen';

  @override
  String get fileUploadUnknownType => 'Datei';

  @override
  String get fileUploadRemove => 'Datei entfernen';

  @override
  String get fileUploadRetry => 'Upload wiederholen';

  @override
  String get fileUploadPreview => 'Datei-Vorschau';

  @override
  String get fileUploadDownload => 'Datei herunterladen';

  @override
  String get errorSomethingWentWrong => 'Etwas ist schiefgelaufen';

  @override
  String get errorUnexpectedMessage =>
      'Bitte versuchen Sie es erneut oder wenden Sie sich an den Support, falls das Problem weiterhin besteht.';

  @override
  String get errorActionRetry => 'Wiederholen';

  @override
  String get errorActionReport => 'Melden';

  @override
  String get errorActionBack => 'Zurück';

  @override
  String get errorActionLogin => 'Anmelden';

  @override
  String get errorActionSettings => 'Einstellungen';

  @override
  String get errorActionContactSupport => 'Support kontaktieren';

  @override
  String get errorBadRequest => 'Ungültige Anfrage';

  @override
  String get errorBadRequestMessage =>
      'Die Anfrage war ungültig. Bitte überprüfen Sie sie und versuchen Sie es erneut.';

  @override
  String get errorUnauthorized => 'Nicht autorisiert';

  @override
  String get errorLoginRequiredMessage =>
      'Bitte melden Sie sich an, um fortzufahren.';

  @override
  String get errorAccessDenied => 'Zugriff verweigert';

  @override
  String get errorAccessDeniedMessage =>
      'Sie haben keine Berechtigung, diese Aktion auszuführen.';

  @override
  String get errorNotFound => 'Nicht gefunden';

  @override
  String get errorNotFoundMessage =>
      'Wir konnten nicht finden, wonach Sie gesucht haben.';

  @override
  String get errorConflict => 'Konflikt';

  @override
  String get errorConflictMessage =>
      'Diese Aktion steht im Konflikt mit vorhandenen Daten.';

  @override
  String get errorInvalidData => 'Ungültige Daten';

  @override
  String get errorInvalidDataMessage =>
      'Einige Felder erfordern Ihre Aufmerksamkeit.';

  @override
  String get errorTooManyRequests => 'Zu viele Anfragen';

  @override
  String get errorTooManyRequestsMessage =>
      'Bitte warten Sie einen Moment und versuchen Sie es erneut.';

  @override
  String get errorServerError => 'Serverfehler';

  @override
  String get errorServerErrorMessage =>
      'Auf dem Server ist ein Problem aufgetreten. Bitte versuchen Sie es erneut.';

  @override
  String get errorRequestTimedOut => 'Zeitüberschreitung der Anfrage';

  @override
  String get errorRequestTimedOutMessage =>
      'Der Server braucht zu lange, um zu antworten.';

  @override
  String get errorAuthenticationRequired => 'Authentifizierung erforderlich';

  @override
  String get errorInvalidInput => 'Ungültige Eingabe';

  @override
  String get errorReviewFieldsMessage =>
      'Bitte überprüfen Sie die markierten Felder.';

  @override
  String get errorPlatformError => 'Plattformfehler';

  @override
  String get errorDeviceErrorMessage =>
      'Auf diesem Gerät ist etwas schiefgelaufen.';

  @override
  String get errorConnectionFailed => 'Verbindung fehlgeschlagen';

  @override
  String get errorConnectionFailedMessage =>
      'Überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.';

  @override
  String get errorSecureConnectionFailed => 'Sichere Verbindung fehlgeschlagen';

  @override
  String get errorSecureConnectionMessage =>
      'Es konnte keine sichere Verbindung hergestellt werden.';

  @override
  String get tableResizeColumn => 'Spaltengröße ändern';

  @override
  String get tableResizeRow => 'Zeilengröße ändern';

  @override
  String get resizableHandle => 'Griff zur Größenänderung';

  @override
  String get spellCheckNoSuggestions => 'Keine Vorschläge';

  @override
  String get announcementLoading => 'Wird geladen';

  @override
  String get announcementSuccess => 'Erfolg';

  @override
  String get announcementFailure => 'Fehler';

  @override
  String get toolbarMore => 'Mehr';

  @override
  String get toolbarMoreActions => 'Weitere Aktionen';

  @override
  String get treeCollapse => 'Reduzieren';

  @override
  String get treeExpand => 'Erweitern';

  @override
  String get markdownDetails => 'Details';

  @override
  String get carouselLabel => 'Feature-Karussell';

  @override
  String get carouselPrimaryAction => 'Zum Chat hinzufügen';

  @override
  String carouselItemPreview(Object? title) =>
      'Feature-Vorschau: ${title ?? mediaUntitled}';

  @override
  String carouselPageOf(int position, int length) =>
      'Seite ${_number(position)} von ${_number(length)}';

  @override
  String stepperStep(int index) => 'Schritt ${_number(index + 1)}';

  @override
  String paginationPage(Object? page) => 'Seite ${_number(page)}';

  @override
  String chartSeriesDefault(int index) => 'Reihe ${_number(index + 1)}';

  @override
  String chartSliceDefault(int index) => 'Segment ${_number(index)}';

  @override
  String chartCategoryDefault(int index) => 'Kategorie ${_number(index)}';

  @override
  String get chartValueDefault => 'Wert';

  @override
  String get chartKindLine => 'Linie';

  @override
  String get chartKindArea => 'Fläche';

  @override
  String get chartKindBar => 'Balken';

  @override
  String get chartKindDonut => 'Donut';

  @override
  String get chartKindPie => 'Kreis';

  @override
  String get chartKindSparkline => 'Sparkline';

  @override
  String get chartKindScatter => 'Streuung';

  @override
  String get chartKindRadar => 'Radar';

  @override
  String get chartKindRadial => 'Radial';

  @override
  String chartSummaryEmpty(Object? kind) => '$kind-Diagramm ohne Daten';

  @override
  String chartSummary(int series, int points, Object? kind) =>
      '$kind-Diagramm mit ${_number(series)} Reihen und ${_number(points)} Punkten';

  @override
  String get colorFieldHsv => 'HSV-Farbfeld';

  @override
  String get colorFieldHsl => 'HSL-Farbfeld';

  @override
  String get actionClear => 'Leeren';

  @override
  String get actionApply => 'Anwenden';

  @override
  String get actionVerify => 'Bestätigen';

  @override
  String get actionResend => 'Erneut senden';

  @override
  String resendInSeconds(int seconds) =>
      'In ${_number(seconds)} s erneut senden';

  @override
  String get authCode => 'Code';

  @override
  String get authEmail => 'E-Mail';

  @override
  String get authPassword => 'Passwort';

  @override
  String get authName => 'Name';

  @override
  String get authSignIn => 'Anmelden';

  @override
  String get authForgotPassword => 'Passwort vergessen?';

  @override
  String get authRememberMe => 'Angemeldet bleiben';

  @override
  String get authCreateAccount => 'Konto erstellen';

  @override
  String get actionClose => 'Schließen';

  @override
  String get mediaPlay => 'Abspielen';

  @override
  String get mediaPause => 'Pause';

  @override
  String get mediaMute => 'Stummschalten';

  @override
  String get mediaUnmute => 'Stummschaltung aufheben';

  @override
  String get mediaVolume => 'Lautstärke';

  @override
  String get mediaSeek => 'Suchen';

  @override
  String get mediaDownload => 'Herunterladen';

  @override
  String get mediaAudioPlayer => 'Audioplayer';

  @override
  String get mediaVideoPlayer => 'Videoplayer';

  @override
  String get mediaUntitled => 'Ohne Titel';

  @override
  String get mediaPlaybackFailed => 'Wiedergabe fehlgeschlagen';

  @override
  String get mediaPreviousTrack => 'Vorheriger Titel';

  @override
  String get mediaNextTrack => 'Nächster Titel';

  @override
  String get mediaShuffleDisable => 'Zufällig deaktivieren';

  @override
  String get mediaShuffleEnable => 'Zufällig aktivieren';

  @override
  String get mediaRepeatDisable => 'Wiederholen deaktivieren';

  @override
  String get mediaRepeatEnable => 'Wiederholen aktivieren';

  @override
  String mediaPlaybackSpeed(Object? speed) =>
      'Wiedergabegeschwindigkeit ${speed}x, zum Ändern tippen';

  @override
  String mediaPositionOf(Object position, Object duration) =>
      '$position von $duration';

  @override
  String mediaHours(int count) =>
      count == 1 ? '1 Stunde' : '${_number(count)} Stunden';

  @override
  String mediaMinutes(int count) =>
      count == 1 ? '1 Minute' : '${_number(count)} Minuten';

  @override
  String mediaSeconds(int count) =>
      count == 1 ? '1 Sekunde' : '${_number(count)} Sekunden';

  @override
  String get signaturePadLabel => 'Unterschriftenfeld';

  @override
  String get qrCodeLabel => 'QR-Code';

  @override
  String get marqueeContent => 'Laufbandinhalt';

  @override
  String mediaSkipBack(int seconds) => '${_number(seconds)} Sekunden zurück';

  @override
  String mediaSkipForward(int seconds) => '${_number(seconds)} Sekunden vor';

  @override
  String get mediaCaptionsShow => 'Untertitel einblenden';

  @override
  String get mediaCaptionsHide => 'Untertitel ausblenden';

  @override
  String get mediaCaptionsOn => 'Untertitel ein';

  @override
  String get mediaCaptionsOff => 'Untertitel aus';

  @override
  String get mediaFullscreen => 'Vollbild';

  @override
  String mediaMoreOptionsSpeed(Object? speed) =>
      'Weitere Optionen, Wiedergabegeschwindigkeit ${speed}x';

  @override
  String mediaSpeed(Object? speed) => 'Geschwindigkeit ${speed}x';

  @override
  String get actionStartTrial => 'Kostenlose Testversion starten';

  @override
  String get authFirstName => 'Vorname';

  @override
  String get authLastName => 'Nachname';

  @override
  String get authPasswordHint => 'Mindestens 8 Zeichen.';

  @override
  String get authUseDifferentEmail => 'Andere E-Mail-Adresse verwenden';

  @override
  String get authWorkEmail => 'Geschäftliche E-Mail-Adresse';

  @override
  String get chartTotalLabel => 'Gesamt';

  @override
  String get mediaQualityAuto => 'Qualität Auto';
}
