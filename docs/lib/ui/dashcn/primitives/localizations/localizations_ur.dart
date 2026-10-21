import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

/// Urdu (`ur`) locale data.
///
/// Translations only: anything this table does not override falls
/// through to the English default on [ComponentLocalizations]. Text
/// direction is not handled here - Flutter resolves it from
/// [WidgetsLocalizations] and [Directionality].
class ComponentLocalizationsUr extends ComponentLocalizations {
  /// Creates the Urdu strings.
  const ComponentLocalizationsUr([super.locale = const Locale('ur')]);

  /// Formats [value] as a number in this locale, or returns it
  /// verbatim when it is not a number.
  String _number(Object? value) {
    if (value is! num) return '$value';
    return intl.NumberFormat.decimalPattern(localeName).format(value);
  }

  @override
  String get formNotEmpty => 'یہ خانہ خالی نہیں ہو سکتا';

  @override
  String get invalidValue => 'غلط قدر';

  @override
  String get invalidEmail => 'غلط ای میل';

  @override
  String get invalidURL => 'غلط URL';

  @override
  String formLessThan(Object? value) => '${_number(value)} سے کم ہونا چاہیے';

  @override
  String formGreaterThan(Object? value) =>
      '${_number(value)} سے زیادہ ہونا چاہیے';

  @override
  String formLessThanOrEqualTo(Object? value) =>
      '${_number(value)} سے کم یا اس کے برابر ہونا چاہیے';

  @override
  String get formPhoneNumberInvalid => 'فون نمبر غلط ہے';

  @override
  String get formPhoneNumberEmpty => 'فون نمبر درکار ہے';

  @override
  String formGreaterThanOrEqualTo(Object? value) =>
      '${_number(value)} سے زیادہ یا اس کے برابر ہونا چاہیے';

  @override
  String formBetweenInclusively(Object? min, Object? max) =>
      '${_number(min)} اور ${_number(max)} کے درمیان ہونا چاہیے (شامل)';

  @override
  String formEqualTo(Object? value) => '${_number(value)} کے برابر ہونا چاہیے';

  @override
  String formBetweenExclusively(Object? min, Object? max) =>
      '${_number(min)} اور ${_number(max)} کے درمیان ہونا چاہیے (غیر شامل)';

  @override
  String formLengthLessThan(int limit) => 'کم از کم $limit حروف ہونے چاہئیں';

  @override
  String formLengthGreaterThan(int limit) =>
      'زیادہ سے زیادہ $limit حروف ہونے چاہئیں';

  @override
  String get formPasswordDigits => 'کم از کم ایک ہندسہ ہونا چاہیے';

  @override
  String get formPasswordLowercase => 'کم از کم ایک چھوٹا حرف ہونا چاہیے';

  @override
  String get formPasswordUppercase => 'کم از کم ایک بڑا حرف ہونا چاہیے';

  @override
  String get formPasswordSpecial => 'کم از کم ایک خصوصی حرف ہونا چاہیے';

  @override
  String get commandSearch => 'کمانڈ لکھیں یا تلاش کریں...';

  @override
  String get commandEmpty => 'کوئی نتیجہ نہیں ملا۔';

  @override
  String get datePickerSelectYear => 'سال منتخب کریں';

  @override
  String get abbreviatedMonday => 'پیر';

  @override
  String get abbreviatedTuesday => 'منگل';

  @override
  String get abbreviatedWednesday => 'بدھ';

  @override
  String get abbreviatedThursday => 'جمعرات';

  @override
  String get abbreviatedFriday => 'جمعہ';

  @override
  String get abbreviatedSaturday => 'ہفتہ';

  @override
  String get abbreviatedSunday => 'اتوار';

  @override
  String get monthJanuary => 'جنوری';

  @override
  String get monthFebruary => 'فروری';

  @override
  String get monthMarch => 'مارچ';

  @override
  String get monthApril => 'اپریل';

  @override
  String get monthMay => 'مئی';

  @override
  String get monthJune => 'جون';

  @override
  String get monthJuly => 'جولائی';

  @override
  String get monthAugust => 'اگست';

  @override
  String get monthSeptember => 'ستمبر';

  @override
  String get monthOctober => 'اکتوبر';

  @override
  String get monthNovember => 'نومبر';

  @override
  String get monthDecember => 'دسمبر';

  @override
  String get abbreviatedJanuary => 'جنو';

  @override
  String get abbreviatedFebruary => 'فرو';

  @override
  String get abbreviatedMarch => 'مار';

  @override
  String get abbreviatedApril => 'اپر';

  @override
  String get abbreviatedMay => 'مئی';

  @override
  String get abbreviatedJune => 'جون';

  @override
  String get abbreviatedJuly => 'جول';

  @override
  String get abbreviatedAugust => 'اگس';

  @override
  String get abbreviatedSeptember => 'ستم';

  @override
  String get abbreviatedOctober => 'اکت';

  @override
  String get abbreviatedNovember => 'نوم';

  @override
  String get abbreviatedDecember => 'دسم';

  @override
  String get dialogDismiss => 'برخاست کریں';

  @override
  String get chipInputRemoveChip => 'حذف کریں';

  @override
  String get buttonCancel => 'منسوخ کریں';

  @override
  String get buttonSave => 'محفوظ کریں';

  @override
  String get timeHour => 'گھنٹہ';

  @override
  String get timeMinute => 'منٹ';

  @override
  String get timeSecond => 'سیکنڈ';

  @override
  String get timeAM => 'صبح';

  @override
  String get timePM => 'شام';

  @override
  String get colorRed => 'سرخ';

  @override
  String get colorGreen => 'سبز';

  @override
  String get colorBlue => 'نیلا';

  @override
  String get colorAlpha => 'الفا';

  @override
  String get colorHue => 'رنگت';

  @override
  String get colorSaturation => 'سیرابی';

  @override
  String get colorValue => 'قدر';

  @override
  String get colorLightness => 'روشنی';

  @override
  String get menuCut => 'کاٹیں';

  @override
  String get menuCopy => 'کاپی کریں';

  @override
  String get menuPaste => 'پیسٹ کریں';

  @override
  String get menuSelectAll => 'سب منتخب کریں';

  @override
  String get menuUndo => 'کالعدم کریں';

  @override
  String get menuRedo => 'دوبارہ کریں';

  @override
  String get menuDelete => 'حذف کریں';

  @override
  String get menuShare => 'شیئر کریں';

  @override
  String get menuSearchWeb => 'ویب پر تلاش کریں';

  @override
  String get menuLiveTextInput => 'لائیو ٹیکسٹ';

  @override
  String get placeholderDatePicker => 'تاریخ منتخب کریں';

  @override
  String get placeholderTimePicker => 'وقت منتخب کریں';

  @override
  String get placeholderColorPicker => 'رنگ منتخب کریں';

  @override
  String get buttonPrevious => 'پچھلا';

  @override
  String get buttonNext => 'اگلا';

  @override
  String get refreshTriggerPull => 'ریفریش کرنے کے لیے کھینچیں';

  @override
  String get refreshTriggerRelease => 'ریفریش کرنے کے لیے چھوڑیں';

  @override
  String get refreshTriggerRefreshing => 'ریفریش ہو رہا ہے...';

  @override
  String get refreshTriggerComplete => 'ریفریش مکمل ہوا';

  @override
  String get colorPickerTabRGB => 'RGB';

  @override
  String get colorPickerTabHSV => 'HSV';

  @override
  String get colorPickerTabHSL => 'HSL';

  @override
  String get colorPickerTabHEX => 'HEX';

  @override
  String get commandMoveUp => 'اوپر لے جائیں';

  @override
  String get commandMoveDown => 'نیچے لے جائیں';

  @override
  String get commandActivate => 'منتخب کریں';

  @override
  String get timeDaysAbbreviation => 'دد';

  @override
  String get timeHoursAbbreviation => 'گگ';

  @override
  String get timeMinutesAbbreviation => 'من';

  @override
  String get timeSecondsAbbreviation => 'سس';

  @override
  String get placeholderDurationPicker => 'دورانیہ منتخب کریں';

  @override
  String get durationDay => 'دن';

  @override
  String get durationHour => 'گھنٹہ';

  @override
  String get durationMinute => 'منٹ';

  @override
  String get durationSecond => 'سیکنڈ';

  @override
  String get dropzoneIdle => 'فائلیں اپ لوڈ کرنے کے لیے براؤز کریں';

  @override
  String get dropzoneDragging => 'اپ لوڈ کے لیے فائلیں چھوڑیں';

  @override
  String get dropzoneUploading => 'فائلیں اپ لوڈ ہو رہی ہیں...';

  @override
  String get dropzoneSuccess => 'فائلیں تیار ہیں';

  @override
  String get dropzoneError => 'جاری رکھنے کے لیے خرابیاں درست کریں';

  @override
  String get dropzoneDisabled => 'فائل اپ لوڈ غیر فعال ہے';

  @override
  String get dropzoneBrowse => 'فائلیں براؤز کریں';

  @override
  String get emptyStateEmptyTitle => 'ابھی یہاں کچھ نہیں ہے';

  @override
  String get emptyStateEmptyDescription => 'شروع کرنے کے لیے پہلا آئٹم بنائیں۔';

  @override
  String get emptyStateNoResultsTitle => 'کوئی نتائج نہیں ملے';

  @override
  String get emptyStateNoResultsDescription =>
      'اپنے فلٹرز یا تلاش کی شرائط درست کریں۔';

  @override
  String get emptyStateErrorTitle => 'کچھ غلط ہو گیا';

  @override
  String get emptyStateErrorDescription =>
      'ہم یہ ڈیٹا لوڈ نہیں کر سکے۔ تھوڑی دیر بعد دوبارہ کوشش کریں۔';

  @override
  String get filterSearch => 'تلاش';

  @override
  String get filterSort => 'ترتیب';

  @override
  String get filterDateRange => 'تاریخ کی حد';

  @override
  String get filterClearAll => 'سب صاف کریں';

  @override
  String get filterFilters => 'فلٹرز';

  @override
  String filterActiveCount(int count) => '${_number(count)} فعال فلٹرز';

  @override
  String filterResultsCount(int count) => '${_number(count)} نتائج';

  @override
  String get fileUploadChoose => 'فائل منتخب کریں';

  @override
  String get fileUploadNoFile => 'کوئی فائل منتخب نہیں';

  @override
  String get fileUploadPickFailed => 'فائل کا انتخاب ناکام ہو گیا۔';

  @override
  String get fileUploadTooMany => 'بہت زیادہ فائلیں منتخب کی گئیں۔';

  @override
  String get fileUploadTooLarge => 'فائل بہت بڑی ہے۔';

  @override
  String get fileUploadInvalidType => 'فائل کی قسم کی اجازت نہیں ہے۔';

  @override
  String get fileUploadUploadFailed => 'اپ لوڈ ناکام ہو گیا۔';

  @override
  String fileUploadUploadFailedFor(String name) =>
      '$name کے لیے اپ لوڈ ناکام ہو گیا۔';

  @override
  String get fileUploadStatusQueued => 'قطار میں';

  @override
  String get fileUploadStatusUploading => 'اپ لوڈ ہو رہا ہے';

  @override
  String get fileUploadStatusCompleted => 'مکمل';

  @override
  String get fileUploadStatusFailed => 'ناکام';

  @override
  String get fileUploadUnknownType => 'فائل';

  @override
  String get fileUploadRemove => 'فائل ہٹائیں';

  @override
  String get fileUploadRetry => 'اپ لوڈ دوبارہ کوشش کریں';

  @override
  String get fileUploadPreview => 'فائل کا پیش نظارہ';

  @override
  String get fileUploadDownload => 'فائل ڈاؤن لوڈ کریں';

  @override
  String get errorSomethingWentWrong => 'کچھ غلط ہو گیا';

  @override
  String get errorUnexpectedMessage =>
      'براہ کرم دوبارہ کوشش کریں یا مسئلہ برقرار رہے تو سپورٹ سے رابطہ کریں۔';

  @override
  String get errorActionRetry => 'دوبارہ کوشش کریں';

  @override
  String get errorActionReport => 'رپورٹ';

  @override
  String get errorActionBack => 'واپس جائیں';

  @override
  String get errorActionLogin => 'لاگ ان';

  @override
  String get errorActionSettings => 'ترتیبات';

  @override
  String get errorActionContactSupport => 'سپورٹ سے رابطہ کریں';

  @override
  String get errorBadRequest => 'غلط درخواست';

  @override
  String get errorBadRequestMessage =>
      'درخواست غلط تھی۔ براہ کرم جائزہ لیں اور دوبارہ کوشش کریں۔';

  @override
  String get errorUnauthorized => 'غیر مجاز';

  @override
  String get errorLoginRequiredMessage =>
      'جاری رکھنے کے لیے براہ کرم لاگ ان کریں۔';

  @override
  String get errorAccessDenied => 'رسائی سے انکار';

  @override
  String get errorAccessDeniedMessage => 'آپ کو یہ عمل کرنے کی اجازت نہیں ہے۔';

  @override
  String get errorNotFound => 'نہیں ملا';

  @override
  String get errorNotFoundMessage =>
      'ہم وہ نہیں ڈھونڈ سکے جو آپ تلاش کر رہے تھے۔';

  @override
  String get errorConflict => 'تصادم';

  @override
  String get errorConflictMessage => 'یہ عمل موجودہ ڈیٹا سے متصادم ہے۔';

  @override
  String get errorInvalidData => 'غلط ڈیٹا';

  @override
  String get errorInvalidDataMessage => 'کچھ فیلڈز کو آپ کی توجہ درکار ہے۔';

  @override
  String get errorTooManyRequests => 'بہت زیادہ درخواستیں';

  @override
  String get errorTooManyRequestsMessage =>
      'براہ کرم تھوڑا انتظار کریں اور دوبارہ کوشش کریں۔';

  @override
  String get errorServerError => 'سرور کی خرابی';

  @override
  String get errorServerErrorMessage =>
      'سرور کو مسئلہ پیش آیا۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get errorRequestTimedOut => 'درخواست کا وقت ختم ہو گیا';

  @override
  String get errorRequestTimedOutMessage =>
      'سرور جواب دینے میں بہت زیادہ وقت لے رہا ہے۔';

  @override
  String get errorAuthenticationRequired => 'توثیق درکار ہے';

  @override
  String get errorInvalidInput => 'غلط ان پٹ';

  @override
  String get errorReviewFieldsMessage => 'براہ کرم نمایاں فیلڈز کا جائزہ لیں۔';

  @override
  String get errorPlatformError => 'پلیٹ فارم کی خرابی';

  @override
  String get errorDeviceErrorMessage => 'اس آلے پر کچھ غلط ہو گیا۔';

  @override
  String get errorConnectionFailed => 'کنکشن ناکام ہو گیا';

  @override
  String get errorConnectionFailedMessage =>
      'اپنا انٹرنیٹ کنکشن چیک کریں اور دوبارہ کوشش کریں۔';

  @override
  String get errorSecureConnectionFailed => 'محفوظ کنکشن ناکام ہو گیا';

  @override
  String get errorSecureConnectionMessage => 'ہم محفوظ کنکشن قائم نہیں کر سکے۔';

  @override
  String get tableResizeColumn => 'کالم کا سائز تبدیل کریں';

  @override
  String get tableResizeRow => 'قطار کا سائز تبدیل کریں';

  @override
  String get resizableHandle => 'سائز تبدیل کرنے کا ہینڈل';

  @override
  String get spellCheckNoSuggestions => 'کوئی تجاویز نہیں';

  @override
  String get announcementLoading => 'لوڈ ہو رہا ہے';

  @override
  String get announcementSuccess => 'کامیابی';

  @override
  String get announcementFailure => 'ناکامی';

  @override
  String get toolbarMore => 'مزید';

  @override
  String get toolbarMoreActions => 'مزید کارروائیاں';

  @override
  String get treeCollapse => 'سکیڑیں';

  @override
  String get treeExpand => 'پھیلائیں';

  @override
  String get markdownDetails => 'تفصیلات';

  @override
  String get carouselLabel => 'نمایاں کیروسل';

  @override
  String get carouselPrimaryAction => 'چیٹ میں شامل کریں';

  @override
  String carouselItemPreview(Object? title) =>
      'فیچر کا پیش نظارہ: ${title ?? mediaUntitled}';

  @override
  String carouselPageOf(int position, int length) =>
      'صفحہ ${_number(position)} از ${_number(length)}';

  @override
  String stepperStep(int index) => 'مرحلہ ${_number(index + 1)}';

  @override
  String paginationPage(Object? page) => 'صفحہ ${_number(page)}';

  @override
  String chartSeriesDefault(int index) => 'سیریز ${_number(index + 1)}';

  @override
  String chartSliceDefault(int index) => 'ٹکڑا ${_number(index)}';

  @override
  String chartCategoryDefault(int index) => 'زمرہ ${_number(index)}';

  @override
  String get chartValueDefault => 'قدر';

  @override
  String get chartKindLine => 'لائن';

  @override
  String get chartKindArea => 'رقبہ';

  @override
  String get chartKindBar => 'بار';

  @override
  String get chartKindDonut => 'ڈونٹ';

  @override
  String get chartKindPie => 'پائی';

  @override
  String get chartKindSparkline => 'اسپارک لائن';

  @override
  String get chartKindScatter => 'اسکیٹر';

  @override
  String get chartKindRadar => 'ریڈار';

  @override
  String get chartKindRadial => 'ریڈیل';

  @override
  String chartSummaryEmpty(Object? kind) => '$kind چارٹ میں کوئی ڈیٹا نہیں';

  @override
  String chartSummary(int series, int points, Object? kind) =>
      '$kind چارٹ میں ${_number(series)} سیریز اور ${_number(points)} پوائنٹس';

  @override
  String get colorFieldHsv => 'HSV کلر فیلڈ';

  @override
  String get colorFieldHsl => 'HSL کلر فیلڈ';

  @override
  String get actionClear => 'صاف کریں';

  @override
  String get actionApply => 'لاگو کریں';

  @override
  String get actionVerify => 'تصدیق کریں';

  @override
  String get actionResend => 'دوبارہ بھیجیں';

  @override
  String resendInSeconds(int seconds) =>
      '${_number(seconds)} سیکنڈ میں دوبارہ بھیجیں';

  @override
  String get authCode => 'کوڈ';

  @override
  String get authEmail => 'ای میل';

  @override
  String get authPassword => 'پاس ورڈ';

  @override
  String get authName => 'نام';

  @override
  String get authSignIn => 'سائن ان';

  @override
  String get authForgotPassword => 'پاس ورڈ بھول گئے؟';

  @override
  String get authRememberMe => 'مجھے یاد رکھیں';

  @override
  String get authCreateAccount => 'اکاؤنٹ بنائیں';

  @override
  String get actionClose => 'بند کریں';

  @override
  String get mediaPlay => 'چلائیں';

  @override
  String get mediaPause => 'روکیں';

  @override
  String get mediaMute => 'خاموش';

  @override
  String get mediaUnmute => 'آواز بحال کریں';

  @override
  String get mediaVolume => 'آواز';

  @override
  String get mediaSeek => 'تلاش';

  @override
  String get mediaDownload => 'ڈاؤن لوڈ';

  @override
  String get mediaAudioPlayer => 'آڈیو پلیئر';

  @override
  String get mediaVideoPlayer => 'ویڈیو پلیئر';

  @override
  String get mediaUntitled => 'بے عنوان';

  @override
  String get mediaPlaybackFailed => 'پلے بیک ناکام ہو گیا';

  @override
  String get mediaPreviousTrack => 'پچھلا ٹریک';

  @override
  String get mediaNextTrack => 'اگلا ٹریک';

  @override
  String get mediaShuffleDisable => 'شفل غیر فعال کریں';

  @override
  String get mediaShuffleEnable => 'شفل فعال کریں';

  @override
  String get mediaRepeatDisable => 'تکرار غیر فعال کریں';

  @override
  String get mediaRepeatEnable => 'تکرار فعال کریں';

  @override
  String mediaPlaybackSpeed(Object? speed) =>
      'پلے بیک رفتار ${speed}x، تبدیل کرنے کے لیے تھپتھپائیں';

  @override
  String mediaPositionOf(Object position, Object duration) =>
      '$position از $duration';

  @override
  String mediaHours(int count) =>
      count == 1 ? '1 گھنٹہ' : '${_number(count)} گھنٹے';

  @override
  String mediaMinutes(int count) =>
      count == 1 ? '1 منٹ' : '${_number(count)} منٹ';

  @override
  String mediaSeconds(int count) =>
      count == 1 ? '1 سیکنڈ' : '${_number(count)} سیکنڈ';

  @override
  String get signaturePadLabel => 'دستخط پیڈ';

  @override
  String get qrCodeLabel => 'QR کوڈ';

  @override
  String get marqueeContent => 'متحرک مواد';

  @override
  String mediaSkipBack(int seconds) => 'پیچھے ${_number(seconds)} سیکنڈ';

  @override
  String mediaSkipForward(int seconds) => 'آگے ${_number(seconds)} سیکنڈ';

  @override
  String get mediaCaptionsShow => 'کیپشن دکھائیں';

  @override
  String get mediaCaptionsHide => 'کیپشن چھپائیں';

  @override
  String get mediaCaptionsOn => 'کیپشن آن';

  @override
  String get mediaCaptionsOff => 'کیپشن آف';

  @override
  String get mediaFullscreen => 'فل اسکرین';

  @override
  String mediaMoreOptionsSpeed(Object? speed) =>
      'مزید اختیارات، پلے بیک رفتار ${speed}x';

  @override
  String mediaSpeed(Object? speed) => 'رفتار ${speed}x';

  @override
  String get actionStartTrial => 'مفت آزمائش شروع کریں';

  @override
  String get authFirstName => 'پہلا نام';

  @override
  String get authLastName => 'آخری نام';

  @override
  String get authPasswordHint => 'کم از کم 8 حروف۔';

  @override
  String get authUseDifferentEmail => 'کوئی مختلف ای میل استعمال کریں';

  @override
  String get authWorkEmail => 'دفتری ای میل';

  @override
  String get chartTotalLabel => 'کل';

  @override
  String get mediaQualityAuto => 'کوالٹی خودکار';

  @override
  String get mediaLiveBadge => 'براہ راست';

  @override
  String get blockDontHaveAccount => 'اکاؤنٹ نہیں ہے؟';

  @override
  String get blockAlreadyHaveAccount => 'کیا پہلے سے اکاؤنٹ ہے؟';

  @override
  String get blockNoAccountYet => 'ابھی تک اکاؤنٹ نہیں ہے؟';

  @override
  String get blockHaveAnAccount => 'اکاؤنٹ ہے؟';

  @override
  String get blockCreateOne => 'بنائیں';

  @override
  String get blockCreateAccount => 'اکاؤنٹ بنائیں';

  @override
  String get blockCreateYourAccount => 'اپنا اکاؤنٹ بنائیں';

  @override
  String get blockForgotYourPassword => 'پاس ورڈ بھول گئے؟';

  @override
  String get blockBackToSignIn => 'سائن ان پر واپس جائیں';

  @override
  String get blockEnterCredentialsWorkspace =>
      'اپنے ورک اسپیس تک رسائی کے لیے اپنی اسناد درج کریں۔';

  @override
  String get blockEnterCredentialsContinue =>
      'جاری رکھنے کے لیے اپنی اسناد درج کریں۔';

  @override
  String get blockEnterDetailsContinue =>
      'جاری رکھنے کے لیے نیچے اپنی تفصیلات درج کریں۔';

  @override
  String get blockEnterEmailCreateAccount =>
      'اپنا اکاؤنٹ بنانے کے لیے نیچے اپنا ای میل درج کریں۔';

  @override
  String get blockSignedInWelcomeBack => 'سائن ان ہو گیا — خوش آمدید۔';

  @override
  String get blockAccountCreatedVerify =>
      'اکاؤنٹ بن گیا — تصدیق کے لیے اپنا ان باکس دیکھیں۔';

  @override
  String get blockTrialStartedVerify =>
      'آزمائش شروع ہو گئی — تصدیق کے لیے اپنا ان باکس دیکھیں۔';

  @override
  String get blockPasswordsDoNotMatch => 'پاس ورڈز مماثل نہیں ہیں۔';

  @override
  String get blockCurrentPassword => 'موجودہ پاس ورڈ';

  @override
  String get blockNewPassword => 'نیا پاس ورڈ';

  @override
  String get blockConfirmNewPassword => 'نئے پاس ورڈ کی تصدیق کریں';

  @override
  String get blockUpdatePassword => 'پاس ورڈ اپ ڈیٹ کریں';

  @override
  String get blockPasswordUpdated => 'پاس ورڈ اپ ڈیٹ ہو گیا۔';

  @override
  String get blockPasswordHintChange =>
      'کم از کم 8 حروف۔ اسے بدلنے سے آپ دوسری جگہوں سے سائن آؤٹ ہو جائیں گے۔';

  @override
  String get blockUsername => 'صارف نام';

  @override
  String get blockUsernameHint => 'چھوٹے حروف، ہندسے، انڈر اسکور۔';

  @override
  String get blockYourAvatar => 'آپ کا اوتار';

  @override
  String get blockUploadImage => 'تصویر اپ لوڈ کریں';

  @override
  String get blockBio => 'تعارف';

  @override
  String get blockBioHint => 'اپنے بارے میں تھوڑا بتائیں';

  @override
  String get blockBioCounterHint => 'زیادہ سے زیادہ 160 حروف۔';

  @override
  String get blockProfileSaved => 'پروفائل محفوظ ہو گئی۔';

  @override
  String get blockSaveChanges => 'تبدیلیاں محفوظ کریں';

  @override
  String get blockInviteMember => 'رکن مدعو کریں';

  @override
  String get blockRoleAdmin => 'منتظم';

  @override
  String get blockRoleOwner => 'مالک';

  @override
  String get blockRoleMember => 'رکن';

  @override
  String get blockTeam => 'ٹیم';

  @override
  String get blockProfile => 'پروفائل';

  @override
  String get blockSignInWithEmail => 'ای میل سے سائن ان کریں';

  @override
  String get blockSignUp => 'سائن اپ کریں';

  @override
  String get blockPickWayYouPrefer => 'اپنا پسندیدہ طریقہ منتخب کریں۔';

  @override
  String blockContinueWith(Object? provider) => '$provider کے ساتھ جاری رکھیں';

  @override
  String get blockCreating => 'بنایا جا رہا ہے…';

  @override
  String get blockSigningIn => 'سائن ان ہو رہا ہے…';

  @override
  String get blockSending => 'بھیجا جا رہا ہے…';

  @override
  String get blockSaving => 'محفوظ کیا جا رہا ہے…';

  @override
  String get blockPaying => 'ادائیگی ہو رہی ہے…';

  @override
  String get blockSendResetLink => 'ری سیٹ لنک بھیجیں';

  @override
  String get blockResetPassword => 'پاس ورڈ ری سیٹ کریں';

  @override
  String get blockResetLinkSent =>
      'ری سیٹ لنک بھیج دیا گیا۔ جاری رکھنے کے لیے اپنا ان باکس دیکھیں۔';

  @override
  String get blockWeWillEmailReset =>
      'ہم آپ کو ای میل سے ری سیٹ لنک بھیجیں گے۔';

  @override
  String get blockMustAcceptTerms =>
      'جاری رکھنے کے لیے آپ کو شرائط قبول کرنی ہوں گی۔';

  @override
  String get blockCheckInbox => 'اپنا ان باکس دیکھیں';

  @override
  String get blockEnterSixDigitCode =>
      'آپ کو بھیجا گیا 6 ہندسوں کا کوڈ درج کریں۔';

  @override
  String get blockCodeVerifiedSignedIn =>
      'کوڈ کی تصدیق ہو گئی۔ آپ سائن ان ہیں۔';

  @override
  String get blockEmailVerifiedSet => 'ای میل کی تصدیق ہو گئی — سب تیار ہے۔';

  @override
  String get blockVerifyYourEmail => 'اپنے ای میل کی تصدیق کریں';

  @override
  String blockWeSentCodeTo(Object? email) =>
      'ہم نے $email پر چھ ہندسوں کا کوڈ بھیجا ہے۔';

  @override
  String get blockDidntGetCode => 'کوڈ نہیں ملا؟';

  @override
  String get blockBack => 'پیچھے';

  @override
  String get blockBackToCart => 'کارٹ پر واپس جائیں';

  @override
  String get blockBackToSettings => 'ترتیبات پر واپس جائیں';

  @override
  String get blockOneAccountEverything => 'ہر چیز کے لیے ایک اکاؤنٹ۔';

  @override
  String get blockStartTrialNoCard =>
      'اپنی 14 روزہ آزمائش شروع کریں۔ کریڈٹ کارڈ درکار نہیں۔';

  @override
  String get blockNotifications => 'اطلاعات';

  @override
  String get blockNotifChoose =>
      'منتخب کریں کہ آپ کس بارے میں اور کہاں سننا چاہتے ہیں۔';

  @override
  String get blockEmailNotifications => 'ای میل اطلاعات';

  @override
  String get blockPushNotifications => 'پش اطلاعات';

  @override
  String get blockMentionsReplies => 'تذکرے اور جوابات';

  @override
  String get blockDeliveredToDevices => 'آپ کے آلات پر پہنچایا گیا';

  @override
  String blockEmailChannel(Object? channel) => 'ای میل · $channel';

  @override
  String blockPushChannel(Object? channel) => 'پش · $channel';

  @override
  String get blockQuietHours => 'خاموش اوقات';

  @override
  String get blockWeeklyDigest => 'ہفتہ وار خلاصہ';

  @override
  String get blockWeeklyDigestBlurb =>
      'جو کچھ ہوا اس کے ساتھ ہر پیر کو ایک ای میل۔';

  @override
  String get blockPreferencesSaved => 'ترجیحات محفوظ ہو گئیں۔';

  @override
  String get blockSavePreferences => 'ترجیحات محفوظ کریں';

  @override
  String get blockReset => 'ری سیٹ کریں';

  @override
  String get blockWelcomeAboard => 'خوش آمدید';

  @override
  String get blockQuickTour => 'ایپ استعمال شروع کرنے سے پہلے ایک فوری تعارف۔';

  @override
  String get blockStayInLoop => 'باخبر رہیں';

  @override
  String get blockMessagesArriveMoment =>
      'پیغامات اور اپ ڈیٹس ہوتے ہی پہنچتے ہیں۔';

  @override
  String get blockNeverMissThing => 'کچھ بھی مت چھوڑیں';

  @override
  String get blockNotifPermissionBlurb =>
      'ہم صرف اہم چیزیں بھیجتے ہیں: جوابات، یاد دہانیاں اور حفاظتی انتباہات۔ آپ اسے بعد میں بدل سکتے ہیں۔';

  @override
  String get blockEnableNotifications => 'اطلاعات فعال کریں؟';

  @override
  String get blockAllowNotifications => 'اطلاعات کی اجازت دیں';

  @override
  String get blockAllowNotificationsBlurb =>
      'ایپ سے بھرپور فائدہ کے لیے اطلاعات کی اجازت دیں۔';

  @override
  String get blockNotNow => 'ابھی نہیں';

  @override
  String get blockSkip => 'چھوڑیں';

  @override
  String get blockGetStarted => 'شروع کریں';

  @override
  String get blockMessages => 'پیغامات';

  @override
  String get blockNoConversations => 'کوئی گفتگو نہیں';

  @override
  String get blockPullRefreshChat =>
      'ریفریش کے لیے کھینچیں یا نئی چیٹ شروع کریں۔';

  @override
  String get blockMute => 'خاموش کریں';

  @override
  String get blockMuted => 'خاموش کیا گیا';

  @override
  String get blockAttach => 'منسلک کریں';

  @override
  String get blockAttachFile => 'فائل';

  @override
  String get blockAttachPhoto => 'تصویر';

  @override
  String get blockWriteMessage => 'پیغام لکھیں…';

  @override
  String get blockYourCart => 'آپ کی کارٹ';

  @override
  String get blockAddSomethingFirst =>
      'پہلے کچھ ایسا شامل کریں جو آپ کو پسند ہو۔';

  @override
  String get blockCartEmpty => 'کارٹ خالی ہے';

  @override
  String get blockCheckout => 'چیک آؤٹ';

  @override
  String blockQty(int quantity) => 'مقدار $quantity';

  @override
  String blockPayTotal(Object? amount) => '$amount ادا کریں';

  @override
  String get blockPayment => 'ادائیگی';

  @override
  String get blockCardNumber => 'کارڈ نمبر';

  @override
  String get blockExpiry => 'میعاد';

  @override
  String get blockCvc => 'CVC';

  @override
  String get blockDeliveryAddress => 'ترسیل کا پتہ';

  @override
  String get blockStreet => 'گلی';

  @override
  String get blockCity => 'شہر';

  @override
  String get blockSaveAndContinue => 'محفوظ کریں اور جاری رکھیں';

  @override
  String get blockOrderPlaced => 'آرڈر ہو گیا';

  @override
  String get blockOrderThanks => 'ہم سے خریداری کا شکریہ۔ تصدیق آ رہی ہے۔';

  @override
  String get blockContinueShopping => 'خریداری جاری رکھیں';

  @override
  String get blockSchedule => 'شیڈول';

  @override
  String get blockPickDateRangeReport =>
      'اپنی رپورٹ کے لیے تاریخ کی حد منتخب کریں۔';

  @override
  String get blockPickDateRange => 'تاریخ کی حد منتخب کریں';

  @override
  String get blockTapAnotherDay => 'حد بڑھانے کے لیے دوسرے دن پر ٹیپ کریں';

  @override
  String get blockBookMeeting => 'میٹنگ بک کریں';

  @override
  String get blockPickDayTime => 'ایک دن منتخب کریں، پھر مناسب وقت منتخب کریں۔';

  @override
  String get blockFourSlots => '30 منٹ کے چار سلاٹ باقی ہیں۔ ایک منتخب کریں۔';

  @override
  String blockPickedSlot(Object? slot) => '$slot منتخب، 30 منٹ۔';

  @override
  String get blockOverview => 'جائزہ';

  @override
  String get blockRevenueOrdersBlurb => 'آمدنی، سبسکرپشنز اور تازہ ترین آرڈرز۔';

  @override
  String get blockTotalRevenue => 'کل آمدنی';

  @override
  String get blockSubscriptions => 'سبسکرپشنز';

  @override
  String get blockSales => 'فروخت';

  @override
  String get blockRevenueByMonth => 'ماہ کے لحاظ سے آمدنی';

  @override
  String get blockRecentSales => 'حالیہ فروخت';

  @override
  String get blockViewAll => 'سب دیکھیں';

  @override
  String get blockTransactions => 'لین دین';

  @override
  String get blockFilterTransactions => 'لین دین فلٹر کریں';

  @override
  String get blockCustomer => 'گاہک';

  @override
  String get blockAmount => 'رقم';

  @override
  String get blockMethod => 'طریقہ';

  @override
  String get blockStatus => 'حالت';

  @override
  String get blockPaid => 'ادا شدہ';

  @override
  String get blockPending => 'زیر التواء';

  @override
  String get blockRefunded => 'واپس کیا گیا';

  @override
  String blockNoTransactions(Object? query) =>
      '“$query” سے کوئی لین دین مماثل نہیں۔';

  @override
  String blockDeltaFromLastMonth(Object? delta) => 'پچھلے مہینے سے $delta';

  @override
  String get blockAnalytics => 'تجزیات';

  @override
  String get blockSessionsDevicesBlurb => 'سیشنز، آلات اور ٹریفک کہاں سے آئی۔';

  @override
  String get blockSearchReports => 'رپورٹس تلاش کریں';

  @override
  String get blockLast30Days => 'پچھلے 30 دن';

  @override
  String get blockAllDevices => 'تمام آلات';

  @override
  String get blockSessions => 'سیشنز';

  @override
  String get blockUsers => 'صارفین';

  @override
  String get blockAvgSession => 'اوسط سیشن';

  @override
  String get blockBounceRate => 'باؤنس ریٹ';

  @override
  String get blockConversions => 'تبادلوں';

  @override
  String get blockByDevice => 'آلے کے لحاظ سے';

  @override
  String get blockDesktop => 'ڈیسک ٹاپ';

  @override
  String get blockMobile => 'موبائل';

  @override
  String get blockTablet => 'ٹیبلٹ';

  @override
  String get blockDirect => 'براہ راست';

  @override
  String get blockReferral => 'ریفرل';

  @override
  String get blockSocial => 'سوشل';

  @override
  String get blockTrafficSources => 'ٹریفک ذرائع';

  @override
  String get blockVisitors => 'زائرین';

  @override
  String get blockHome => 'ہوم';

  @override
  String get blockInbox => 'ان باکس';

  @override
  String get blockCalendar => 'کیلنڈر';

  @override
  String get blockCompose => 'تحریر کریں';

  @override
  String get blockMarkAllRead => 'سب کو پڑھا ہوا نشان زد کریں';

  @override
  String get blockStarred => 'ستارہ زدہ';

  @override
  String get blockSnoozed => 'مؤخر';

  @override
  String get blockUnread => 'غیر پڑھا ہوا';

  @override
  String get blockDocuments => 'دستاویزات';

  @override
  String get blockReports => 'رپورٹس';

  @override
  String get blockDashboard => 'ڈیش بورڈ';

  @override
  String get blockStorage => 'اسٹوریج';

  @override
  String get blockNavigation => 'رہنمائی';

  @override
  String get blockSharedWithYou => 'آپ کے ساتھ شیئر کیا گیا';

  @override
  String get blockRecentProjects => 'حالیہ پراجیکٹس';

  @override
  String get blockStorageUsed => 'استعمال شدہ اسٹوریج';

  @override
  String get blockOpen => 'کھولیں';

  @override
  String get blockLive => 'براہ راست';

  @override
  String get blockMembers => 'اراکین';

  @override
  String get blockProjects => 'پراجیکٹس';

  @override
  String get blockDeploys => 'تعیناتیاں';

  @override
  String get blockActivity => 'سرگرمی';

  @override
  String get blockRecentFiles => 'حالیہ فائلیں';

  @override
  String get blockUsageThisMonth => 'اس ماہ کا استعمال';

  @override
  String get blockUpgradePlan => 'منصوبہ اپ گریڈ کریں';

  @override
  String blockNoMatches(Object? query) => '“$query” کے لیے کوئی نتائج نہیں۔';

  @override
  String get blockWorkspaces => 'ورک اسپیسز';

  @override
  String get blockPricing => 'قیمتیں';

  @override
  String get blockPlansScale => 'منصوبے جو آپ کے ساتھ بڑھیں';

  @override
  String get blockPlansBlurb =>
      'مفت شروع کریں، جب آپ کی ٹیم بڑھے تو اپ گریڈ کریں۔ ہر منصوبے میں مکمل کمپوننٹ لائبریری اور تھیم پری سیٹس شامل ہیں۔';

  @override
  String get blockPerUserMonth => 'فی صارف / ماہ';

  @override
  String get blockSubscribe => 'سبسکرائب کریں';

  @override
  String get blockContactSales => 'سیلز سے رابطہ کریں';

  @override
  String get blockPromoCode => 'پرومو کوڈ';

  @override
  String get blockApplyCode => 'کوڈ لگائیں';

  @override
  String get blockHaveCodeEnter => 'کوڈ ہے؟ نیچے درج کریں۔';

  @override
  String get blockCodeAppliedDiscount =>
      'کوڈ لگا دیا گیا — آپ کی رعایت چیک آؤٹ پر نظر آئے گی۔';

  @override
  String get blockFaqTitle => 'سوالات';

  @override
  String get blockFaqChangePlans => 'کیا میں بعد میں منصوبہ بدل سکتا ہوں؟';

  @override
  String get blockFaqChangePlansAnswer =>
      'جی ہاں۔ اپ گریڈ فوری نافذ ہوتے ہیں، ڈاؤن گریڈ اگلے چکر سے۔';

  @override
  String get blockFaqFreeTrial => 'کیا مفت آزمائش ہے؟';

  @override
  String get blockFaqFreeTrialAnswer =>
      'ہر منصوبہ 14 دن سے شروع ہوتا ہے، کارڈ درکار نہیں۔';

  @override
  String get blockAccount => 'اکاؤنٹ';

  @override
  String get blockGeneral => 'عمومی';

  @override
  String get blockAppearance => 'شکل';

  @override
  String get blockDarkMode => 'ڈارک موڈ';

  @override
  String get blockPreferences => 'ترجیحات';

  @override
  String get blockSignOut => 'سائن آؤٹ کریں';

  @override
  String get blockSignOutConfirm => 'سائن آؤٹ کریں؟';

  @override
  String get blockSignOutBlurb =>
      'آپ بعد میں ہمیشہ دوبارہ سائن ان کر سکتے ہیں۔';

  @override
  String get blockSounds => 'آوازیں';

  @override
  String get blockWhatYouGet => 'آپ کو کیا ملتا ہے';

  @override
  String get blockAllComponentCategories => 'تمام کمپوننٹ زمرے';

  @override
  String get blockPrioritySupport => 'ترجیحی معاونت';

  @override
  String get blockUnlimitedProjectsTrial => 'آزمائش کے دوران لامحدود پراجیکٹس';

  @override
  String get blockTrialDaysLeft => 'آپ کی آزمائش میں 14 دن باقی ہیں';

  @override
  String get blockStarterChat => 'چیٹ';

  @override
  String get blockStarterShop => 'دکان';

  @override
  String get blockStarterCart => 'کارٹ';

  @override
  String get blockAddToCart => 'کارٹ میں شامل کریں';
}
