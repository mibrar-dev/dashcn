import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

/// Italian (`it`) locale data.
///
/// Translations only: anything this table does not override falls
/// through to the English default on [ComponentLocalizations]. Text
/// direction is not handled here - Flutter resolves it from
/// [WidgetsLocalizations] and [Directionality].
class ComponentLocalizationsIt extends ComponentLocalizations {
  /// Creates the Italian strings.
  const ComponentLocalizationsIt([super.locale = const Locale('it')]);

  /// Formats [value] as a number in this locale, or returns it
  /// verbatim when it is not a number.
  String _number(Object? value) {
    if (value is! num) return '$value';
    return intl.NumberFormat.decimalPattern(localeName).format(value);
  }

  @override
  String get formNotEmpty => 'Questo campo non può essere vuoto';

  @override
  String get invalidValue => 'Valore non valido';

  @override
  String get invalidEmail => 'Indirizzo e-mail non valido';

  @override
  String get invalidURL => 'URL non valido';

  @override
  String formLessThan(Object? value) =>
      'Deve essere minore di ${_number(value)}';

  @override
  String formGreaterThan(Object? value) =>
      'Deve essere maggiore di ${_number(value)}';

  @override
  String formLessThanOrEqualTo(Object? value) =>
      'Deve essere minore o uguale a ${_number(value)}';

  @override
  String get formPhoneNumberInvalid => 'Il numero di telefono non è valido';

  @override
  String get formPhoneNumberEmpty => 'Il numero di telefono è obbligatorio';

  @override
  String formGreaterThanOrEqualTo(Object? value) =>
      'Deve essere maggiore o uguale a ${_number(value)}';

  @override
  String formBetweenInclusively(Object? min, Object? max) =>
      'Deve essere compreso tra ${_number(min)} e ${_number(max)} (inclusi)';

  @override
  String formEqualTo(Object? value) => 'Deve essere uguale a ${_number(value)}';

  @override
  String formBetweenExclusively(Object? min, Object? max) =>
      'Deve essere compreso tra ${_number(min)} e ${_number(max)} (esclusi)';

  @override
  String formLengthLessThan(int limit) =>
      'Deve contenere almeno $limit caratteri';

  @override
  String formLengthGreaterThan(int limit) =>
      'Deve contenere al massimo $limit caratteri';

  @override
  String get formPasswordDigits => 'Deve contenere almeno una cifra';

  @override
  String get formPasswordLowercase =>
      'Deve contenere almeno una lettera minuscola';

  @override
  String get formPasswordUppercase =>
      'Deve contenere almeno una lettera maiuscola';

  @override
  String get formPasswordSpecial =>
      'Deve contenere almeno un carattere speciale';

  @override
  String get commandSearch => 'Digita un comando o cerca...';

  @override
  String get commandEmpty => 'Nessun risultato.';

  @override
  String get datePickerSelectYear => 'Seleziona un anno';

  @override
  String get abbreviatedMonday => 'Lu';

  @override
  String get abbreviatedTuesday => 'Ma';

  @override
  String get abbreviatedWednesday => 'Me';

  @override
  String get abbreviatedThursday => 'Gi';

  @override
  String get abbreviatedFriday => 'Ve';

  @override
  String get abbreviatedSaturday => 'Sa';

  @override
  String get abbreviatedSunday => 'Do';

  @override
  String get monthJanuary => 'Gennaio';

  @override
  String get monthFebruary => 'Febbraio';

  @override
  String get monthMarch => 'Marzo';

  @override
  String get monthApril => 'Aprile';

  @override
  String get monthMay => 'Maggio';

  @override
  String get monthJune => 'Giugno';

  @override
  String get monthJuly => 'Luglio';

  @override
  String get monthAugust => 'Agosto';

  @override
  String get monthSeptember => 'Settembre';

  @override
  String get monthOctober => 'Ottobre';

  @override
  String get monthNovember => 'Novembre';

  @override
  String get monthDecember => 'Dicembre';

  @override
  String get abbreviatedJanuary => 'Gen';

  @override
  String get abbreviatedFebruary => 'Feb';

  @override
  String get abbreviatedMarch => 'Mar';

  @override
  String get abbreviatedApril => 'Apr';

  @override
  String get abbreviatedMay => 'Mag';

  @override
  String get abbreviatedJune => 'Giu';

  @override
  String get abbreviatedJuly => 'Lug';

  @override
  String get abbreviatedAugust => 'Ago';

  @override
  String get abbreviatedSeptember => 'Set';

  @override
  String get abbreviatedOctober => 'Ott';

  @override
  String get abbreviatedNovember => 'Nov';

  @override
  String get abbreviatedDecember => 'Dic';

  @override
  String get dialogDismiss => 'Ignora';

  @override
  String get chipInputRemoveChip => 'Elimina';

  @override
  String get buttonCancel => 'Annulla';

  @override
  String get buttonSave => 'Salva';

  @override
  String get timeHour => 'Ora';

  @override
  String get timeMinute => 'Minuto';

  @override
  String get timeSecond => 'Secondo';

  @override
  String get timeAM => 'AM';

  @override
  String get timePM => 'PM';

  @override
  String get colorRed => 'Rosso';

  @override
  String get colorGreen => 'Verde';

  @override
  String get colorBlue => 'Blu';

  @override
  String get colorAlpha => 'Alfa';

  @override
  String get colorHue => 'Tonalità';

  @override
  String get colorSaturation => 'Sat';

  @override
  String get colorValue => 'Val';

  @override
  String get colorLightness => 'Lum';

  @override
  String get menuCut => 'Taglia';

  @override
  String get menuCopy => 'Copia';

  @override
  String get menuPaste => 'Incolla';

  @override
  String get menuSelectAll => 'Seleziona tutto';

  @override
  String get menuUndo => 'Annulla';

  @override
  String get menuRedo => 'Ripeti';

  @override
  String get menuDelete => 'Elimina';

  @override
  String get menuShare => 'Condividi';

  @override
  String get menuSearchWeb => 'Cerca sul Web';

  @override
  String get menuLiveTextInput => 'Testo dal vivo';

  @override
  String get placeholderDatePicker => 'Seleziona una data';

  @override
  String get placeholderTimePicker => 'Seleziona un orario';

  @override
  String get placeholderColorPicker => 'Seleziona un colore';

  @override
  String get buttonPrevious => 'Precedente';

  @override
  String get buttonNext => 'Avanti';

  @override
  String get refreshTriggerPull => 'Trascina per aggiornare';

  @override
  String get refreshTriggerRelease => 'Rilascia per aggiornare';

  @override
  String get refreshTriggerRefreshing => 'Aggiornamento...';

  @override
  String get refreshTriggerComplete => 'Aggiornamento completato';

  @override
  String get colorPickerTabRGB => 'RGB';

  @override
  String get colorPickerTabHSV => 'HSV';

  @override
  String get colorPickerTabHSL => 'HSL';

  @override
  String get colorPickerTabHEX => 'HEX';

  @override
  String get commandMoveUp => 'Sposta su';

  @override
  String get commandMoveDown => 'Sposta giù';

  @override
  String get commandActivate => 'Seleziona';

  @override
  String get timeDaysAbbreviation => 'GG';

  @override
  String get timeHoursAbbreviation => 'HH';

  @override
  String get timeMinutesAbbreviation => 'MM';

  @override
  String get timeSecondsAbbreviation => 'SS';

  @override
  String get placeholderDurationPicker => 'Seleziona una durata';

  @override
  String get durationDay => 'Giorno';

  @override
  String get durationHour => 'Ora';

  @override
  String get durationMinute => 'Minuto';

  @override
  String get durationSecond => 'Secondo';

  @override
  String get dropzoneIdle => 'Sfoglia per caricare i file';

  @override
  String get dropzoneDragging => 'Trascina i file per caricarli';

  @override
  String get dropzoneUploading => 'Caricamento dei file in corso...';

  @override
  String get dropzoneSuccess => 'File pronti';

  @override
  String get dropzoneError => 'Correggi gli errori per continuare';

  @override
  String get dropzoneDisabled => 'Caricamento file disabilitato';

  @override
  String get dropzoneBrowse => 'Sfoglia i file';

  @override
  String get emptyStateEmptyTitle => 'Ancora niente qui';

  @override
  String get emptyStateEmptyDescription =>
      'Crea il tuo primo elemento per iniziare.';

  @override
  String get emptyStateNoResultsTitle => 'Nessun risultato trovato';

  @override
  String get emptyStateNoResultsDescription =>
      'Prova a modificare i filtri o i termini di ricerca.';

  @override
  String get emptyStateErrorTitle => 'Qualcosa è andato storto';

  @override
  String get emptyStateErrorDescription =>
      'Non siamo riusciti a caricare questi dati. Riprova tra un momento.';

  @override
  String get filterSearch => 'Cerca';

  @override
  String get filterSort => 'Ordina';

  @override
  String get filterDateRange => 'Intervallo di date';

  @override
  String get filterClearAll => 'Cancella tutto';

  @override
  String get filterFilters => 'Filtri';

  @override
  String filterActiveCount(int count) => '${_number(count)} filtri attivi';

  @override
  String filterResultsCount(int count) => '${_number(count)} risultati';

  @override
  String get fileUploadChoose => 'Scegli file';

  @override
  String get fileUploadNoFile => 'Nessun file selezionato';

  @override
  String get fileUploadPickFailed => 'Selezione del file non riuscita.';

  @override
  String get fileUploadTooMany => 'Troppi file selezionati.';

  @override
  String get fileUploadTooLarge => 'Il file è troppo grande.';

  @override
  String get fileUploadInvalidType => 'Il tipo di file non è consentito.';

  @override
  String get fileUploadUploadFailed => 'Caricamento non riuscito.';

  @override
  String fileUploadUploadFailedFor(String name) =>
      'Caricamento non riuscito per $name.';

  @override
  String get fileUploadStatusQueued => 'In coda';

  @override
  String get fileUploadStatusUploading => 'Caricamento in corso';

  @override
  String get fileUploadStatusCompleted => 'Completato';

  @override
  String get fileUploadStatusFailed => 'Non riuscito';

  @override
  String get fileUploadUnknownType => 'File';

  @override
  String get fileUploadRemove => 'Rimuovi file';

  @override
  String get fileUploadRetry => 'Riprova caricamento';

  @override
  String get fileUploadPreview => 'Anteprima del file';

  @override
  String get fileUploadDownload => 'Scarica file';

  @override
  String get errorSomethingWentWrong => 'Qualcosa è andato storto';

  @override
  String get errorUnexpectedMessage =>
      'Riprova o contatta l’assistenza se il problema persiste.';

  @override
  String get errorActionRetry => 'Riprova';

  @override
  String get errorActionReport => 'Segnala';

  @override
  String get errorActionBack => 'Torna indietro';

  @override
  String get errorActionLogin => 'Accedi';

  @override
  String get errorActionSettings => 'Impostazioni';

  @override
  String get errorActionContactSupport => 'Contatta l’assistenza';

  @override
  String get errorBadRequest => 'Richiesta non valida';

  @override
  String get errorBadRequestMessage =>
      'La richiesta non era valida. Controllala e riprova.';

  @override
  String get errorUnauthorized => 'Non autorizzato';

  @override
  String get errorLoginRequiredMessage => 'Accedi per continuare.';

  @override
  String get errorAccessDenied => 'Accesso negato';

  @override
  String get errorAccessDeniedMessage =>
      'Non hai l’autorizzazione per eseguire questa azione.';

  @override
  String get errorNotFound => 'Non trovato';

  @override
  String get errorNotFoundMessage =>
      'Non siamo riusciti a trovare ciò che cercavi.';

  @override
  String get errorConflict => 'Conflitto';

  @override
  String get errorConflictMessage =>
      'Questa azione è in conflitto con i dati esistenti.';

  @override
  String get errorInvalidData => 'Dati non validi';

  @override
  String get errorInvalidDataMessage =>
      'Alcuni campi richiedono la tua attenzione.';

  @override
  String get errorTooManyRequests => 'Troppe richieste';

  @override
  String get errorTooManyRequestsMessage => 'Attendi un momento e riprova.';

  @override
  String get errorServerError => 'Errore del server';

  @override
  String get errorServerErrorMessage =>
      'Il server ha riscontrato un problema. Riprova.';

  @override
  String get errorRequestTimedOut => 'Richiesta scaduta';

  @override
  String get errorRequestTimedOutMessage =>
      'Il server impiega troppo tempo a rispondere.';

  @override
  String get errorAuthenticationRequired => 'Autenticazione richiesta';

  @override
  String get errorInvalidInput => 'Input non valido';

  @override
  String get errorReviewFieldsMessage => 'Controlla i campi evidenziati.';

  @override
  String get errorPlatformError => 'Errore di piattaforma';

  @override
  String get errorDeviceErrorMessage =>
      'Qualcosa è andato storto su questo dispositivo.';

  @override
  String get errorConnectionFailed => 'Connessione non riuscita';

  @override
  String get errorConnectionFailedMessage =>
      'Controlla la connessione Internet e riprova.';

  @override
  String get errorSecureConnectionFailed => 'Connessione sicura non riuscita';

  @override
  String get errorSecureConnectionMessage =>
      'Non siamo riusciti a stabilire una connessione sicura.';

  @override
  String get tableResizeColumn => 'Ridimensiona colonna';

  @override
  String get tableResizeRow => 'Ridimensiona riga';

  @override
  String get resizableHandle => 'Maniglia di ridimensionamento';

  @override
  String get spellCheckNoSuggestions => 'Nessun suggerimento';

  @override
  String get announcementLoading => 'Caricamento';

  @override
  String get announcementSuccess => 'Riuscito';

  @override
  String get announcementFailure => 'Non riuscito';

  @override
  String get toolbarMore => 'Altro';

  @override
  String get toolbarMoreActions => 'Altre azioni';

  @override
  String get treeCollapse => 'Comprimi';

  @override
  String get treeExpand => 'Espandi';

  @override
  String get markdownDetails => 'Dettagli';

  @override
  String get carouselLabel => 'Carosello in evidenza';

  @override
  String get carouselPrimaryAction => 'Aggiungi alla chat';

  @override
  String carouselItemPreview(Object? title) =>
      'Anteprima in evidenza: ${title ?? mediaUntitled}';

  @override
  String carouselPageOf(int position, int length) =>
      'Pagina ${_number(position)} di ${_number(length)}';

  @override
  String stepperStep(int index) => 'Passaggio ${_number(index + 1)}';

  @override
  String paginationPage(Object? page) => 'Pagina ${_number(page)}';

  @override
  String chartSeriesDefault(int index) => 'Serie ${_number(index + 1)}';

  @override
  String chartSliceDefault(int index) => 'Fetta ${_number(index)}';

  @override
  String chartCategoryDefault(int index) => 'Categoria ${_number(index)}';

  @override
  String get chartValueDefault => 'Valore';

  @override
  String get chartKindLine => 'Linea';

  @override
  String get chartKindArea => 'Area';

  @override
  String get chartKindBar => 'Barre';

  @override
  String get chartKindDonut => 'Ciambella';

  @override
  String get chartKindPie => 'Torta';

  @override
  String get chartKindSparkline => 'Sparkline';

  @override
  String get chartKindScatter => 'Dispersione';

  @override
  String get chartKindRadar => 'Radar';

  @override
  String get chartKindRadial => 'Radiale';

  @override
  String chartSummaryEmpty(Object? kind) => 'Grafico $kind senza dati';

  @override
  String chartSummary(int series, int points, Object? kind) =>
      'Grafico $kind con ${_number(series)} serie e ${_number(points)} punti';

  @override
  String get colorFieldHsv => 'Campo colore HSV';

  @override
  String get colorFieldHsl => 'Campo colore HSL';

  @override
  String get actionClear => 'Cancella';

  @override
  String get actionApply => 'Applica';

  @override
  String get actionVerify => 'Verifica';

  @override
  String get actionResend => 'Invia di nuovo';

  @override
  String resendInSeconds(int seconds) =>
      'Invia di nuovo tra ${_number(seconds)} s';

  @override
  String get authCode => 'Codice';

  @override
  String get authEmail => 'E-mail';

  @override
  String get authPassword => 'Password';

  @override
  String get authName => 'Nome';

  @override
  String get authSignIn => 'Accedi';

  @override
  String get authForgotPassword => 'Password dimenticata?';

  @override
  String get authRememberMe => 'Ricordami';

  @override
  String get authCreateAccount => 'Crea un account';

  @override
  String get actionClose => 'Chiudi';

  @override
  String get mediaPlay => 'Riproduci';

  @override
  String get mediaPause => 'Pausa';

  @override
  String get mediaMute => 'Silenzia';

  @override
  String get mediaUnmute => 'Riattiva audio';

  @override
  String get mediaVolume => 'Volume';

  @override
  String get mediaSeek => 'Cerca';

  @override
  String get mediaDownload => 'Scarica';

  @override
  String get mediaAudioPlayer => 'Lettore audio';

  @override
  String get mediaVideoPlayer => 'Lettore video';

  @override
  String get mediaUntitled => 'Senza titolo';

  @override
  String get mediaPlaybackFailed => 'Riproduzione non riuscita';

  @override
  String get mediaPreviousTrack => 'Traccia precedente';

  @override
  String get mediaNextTrack => 'Traccia successiva';

  @override
  String get mediaShuffleDisable => 'Disattiva casuale';

  @override
  String get mediaShuffleEnable => 'Attiva casuale';

  @override
  String get mediaRepeatDisable => 'Disattiva ripetizione';

  @override
  String get mediaRepeatEnable => 'Attiva ripetizione';

  @override
  String mediaPlaybackSpeed(Object? speed) =>
      'Velocità: ${speed}x, tocca per cambiare';

  @override
  String mediaPositionOf(Object position, Object duration) =>
      '$position di $duration';

  @override
  String mediaHours(int count) =>
      count == 1 ? '1 ora' : '${_number(count)} ore';

  @override
  String mediaMinutes(int count) =>
      count == 1 ? '1 minuto' : '${_number(count)} minuti';

  @override
  String mediaSeconds(int count) =>
      count == 1 ? '1 secondo' : '${_number(count)} secondi';

  @override
  String get signaturePadLabel => 'Area firma';

  @override
  String get qrCodeLabel => 'Codice QR';

  @override
  String get marqueeContent => 'Contenuto scorrevole';

  @override
  String mediaSkipBack(int seconds) =>
      'Indietro di ${_number(seconds)} secondi';

  @override
  String mediaSkipForward(int seconds) =>
      'Avanti di ${_number(seconds)} secondi';

  @override
  String get mediaCaptionsShow => 'Mostra sottotitoli';

  @override
  String get mediaCaptionsHide => 'Nascondi sottotitoli';

  @override
  String get mediaCaptionsOn => 'Sottotitoli attivi';

  @override
  String get mediaCaptionsOff => 'Sottotitoli disattivati';

  @override
  String get mediaFullscreen => 'Schermo intero';

  @override
  String mediaMoreOptionsSpeed(Object? speed) =>
      'Altre opzioni, velocità: ${speed}x';

  @override
  String mediaSpeed(Object? speed) => 'Velocità: ${speed}x';

  @override
  String get actionStartTrial => 'Inizia la prova gratuita';

  @override
  String get authFirstName => 'Nome';

  @override
  String get authLastName => 'Cognome';

  @override
  String get authPasswordHint => 'Almeno 8 caratteri.';

  @override
  String get authUseDifferentEmail => 'Usa un altro indirizzo e-mail';

  @override
  String get authWorkEmail => 'E-mail di lavoro';

  @override
  String get chartTotalLabel => 'Totale';

  @override
  String get mediaQualityAuto => 'Qualità Auto';
}
