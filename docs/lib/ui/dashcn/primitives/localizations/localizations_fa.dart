import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

/// Persian (`fa`) locale data.
///
/// Translations only: anything this table does not override falls
/// through to the English default on [ComponentLocalizations]. Text
/// direction is not handled here - Flutter resolves it from
/// [WidgetsLocalizations] and [Directionality].
class ComponentLocalizationsFa extends ComponentLocalizations {
  /// Creates the Persian strings.
  const ComponentLocalizationsFa([super.locale = const Locale('fa')]);

  /// Formats [value] as a number in this locale, or returns it
  /// verbatim when it is not a number.
  String _number(Object? value) {
    if (value is! num) return '$value';
    return intl.NumberFormat.decimalPattern(localeName).format(value);
  }

  @override
  String get formNotEmpty => 'این فیلد نمی‌تواند خالی باشد';

  @override
  String get invalidValue => 'مقدار نامعتبر';

  @override
  String get invalidEmail => 'ایمیل نامعتبر';

  @override
  String get invalidURL => 'نشانی اینترنتی نامعتبر';

  @override
  String formLessThan(Object? value) => 'باید کمتر از ${_number(value)} باشد';

  @override
  String formGreaterThan(Object? value) =>
      'باید بیشتر از ${_number(value)} باشد';

  @override
  String formLessThanOrEqualTo(Object? value) =>
      'باید کمتر یا مساوی ${_number(value)} باشد';

  @override
  String get formPhoneNumberInvalid => 'شماره تلفن نامعتبر است';

  @override
  String get formPhoneNumberEmpty => 'شماره تلفن الزامی است';

  @override
  String formGreaterThanOrEqualTo(Object? value) =>
      'باید بیشتر یا مساوی ${_number(value)} باشد';

  @override
  String formBetweenInclusively(Object? min, Object? max) =>
      'باید بین ${_number(min)} و ${_number(max)} باشد (شامل دو سر)';

  @override
  String formEqualTo(Object? value) => 'باید برابر ${_number(value)} باشد';

  @override
  String formBetweenExclusively(Object? min, Object? max) =>
      'باید بین ${_number(min)} و ${_number(max)} باشد (بدون دو سر)';

  @override
  String formLengthLessThan(int limit) => 'باید حداقل $limit نویسه باشد';

  @override
  String formLengthGreaterThan(int limit) => 'باید حداکثر $limit نویسه باشد';

  @override
  String get formPasswordDigits => 'باید حداقل یک رقم داشته باشد';

  @override
  String get formPasswordLowercase => 'باید حداقل یک حرف کوچک داشته باشد';

  @override
  String get formPasswordUppercase => 'باید حداقل یک حرف بزرگ داشته باشد';

  @override
  String get formPasswordSpecial => 'باید حداقل یک نویسه ویژه داشته باشد';

  @override
  String get commandSearch => 'فرمانی بنویسید یا جستجو کنید...';

  @override
  String get commandEmpty => 'نتیجه‌ای یافت نشد.';

  @override
  String get datePickerSelectYear => 'یک سال انتخاب کنید';

  @override
  String get abbreviatedMonday => 'دو';

  @override
  String get abbreviatedTuesday => 'سه';

  @override
  String get abbreviatedWednesday => 'چه';

  @override
  String get abbreviatedThursday => 'پن';

  @override
  String get abbreviatedFriday => 'جم';

  @override
  String get abbreviatedSaturday => 'شن';

  @override
  String get abbreviatedSunday => 'یک';

  @override
  String get monthJanuary => 'ژانویه';

  @override
  String get monthFebruary => 'فوریه';

  @override
  String get monthMarch => 'مارس';

  @override
  String get monthApril => 'آوریل';

  @override
  String get monthMay => 'مه';

  @override
  String get monthJune => 'ژوئن';

  @override
  String get monthJuly => 'ژوئیه';

  @override
  String get monthAugust => 'اوت';

  @override
  String get monthSeptember => 'سپتامبر';

  @override
  String get monthOctober => 'اکتبر';

  @override
  String get monthNovember => 'نوامبر';

  @override
  String get monthDecember => 'دسامبر';

  @override
  String get abbreviatedJanuary => 'ژانویه';

  @override
  String get abbreviatedFebruary => 'فوریه';

  @override
  String get abbreviatedMarch => 'مارس';

  @override
  String get abbreviatedApril => 'آوریل';

  @override
  String get abbreviatedMay => 'مه';

  @override
  String get abbreviatedJune => 'ژوئن';

  @override
  String get abbreviatedJuly => 'ژوئیه';

  @override
  String get abbreviatedAugust => 'اوت';

  @override
  String get abbreviatedSeptember => 'سپتامبر';

  @override
  String get abbreviatedOctober => 'اکتبر';

  @override
  String get abbreviatedNovember => 'نوامبر';

  @override
  String get abbreviatedDecember => 'دسامبر';

  @override
  String get dialogDismiss => 'بستن';

  @override
  String get chipInputRemoveChip => 'حذف';

  @override
  String get buttonCancel => 'لغو';

  @override
  String get buttonSave => 'ذخیره';

  @override
  String get timeHour => 'ساعت';

  @override
  String get timeMinute => 'دقیقه';

  @override
  String get timeSecond => 'ثانیه';

  @override
  String get timeAM => 'ق.ظ';

  @override
  String get timePM => 'ب.ظ';

  @override
  String get colorRed => 'قرمز';

  @override
  String get colorGreen => 'سبز';

  @override
  String get colorBlue => 'آبی';

  @override
  String get colorAlpha => 'آلفا';

  @override
  String get colorHue => 'فام';

  @override
  String get colorSaturation => 'اشباع';

  @override
  String get colorValue => 'روشنی';

  @override
  String get colorLightness => 'درخشندگی';

  @override
  String get menuCut => 'برش';

  @override
  String get menuCopy => 'کپی';

  @override
  String get menuPaste => 'چسباندن';

  @override
  String get menuSelectAll => 'انتخاب همه';

  @override
  String get menuUndo => 'واگرد';

  @override
  String get menuRedo => 'ازنو';

  @override
  String get menuDelete => 'حذف';

  @override
  String get menuShare => 'هم‌رسانی';

  @override
  String get menuSearchWeb => 'جستجو در وب';

  @override
  String get menuLiveTextInput => 'متن زنده';

  @override
  String get placeholderDatePicker => 'یک تاریخ انتخاب کنید';

  @override
  String get placeholderTimePicker => 'یک زمان انتخاب کنید';

  @override
  String get placeholderColorPicker => 'یک رنگ انتخاب کنید';

  @override
  String get buttonPrevious => 'قبلی';

  @override
  String get buttonNext => 'بعدی';

  @override
  String get refreshTriggerPull => 'برای تازه‌سازی بکشید';

  @override
  String get refreshTriggerRelease => 'برای تازه‌سازی رها کنید';

  @override
  String get refreshTriggerRefreshing => 'در حال تازه‌سازی...';

  @override
  String get refreshTriggerComplete => 'تازه‌سازی کامل شد';

  @override
  String get colorPickerTabRGB => 'RGB';

  @override
  String get colorPickerTabHSV => 'HSV';

  @override
  String get colorPickerTabHSL => 'HSL';

  @override
  String get colorPickerTabHEX => 'HEX';

  @override
  String get commandMoveUp => 'انتقال به بالا';

  @override
  String get commandMoveDown => 'انتقال به پایین';

  @override
  String get commandActivate => 'انتخاب';

  @override
  String get timeDaysAbbreviation => 'رر';

  @override
  String get timeHoursAbbreviation => 'سس';

  @override
  String get timeMinutesAbbreviation => 'دد';

  @override
  String get timeSecondsAbbreviation => 'ثث';

  @override
  String get placeholderDurationPicker => 'یک مدت انتخاب کنید';

  @override
  String get durationDay => 'روز';

  @override
  String get durationHour => 'ساعت';

  @override
  String get durationMinute => 'دقیقه';

  @override
  String get durationSecond => 'ثانیه';

  @override
  String get dropzoneIdle => 'مرور برای آپلود فایل‌ها';

  @override
  String get dropzoneDragging => 'فایل‌ها را برای آپلود رها کنید';

  @override
  String get dropzoneUploading => 'در حال آپلود فایل‌ها...';

  @override
  String get dropzoneSuccess => 'فایل‌ها آماده‌اند';

  @override
  String get dropzoneError => 'برای ادامه خطاها را برطرف کنید';

  @override
  String get dropzoneDisabled => 'آپلود فایل غیرفعال است';

  @override
  String get dropzoneBrowse => 'مرور فایل‌ها';

  @override
  String get emptyStateEmptyTitle => 'هنوز چیزی اینجا نیست';

  @override
  String get emptyStateEmptyDescription =>
      'برای شروع اولین مورد را ایجاد کنید.';

  @override
  String get emptyStateNoResultsTitle => 'نتیجه‌ای یافت نشد';

  @override
  String get emptyStateNoResultsDescription =>
      'فیلترها یا عبارت‌های جستجو را تنظیم کنید.';

  @override
  String get emptyStateErrorTitle => 'مشکلی پیش آمد';

  @override
  String get emptyStateErrorDescription =>
      'نتوانستیم این داده‌ها را بارگیری کنیم. لحظاتی دیگر دوباره تلاش کنید.';

  @override
  String get filterSearch => 'جستجو';

  @override
  String get filterSort => 'مرتب‌سازی';

  @override
  String get filterDateRange => 'بازه زمانی';

  @override
  String get filterClearAll => 'پاک کردن همه';

  @override
  String get filterFilters => 'فیلترها';

  @override
  String filterActiveCount(int count) => '${_number(count)} فیلتر فعال';

  @override
  String filterResultsCount(int count) => '${_number(count)} نتیجه';

  @override
  String get fileUploadChoose => 'انتخاب فایل';

  @override
  String get fileUploadNoFile => 'فایلی انتخاب نشده است';

  @override
  String get fileUploadPickFailed => 'انتخاب فایل ناموفق بود.';

  @override
  String get fileUploadTooMany => 'فایل‌های زیادی انتخاب شده است.';

  @override
  String get fileUploadTooLarge => 'فایل خیلی بزرگ است.';

  @override
  String get fileUploadInvalidType => 'نوع فایل مجاز نیست.';

  @override
  String get fileUploadUploadFailed => 'آپلود ناموفق بود.';

  @override
  String fileUploadUploadFailedFor(String name) => 'آپلود $name ناموفق بود.';

  @override
  String get fileUploadStatusQueued => 'در صف';

  @override
  String get fileUploadStatusUploading => 'در حال آپلود';

  @override
  String get fileUploadStatusCompleted => 'تکمیل‌شده';

  @override
  String get fileUploadStatusFailed => 'ناموفق';

  @override
  String get fileUploadUnknownType => 'فایل';

  @override
  String get fileUploadRemove => 'حذف فایل';

  @override
  String get fileUploadRetry => 'تلاش مجدد برای آپلود';

  @override
  String get fileUploadPreview => 'پیش‌نمایش فایل';

  @override
  String get fileUploadDownload => 'دانلود فایل';

  @override
  String get errorSomethingWentWrong => 'مشکلی پیش آمد';

  @override
  String get errorUnexpectedMessage =>
      'لطفاً دوباره تلاش کنید یا اگر مشکل ادامه داشت با پشتیبانی تماس بگیرید.';

  @override
  String get errorActionRetry => 'تلاش مجدد';

  @override
  String get errorActionReport => 'گزارش';

  @override
  String get errorActionBack => 'بازگشت';

  @override
  String get errorActionLogin => 'ورود';

  @override
  String get errorActionSettings => 'تنظیمات';

  @override
  String get errorActionContactSupport => 'تماس با پشتیبانی';

  @override
  String get errorBadRequest => 'درخواست نامعتبر';

  @override
  String get errorBadRequestMessage =>
      'درخواست نامعتبر بود. لطفاً بازبینی و دوباره تلاش کنید.';

  @override
  String get errorUnauthorized => 'غیرمجاز';

  @override
  String get errorLoginRequiredMessage => 'لطفاً برای ادامه وارد شوید.';

  @override
  String get errorAccessDenied => 'دسترسی رد شد';

  @override
  String get errorAccessDeniedMessage => 'شما اجازه انجام این کار را ندارید.';

  @override
  String get errorNotFound => 'یافت نشد';

  @override
  String get errorNotFoundMessage =>
      'نتوانستیم آنچه را جستجو می‌کردید پیدا کنیم.';

  @override
  String get errorConflict => 'تعارض';

  @override
  String get errorConflictMessage =>
      'این اقدام با داده‌های موجود در تعارض است.';

  @override
  String get errorInvalidData => 'داده نامعتبر';

  @override
  String get errorInvalidDataMessage => 'برخی فیلدها نیاز به توجه شما دارند.';

  @override
  String get errorTooManyRequests => 'درخواست‌های بیش از حد';

  @override
  String get errorTooManyRequestsMessage =>
      'لطفاً لحظه‌ای صبر کنید و دوباره تلاش کنید.';

  @override
  String get errorServerError => 'خطای سرور';

  @override
  String get errorServerErrorMessage =>
      'سرور با مشکل مواجه شد. لطفاً دوباره تلاش کنید.';

  @override
  String get errorRequestTimedOut => 'مهلت درخواست تمام شد';

  @override
  String get errorRequestTimedOutMessage => 'پاسخ سرور خیلی طول کشیده است.';

  @override
  String get errorAuthenticationRequired => 'احراز هویت لازم است';

  @override
  String get errorInvalidInput => 'ورودی نامعتبر';

  @override
  String get errorReviewFieldsMessage =>
      'لطفاً فیلدهای مشخص‌شده را بازبینی کنید.';

  @override
  String get errorPlatformError => 'خطای سکو';

  @override
  String get errorDeviceErrorMessage => 'در این دستگاه مشکلی پیش آمد.';

  @override
  String get errorConnectionFailed => 'اتصال ناموفق بود';

  @override
  String get errorConnectionFailedMessage =>
      'اتصال اینترنت خود را بررسی کنید و دوباره تلاش کنید.';

  @override
  String get errorSecureConnectionFailed => 'اتصال امن ناموفق بود';

  @override
  String get errorSecureConnectionMessage =>
      'نتوانستیم اتصال امنی برقرار کنیم.';

  @override
  String get tableResizeColumn => 'تغییر اندازه ستون';

  @override
  String get tableResizeRow => 'تغییر اندازه ردیف';

  @override
  String get resizableHandle => 'دستگیره تغییر اندازه';

  @override
  String get spellCheckNoSuggestions => 'پیشنهادی نیست';

  @override
  String get announcementLoading => 'در حال بارگیری';

  @override
  String get announcementSuccess => 'موفقیت';

  @override
  String get announcementFailure => 'شکست';

  @override
  String get toolbarMore => 'بیشتر';

  @override
  String get toolbarMoreActions => 'اقدامات بیشتر';

  @override
  String get treeCollapse => 'بستن';

  @override
  String get treeExpand => 'گسترش';

  @override
  String get markdownDetails => 'جزئیات';

  @override
  String get carouselLabel => 'چرخونک ویژه';

  @override
  String get carouselPrimaryAction => 'افزودن به گفتگو';

  @override
  String carouselItemPreview(Object? title) =>
      'پیش‌نمایش ویژگی: ${title ?? mediaUntitled}';

  @override
  String carouselPageOf(int position, int length) =>
      'صفحه ${_number(position)} از ${_number(length)}';

  @override
  String stepperStep(int index) => 'مرحله ${_number(index + 1)}';

  @override
  String paginationPage(Object? page) => 'صفحه ${_number(page)}';

  @override
  String chartSeriesDefault(int index) => 'سری ${_number(index + 1)}';

  @override
  String chartSliceDefault(int index) => 'برش ${_number(index)}';

  @override
  String chartCategoryDefault(int index) => 'دسته ${_number(index)}';

  @override
  String get chartValueDefault => 'مقدار';

  @override
  String get chartKindLine => 'خطی';

  @override
  String get chartKindArea => 'ناحیه‌ای';

  @override
  String get chartKindBar => 'میله‌ای';

  @override
  String get chartKindDonut => 'دونات';

  @override
  String get chartKindPie => 'دایره‌ای';

  @override
  String get chartKindSparkline => 'خط جرقه‌ای';

  @override
  String get chartKindScatter => 'پراکندگی';

  @override
  String get chartKindRadar => 'راداری';

  @override
  String get chartKindRadial => 'شعاعی';

  @override
  String chartSummaryEmpty(Object? kind) => 'نمودار $kind بدون داده';

  @override
  String chartSummary(int series, int points, Object? kind) =>
      'نمودار $kind با ${_number(series)} سری و ${_number(points)} نقطه';

  @override
  String get colorFieldHsv => 'فیلد رنگ HSV';

  @override
  String get colorFieldHsl => 'فیلد رنگ HSL';

  @override
  String get actionClear => 'پاک کردن';

  @override
  String get actionApply => 'اعمال';

  @override
  String get actionVerify => 'تأیید';

  @override
  String get actionResend => 'ارسال مجدد';

  @override
  String resendInSeconds(int seconds) =>
      'ارسال مجدد در ${_number(seconds)} ثانیه';

  @override
  String get authCode => 'کد';

  @override
  String get authEmail => 'ایمیل';

  @override
  String get authPassword => 'گذرواژه';

  @override
  String get authName => 'نام';

  @override
  String get authSignIn => 'ورود';

  @override
  String get authForgotPassword => 'گذرواژه را فراموش کردید؟';

  @override
  String get authRememberMe => 'مرا به خاطر بسپار';

  @override
  String get authCreateAccount => 'ایجاد حساب';

  @override
  String get actionClose => 'بستن';

  @override
  String get mediaPlay => 'پخش';

  @override
  String get mediaPause => 'توقف';

  @override
  String get mediaMute => 'بی‌صدا';

  @override
  String get mediaUnmute => 'باصدا';

  @override
  String get mediaVolume => 'صدا';

  @override
  String get mediaSeek => 'جستجو در رسانه';

  @override
  String get mediaDownload => 'دانلود';

  @override
  String get mediaAudioPlayer => 'پخش‌کننده صوتی';

  @override
  String get mediaVideoPlayer => 'پخش‌کننده ویدیویی';

  @override
  String get mediaUntitled => 'بدون عنوان';

  @override
  String get mediaPlaybackFailed => 'پخش ناموفق بود';

  @override
  String get mediaPreviousTrack => 'قطعه قبلی';

  @override
  String get mediaNextTrack => 'قطعه بعدی';

  @override
  String get mediaShuffleDisable => 'غیرفعال کردن پخش تصادفی';

  @override
  String get mediaShuffleEnable => 'فعال کردن پخش تصادفی';

  @override
  String get mediaRepeatDisable => 'غیرفعال کردن تکرار';

  @override
  String get mediaRepeatEnable => 'فعال کردن تکرار';

  @override
  String mediaPlaybackSpeed(Object? speed) =>
      'سرعت پخش ${speed}x، برای تغییر ضربه بزنید';

  @override
  String mediaPositionOf(Object position, Object duration) =>
      '$position از $duration';

  @override
  String mediaHours(int count) =>
      count == 1 ? '۱ ساعت' : '${_number(count)} ساعت';

  @override
  String mediaMinutes(int count) =>
      count == 1 ? '۱ دقیقه' : '${_number(count)} دقیقه';

  @override
  String mediaSeconds(int count) =>
      count == 1 ? '۱ ثانیه' : '${_number(count)} ثانیه';

  @override
  String get signaturePadLabel => 'صفحه امضا';

  @override
  String get qrCodeLabel => 'کد QR';

  @override
  String get marqueeContent => 'محتوای متحرک';

  @override
  String mediaSkipBack(int seconds) => 'برگشت ${_number(seconds)} ثانیه';

  @override
  String mediaSkipForward(int seconds) => 'جلو ${_number(seconds)} ثانیه';

  @override
  String get mediaCaptionsShow => 'نمایش زیرنویس';

  @override
  String get mediaCaptionsHide => 'پنهان کردن زیرنویس';

  @override
  String get mediaCaptionsOn => 'زیرنویس روشن';

  @override
  String get mediaCaptionsOff => 'زیرنویس خاموش';

  @override
  String get mediaFullscreen => 'تمام‌صفحه';

  @override
  String mediaMoreOptionsSpeed(Object? speed) =>
      'گزینه‌های بیشتر، سرعت پخش ${speed}x';

  @override
  String mediaSpeed(Object? speed) => 'سرعت ${speed}x';

  @override
  String get actionStartTrial => 'شروع آزمایش رایگان';

  @override
  String get authFirstName => 'نام';

  @override
  String get authLastName => 'نام خانوادگی';

  @override
  String get authPasswordHint => 'حداقل ۸ نویسه.';

  @override
  String get authUseDifferentEmail => 'استفاده از رایانامه دیگر';

  @override
  String get authWorkEmail => 'رایانامه کاری';

  @override
  String get chartTotalLabel => 'جمع';

  @override
  String get mediaQualityAuto => 'کیفیت خودکار';
}
