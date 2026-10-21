import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

/// Russian (`ru`) locale data.
///
/// Translations only: anything this table does not override falls
/// through to the English default on [ComponentLocalizations]. Text
/// direction is not handled here - Flutter resolves it from
/// [WidgetsLocalizations] and [Directionality].
class ComponentLocalizationsRu extends ComponentLocalizations {
  /// Creates the Russian strings.
  const ComponentLocalizationsRu([super.locale = const Locale('ru')]);

  /// Formats [value] as a number in this locale, or returns it
  /// verbatim when it is not a number.
  String _number(Object? value) {
    if (value is! num) return '$value';
    return intl.NumberFormat.decimalPattern(localeName).format(value);
  }

  @override
  String get formNotEmpty => 'Это поле не может быть пустым';

  @override
  String get invalidValue => 'Недопустимое значение';

  @override
  String get invalidEmail => 'Недопустимый адрес эл. почты';

  @override
  String get invalidURL => 'Недопустимый URL';

  @override
  String formLessThan(Object? value) => 'Должно быть меньше ${_number(value)}';

  @override
  String formGreaterThan(Object? value) =>
      'Должно быть больше ${_number(value)}';

  @override
  String formLessThanOrEqualTo(Object? value) =>
      'Должно быть меньше или равно ${_number(value)}';

  @override
  String get formPhoneNumberInvalid => 'Недопустимый номер телефона';

  @override
  String get formPhoneNumberEmpty => 'Укажите номер телефона';

  @override
  String formGreaterThanOrEqualTo(Object? value) =>
      'Должно быть больше или равно ${_number(value)}';

  @override
  String formBetweenInclusively(Object? min, Object? max) =>
      'Должно быть от ${_number(min)} до ${_number(max)} (включительно)';

  @override
  String formEqualTo(Object? value) => 'Должно быть равно ${_number(value)}';

  @override
  String formBetweenExclusively(Object? min, Object? max) =>
      'Должно быть между ${_number(min)} и ${_number(max)} (не включая границы)';

  @override
  String formLengthLessThan(int limit) =>
      'Должно содержать не менее $limit символов';

  @override
  String formLengthGreaterThan(int limit) =>
      'Должно содержать не более $limit символов';

  @override
  String get formPasswordDigits => 'Должно содержать хотя бы одну цифру';

  @override
  String get formPasswordLowercase =>
      'Должно содержать хотя бы одну строчную букву';

  @override
  String get formPasswordUppercase =>
      'Должно содержать хотя бы одну заглавную букву';

  @override
  String get formPasswordSpecial =>
      'Должно содержать хотя бы один специальный символ';

  @override
  String get commandSearch => 'Введите команду или запрос...';

  @override
  String get commandEmpty => 'Ничего не найдено.';

  @override
  String get datePickerSelectYear => 'Выберите год';

  @override
  String get abbreviatedMonday => 'Пн';

  @override
  String get abbreviatedTuesday => 'Вт';

  @override
  String get abbreviatedWednesday => 'Ср';

  @override
  String get abbreviatedThursday => 'Чт';

  @override
  String get abbreviatedFriday => 'Пт';

  @override
  String get abbreviatedSaturday => 'Сб';

  @override
  String get abbreviatedSunday => 'Вс';

  @override
  String get monthJanuary => 'Январь';

  @override
  String get monthFebruary => 'Февраль';

  @override
  String get monthMarch => 'Март';

  @override
  String get monthApril => 'Апрель';

  @override
  String get monthMay => 'Май';

  @override
  String get monthJune => 'Июнь';

  @override
  String get monthJuly => 'Июль';

  @override
  String get monthAugust => 'Август';

  @override
  String get monthSeptember => 'Сентябрь';

  @override
  String get monthOctober => 'Октябрь';

  @override
  String get monthNovember => 'Ноябрь';

  @override
  String get monthDecember => 'Декабрь';

  @override
  String get abbreviatedJanuary => 'янв.';

  @override
  String get abbreviatedFebruary => 'февр.';

  @override
  String get abbreviatedMarch => 'март';

  @override
  String get abbreviatedApril => 'апр.';

  @override
  String get abbreviatedMay => 'май';

  @override
  String get abbreviatedJune => 'июнь';

  @override
  String get abbreviatedJuly => 'июль';

  @override
  String get abbreviatedAugust => 'авг.';

  @override
  String get abbreviatedSeptember => 'сент.';

  @override
  String get abbreviatedOctober => 'окт.';

  @override
  String get abbreviatedNovember => 'нояб.';

  @override
  String get abbreviatedDecember => 'дек.';

  @override
  String get dialogDismiss => 'Закрыть';

  @override
  String get chipInputRemoveChip => 'Удалить';

  @override
  String get buttonCancel => 'Отмена';

  @override
  String get buttonSave => 'Сохранить';

  @override
  String get timeHour => 'Час';

  @override
  String get timeMinute => 'Минута';

  @override
  String get timeSecond => 'Секунда';

  @override
  String get timeAM => 'AM';

  @override
  String get timePM => 'PM';

  @override
  String get colorRed => 'Красный';

  @override
  String get colorGreen => 'Зелёный';

  @override
  String get colorBlue => 'Синий';

  @override
  String get colorAlpha => 'Альфа';

  @override
  String get colorHue => 'Оттенок';

  @override
  String get colorSaturation => 'Нас';

  @override
  String get colorValue => 'Ярк';

  @override
  String get colorLightness => 'Свет';

  @override
  String get menuCut => 'Вырезать';

  @override
  String get menuCopy => 'Копировать';

  @override
  String get menuPaste => 'Вставить';

  @override
  String get menuSelectAll => 'Выбрать всё';

  @override
  String get menuUndo => 'Отменить';

  @override
  String get menuRedo => 'Повторить';

  @override
  String get menuDelete => 'Удалить';

  @override
  String get menuShare => 'Поделиться';

  @override
  String get menuSearchWeb => 'Искать в интернете';

  @override
  String get menuLiveTextInput => 'Живой текст';

  @override
  String get placeholderDatePicker => 'Выберите дату';

  @override
  String get placeholderTimePicker => 'Выберите время';

  @override
  String get placeholderColorPicker => 'Выберите цвет';

  @override
  String get buttonPrevious => 'Назад';

  @override
  String get buttonNext => 'Далее';

  @override
  String get refreshTriggerPull => 'Потяните для обновления';

  @override
  String get refreshTriggerRelease => 'Отпустите для обновления';

  @override
  String get refreshTriggerRefreshing => 'Обновление...';

  @override
  String get refreshTriggerComplete => 'Обновление завершено';

  @override
  String get colorPickerTabRGB => 'RGB';

  @override
  String get colorPickerTabHSV => 'HSV';

  @override
  String get colorPickerTabHSL => 'HSL';

  @override
  String get colorPickerTabHEX => 'HEX';

  @override
  String get commandMoveUp => 'Вверх';

  @override
  String get commandMoveDown => 'Вниз';

  @override
  String get commandActivate => 'Выбрать';

  @override
  String get timeDaysAbbreviation => 'ДД';

  @override
  String get timeHoursAbbreviation => 'ЧЧ';

  @override
  String get timeMinutesAbbreviation => 'ММ';

  @override
  String get timeSecondsAbbreviation => 'СС';

  @override
  String get placeholderDurationPicker => 'Выберите продолжительность';

  @override
  String get durationDay => 'День';

  @override
  String get durationHour => 'Час';

  @override
  String get durationMinute => 'Минута';

  @override
  String get durationSecond => 'Секунда';

  @override
  String get dropzoneIdle => 'Выберите файлы для загрузки';

  @override
  String get dropzoneDragging => 'Перетащите файлы для загрузки';

  @override
  String get dropzoneUploading => 'Загрузка файлов...';

  @override
  String get dropzoneSuccess => 'Файлы готовы';

  @override
  String get dropzoneError => 'Исправьте ошибки, чтобы продолжить';

  @override
  String get dropzoneDisabled => 'Загрузка файлов отключена';

  @override
  String get dropzoneBrowse => 'Выбрать файлы';

  @override
  String get emptyStateEmptyTitle => 'Здесь пока ничего нет';

  @override
  String get emptyStateEmptyDescription =>
      'Создайте первый элемент, чтобы начать.';

  @override
  String get emptyStateNoResultsTitle => 'Ничего не найдено';

  @override
  String get emptyStateNoResultsDescription =>
      'Попробуйте изменить фильтры или поисковый запрос.';

  @override
  String get emptyStateErrorTitle => 'Что-то пошло не так';

  @override
  String get emptyStateErrorDescription =>
      'Не удалось загрузить эти данные. Повторите попытку чуть позже.';

  @override
  String get filterSearch => 'Поиск';

  @override
  String get filterSort => 'Сортировка';

  @override
  String get filterDateRange => 'Диапазон дат';

  @override
  String get filterClearAll => 'Очистить всё';

  @override
  String get filterFilters => 'Фильтры';

  @override
  String filterActiveCount(int count) => 'Активных фильтров: ${_number(count)}';

  @override
  String filterResultsCount(int count) => 'Результатов: ${_number(count)}';

  @override
  String get fileUploadChoose => 'Выбрать файл';

  @override
  String get fileUploadNoFile => 'Файл не выбран';

  @override
  String get fileUploadPickFailed => 'Не удалось выбрать файл.';

  @override
  String get fileUploadTooMany => 'Выбрано слишком много файлов.';

  @override
  String get fileUploadTooLarge => 'Файл слишком большой.';

  @override
  String get fileUploadInvalidType => 'Этот тип файлов запрещён.';

  @override
  String get fileUploadUploadFailed => 'Загрузка не удалась.';

  @override
  String fileUploadUploadFailedFor(String name) =>
      'Не удалось загрузить $name.';

  @override
  String get fileUploadStatusQueued => 'В очереди';

  @override
  String get fileUploadStatusUploading => 'Загрузка';

  @override
  String get fileUploadStatusCompleted => 'Завершено';

  @override
  String get fileUploadStatusFailed => 'Ошибка';

  @override
  String get fileUploadUnknownType => 'Файл';

  @override
  String get fileUploadRemove => 'Удалить файл';

  @override
  String get fileUploadRetry => 'Повторить загрузку';

  @override
  String get fileUploadPreview => 'Предпросмотр файла';

  @override
  String get fileUploadDownload => 'Скачать файл';

  @override
  String get errorSomethingWentWrong => 'Что-то пошло не так';

  @override
  String get errorUnexpectedMessage =>
      'Повторите попытку или обратитесь в поддержку, если проблема сохранится.';

  @override
  String get errorActionRetry => 'Повторить';

  @override
  String get errorActionReport => 'Пожаловаться';

  @override
  String get errorActionBack => 'Назад';

  @override
  String get errorActionLogin => 'Войти';

  @override
  String get errorActionSettings => 'Настройки';

  @override
  String get errorActionContactSupport => 'Связаться с поддержкой';

  @override
  String get errorBadRequest => 'Некорректный запрос';

  @override
  String get errorBadRequestMessage =>
      'Запрос некорректен. Проверьте его и повторите попытку.';

  @override
  String get errorUnauthorized => 'Нет доступа';

  @override
  String get errorLoginRequiredMessage => 'Войдите, чтобы продолжить.';

  @override
  String get errorAccessDenied => 'Доступ запрещён';

  @override
  String get errorAccessDeniedMessage =>
      'У вас нет прав для выполнения этого действия.';

  @override
  String get errorNotFound => 'Не найдено';

  @override
  String get errorNotFoundMessage => 'Мы не смогли найти то, что вы искали.';

  @override
  String get errorConflict => 'Конфликт';

  @override
  String get errorConflictMessage =>
      'Это действие противоречит существующим данным.';

  @override
  String get errorInvalidData => 'Некорректные данные';

  @override
  String get errorInvalidDataMessage =>
      'Некоторые поля требуют вашего внимания.';

  @override
  String get errorTooManyRequests => 'Слишком много запросов';

  @override
  String get errorTooManyRequestsMessage =>
      'Подождите немного и повторите попытку.';

  @override
  String get errorServerError => 'Ошибка сервера';

  @override
  String get errorServerErrorMessage =>
      'На сервере возникла проблема. Повторите попытку.';

  @override
  String get errorRequestTimedOut => 'Время ожидания истекло';

  @override
  String get errorRequestTimedOutMessage => 'Сервер слишком долго отвечает.';

  @override
  String get errorAuthenticationRequired => 'Требуется аутентификация';

  @override
  String get errorInvalidInput => 'Некорректный ввод';

  @override
  String get errorReviewFieldsMessage => 'Проверьте выделенные поля.';

  @override
  String get errorPlatformError => 'Ошибка платформы';

  @override
  String get errorDeviceErrorMessage =>
      'Что-то пошло не так на этом устройстве.';

  @override
  String get errorConnectionFailed => 'Ошибка соединения';

  @override
  String get errorConnectionFailedMessage =>
      'Проверьте подключение к интернету и повторите попытку.';

  @override
  String get errorSecureConnectionFailed => 'Ошибка защищённого соединения';

  @override
  String get errorSecureConnectionMessage =>
      'Не удалось установить защищённое соединение.';

  @override
  String get tableResizeColumn => 'Изменить размер столбца';

  @override
  String get tableResizeRow => 'Изменить размер строки';

  @override
  String get resizableHandle => 'Маркер изменения размера';

  @override
  String get spellCheckNoSuggestions => 'Нет предложений';

  @override
  String get announcementLoading => 'Загрузка';

  @override
  String get announcementSuccess => 'Готово';

  @override
  String get announcementFailure => 'Ошибка';

  @override
  String get toolbarMore => 'Ещё';

  @override
  String get toolbarMoreActions => 'Другие действия';

  @override
  String get treeCollapse => 'Свернуть';

  @override
  String get treeExpand => 'Развернуть';

  @override
  String get markdownDetails => 'Подробности';

  @override
  String get carouselLabel => 'Рекомендуемая карусель';

  @override
  String get carouselPrimaryAction => 'Добавить в чат';

  @override
  String carouselItemPreview(Object? title) =>
      'Рекомендуемый предпросмотр: ${title ?? mediaUntitled}';

  @override
  String carouselPageOf(int position, int length) =>
      'Страница ${_number(position)} из ${_number(length)}';

  @override
  String stepperStep(int index) => 'Шаг ${_number(index + 1)}';

  @override
  String paginationPage(Object? page) => 'Страница ${_number(page)}';

  @override
  String chartSeriesDefault(int index) => 'Ряд ${_number(index + 1)}';

  @override
  String chartSliceDefault(int index) => 'Сегмент ${_number(index)}';

  @override
  String chartCategoryDefault(int index) => 'Категория ${_number(index)}';

  @override
  String get chartValueDefault => 'Значение';

  @override
  String get chartKindLine => 'Линия';

  @override
  String get chartKindArea => 'Область';

  @override
  String get chartKindBar => 'Столбцы';

  @override
  String get chartKindDonut => 'Кольцо';

  @override
  String get chartKindPie => 'Круг';

  @override
  String get chartKindSparkline => 'Спарклайн';

  @override
  String get chartKindScatter => 'Рассеяние';

  @override
  String get chartKindRadar => 'Радар';

  @override
  String get chartKindRadial => 'Радиальный';

  @override
  String chartSummaryEmpty(Object? kind) => 'Диаграмма $kind без данных';

  @override
  String chartSummary(int series, int points, Object? kind) =>
      'Диаграмма $kind: ${_number(series)} рядов, ${_number(points)} точек';

  @override
  String get colorFieldHsv => 'Поле цвета HSV';

  @override
  String get colorFieldHsl => 'Поле цвета HSL';

  @override
  String get actionClear => 'Очистить';

  @override
  String get actionApply => 'Применить';

  @override
  String get actionVerify => 'Подтвердить';

  @override
  String get actionResend => 'Отправить снова';

  @override
  String resendInSeconds(int seconds) =>
      'Отправить снова через ${_number(seconds)} с';

  @override
  String get authCode => 'Код';

  @override
  String get authEmail => 'Почта';

  @override
  String get authPassword => 'Пароль';

  @override
  String get authName => 'Имя';

  @override
  String get authSignIn => 'Войти';

  @override
  String get authForgotPassword => 'Забыли пароль?';

  @override
  String get authRememberMe => 'Запомнить меня';

  @override
  String get authCreateAccount => 'Создать аккаунт';

  @override
  String get actionClose => 'Закрыть';

  @override
  String get mediaPlay => 'Играть';

  @override
  String get mediaPause => 'Пауза';

  @override
  String get mediaMute => 'Без звука';

  @override
  String get mediaUnmute => 'Со звуком';

  @override
  String get mediaVolume => 'Громкость';

  @override
  String get mediaSeek => 'Перемотка';

  @override
  String get mediaDownload => 'Скачать';

  @override
  String get mediaAudioPlayer => 'Аудиоплеер';

  @override
  String get mediaVideoPlayer => 'Видеоплеер';

  @override
  String get mediaUntitled => 'Без названия';

  @override
  String get mediaPlaybackFailed => 'Не удалось воспроизвести';

  @override
  String get mediaPreviousTrack => 'Предыдущий трек';

  @override
  String get mediaNextTrack => 'Следующий трек';

  @override
  String get mediaShuffleDisable => 'Выключить перемешивание';

  @override
  String get mediaShuffleEnable => 'Включить перемешивание';

  @override
  String get mediaRepeatDisable => 'Выключить повтор';

  @override
  String get mediaRepeatEnable => 'Включить повтор';

  @override
  String mediaPlaybackSpeed(Object? speed) =>
      'Скорость: ${speed}x, нажмите чтобы изменить';

  @override
  String mediaPositionOf(Object position, Object duration) =>
      '$position из $duration';

  @override
  String mediaHours(int count) => count == 1 ? '1 час' : '${_number(count)} ч';

  @override
  String mediaMinutes(int count) =>
      count == 1 ? '1 минута' : '${_number(count)} мин';

  @override
  String mediaSeconds(int count) =>
      count == 1 ? '1 секунда' : '${_number(count)} с';

  @override
  String get signaturePadLabel => 'Поле подписи';

  @override
  String get qrCodeLabel => 'QR-код';

  @override
  String get marqueeContent => 'Бегущая строка';

  @override
  String mediaSkipBack(int seconds) => 'Назад на ${_number(seconds)} с';

  @override
  String mediaSkipForward(int seconds) => 'Вперёд на ${_number(seconds)} с';

  @override
  String get mediaCaptionsShow => 'Показать субтитры';

  @override
  String get mediaCaptionsHide => 'Скрыть субтитры';

  @override
  String get mediaCaptionsOn => 'Субтитры включены';

  @override
  String get mediaCaptionsOff => 'Субтитры выключены';

  @override
  String get mediaFullscreen => 'Полный экран';

  @override
  String mediaMoreOptionsSpeed(Object? speed) =>
      'Другие параметры, скорость: ${speed}x';

  @override
  String mediaSpeed(Object? speed) => 'Скорость: ${speed}x';

  @override
  String get actionStartTrial => 'Начать пробный период';

  @override
  String get authFirstName => 'Имя';

  @override
  String get authLastName => 'Фамилия';

  @override
  String get authPasswordHint => 'Минимум 8 символов.';

  @override
  String get authUseDifferentEmail => 'Использовать другой адрес эл. почты';

  @override
  String get authWorkEmail => 'Рабочая эл. почта';

  @override
  String get chartTotalLabel => 'Итого';

  @override
  String get mediaQualityAuto => 'Качество: Авто';
}
