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

  @override
  String get blockDontHaveAccount => 'Non hai un account?';

  @override
  String get blockAlreadyHaveAccount => 'Hai già un account?';

  @override
  String get blockNoAccountYet => 'Non hai ancora un account?';

  @override
  String get blockHaveAnAccount => 'Hai un account?';

  @override
  String get blockCreateOne => 'Creane uno';

  @override
  String get blockCreateAccount => 'Crea account';

  @override
  String get blockCreateYourAccount => 'Crea il tuo account';

  @override
  String get blockForgotYourPassword => 'Hai dimenticato la password?';

  @override
  String get blockBackToSignIn => 'Torna all’accesso';

  @override
  String get blockEnterCredentialsWorkspace =>
      'Inserisci le credenziali per accedere alla tua area di lavoro.';

  @override
  String get blockEnterCredentialsContinue =>
      'Inserisci le credenziali per continuare.';

  @override
  String get blockEnterDetailsContinue =>
      'Inserisci i tuoi dati qui sotto per continuare.';

  @override
  String get blockEnterEmailCreateAccount =>
      'Inserisci la tua e-mail qui sotto per creare il tuo account.';

  @override
  String get blockSignedInWelcomeBack => 'Accesso effettuato — bentornato.';

  @override
  String get blockAccountCreatedVerify =>
      'Account creato — controlla la posta in arrivo per verificarlo.';

  @override
  String get blockTrialStartedVerify =>
      'Prova avviata — controlla la posta in arrivo per verificarla.';

  @override
  String get blockPasswordsDoNotMatch => 'Le password non corrispondono.';

  @override
  String get blockCurrentPassword => 'Password attuale';

  @override
  String get blockNewPassword => 'Nuova password';

  @override
  String get blockConfirmNewPassword => 'Conferma la nuova password';

  @override
  String get blockUpdatePassword => 'Aggiorna password';

  @override
  String get blockPasswordUpdated => 'Password aggiornata.';

  @override
  String get blockPasswordHintChange =>
      'Almeno 8 caratteri. Modificarla ti disconnette altrove.';

  @override
  String get blockUsername => 'Nome utente';

  @override
  String get blockUsernameHint => 'Minuscole, cifre, trattini bassi.';

  @override
  String get blockYourAvatar => 'Il tuo avatar';

  @override
  String get blockUploadImage => 'Carica immagine';

  @override
  String get blockBio => 'Biografia';

  @override
  String get blockBioHint => 'Raccontaci qualcosa di te';

  @override
  String get blockBioCounterHint => 'Fino a 160 caratteri.';

  @override
  String get blockProfileSaved => 'Profilo salvato.';

  @override
  String get blockSaveChanges => 'Salva modifiche';

  @override
  String get blockInviteMember => 'Invita membro';

  @override
  String get blockRoleAdmin => 'Amministratore';

  @override
  String get blockRoleOwner => 'Proprietario';

  @override
  String get blockRoleMember => 'Membro';

  @override
  String get blockTeam => 'Team';

  @override
  String get blockProfile => 'Profilo';

  @override
  String get blockSignInWithEmail => 'Accedi con l’e-mail';

  @override
  String get blockSignUp => 'Registrati';

  @override
  String get blockPickWayYouPrefer => 'Scegli il metodo che preferisci.';

  @override
  String blockContinueWith(Object? provider) => 'Continua con $provider';

  @override
  String get blockCreating => 'Creazione in corso…';

  @override
  String get blockSigningIn => 'Accesso in corso…';

  @override
  String get blockSending => 'Invio in corso…';

  @override
  String get blockSaving => 'Salvataggio in corso…';

  @override
  String get blockPaying => 'Pagamento in corso…';

  @override
  String get blockSendResetLink => 'Invia il link di reimpostazione';

  @override
  String get blockResetPassword => 'Reimposta password';

  @override
  String get blockResetLinkSent =>
      'Link di reimpostazione inviato. Controlla la posta in arrivo per continuare.';

  @override
  String get blockWeWillEmailReset =>
      'Ti invieremo un link di reimpostazione via e-mail.';

  @override
  String get blockMustAcceptTerms => 'Devi accettare i termini per continuare.';

  @override
  String get blockCheckInbox => 'Controlla la posta in arrivo';

  @override
  String get blockEnterSixDigitCode =>
      'Inserisci il codice a 6 cifre che ti abbiamo inviato.';

  @override
  String get blockCodeVerifiedSignedIn =>
      'Codice verificato. Hai effettuato l’accesso.';

  @override
  String get blockEmailVerifiedSet => 'E-mail verificata — è tutto pronto.';

  @override
  String get blockVerifyYourEmail => 'Verifica la tua e-mail';

  @override
  String blockWeSentCodeTo(Object? email) =>
      'Abbiamo inviato un codice a 6 cifre a $email.';

  @override
  String get blockDidntGetCode => 'Non hai ricevuto il codice?';

  @override
  String get blockBack => 'Indietro';

  @override
  String get blockBackToCart => 'Torna al carrello';

  @override
  String get blockBackToSettings => 'Torna alle impostazioni';

  @override
  String get blockOneAccountEverything => 'Un unico account per tutto.';

  @override
  String get blockStartTrialNoCard =>
      'Inizia la prova di 14 giorni. Nessuna carta di credito richiesta.';

  @override
  String get blockNotifications => 'Notifiche';

  @override
  String get blockNotifChoose =>
      'Scegli di cosa vuoi essere informato, e dove.';

  @override
  String get blockEmailNotifications => 'Notifiche e-mail';

  @override
  String get blockPushNotifications => 'Notifiche push';

  @override
  String get blockMentionsReplies => 'Menzioni e risposte';

  @override
  String get blockDeliveredToDevices => 'Recapitato sui tuoi dispositivi';

  @override
  String blockEmailChannel(Object? channel) => 'E-mail · $channel';

  @override
  String blockPushChannel(Object? channel) => 'Push · $channel';

  @override
  String get blockQuietHours => 'Ore di silenzio';

  @override
  String get blockWeeklyDigest => 'Riepilogo settimanale';

  @override
  String get blockWeeklyDigestBlurb =>
      'Un’e-mail ogni lunedì con tutto ciò che è successo.';

  @override
  String get blockPreferencesSaved => 'Preferenze salvate.';

  @override
  String get blockSavePreferences => 'Salva preferenze';

  @override
  String get blockReset => 'Reimposta';

  @override
  String get blockWelcomeAboard => 'Benvenuto a bordo';

  @override
  String get blockQuickTour => 'Un breve tour prima di iniziare a usare l’app.';

  @override
  String get blockStayInLoop => 'Resta aggiornato';

  @override
  String get blockMessagesArriveMoment =>
      'Messaggi e aggiornamenti arrivano nel momento in cui accadono.';

  @override
  String get blockNeverMissThing => 'Non perderti nulla';

  @override
  String get blockNotifPermissionBlurb =>
      'Inviamo solo ciò che conta: risposte, promemoria e avvisi di sicurezza. Potrai modificarlo in seguito.';

  @override
  String get blockEnableNotifications => 'Attivare le notifiche?';

  @override
  String get blockAllowNotifications => 'Consenti notifiche';

  @override
  String get blockAllowNotificationsBlurb =>
      'Consenti le notifiche per sfruttare al meglio l’app.';

  @override
  String get blockNotNow => 'Non ora';

  @override
  String get blockSkip => 'Salta';

  @override
  String get blockGetStarted => 'Inizia';

  @override
  String get blockMessages => 'Messaggi';

  @override
  String get blockNoConversations => 'Nessuna conversazione';

  @override
  String get blockPullRefreshChat =>
      'Trascina per aggiornare o avvia una nuova chat.';

  @override
  String get blockMute => 'Silenzia';

  @override
  String get blockMuted => 'Silenziato';

  @override
  String get blockAttach => 'Allega';

  @override
  String get blockAttachFile => 'File';

  @override
  String get blockAttachPhoto => 'Foto';

  @override
  String get blockWriteMessage => 'Scrivi un messaggio…';

  @override
  String get blockYourCart => 'Il tuo carrello';

  @override
  String get blockAddSomethingFirst => 'Aggiungi prima qualcosa che ami.';

  @override
  String get blockCartEmpty => 'Il carrello è vuoto';

  @override
  String get blockCheckout => 'Vai alla cassa';

  @override
  String blockQty(int quantity) => 'Qtà $quantity';

  @override
  String blockPayTotal(Object? amount) => 'Paga $amount';

  @override
  String get blockPayment => 'Pagamento';

  @override
  String get blockCardNumber => 'Numero di carta';

  @override
  String get blockExpiry => 'Scadenza';

  @override
  String get blockCvc => 'CVC';

  @override
  String get blockDeliveryAddress => 'Indirizzo di consegna';

  @override
  String get blockStreet => 'Via';

  @override
  String get blockCity => 'Città';

  @override
  String get blockSaveAndContinue => 'Salva e continua';

  @override
  String get blockOrderPlaced => 'Ordine effettuato';

  @override
  String get blockOrderThanks =>
      'Grazie per aver acquistato con noi. Una conferma è in arrivo.';

  @override
  String get blockContinueShopping => 'Continua gli acquisti';

  @override
  String get blockSchedule => 'Programma';

  @override
  String get blockPickDateRangeReport =>
      'Scegli un intervallo di date per il tuo report.';

  @override
  String get blockPickDateRange => 'Scegli un intervallo';

  @override
  String get blockTapAnotherDay =>
      'tocca un altro giorno per estendere l’intervallo';

  @override
  String get blockBookMeeting => 'Prenota una riunione';

  @override
  String get blockPickDayTime => 'Scegli un giorno, poi un orario adatto.';

  @override
  String get blockFourSlots =>
      'Restano quattro slot da 30 minuti. Scegline uno.';

  @override
  String blockPickedSlot(Object? slot) => '$slot selezionato, 30 minuti.';

  @override
  String get blockOverview => 'Panoramica';

  @override
  String get blockRevenueOrdersBlurb =>
      'Ricavi, abbonamenti e ordini più recenti.';

  @override
  String get blockTotalRevenue => 'Ricavi totali';

  @override
  String get blockSubscriptions => 'Abbonamenti';

  @override
  String get blockSales => 'Vendite';

  @override
  String get blockRevenueByMonth => 'Ricavi per mese';

  @override
  String get blockRecentSales => 'Vendite recenti';

  @override
  String get blockViewAll => 'Vedi tutto';

  @override
  String get blockTransactions => 'Transazioni';

  @override
  String get blockFilterTransactions => 'Filtra transazioni';

  @override
  String get blockCustomer => 'Cliente';

  @override
  String get blockAmount => 'Importo';

  @override
  String get blockMethod => 'Metodo';

  @override
  String get blockStatus => 'Stato';

  @override
  String get blockPaid => 'Pagato';

  @override
  String get blockPending => 'In sospeso';

  @override
  String get blockRefunded => 'Rimborsato';

  @override
  String blockNoTransactions(Object? query) =>
      'Nessuna transazione corrispondente a “$query”.';

  @override
  String blockDeltaFromLastMonth(Object? delta) =>
      '$delta rispetto al mese scorso';

  @override
  String get blockAnalytics => 'Statistiche';

  @override
  String get blockSessionsDevicesBlurb =>
      'Sessioni, dispositivi e provenienza del traffico.';

  @override
  String get blockSearchReports => 'Cerca nei report';

  @override
  String get blockLast30Days => 'Ultimi 30 giorni';

  @override
  String get blockAllDevices => 'Tutti i dispositivi';

  @override
  String get blockSessions => 'Sessioni';

  @override
  String get blockUsers => 'Utenti';

  @override
  String get blockAvgSession => 'Sessione media';

  @override
  String get blockBounceRate => 'Frequenza di rimbalzo';

  @override
  String get blockConversions => 'Conversioni';

  @override
  String get blockByDevice => 'Per dispositivo';

  @override
  String get blockDesktop => 'Desktop';

  @override
  String get blockMobile => 'Mobile';

  @override
  String get blockTablet => 'Tablet';

  @override
  String get blockDirect => 'Diretto';

  @override
  String get blockReferral => 'Referral';

  @override
  String get blockSocial => 'Social';

  @override
  String get blockTrafficSources => 'Sorgenti di traffico';

  @override
  String get blockVisitors => 'Visitatori';

  @override
  String get blockHome => 'Home';

  @override
  String get blockInbox => 'Posta in arrivo';

  @override
  String get blockCalendar => 'Calendario';

  @override
  String get blockCompose => 'Scrivi';

  @override
  String get blockMarkAllRead => 'Segna tutto come letto';

  @override
  String get blockStarred => 'Speciali';

  @override
  String get blockSnoozed => 'Posticipati';

  @override
  String get blockUnread => 'Non letti';

  @override
  String get blockDocuments => 'Documenti';

  @override
  String get blockReports => 'Report';

  @override
  String get blockDashboard => 'Dashboard';

  @override
  String get blockStorage => 'Archiviazione';

  @override
  String get blockNavigation => 'Navigazione';

  @override
  String get blockSharedWithYou => 'Condiviso con te';

  @override
  String get blockRecentProjects => 'Progetti recenti';

  @override
  String get blockStorageUsed => 'Spazio utilizzato';

  @override
  String get blockOpen => 'Apri';

  @override
  String get blockLive => 'Live';

  @override
  String get blockMembers => 'Membri';

  @override
  String get blockProjects => 'Progetti';

  @override
  String get blockDeploys => 'Distribuzioni';

  @override
  String get blockActivity => 'Attività';

  @override
  String get blockRecentFiles => 'File recenti';

  @override
  String get blockUsageThisMonth => 'Utilizzo di questo mese';

  @override
  String get blockUpgradePlan => 'Aggiorna piano';

  @override
  String blockNoMatches(Object? query) => 'Nessun risultato per “$query”.';

  @override
  String get blockWorkspaces => 'Aree di lavoro';

  @override
  String get blockPricing => 'Prezzi';

  @override
  String get blockPlansScale => 'Piani che crescono con te';

  @override
  String get blockPlansBlurb =>
      'Inizia gratis, passa a un piano superiore quando il team cresce. Ogni piano include l’intera libreria di componenti e i preset di tema.';

  @override
  String get blockPerUserMonth => 'per utente / mese';

  @override
  String get blockSubscribe => 'Abbonati';

  @override
  String get blockContactSales => 'Contatta le vendite';

  @override
  String get blockPromoCode => 'Codice promo';

  @override
  String get blockApplyCode => 'Applica codice';

  @override
  String get blockHaveCodeEnter => 'Hai un codice? Inseriscilo qui sotto.';

  @override
  String get blockCodeAppliedDiscount =>
      'Codice applicato — lo sconto sarà visibile alla cassa.';

  @override
  String get blockFaqTitle => 'Domande';

  @override
  String get blockFaqChangePlans => 'Posso cambiare piano in seguito?';

  @override
  String get blockFaqChangePlansAnswer =>
      'Sì. Gli upgrade sono immediati, i downgrade dal ciclo successivo.';

  @override
  String get blockFaqFreeTrial => 'C’è una prova gratuita?';

  @override
  String get blockFaqFreeTrialAnswer =>
      'Ogni piano inizia con 14 giorni, senza carta richiesta.';

  @override
  String get blockAccount => 'Account';

  @override
  String get blockGeneral => 'Generali';

  @override
  String get blockAppearance => 'Aspetto';

  @override
  String get blockDarkMode => 'Modalità scura';

  @override
  String get blockPreferences => 'Preferenze';

  @override
  String get blockSignOut => 'Esci';

  @override
  String get blockSignOutConfirm => 'Uscire?';

  @override
  String get blockSignOutBlurb => 'Potrai sempre accedere di nuovo in seguito.';

  @override
  String get blockSounds => 'Suoni';

  @override
  String get blockWhatYouGet => 'Cosa ottieni';

  @override
  String get blockAllComponentCategories => 'Tutte le categorie di componenti';

  @override
  String get blockPrioritySupport => 'Supporto prioritario';

  @override
  String get blockUnlimitedProjectsTrial =>
      'Progetti illimitati durante la prova';

  @override
  String get blockTrialDaysLeft => 'Restano 14 giorni di prova';

  @override
  String get blockStarterChat => 'Chat';

  @override
  String get blockStarterShop => 'Negozio';

  @override
  String get blockStarterCart => 'Carrello';

  @override
  String get blockAddToCart => 'Aggiungi al carrello';
}
