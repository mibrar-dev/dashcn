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
}
