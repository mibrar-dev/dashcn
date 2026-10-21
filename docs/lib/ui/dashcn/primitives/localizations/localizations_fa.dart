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

  @override
  String get blockDontHaveAccount => 'حساب ندارید؟';

  @override
  String get blockAlreadyHaveAccount => 'قبلاً حساب ساخته‌اید؟';

  @override
  String get blockNoAccountYet => 'هنوز حساب ندارید؟';

  @override
  String get blockHaveAnAccount => 'حساب دارید؟';

  @override
  String get blockCreateOne => 'بسازید';

  @override
  String get blockCreateAccount => 'ساخت حساب';

  @override
  String get blockCreateYourAccount => 'حساب خود را بسازید';

  @override
  String get blockForgotYourPassword => 'رمز عبور را فراموش کردید؟';

  @override
  String get blockBackToSignIn => 'بازگشت به ورود';

  @override
  String get blockEnterCredentialsWorkspace =>
      'برای دسترسی به فضای کاری، مشخصات خود را وارد کنید.';

  @override
  String get blockEnterCredentialsContinue =>
      'برای ادامه، مشخصات خود را وارد کنید.';

  @override
  String get blockEnterDetailsContinue =>
      'برای ادامه، مشخصات خود را در زیر وارد کنید.';

  @override
  String get blockEnterEmailCreateAccount =>
      'برای ساخت حساب، ایمیل خود را در زیر وارد کنید.';

  @override
  String get blockSignedInWelcomeBack => 'وارد شدید — خوش برگشتید.';

  @override
  String get blockAccountCreatedVerify =>
      'حساب ساخته شد — برای تأیید، صندوق ورودی را بررسی کنید.';

  @override
  String get blockTrialStartedVerify =>
      'دوره آزمایشی آغاز شد — برای تأیید، صندوق ورودی را بررسی کنید.';

  @override
  String get blockPasswordsDoNotMatch => 'رمزهای عبور مطابقت ندارند.';

  @override
  String get blockCurrentPassword => 'رمز عبور فعلی';

  @override
  String get blockNewPassword => 'رمز عبور جدید';

  @override
  String get blockConfirmNewPassword => 'تأیید رمز عبور جدید';

  @override
  String get blockUpdatePassword => 'به‌روزرسانی رمز عبور';

  @override
  String get blockPasswordUpdated => 'رمز عبور به‌روز شد.';

  @override
  String get blockPasswordHintChange =>
      'حداقل ۸ نویسه. تغییر آن شما را در جاهای دیگر خارج می‌کند.';

  @override
  String get blockUsername => 'نام کاربری';

  @override
  String get blockUsernameHint => 'حروف کوچک، ارقام، زیرخط.';

  @override
  String get blockYourAvatar => 'آواتار شما';

  @override
  String get blockUploadImage => 'بارگذاری تصویر';

  @override
  String get blockBio => 'زندگینامه';

  @override
  String get blockBioHint => 'کمی درباره خودتان بگویید';

  @override
  String get blockBioCounterHint => 'حداکثر ۱۶۰ نویسه.';

  @override
  String get blockProfileSaved => 'نمایه ذخیره شد.';

  @override
  String get blockSaveChanges => 'ذخیره تغییرات';

  @override
  String get blockInviteMember => 'دعوت عضو';

  @override
  String get blockRoleAdmin => 'مدیر';

  @override
  String get blockRoleOwner => 'مالک';

  @override
  String get blockRoleMember => 'عضو';

  @override
  String get blockTeam => 'تیم';

  @override
  String get blockProfile => 'نمایه';

  @override
  String get blockSignInWithEmail => 'ورود با ایمیل';

  @override
  String get blockSignUp => 'ثبت‌نام';

  @override
  String get blockPickWayYouPrefer => 'روش دلخواه خود را انتخاب کنید.';

  @override
  String blockContinueWith(Object? provider) => 'ادامه با $provider';

  @override
  String get blockCreating => 'در حال ساخت…';

  @override
  String get blockSigningIn => 'در حال ورود…';

  @override
  String get blockSending => 'در حال ارسال…';

  @override
  String get blockSaving => 'در حال ذخیره…';

  @override
  String get blockPaying => 'در حال پرداخت…';

  @override
  String get blockSendResetLink => 'ارسال پیوند بازنشانی';

  @override
  String get blockResetPassword => 'بازنشانی رمز عبور';

  @override
  String get blockResetLinkSent =>
      'پیوند بازنشانی ارسال شد. برای ادامه، صندوق ورودی را بررسی کنید.';

  @override
  String get blockWeWillEmailReset =>
      'پیوند بازنشانی را برای شما ایمیل می‌کنیم.';

  @override
  String get blockMustAcceptTerms => 'برای ادامه باید شرایط را بپذیرید.';

  @override
  String get blockCheckInbox => 'صندوق ورودی را بررسی کنید';

  @override
  String get blockEnterSixDigitCode => 'کد ۶ رقمی ارسال‌شده را وارد کنید.';

  @override
  String get blockCodeVerifiedSignedIn => 'کد تأیید شد. وارد شدید.';

  @override
  String get blockEmailVerifiedSet => 'ایمیل تأیید شد — همه‌چیز آماده است.';

  @override
  String get blockVerifyYourEmail => 'ایمیل خود را تأیید کنید';

  @override
  String blockWeSentCodeTo(Object? email) =>
      'یک کد ۶ رقمی به $email ارسال کردیم.';

  @override
  String get blockDidntGetCode => 'کد را دریافت نکردید؟';

  @override
  String get blockBack => 'بازگشت';

  @override
  String get blockBackToCart => 'بازگشت به سبد';

  @override
  String get blockBackToSettings => 'بازگشت به تنظیمات';

  @override
  String get blockOneAccountEverything => 'یک حساب برای همه‌چیز.';

  @override
  String get blockStartTrialNoCard =>
      'دوره آزمایشی ۱۴ روزه را شروع کنید. نیازی به کارت اعتباری نیست.';

  @override
  String get blockNotifications => 'اعلان‌ها';

  @override
  String get blockNotifChoose => 'انتخاب کنید درباره چه چیزی و کجا باخبر شوید.';

  @override
  String get blockEmailNotifications => 'اعلان‌های ایمیلی';

  @override
  String get blockPushNotifications => 'اعلان‌های فوری';

  @override
  String get blockMentionsReplies => 'منشن‌ها و پاسخ‌ها';

  @override
  String get blockDeliveredToDevices => 'به دستگاه‌های شما تحویل شد';

  @override
  String blockEmailChannel(Object? channel) => 'ایمیل · $channel';

  @override
  String blockPushChannel(Object? channel) => 'فوری · $channel';

  @override
  String get blockQuietHours => 'ساعات سکوت';

  @override
  String get blockWeeklyDigest => 'خلاصه هفتگی';

  @override
  String get blockWeeklyDigestBlurb => 'هر دوشنبه یک ایمیل با همه اتفاقات.';

  @override
  String get blockPreferencesSaved => 'ترجیحات ذخیره شد.';

  @override
  String get blockSavePreferences => 'ذخیره ترجیحات';

  @override
  String get blockReset => 'بازنشانی';

  @override
  String get blockWelcomeAboard => 'خوش آمدید';

  @override
  String get blockQuickTour => 'یک تور سریع قبل از شروع استفاده از برنامه.';

  @override
  String get blockStayInLoop => 'در جریان بمانید';

  @override
  String get blockMessagesArriveMoment =>
      'پیام‌ها و به‌روزرسانی‌ها همان لحظه می‌رسند.';

  @override
  String get blockNeverMissThing => 'هیچ‌چیز را از دست ندهید';

  @override
  String get blockNotifPermissionBlurb =>
      'فقط موارد مهم را می‌فرستیم: پاسخ‌ها، یادآورها و هشدارهای امنیتی. بعداً می‌توانید تغییر دهید.';

  @override
  String get blockEnableNotifications => 'اعلان‌ها فعال شود؟';

  @override
  String get blockAllowNotifications => 'اجازه اعلان‌ها';

  @override
  String get blockAllowNotificationsBlurb =>
      'برای بهترین استفاده از برنامه، اجازه اعلان‌ها را بدهید.';

  @override
  String get blockNotNow => 'فعلاً نه';

  @override
  String get blockSkip => 'رد شدن';

  @override
  String get blockGetStarted => 'شروع کنید';

  @override
  String get blockMessages => 'پیام‌ها';

  @override
  String get blockNoConversations => 'گفت‌وگویی نیست';

  @override
  String get blockPullRefreshChat =>
      'برای تازه‌سازی بکشید یا گفت‌وگوی جدیدی شروع کنید.';

  @override
  String get blockMute => 'بی‌صدا';

  @override
  String get blockMuted => 'بی‌صدا شده';

  @override
  String get blockAttach => 'پیوست';

  @override
  String get blockAttachFile => 'فایل';

  @override
  String get blockAttachPhoto => 'عکس';

  @override
  String get blockWriteMessage => 'پیام بنویسید…';

  @override
  String get blockYourCart => 'سبد خرید شما';

  @override
  String get blockAddSomethingFirst => 'اول چیزی را که دوست دارید اضافه کنید.';

  @override
  String get blockCartEmpty => 'سبد خرید خالی است';

  @override
  String get blockCheckout => 'تسویه حساب';

  @override
  String blockQty(int quantity) => 'تعداد $quantity';

  @override
  String blockPayTotal(Object? amount) => 'پرداخت $amount';

  @override
  String get blockPayment => 'پرداخت';

  @override
  String get blockCardNumber => 'شماره کارت';

  @override
  String get blockExpiry => 'انقضا';

  @override
  String get blockCvc => 'CVC';

  @override
  String get blockDeliveryAddress => 'نشانی تحویل';

  @override
  String get blockStreet => 'خیابان';

  @override
  String get blockCity => 'شهر';

  @override
  String get blockSaveAndContinue => 'ذخیره و ادامه';

  @override
  String get blockOrderPlaced => 'سفارش ثبت شد';

  @override
  String get blockOrderThanks => 'از خرید شما متشکریم. تأییدیه در راه است.';

  @override
  String get blockContinueShopping => 'ادامه خرید';

  @override
  String get blockSchedule => 'برنامه';

  @override
  String get blockPickDateRangeReport => 'بازه تاریخی گزارش را انتخاب کنید.';

  @override
  String get blockPickDateRange => 'انتخاب بازه تاریخی';

  @override
  String get blockTapAnotherDay => 'برای گسترش بازه، روز دیگری را بزنید';

  @override
  String get blockBookMeeting => 'رزرو جلسه';

  @override
  String get blockPickDayTime => 'یک روز و سپس زمان مناسب را انتخاب کنید.';

  @override
  String get blockFourSlots =>
      'چهار نوبت ۳۰ دقیقه‌ای مانده. یکی را انتخاب کنید.';

  @override
  String blockPickedSlot(Object? slot) => '$slot انتخاب شد، ۳۰ دقیقه.';

  @override
  String get blockOverview => 'نمای کلی';

  @override
  String get blockRevenueOrdersBlurb => 'درآمد، اشتراک‌ها و جدیدترین سفارش‌ها.';

  @override
  String get blockTotalRevenue => 'درآمد کل';

  @override
  String get blockSubscriptions => 'اشتراک‌ها';

  @override
  String get blockSales => 'فروش';

  @override
  String get blockRevenueByMonth => 'درآمد بر اساس ماه';

  @override
  String get blockRecentSales => 'فروش‌های اخیر';

  @override
  String get blockViewAll => 'مشاهده همه';

  @override
  String get blockTransactions => 'تراکنش‌ها';

  @override
  String get blockFilterTransactions => 'پالایش تراکنش‌ها';

  @override
  String get blockCustomer => 'مشتری';

  @override
  String get blockAmount => 'مبلغ';

  @override
  String get blockMethod => 'روش';

  @override
  String get blockStatus => 'وضعیت';

  @override
  String get blockPaid => 'پرداخت‌شده';

  @override
  String get blockPending => 'در انتظار';

  @override
  String get blockRefunded => 'بازپرداخت‌شده';

  @override
  String blockNoTransactions(Object? query) =>
      'هیچ تراکنشی با «$query» مطابقت ندارد.';

  @override
  String blockDeltaFromLastMonth(Object? delta) => '$delta نسبت به ماه گذشته';

  @override
  String get blockAnalytics => 'تحلیل‌ها';

  @override
  String get blockSessionsDevicesBlurb => 'نشست‌ها، دستگاه‌ها و منبع ترافیک.';

  @override
  String get blockSearchReports => 'جست‌وجوی گزارش‌ها';

  @override
  String get blockLast30Days => '۳۰ روز گذشته';

  @override
  String get blockAllDevices => 'همه دستگاه‌ها';

  @override
  String get blockSessions => 'نشست‌ها';

  @override
  String get blockUsers => 'کاربران';

  @override
  String get blockAvgSession => 'میانگین نشست';

  @override
  String get blockBounceRate => 'نرخ پرش';

  @override
  String get blockConversions => 'تبدیل‌ها';

  @override
  String get blockByDevice => 'بر اساس دستگاه';

  @override
  String get blockDesktop => 'دسکتاپ';

  @override
  String get blockMobile => 'موبایل';

  @override
  String get blockTablet => 'تبلت';

  @override
  String get blockDirect => 'مستقیم';

  @override
  String get blockReferral => 'ارجاع';

  @override
  String get blockSocial => 'اجتماعی';

  @override
  String get blockTrafficSources => 'منابع ترافیک';

  @override
  String get blockVisitors => 'بازدیدکنندگان';

  @override
  String get blockHome => 'خانه';

  @override
  String get blockInbox => 'صندوق ورودی';

  @override
  String get blockCalendar => 'تقویم';

  @override
  String get blockCompose => 'نوشتن';

  @override
  String get blockMarkAllRead => 'علامت‌گذاری همه به‌عنوان خوانده‌شده';

  @override
  String get blockStarred => 'ستاره‌دار';

  @override
  String get blockSnoozed => 'به تعویق افتاده';

  @override
  String get blockUnread => 'خوانده‌نشده';

  @override
  String get blockDocuments => 'اسناد';

  @override
  String get blockReports => 'گزارش‌ها';

  @override
  String get blockDashboard => 'داشبورد';

  @override
  String get blockStorage => 'فضای ذخیره‌سازی';

  @override
  String get blockNavigation => 'ناوبری';

  @override
  String get blockSharedWithYou => 'به اشتراک گذاشته‌شده با شما';

  @override
  String get blockRecentProjects => 'پروژه‌های اخیر';

  @override
  String get blockStorageUsed => 'فضای استفاده‌شده';

  @override
  String get blockOpen => 'باز کردن';

  @override
  String get blockLive => 'زنده';

  @override
  String get blockMembers => 'اعضا';

  @override
  String get blockProjects => 'پروژه‌ها';

  @override
  String get blockDeploys => 'استقرارها';

  @override
  String get blockActivity => 'فعالیت';

  @override
  String get blockRecentFiles => 'فایل‌های اخیر';

  @override
  String get blockUsageThisMonth => 'مصرف این ماه';

  @override
  String get blockUpgradePlan => 'ارتقای طرح';

  @override
  String blockNoMatches(Object? query) => 'نتیجه‌ای برای «$query» نیست.';

  @override
  String get blockWorkspaces => 'فضاهای کاری';

  @override
  String get blockPricing => 'قیمت‌گذاری';

  @override
  String get blockPlansScale => 'طرح‌هایی که با شما رشد می‌کنند';

  @override
  String get blockPlansBlurb =>
      'رایگان شروع کنید و وقتی تیم شما رشد کرد ارتقا دهید. هر طرح شامل کتابخانه کامل مؤلفه‌ها و تنظیمات پوسته است.';

  @override
  String get blockPerUserMonth => 'به‌ازای هر کاربر در ماه';

  @override
  String get blockSubscribe => 'اشتراک';

  @override
  String get blockContactSales => 'تماس با فروش';

  @override
  String get blockPromoCode => 'کد تخفیف';

  @override
  String get blockApplyCode => 'اعمال کد';

  @override
  String get blockHaveCodeEnter => 'کد دارید؟ آن را در زیر وارد کنید.';

  @override
  String get blockCodeAppliedDiscount =>
      'کد اعمال شد — تخفیف شما هنگام تسویه نمایش داده می‌شود.';

  @override
  String get blockFaqTitle => 'سؤال‌ها';

  @override
  String get blockFaqChangePlans => 'آیا بعداً می‌توانم طرح را تغییر دهم؟';

  @override
  String get blockFaqChangePlansAnswer =>
      'بله. ارتقاها فوراً اعمال می‌شوند، کاهش‌ها از دوره بعد.';

  @override
  String get blockFaqFreeTrial => 'آیا دوره آزمایشی رایگان وجود دارد؟';

  @override
  String get blockFaqFreeTrialAnswer =>
      'هر طرح با ۱۴ روز شروع می‌شود، بدون نیاز به کارت.';

  @override
  String get blockAccount => 'حساب';

  @override
  String get blockGeneral => 'عمومی';

  @override
  String get blockAppearance => 'ظاهر';

  @override
  String get blockDarkMode => 'حالت تیره';

  @override
  String get blockPreferences => 'ترجیحات';

  @override
  String get blockSignOut => 'خروج';

  @override
  String get blockSignOutConfirm => 'خارج می‌شوید؟';

  @override
  String get blockSignOutBlurb => 'هر وقت بخواهید می‌توانید دوباره وارد شوید.';

  @override
  String get blockSounds => 'صداها';

  @override
  String get blockWhatYouGet => 'چه چیزی دریافت می‌کنید';

  @override
  String get blockAllComponentCategories => 'همه دسته‌های مؤلفه';

  @override
  String get blockPrioritySupport => 'پشتیبانی اولویت‌دار';

  @override
  String get blockUnlimitedProjectsTrial => 'پروژه‌های نامحدود در دوره آزمایشی';

  @override
  String get blockTrialDaysLeft => '۱۴ روز از آزمایشی شما مانده';

  @override
  String get blockStarterChat => 'گفت‌وگو';

  @override
  String get blockStarterShop => 'فروشگاه';

  @override
  String get blockStarterCart => 'سبد';

  @override
  String get blockAddToCart => 'افزودن به سبد';
}
