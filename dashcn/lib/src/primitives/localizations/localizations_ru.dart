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

  @override
  String get blockDontHaveAccount => 'Нет учётной записи?';

  @override
  String get blockAlreadyHaveAccount => 'Уже есть учётная запись?';

  @override
  String get blockNoAccountYet => 'Ещё нет учётной записи?';

  @override
  String get blockHaveAnAccount => 'Есть учётная запись?';

  @override
  String get blockCreateOne => 'Создать';

  @override
  String get blockCreateAccount => 'Создать учётную запись';

  @override
  String get blockCreateYourAccount => 'Создайте учётную запись';

  @override
  String get blockForgotYourPassword => 'Забыли пароль?';

  @override
  String get blockBackToSignIn => 'Назад ко входу';

  @override
  String get blockEnterCredentialsWorkspace =>
      'Введите учётные данные для доступа к рабочей области.';

  @override
  String get blockEnterCredentialsContinue =>
      'Введите учётные данные, чтобы продолжить.';

  @override
  String get blockEnterDetailsContinue =>
      'Введите данные ниже, чтобы продолжить.';

  @override
  String get blockEnterEmailCreateAccount =>
      'Введите адрес электронной почты, чтобы создать учётную запись.';

  @override
  String get blockSignedInWelcomeBack => 'Вход выполнен — с возвращением.';

  @override
  String get blockAccountCreatedVerify =>
      'Учётная запись создана — проверьте входящие, чтобы подтвердить её.';

  @override
  String get blockTrialStartedVerify =>
      'Пробный период начат — проверьте входящие, чтобы подтвердить его.';

  @override
  String get blockPasswordsDoNotMatch => 'Пароли не совпадают.';

  @override
  String get blockCurrentPassword => 'Текущий пароль';

  @override
  String get blockNewPassword => 'Новый пароль';

  @override
  String get blockConfirmNewPassword => 'Подтвердите новый пароль';

  @override
  String get blockUpdatePassword => 'Обновить пароль';

  @override
  String get blockPasswordUpdated => 'Пароль обновлён.';

  @override
  String get blockPasswordHintChange =>
      'Минимум 8 символов. Изменение завершит сеансы в других местах.';

  @override
  String get blockUsername => 'Имя пользователя';

  @override
  String get blockUsernameHint => 'Строчные буквы, цифры, подчёркивания.';

  @override
  String get blockYourAvatar => 'Ваш аватар';

  @override
  String get blockUploadImage => 'Загрузить изображение';

  @override
  String get blockBio => 'О себе';

  @override
  String get blockBioHint => 'Расскажите немного о себе';

  @override
  String get blockBioCounterHint => 'До 160 символов.';

  @override
  String get blockProfileSaved => 'Профиль сохранён.';

  @override
  String get blockSaveChanges => 'Сохранить изменения';

  @override
  String get blockInviteMember => 'Пригласить участника';

  @override
  String get blockRoleAdmin => 'Администратор';

  @override
  String get blockRoleOwner => 'Владелец';

  @override
  String get blockRoleMember => 'Участник';

  @override
  String get blockTeam => 'Команда';

  @override
  String get blockProfile => 'Профиль';

  @override
  String get blockSignInWithEmail => 'Войти с помощью почты';

  @override
  String get blockSignUp => 'Зарегистрироваться';

  @override
  String get blockPickWayYouPrefer => 'Выберите удобный способ.';

  @override
  String blockContinueWith(Object? provider) => 'Продолжить с $provider';

  @override
  String get blockCreating => 'Создание…';

  @override
  String get blockSigningIn => 'Выполняется вход…';

  @override
  String get blockSending => 'Отправка…';

  @override
  String get blockSaving => 'Сохранение…';

  @override
  String get blockPaying => 'Оплата…';

  @override
  String get blockSendResetLink => 'Отправить ссылку для сброса';

  @override
  String get blockResetPassword => 'Сбросить пароль';

  @override
  String get blockResetLinkSent =>
      'Ссылка для сброса отправлена. Проверьте входящие, чтобы продолжить.';

  @override
  String get blockWeWillEmailReset =>
      'Мы отправим вам ссылку для сброса по почте.';

  @override
  String get blockMustAcceptTerms => 'Чтобы продолжить, примите условия.';

  @override
  String get blockCheckInbox => 'Проверьте входящие';

  @override
  String get blockEnterSixDigitCode =>
      'Введите отправленный вам 6-значный код.';

  @override
  String get blockCodeVerifiedSignedIn =>
      'Код подтверждён. Вы вошли в систему.';

  @override
  String get blockEmailVerifiedSet => 'Почта подтверждена — всё готово.';

  @override
  String get blockVerifyYourEmail => 'Подтвердите почту';

  @override
  String blockWeSentCodeTo(Object? email) =>
      'Мы отправили 6-значный код на адрес $email.';

  @override
  String get blockDidntGetCode => 'Не получили код?';

  @override
  String get blockBack => 'Назад';

  @override
  String get blockBackToCart => 'Назад в корзину';

  @override
  String get blockBackToSettings => 'Назад к настройкам';

  @override
  String get blockOneAccountEverything => 'Одна учётная запись для всего.';

  @override
  String get blockStartTrialNoCard =>
      'Начните 14-дневный пробный период. Карта не нужна.';

  @override
  String get blockNotifications => 'Уведомления';

  @override
  String get blockNotifChoose => 'Выберите, о чём и где хотите узнавать.';

  @override
  String get blockEmailNotifications => 'Уведомления по почте';

  @override
  String get blockPushNotifications => 'Push-уведомления';

  @override
  String get blockMentionsReplies => 'Упоминания и ответы';

  @override
  String get blockDeliveredToDevices => 'Доставлено на ваши устройства';

  @override
  String blockEmailChannel(Object? channel) => 'Почта · $channel';

  @override
  String blockPushChannel(Object? channel) => 'Push · $channel';

  @override
  String get blockQuietHours => 'Тихие часы';

  @override
  String get blockWeeklyDigest => 'Еженедельная сводка';

  @override
  String get blockWeeklyDigestBlurb =>
      'Одно письмо каждый понедельник обо всём произошедшем.';

  @override
  String get blockPreferencesSaved => 'Настройки сохранены.';

  @override
  String get blockSavePreferences => 'Сохранить настройки';

  @override
  String get blockReset => 'Сбросить';

  @override
  String get blockWelcomeAboard => 'Добро пожаловать';

  @override
  String get blockQuickTour =>
      'Краткий обзор перед началом использования приложения.';

  @override
  String get blockStayInLoop => 'Будьте в курсе';

  @override
  String get blockMessagesArriveMoment =>
      'Сообщения и обновления приходят в момент их появления.';

  @override
  String get blockNeverMissThing => 'Ничего не пропускайте';

  @override
  String get blockNotifPermissionBlurb =>
      'Отправляем только важное: ответы, напоминания и оповещения безопасности. Позже можно изменить.';

  @override
  String get blockEnableNotifications => 'Включить уведомления?';

  @override
  String get blockAllowNotifications => 'Разрешить уведомления';

  @override
  String get blockAllowNotificationsBlurb =>
      'Разрешите уведомления, чтобы использовать приложение по максимуму.';

  @override
  String get blockNotNow => 'Не сейчас';

  @override
  String get blockSkip => 'Пропустить';

  @override
  String get blockGetStarted => 'Начать';

  @override
  String get blockMessages => 'Сообщения';

  @override
  String get blockNoConversations => 'Нет бесед';

  @override
  String get blockPullRefreshChat =>
      'Потяните, чтобы обновить, или начните новый чат.';

  @override
  String get blockMute => 'Заглушить';

  @override
  String get blockMuted => 'Заглушено';

  @override
  String get blockAttach => 'Прикрепить';

  @override
  String get blockAttachFile => 'Файл';

  @override
  String get blockAttachPhoto => 'Фото';

  @override
  String get blockWriteMessage => 'Напишите сообщение…';

  @override
  String get blockYourCart => 'Ваша корзина';

  @override
  String get blockAddSomethingFirst => 'Сначала добавьте что-нибудь любимое.';

  @override
  String get blockCartEmpty => 'Корзина пуста';

  @override
  String get blockCheckout => 'Оформление заказа';

  @override
  String blockQty(int quantity) => 'Кол-во $quantity';

  @override
  String blockPayTotal(Object? amount) => 'Оплатить $amount';

  @override
  String get blockPayment => 'Оплата';

  @override
  String get blockCardNumber => 'Номер карты';

  @override
  String get blockExpiry => 'Срок действия';

  @override
  String get blockCvc => 'CVC';

  @override
  String get blockDeliveryAddress => 'Адрес доставки';

  @override
  String get blockStreet => 'Улица';

  @override
  String get blockCity => 'Город';

  @override
  String get blockSaveAndContinue => 'Сохранить и продолжить';

  @override
  String get blockOrderPlaced => 'Заказ оформлен';

  @override
  String get blockOrderThanks =>
      'Спасибо за покупку. Подтверждение уже в пути.';

  @override
  String get blockContinueShopping => 'Продолжить покупки';

  @override
  String get blockSchedule => 'Расписание';

  @override
  String get blockPickDateRangeReport => 'Выберите диапазон дат для отчёта.';

  @override
  String get blockPickDateRange => 'Выбрать диапазон дат';

  @override
  String get blockTapAnotherDay =>
      'коснитесь другого дня, чтобы расширить диапазон';

  @override
  String get blockBookMeeting => 'Забронировать встречу';

  @override
  String get blockPickDayTime => 'Выберите день, затем подходящее время.';

  @override
  String get blockFourSlots =>
      'Осталось четыре окна по 30 минут. Выберите одно.';

  @override
  String blockPickedSlot(Object? slot) => 'Выбрано $slot, 30 минут.';

  @override
  String get blockOverview => 'Обзор';

  @override
  String get blockRevenueOrdersBlurb => 'Выручка, подписки и последние заказы.';

  @override
  String get blockTotalRevenue => 'Общая выручка';

  @override
  String get blockSubscriptions => 'Подписки';

  @override
  String get blockSales => 'Продажи';

  @override
  String get blockRevenueByMonth => 'Выручка по месяцам';

  @override
  String get blockRecentSales => 'Недавние продажи';

  @override
  String get blockViewAll => 'Показать всё';

  @override
  String get blockTransactions => 'Транзакции';

  @override
  String get blockFilterTransactions => 'Фильтровать транзакции';

  @override
  String get blockCustomer => 'Клиент';

  @override
  String get blockAmount => 'Сумма';

  @override
  String get blockMethod => 'Способ';

  @override
  String get blockStatus => 'Статус';

  @override
  String get blockPaid => 'Оплачено';

  @override
  String get blockPending => 'В ожидании';

  @override
  String get blockRefunded => 'Возвращено';

  @override
  String blockNoTransactions(Object? query) =>
      'Нет транзакций, соответствующих "$query".';

  @override
  String blockDeltaFromLastMonth(Object? delta) => '$delta к прошлому месяцу';

  @override
  String get blockAnalytics => 'Аналитика';

  @override
  String get blockSessionsDevicesBlurb =>
      'Сеансы, устройства и источники трафика.';

  @override
  String get blockSearchReports => 'Поиск по отчётам';

  @override
  String get blockLast30Days => 'Последние 30 дней';

  @override
  String get blockAllDevices => 'Все устройства';

  @override
  String get blockSessions => 'Сеансы';

  @override
  String get blockUsers => 'Пользователи';

  @override
  String get blockAvgSession => 'Ср. сеанс';

  @override
  String get blockBounceRate => 'Показатель отказов';

  @override
  String get blockConversions => 'Конверсии';

  @override
  String get blockByDevice => 'По устройствам';

  @override
  String get blockDesktop => 'ПК';

  @override
  String get blockMobile => 'Мобильные';

  @override
  String get blockTablet => 'Планшет';

  @override
  String get blockDirect => 'Прямой';

  @override
  String get blockReferral => 'Переход';

  @override
  String get blockSocial => 'Соцсети';

  @override
  String get blockTrafficSources => 'Источники трафика';

  @override
  String get blockVisitors => 'Посетители';

  @override
  String get blockHome => 'Главная';

  @override
  String get blockInbox => 'Входящие';

  @override
  String get blockCalendar => 'Календарь';

  @override
  String get blockCompose => 'Написать';

  @override
  String get blockMarkAllRead => 'Отметить всё прочитанным';

  @override
  String get blockStarred => 'Помеченные';

  @override
  String get blockSnoozed => 'Отложенные';

  @override
  String get blockUnread => 'Непрочитанные';

  @override
  String get blockDocuments => 'Документы';

  @override
  String get blockReports => 'Отчёты';

  @override
  String get blockDashboard => 'Панель';

  @override
  String get blockStorage => 'Хранилище';

  @override
  String get blockNavigation => 'Навигация';

  @override
  String get blockSharedWithYou => 'Доступно вам';

  @override
  String get blockRecentProjects => 'Недавние проекты';

  @override
  String get blockStorageUsed => 'Занято места';

  @override
  String get blockOpen => 'Открыть';

  @override
  String get blockLive => 'Вживую';

  @override
  String get blockMembers => 'Участники';

  @override
  String get blockProjects => 'Проекты';

  @override
  String get blockDeploys => 'Развёртывания';

  @override
  String get blockActivity => 'Активность';

  @override
  String get blockRecentFiles => 'Недавние файлы';

  @override
  String get blockUsageThisMonth => 'Использование за месяц';

  @override
  String get blockUpgradePlan => 'Улучшить тариф';

  @override
  String blockNoMatches(Object? query) => 'Нет совпадений для "$query".';

  @override
  String get blockWorkspaces => 'Рабочие области';

  @override
  String get blockPricing => 'Тарифы';

  @override
  String get blockPlansScale => 'Тарифы, которые растут вместе с вами';

  @override
  String get blockPlansBlurb =>
      'Начните бесплатно и улучшайте тариф по мере роста команды. Каждый тариф включает полную библиотеку компонентов и пресеты темы.';

  @override
  String get blockPerUserMonth => 'за пользователя в месяц';

  @override
  String get blockSubscribe => 'Подписаться';

  @override
  String get blockContactSales => 'Связаться с отделом продаж';

  @override
  String get blockPromoCode => 'Промокод';

  @override
  String get blockApplyCode => 'Применить код';

  @override
  String get blockHaveCodeEnter => 'Есть код? Введите его ниже.';

  @override
  String get blockCodeAppliedDiscount =>
      'Код применён — скидка отобразится при оформлении.';

  @override
  String get blockFaqTitle => 'Вопросы';

  @override
  String get blockFaqChangePlans => 'Можно ли сменить тариф позже?';

  @override
  String get blockFaqChangePlansAnswer =>
      'Да. Улучшения действуют сразу, понижения — со следующего цикла.';

  @override
  String get blockFaqFreeTrial => 'Есть ли бесплатный пробный период?';

  @override
  String get blockFaqFreeTrialAnswer =>
      'Каждый тариф начинается с 14 дней, карта не нужна.';

  @override
  String get blockAccount => 'Учётная запись';

  @override
  String get blockGeneral => 'Общие';

  @override
  String get blockAppearance => 'Оформление';

  @override
  String get blockDarkMode => 'Тёмная тема';

  @override
  String get blockPreferences => 'Настройки';

  @override
  String get blockSignOut => 'Выйти';

  @override
  String get blockSignOutConfirm => 'Выйти?';

  @override
  String get blockSignOutBlurb => 'Вы всегда сможете войти снова.';

  @override
  String get blockSounds => 'Звуки';

  @override
  String get blockWhatYouGet => 'Что вы получаете';

  @override
  String get blockAllComponentCategories => 'Все категории компонентов';

  @override
  String get blockPrioritySupport => 'Приоритетная поддержка';

  @override
  String get blockUnlimitedProjectsTrial =>
      'Безлимитные проекты во время пробного периода';

  @override
  String get blockTrialDaysLeft => 'Осталось 14 дней пробного периода';

  @override
  String get blockStarterChat => 'Чат';

  @override
  String get blockStarterShop => 'Магазин';

  @override
  String get blockStarterCart => 'Корзина';

  @override
  String get blockAddToCart => 'В корзину';
}
