import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

/// Spanish (`es`) locale data.
///
/// Translations only: anything this table does not override falls
/// through to the English default on [ComponentLocalizations]. Text
/// direction is not handled here - Flutter resolves it from
/// [WidgetsLocalizations] and [Directionality].
class ComponentLocalizationsEs extends ComponentLocalizations {
  /// Creates the Spanish strings.
  const ComponentLocalizationsEs([super.locale = const Locale('es')]);

  /// Formats [value] as a number in this locale, or returns it
  /// verbatim when it is not a number.
  String _number(Object? value) {
    if (value is! num) return '$value';
    return intl.NumberFormat.decimalPattern(localeName).format(value);
  }

  @override
  String get formNotEmpty => 'Este campo no puede estar vacío';

  @override
  String get invalidValue => 'Valor no válido';

  @override
  String get invalidEmail => 'Correo electrónico no válido';

  @override
  String get invalidURL => 'URL no válida';

  @override
  String formLessThan(Object? value) => 'Debe ser menor que ${_number(value)}';

  @override
  String formGreaterThan(Object? value) =>
      'Debe ser mayor que ${_number(value)}';

  @override
  String formLessThanOrEqualTo(Object? value) =>
      'Debe ser menor o igual que ${_number(value)}';

  @override
  String get formPhoneNumberInvalid => 'El número de teléfono no es válido';

  @override
  String get formPhoneNumberEmpty => 'El número de teléfono es obligatorio';

  @override
  String formGreaterThanOrEqualTo(Object? value) =>
      'Debe ser mayor o igual que ${_number(value)}';

  @override
  String formBetweenInclusively(Object? min, Object? max) =>
      'Debe estar entre ${_number(min)} y ${_number(max)} (inclusive)';

  @override
  String formEqualTo(Object? value) => 'Debe ser igual a ${_number(value)}';

  @override
  String formBetweenExclusively(Object? min, Object? max) =>
      'Debe estar entre ${_number(min)} y ${_number(max)} (exclusive)';

  @override
  String formLengthLessThan(int limit) =>
      'Debe tener al menos $limit caracteres';

  @override
  String formLengthGreaterThan(int limit) =>
      'Debe tener como máximo $limit caracteres';

  @override
  String get formPasswordDigits => 'Debe contener al menos un dígito';

  @override
  String get formPasswordLowercase =>
      'Debe contener al menos una letra minúscula';

  @override
  String get formPasswordUppercase =>
      'Debe contener al menos una letra mayúscula';

  @override
  String get formPasswordSpecial =>
      'Debe contener al menos un carácter especial';

  @override
  String get commandSearch => 'Escribe un comando o busca...';

  @override
  String get commandEmpty => 'No se encontraron resultados.';

  @override
  String get datePickerSelectYear => 'Selecciona un año';

  @override
  String get abbreviatedMonday => 'Lu';

  @override
  String get abbreviatedTuesday => 'Ma';

  @override
  String get abbreviatedWednesday => 'Mi';

  @override
  String get abbreviatedThursday => 'Ju';

  @override
  String get abbreviatedFriday => 'Vi';

  @override
  String get abbreviatedSaturday => 'Sá';

  @override
  String get abbreviatedSunday => 'Do';

  @override
  String get monthJanuary => 'Enero';

  @override
  String get monthFebruary => 'Febrero';

  @override
  String get monthMarch => 'Marzo';

  @override
  String get monthApril => 'Abril';

  @override
  String get monthMay => 'Mayo';

  @override
  String get monthJune => 'Junio';

  @override
  String get monthJuly => 'Julio';

  @override
  String get monthAugust => 'Agosto';

  @override
  String get monthSeptember => 'Septiembre';

  @override
  String get monthOctober => 'Octubre';

  @override
  String get monthNovember => 'Noviembre';

  @override
  String get monthDecember => 'Diciembre';

  @override
  String get abbreviatedJanuary => 'Ene';

  @override
  String get abbreviatedFebruary => 'Feb';

  @override
  String get abbreviatedMarch => 'Mar';

  @override
  String get abbreviatedApril => 'Abr';

  @override
  String get abbreviatedMay => 'May';

  @override
  String get abbreviatedJune => 'Jun';

  @override
  String get abbreviatedJuly => 'Jul';

  @override
  String get abbreviatedAugust => 'Ago';

  @override
  String get abbreviatedSeptember => 'Sep';

  @override
  String get abbreviatedOctober => 'Oct';

  @override
  String get abbreviatedNovember => 'Nov';

  @override
  String get abbreviatedDecember => 'Dic';

  @override
  String get dialogDismiss => 'Cerrar';

  @override
  String get chipInputRemoveChip => 'Eliminar';

  @override
  String get buttonCancel => 'Cancelar';

  @override
  String get buttonSave => 'Guardar';

  @override
  String get timeHour => 'Hora';

  @override
  String get timeMinute => 'Minuto';

  @override
  String get timeSecond => 'Segundo';

  @override
  String get timeAM => 'a. m.';

  @override
  String get timePM => 'p. m.';

  @override
  String get colorRed => 'Rojo';

  @override
  String get colorGreen => 'Verde';

  @override
  String get colorBlue => 'Azul';

  @override
  String get colorAlpha => 'Alfa';

  @override
  String get colorHue => 'Tono';

  @override
  String get colorSaturation => 'Sat';

  @override
  String get colorValue => 'Val';

  @override
  String get colorLightness => 'Lum';

  @override
  String get menuCut => 'Cortar';

  @override
  String get menuCopy => 'Copiar';

  @override
  String get menuPaste => 'Pegar';

  @override
  String get menuSelectAll => 'Seleccionar todo';

  @override
  String get menuUndo => 'Deshacer';

  @override
  String get menuRedo => 'Rehacer';

  @override
  String get menuDelete => 'Eliminar';

  @override
  String get menuShare => 'Compartir';

  @override
  String get menuSearchWeb => 'Buscar en la web';

  @override
  String get menuLiveTextInput => 'Texto en vivo';

  @override
  String get placeholderDatePicker => 'Selecciona una fecha';

  @override
  String get placeholderTimePicker => 'Selecciona una hora';

  @override
  String get placeholderColorPicker => 'Selecciona un color';

  @override
  String get buttonPrevious => 'Anterior';

  @override
  String get buttonNext => 'Siguiente';

  @override
  String get refreshTriggerPull => 'Desliza para actualizar';

  @override
  String get refreshTriggerRelease => 'Suelta para actualizar';

  @override
  String get refreshTriggerRefreshing => 'Actualizando...';

  @override
  String get refreshTriggerComplete => 'Actualización completada';

  @override
  String get colorPickerTabRGB => 'RGB';

  @override
  String get colorPickerTabHSV => 'HSV';

  @override
  String get colorPickerTabHSL => 'HSL';

  @override
  String get colorPickerTabHEX => 'HEX';

  @override
  String get commandMoveUp => 'Subir';

  @override
  String get commandMoveDown => 'Bajar';

  @override
  String get commandActivate => 'Seleccionar';

  @override
  String get timeDaysAbbreviation => 'DD';

  @override
  String get timeHoursAbbreviation => 'HH';

  @override
  String get timeMinutesAbbreviation => 'MM';

  @override
  String get timeSecondsAbbreviation => 'SS';

  @override
  String get placeholderDurationPicker => 'Selecciona una duración';

  @override
  String get durationDay => 'Día';

  @override
  String get durationHour => 'Hora';

  @override
  String get durationMinute => 'Minuto';

  @override
  String get durationSecond => 'Segundo';

  @override
  String get dropzoneIdle => 'Explorar para subir archivos';

  @override
  String get dropzoneDragging => 'Suelta archivos para subirlos';

  @override
  String get dropzoneUploading => 'Subiendo archivos...';

  @override
  String get dropzoneSuccess => 'Archivos listos';

  @override
  String get dropzoneError => 'Corrige los errores para continuar';

  @override
  String get dropzoneDisabled => 'Subida de archivos desactivada';

  @override
  String get dropzoneBrowse => 'Explorar archivos';

  @override
  String get emptyStateEmptyTitle => 'Nada aquí todavía';

  @override
  String get emptyStateEmptyDescription =>
      'Crea tu primer elemento para empezar.';

  @override
  String get emptyStateNoResultsTitle => 'No se encontraron resultados';

  @override
  String get emptyStateNoResultsDescription =>
      'Prueba a ajustar los filtros o los términos de búsqueda.';

  @override
  String get emptyStateErrorTitle => 'Algo salió mal';

  @override
  String get emptyStateErrorDescription =>
      'No pudimos cargar estos datos. Inténtalo de nuevo en un momento.';

  @override
  String get filterSearch => 'Buscar';

  @override
  String get filterSort => 'Ordenar';

  @override
  String get filterDateRange => 'Rango de fechas';

  @override
  String get filterClearAll => 'Borrar todo';

  @override
  String get filterFilters => 'Filtros';

  @override
  String filterActiveCount(int count) => '${_number(count)} filtros activos';

  @override
  String filterResultsCount(int count) => '${_number(count)} resultados';

  @override
  String get fileUploadChoose => 'Elegir archivo';

  @override
  String get fileUploadNoFile => 'Ningún archivo elegido';

  @override
  String get fileUploadPickFailed => 'Error al seleccionar el archivo.';

  @override
  String get fileUploadTooMany => 'Demasiados archivos seleccionados.';

  @override
  String get fileUploadTooLarge => 'El archivo es demasiado grande.';

  @override
  String get fileUploadInvalidType => 'El tipo de archivo no está permitido.';

  @override
  String get fileUploadUploadFailed => 'Error al subir.';

  @override
  String fileUploadUploadFailedFor(String name) => 'Error al subir $name.';

  @override
  String get fileUploadStatusQueued => 'En cola';

  @override
  String get fileUploadStatusUploading => 'Subiendo';

  @override
  String get fileUploadStatusCompleted => 'Completado';

  @override
  String get fileUploadStatusFailed => 'Fallido';

  @override
  String get fileUploadUnknownType => 'Archivo';

  @override
  String get fileUploadRemove => 'Quitar archivo';

  @override
  String get fileUploadRetry => 'Reintentar subida';

  @override
  String get fileUploadPreview => 'Vista previa del archivo';

  @override
  String get fileUploadDownload => 'Descargar archivo';

  @override
  String get errorSomethingWentWrong => 'Algo salió mal';

  @override
  String get errorUnexpectedMessage =>
      'Inténtalo de nuevo o contacta con el soporte si el problema persiste.';

  @override
  String get errorActionRetry => 'Reintentar';

  @override
  String get errorActionReport => 'Informar';

  @override
  String get errorActionBack => 'Volver';

  @override
  String get errorActionLogin => 'Iniciar sesión';

  @override
  String get errorActionSettings => 'Ajustes';

  @override
  String get errorActionContactSupport => 'Contactar con soporte';

  @override
  String get errorBadRequest => 'Solicitud incorrecta';

  @override
  String get errorBadRequestMessage =>
      'La solicitud no era válida. Revísala e inténtalo de nuevo.';

  @override
  String get errorUnauthorized => 'No autorizado';

  @override
  String get errorLoginRequiredMessage => 'Inicia sesión para continuar.';

  @override
  String get errorAccessDenied => 'Acceso denegado';

  @override
  String get errorAccessDeniedMessage =>
      'No tienes permiso para realizar esta acción.';

  @override
  String get errorNotFound => 'No encontrado';

  @override
  String get errorNotFoundMessage => 'No pudimos encontrar lo que buscabas.';

  @override
  String get errorConflict => 'Conflicto';

  @override
  String get errorConflictMessage =>
      'Esta acción entra en conflicto con los datos existentes.';

  @override
  String get errorInvalidData => 'Datos no válidos';

  @override
  String get errorInvalidDataMessage => 'Algunos campos necesitan tu atención.';

  @override
  String get errorTooManyRequests => 'Demasiadas solicitudes';

  @override
  String get errorTooManyRequestsMessage =>
      'Espera un momento e inténtalo de nuevo.';

  @override
  String get errorServerError => 'Error del servidor';

  @override
  String get errorServerErrorMessage =>
      'El servidor encontró un problema. Inténtalo de nuevo.';

  @override
  String get errorRequestTimedOut => 'Tiempo de espera agotado';

  @override
  String get errorRequestTimedOutMessage =>
      'El servidor está tardando demasiado en responder.';

  @override
  String get errorAuthenticationRequired => 'Autenticación requerida';

  @override
  String get errorInvalidInput => 'Entrada no válida';

  @override
  String get errorReviewFieldsMessage => 'Revisa los campos resaltados.';

  @override
  String get errorPlatformError => 'Error de plataforma';

  @override
  String get errorDeviceErrorMessage => 'Algo salió mal en este dispositivo.';

  @override
  String get errorConnectionFailed => 'Conexión fallida';

  @override
  String get errorConnectionFailedMessage =>
      'Comprueba tu conexión a Internet e inténtalo de nuevo.';

  @override
  String get errorSecureConnectionFailed => 'Conexión segura fallida';

  @override
  String get errorSecureConnectionMessage =>
      'No pudimos establecer una conexión segura.';

  @override
  String get tableResizeColumn => 'Cambiar tamaño de columna';

  @override
  String get tableResizeRow => 'Cambiar tamaño de fila';

  @override
  String get resizableHandle => 'Control para cambiar el tamaño';

  @override
  String get spellCheckNoSuggestions => 'Sin sugerencias';

  @override
  String get announcementLoading => 'Cargando';

  @override
  String get announcementSuccess => 'Correcto';

  @override
  String get announcementFailure => 'Error';

  @override
  String get toolbarMore => 'Más';

  @override
  String get toolbarMoreActions => 'Más acciones';

  @override
  String get treeCollapse => 'Contraer';

  @override
  String get treeExpand => 'Expandir';

  @override
  String get markdownDetails => 'Detalles';

  @override
  String get carouselLabel => 'Carrusel destacado';

  @override
  String get carouselPrimaryAction => 'Añadir al chat';

  @override
  String carouselItemPreview(Object? title) =>
      'Vista destacada: ${title ?? mediaUntitled}';

  @override
  String carouselPageOf(int position, int length) =>
      'Página ${_number(position)} de ${_number(length)}';

  @override
  String stepperStep(int index) => 'Paso ${_number(index + 1)}';

  @override
  String paginationPage(Object? page) => 'Página ${_number(page)}';

  @override
  String chartSeriesDefault(int index) => 'Serie ${_number(index + 1)}';

  @override
  String chartSliceDefault(int index) => 'Parte ${_number(index)}';

  @override
  String chartCategoryDefault(int index) => 'Categoría ${_number(index)}';

  @override
  String get chartValueDefault => 'Valor';

  @override
  String get chartKindLine => 'Línea';

  @override
  String get chartKindArea => 'Área';

  @override
  String get chartKindBar => 'Barras';

  @override
  String get chartKindDonut => 'Dona';

  @override
  String get chartKindPie => 'Circular';

  @override
  String get chartKindSparkline => 'Minigráfico';

  @override
  String get chartKindScatter => 'Dispersión';

  @override
  String get chartKindRadar => 'Radar';

  @override
  String get chartKindRadial => 'Radial';

  @override
  String chartSummaryEmpty(Object? kind) => 'Gráfico $kind sin datos';

  @override
  String chartSummary(int series, int points, Object? kind) =>
      'Gráfico $kind con ${_number(series)} series y ${_number(points)} puntos';

  @override
  String get colorFieldHsv => 'Campo de color HSV';

  @override
  String get colorFieldHsl => 'Campo de color HSL';

  @override
  String get actionClear => 'Borrar';

  @override
  String get actionApply => 'Aplicar';

  @override
  String get actionVerify => 'Verificar';

  @override
  String get actionResend => 'Reenviar';

  @override
  String resendInSeconds(int seconds) => 'Reenviar en ${_number(seconds)} s';

  @override
  String get authCode => 'Código';

  @override
  String get authEmail => 'Correo electrónico';

  @override
  String get authPassword => 'Contraseña';

  @override
  String get authName => 'Nombre';

  @override
  String get authSignIn => 'Iniciar sesión';

  @override
  String get authForgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get authRememberMe => 'Recuérdame';

  @override
  String get authCreateAccount => 'Crear una cuenta';

  @override
  String get actionClose => 'Cerrar';

  @override
  String get mediaPlay => 'Reproducir';

  @override
  String get mediaPause => 'Pausar';

  @override
  String get mediaMute => 'Silenciar';

  @override
  String get mediaUnmute => 'Activar sonido';

  @override
  String get mediaVolume => 'Volumen';

  @override
  String get mediaSeek => 'Buscar';

  @override
  String get mediaDownload => 'Descargar';

  @override
  String get mediaAudioPlayer => 'Reproductor de audio';

  @override
  String get mediaVideoPlayer => 'Reproductor de vídeo';

  @override
  String get mediaUntitled => 'Sin título';

  @override
  String get mediaPlaybackFailed => 'Error de reproducción';

  @override
  String get mediaPreviousTrack => 'Pista anterior';

  @override
  String get mediaNextTrack => 'Pista siguiente';

  @override
  String get mediaShuffleDisable => 'Desactivar aleatorio';

  @override
  String get mediaShuffleEnable => 'Activar aleatorio';

  @override
  String get mediaRepeatDisable => 'Desactivar repetición';

  @override
  String get mediaRepeatEnable => 'Activar repetición';

  @override
  String mediaPlaybackSpeed(Object? speed) =>
      'Velocidad: ${speed}x, toca para cambiar';

  @override
  String mediaPositionOf(Object position, Object duration) =>
      '$position de $duration';

  @override
  String mediaHours(int count) =>
      count == 1 ? '1 hora' : '${_number(count)} horas';

  @override
  String mediaMinutes(int count) =>
      count == 1 ? '1 minuto' : '${_number(count)} minutos';

  @override
  String mediaSeconds(int count) =>
      count == 1 ? '1 segundo' : '${_number(count)} segundos';

  @override
  String get signaturePadLabel => 'Panel de firma';

  @override
  String get qrCodeLabel => 'Código QR';

  @override
  String get marqueeContent => 'Contenido en movimiento';

  @override
  String mediaSkipBack(int seconds) =>
      'Retroceder ${_number(seconds)} segundos';

  @override
  String mediaSkipForward(int seconds) =>
      'Avanzar ${_number(seconds)} segundos';

  @override
  String get mediaCaptionsShow => 'Mostrar subtítulos';

  @override
  String get mediaCaptionsHide => 'Ocultar subtítulos';

  @override
  String get mediaCaptionsOn => 'Subtítulos activados';

  @override
  String get mediaCaptionsOff => 'Subtítulos desactivados';

  @override
  String get mediaFullscreen => 'Pantalla completa';

  @override
  String mediaMoreOptionsSpeed(Object? speed) =>
      'Más opciones, velocidad: ${speed}x';

  @override
  String mediaSpeed(Object? speed) => 'Velocidad: ${speed}x';

  @override
  String get actionStartTrial => 'Iniciar prueba gratuita';

  @override
  String get authFirstName => 'Nombre';

  @override
  String get authLastName => 'Apellidos';

  @override
  String get authPasswordHint => '8 caracteres como mínimo.';

  @override
  String get authUseDifferentEmail => 'Usar otro correo electrónico';

  @override
  String get authWorkEmail => 'Correo electrónico del trabajo';

  @override
  String get chartTotalLabel => 'Total';

  @override
  String get mediaQualityAuto => 'Calidad Auto';

  @override
  String get blockDontHaveAccount => '¿No tienes cuenta?';

  @override
  String get blockAlreadyHaveAccount => '¿Ya tienes cuenta?';

  @override
  String get blockNoAccountYet => '¿Aún no tienes cuenta?';

  @override
  String get blockHaveAnAccount => '¿Tienes cuenta?';

  @override
  String get blockCreateOne => 'Crea una';

  @override
  String get blockCreateAccount => 'Crear cuenta';

  @override
  String get blockCreateYourAccount => 'Crea tu cuenta';

  @override
  String get blockForgotYourPassword => '¿Olvidaste tu contraseña?';

  @override
  String get blockBackToSignIn => 'Volver al inicio de sesión';

  @override
  String get blockEnterCredentialsWorkspace =>
      'Introduce tus credenciales para acceder a tu espacio de trabajo.';

  @override
  String get blockEnterCredentialsContinue =>
      'Introduce tus credenciales para continuar.';

  @override
  String get blockEnterDetailsContinue =>
      'Introduce tus datos a continuación para continuar.';

  @override
  String get blockEnterEmailCreateAccount =>
      'Introduce tu correo electrónico para crear tu cuenta.';

  @override
  String get blockSignedInWelcomeBack =>
      'Sesión iniciada; bienvenido de nuevo.';

  @override
  String get blockAccountCreatedVerify =>
      'Cuenta creada; revisa tu bandeja para verificarla.';

  @override
  String get blockTrialStartedVerify =>
      'Prueba iniciada; revisa tu bandeja para verificarla.';

  @override
  String get blockPasswordsDoNotMatch => 'Las contraseñas no coinciden.';

  @override
  String get blockCurrentPassword => 'Contraseña actual';

  @override
  String get blockNewPassword => 'Nueva contraseña';

  @override
  String get blockConfirmNewPassword => 'Confirmar la nueva contraseña';

  @override
  String get blockUpdatePassword => 'Actualizar contraseña';

  @override
  String get blockPasswordUpdated => 'Contraseña actualizada.';

  @override
  String get blockPasswordHintChange =>
      'Al menos 8 caracteres. Cambiarla cierra tu sesión en otros lugares.';

  @override
  String get blockUsername => 'Nombre de usuario';

  @override
  String get blockUsernameHint => 'Minúsculas, dígitos y guiones bajos.';

  @override
  String get blockYourAvatar => 'Tu avatar';

  @override
  String get blockUploadImage => 'Subir imagen';

  @override
  String get blockBio => 'Biografía';

  @override
  String get blockBioHint => 'Cuéntanos un poco sobre ti';

  @override
  String get blockBioCounterHint => 'Hasta 160 caracteres.';

  @override
  String get blockProfileSaved => 'Perfil guardado.';

  @override
  String get blockSaveChanges => 'Guardar cambios';

  @override
  String get blockInviteMember => 'Invitar miembro';

  @override
  String get blockRoleAdmin => 'Administrador';

  @override
  String get blockRoleOwner => 'Propietario';

  @override
  String get blockRoleMember => 'Miembro';

  @override
  String get blockTeam => 'Equipo';

  @override
  String get blockProfile => 'Perfil';

  @override
  String get blockSignInWithEmail => 'Iniciar sesión con correo';

  @override
  String get blockSignUp => 'Registrarse';

  @override
  String get blockPickWayYouPrefer => 'Elige el método que prefieras.';

  @override
  String blockContinueWith(Object? provider) => 'Continuar con $provider';

  @override
  String get blockCreating => 'Creando…';

  @override
  String get blockSigningIn => 'Iniciando sesión…';

  @override
  String get blockSending => 'Enviando…';

  @override
  String get blockSaving => 'Guardando…';

  @override
  String get blockPaying => 'Pagando…';

  @override
  String get blockSendResetLink => 'Enviar enlace de restablecimiento';

  @override
  String get blockResetPassword => 'Restablecer contraseña';

  @override
  String get blockResetLinkSent =>
      'Enlace de restablecimiento enviado. Revisa tu bandeja para continuar.';

  @override
  String get blockWeWillEmailReset =>
      'Te enviaremos un enlace de restablecimiento por correo.';

  @override
  String get blockMustAcceptTerms =>
      'Debes aceptar los términos para continuar.';

  @override
  String get blockCheckInbox => 'Revisa tu bandeja';

  @override
  String get blockEnterSixDigitCode =>
      'Introduce el código de 6 dígitos que te enviamos.';

  @override
  String get blockCodeVerifiedSignedIn =>
      'Código verificado. Has iniciado sesión.';

  @override
  String get blockEmailVerifiedSet => 'Correo verificado; todo listo.';

  @override
  String get blockVerifyYourEmail => 'Verifica tu correo';

  @override
  String blockWeSentCodeTo(Object? email) =>
      'Enviamos un código de 6 dígitos a $email.';

  @override
  String get blockDidntGetCode => '¿No recibiste el código?';

  @override
  String get blockBack => 'Atrás';

  @override
  String get blockBackToCart => 'Volver al carrito';

  @override
  String get blockBackToSettings => 'Volver a los ajustes';

  @override
  String get blockOneAccountEverything => 'Una cuenta para todo.';

  @override
  String get blockStartTrialNoCard =>
      'Inicia tu prueba de 14 días. Sin tarjeta de crédito.';

  @override
  String get blockNotifications => 'Notificaciones';

  @override
  String get blockNotifChoose => 'Elige sobre qué quieres saber, y dónde.';

  @override
  String get blockEmailNotifications => 'Notificaciones por correo';

  @override
  String get blockPushNotifications => 'Notificaciones push';

  @override
  String get blockMentionsReplies => 'Menciones y respuestas';

  @override
  String get blockDeliveredToDevices => 'Entregado en tus dispositivos';

  @override
  String blockEmailChannel(Object? channel) => 'Correo · $channel';

  @override
  String blockPushChannel(Object? channel) => 'Push · $channel';

  @override
  String get blockQuietHours => 'Horas de silencio';

  @override
  String get blockWeeklyDigest => 'Resumen semanal';

  @override
  String get blockWeeklyDigestBlurb =>
      'Un correo cada lunes con todo lo ocurrido.';

  @override
  String get blockPreferencesSaved => 'Preferencias guardadas.';

  @override
  String get blockSavePreferences => 'Guardar preferencias';

  @override
  String get blockReset => 'Restablecer';

  @override
  String get blockWelcomeAboard => 'Bienvenido a bordo';

  @override
  String get blockQuickTour => 'Un recorrido rápido antes de usar la app.';

  @override
  String get blockStayInLoop => 'Mantente al día';

  @override
  String get blockMessagesArriveMoment =>
      'Los mensajes y novedades llegan en cuanto ocurren.';

  @override
  String get blockNeverMissThing => 'No te pierdas nada';

  @override
  String get blockNotifPermissionBlurb =>
      'Solo enviamos lo importante: respuestas, recordatorios y alertas de seguridad. Puedes cambiarlo más tarde.';

  @override
  String get blockEnableNotifications => '¿Activar notificaciones?';

  @override
  String get blockAllowNotifications => 'Permitir notificaciones';

  @override
  String get blockAllowNotificationsBlurb =>
      'Permite las notificaciones para aprovechar la app al máximo.';

  @override
  String get blockNotNow => 'Ahora no';

  @override
  String get blockSkip => 'Omitir';

  @override
  String get blockGetStarted => 'Comenzar';

  @override
  String get blockMessages => 'Mensajes';

  @override
  String get blockNoConversations => 'Sin conversaciones';

  @override
  String get blockPullRefreshChat =>
      'Desliza para actualizar o inicia un chat nuevo.';

  @override
  String get blockMute => 'Silenciar';

  @override
  String get blockMuted => 'Silenciado';

  @override
  String get blockAttach => 'Adjuntar';

  @override
  String get blockAttachFile => 'Archivo';

  @override
  String get blockAttachPhoto => 'Foto';

  @override
  String get blockWriteMessage => 'Escribe un mensaje…';

  @override
  String get blockYourCart => 'Tu carrito';

  @override
  String get blockAddSomethingFirst => 'Añade primero algo que te encante.';

  @override
  String get blockCartEmpty => 'El carrito está vacío';

  @override
  String get blockCheckout => 'Pagar';

  @override
  String blockQty(int quantity) => 'Cant. $quantity';

  @override
  String blockPayTotal(Object? amount) => 'Pagar $amount';

  @override
  String get blockPayment => 'Pago';

  @override
  String get blockCardNumber => 'Número de tarjeta';

  @override
  String get blockExpiry => 'Vencimiento';

  @override
  String get blockCvc => 'CVC';

  @override
  String get blockDeliveryAddress => 'Dirección de entrega';

  @override
  String get blockStreet => 'Calle';

  @override
  String get blockCity => 'Ciudad';

  @override
  String get blockSaveAndContinue => 'Guardar y continuar';

  @override
  String get blockOrderPlaced => 'Pedido realizado';

  @override
  String get blockOrderThanks =>
      'Gracias por comprar con nosotros. Una confirmación está en camino.';

  @override
  String get blockContinueShopping => 'Seguir comprando';

  @override
  String get blockSchedule => 'Agenda';

  @override
  String get blockPickDateRangeReport =>
      'Elige un intervalo de fechas para tu informe.';

  @override
  String get blockPickDateRange => 'Elige un intervalo';

  @override
  String get blockTapAnotherDay => 'toca otro día para ampliar el intervalo';

  @override
  String get blockBookMeeting => 'Reservar una reunión';

  @override
  String get blockPickDayTime =>
      'Elige un día y luego una hora que te convenga.';

  @override
  String get blockFourSlots => 'Quedan cuatro huecos de 30 minutos. Elige uno.';

  @override
  String blockPickedSlot(Object? slot) => 'Elegido $slot, 30 minutos.';

  @override
  String get blockOverview => 'Resumen';

  @override
  String get blockRevenueOrdersBlurb =>
      'Ingresos, suscripciones y los pedidos más recientes.';

  @override
  String get blockTotalRevenue => 'Ingresos totales';

  @override
  String get blockSubscriptions => 'Suscripciones';

  @override
  String get blockSales => 'Ventas';

  @override
  String get blockRevenueByMonth => 'Ingresos por mes';

  @override
  String get blockRecentSales => 'Ventas recientes';

  @override
  String get blockViewAll => 'Ver todo';

  @override
  String get blockTransactions => 'Transacciones';

  @override
  String get blockFilterTransactions => 'Filtrar transacciones';

  @override
  String get blockCustomer => 'Cliente';

  @override
  String get blockAmount => 'Importe';

  @override
  String get blockMethod => 'Método';

  @override
  String get blockStatus => 'Estado';

  @override
  String get blockPaid => 'Pagado';

  @override
  String get blockPending => 'Pendiente';

  @override
  String get blockRefunded => 'Reembolsado';

  @override
  String blockNoTransactions(Object? query) =>
      'Ninguna transacción coincide con «$query».';

  @override
  String blockDeltaFromLastMonth(Object? delta) =>
      '$delta respecto al mes pasado';

  @override
  String get blockAnalytics => 'Analíticas';

  @override
  String get blockSessionsDevicesBlurb =>
      'Sesiones, dispositivos y origen del tráfico.';

  @override
  String get blockSearchReports => 'Buscar informes';

  @override
  String get blockLast30Days => 'Últimos 30 días';

  @override
  String get blockAllDevices => 'Todos los dispositivos';

  @override
  String get blockSessions => 'Sesiones';

  @override
  String get blockUsers => 'Usuarios';

  @override
  String get blockAvgSession => 'Sesión prom.';

  @override
  String get blockBounceRate => 'Tasa de rebote';

  @override
  String get blockConversions => 'Conversiones';

  @override
  String get blockByDevice => 'Por dispositivo';

  @override
  String get blockDesktop => 'Escritorio';

  @override
  String get blockMobile => 'Móvil';

  @override
  String get blockTablet => 'Tableta';

  @override
  String get blockDirect => 'Directo';

  @override
  String get blockReferral => 'Referido';

  @override
  String get blockSocial => 'Social';

  @override
  String get blockTrafficSources => 'Fuentes de tráfico';

  @override
  String get blockVisitors => 'Visitantes';

  @override
  String get blockHome => 'Inicio';

  @override
  String get blockInbox => 'Bandeja de entrada';

  @override
  String get blockCalendar => 'Calendario';

  @override
  String get blockCompose => 'Redactar';

  @override
  String get blockMarkAllRead => 'Marcar todo como leído';

  @override
  String get blockStarred => 'Destacados';

  @override
  String get blockSnoozed => 'Pospuestos';

  @override
  String get blockUnread => 'No leídos';

  @override
  String get blockDocuments => 'Documentos';

  @override
  String get blockReports => 'Informes';

  @override
  String get blockDashboard => 'Panel';

  @override
  String get blockStorage => 'Almacenamiento';

  @override
  String get blockNavigation => 'Navegación';

  @override
  String get blockSharedWithYou => 'Compartido contigo';

  @override
  String get blockRecentProjects => 'Proyectos recientes';

  @override
  String get blockStorageUsed => 'Almacenamiento usado';

  @override
  String get blockOpen => 'Abrir';

  @override
  String get blockLive => 'En vivo';

  @override
  String get blockMembers => 'Miembros';

  @override
  String get blockProjects => 'Proyectos';

  @override
  String get blockDeploys => 'Despliegues';

  @override
  String get blockActivity => 'Actividad';

  @override
  String get blockRecentFiles => 'Archivos recientes';

  @override
  String get blockUsageThisMonth => 'Uso de este mes';

  @override
  String get blockUpgradePlan => 'Mejorar plan';

  @override
  String blockNoMatches(Object? query) => 'Sin resultados para «$query».';

  @override
  String get blockWorkspaces => 'Espacios de trabajo';

  @override
  String get blockPricing => 'Precios';

  @override
  String get blockPlansScale => 'Planes que crecen contigo';

  @override
  String get blockPlansBlurb =>
      'Empieza gratis y mejora cuando crezca tu equipo. Cada plan incluye la biblioteca completa de componentes y los ajustes de tema.';

  @override
  String get blockPerUserMonth => 'por usuario al mes';

  @override
  String get blockSubscribe => 'Suscribirse';

  @override
  String get blockContactSales => 'Contactar con ventas';

  @override
  String get blockPromoCode => 'Código promocional';

  @override
  String get blockApplyCode => 'Aplicar código';

  @override
  String get blockHaveCodeEnter => '¿Tienes un código? Introdúcelo abajo.';

  @override
  String get blockCodeAppliedDiscount =>
      'Código aplicado; tu descuento se muestra al pagar.';

  @override
  String get blockFaqTitle => 'Preguntas';

  @override
  String get blockFaqChangePlans => '¿Puedo cambiar de plan más tarde?';

  @override
  String get blockFaqChangePlansAnswer =>
      'Sí. Las mejoras se aplican de inmediato, las reducciones en el próximo ciclo.';

  @override
  String get blockFaqFreeTrial => '¿Hay una prueba gratuita?';

  @override
  String get blockFaqFreeTrialAnswer =>
      'Cada plan empieza con 14 días, sin tarjeta.';

  @override
  String get blockAccount => 'Cuenta';

  @override
  String get blockGeneral => 'General';

  @override
  String get blockAppearance => 'Apariencia';

  @override
  String get blockDarkMode => 'Modo oscuro';

  @override
  String get blockPreferences => 'Preferencias';

  @override
  String get blockSignOut => 'Cerrar sesión';

  @override
  String get blockSignOutConfirm => '¿Cerrar sesión?';

  @override
  String get blockSignOutBlurb => 'Siempre puedes volver a iniciar sesión.';

  @override
  String get blockSounds => 'Sonidos';

  @override
  String get blockWhatYouGet => 'Lo que obtienes';

  @override
  String get blockAllComponentCategories =>
      'Todas las categorías de componentes';

  @override
  String get blockPrioritySupport => 'Soporte prioritario';

  @override
  String get blockUnlimitedProjectsTrial =>
      'Proyectos ilimitados durante la prueba';

  @override
  String get blockTrialDaysLeft => 'Quedan 14 días de prueba';

  @override
  String get blockStarterChat => 'Chat';

  @override
  String get blockStarterShop => 'Tienda';

  @override
  String get blockStarterCart => 'Carrito';

  @override
  String get blockAddToCart => 'Añadir al carrito';
}
