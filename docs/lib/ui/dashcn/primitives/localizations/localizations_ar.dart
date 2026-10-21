import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

/// Arabic (`ar`) locale data.
///
/// Translations only: anything this table does not override falls
/// through to the English default on [ComponentLocalizations]. Text
/// direction is not handled here - Flutter resolves it from
/// [WidgetsLocalizations] and [Directionality].
class ComponentLocalizationsAr extends ComponentLocalizations {
  /// Creates the Arabic strings.
  const ComponentLocalizationsAr([super.locale = const Locale('ar')]);

  /// Formats [value] as a number in this locale, or returns it
  /// verbatim when it is not a number.
  String _number(Object? value) {
    if (value is! num) return '$value';
    return intl.NumberFormat.decimalPattern(localeName).format(value);
  }

  @override
  String get formNotEmpty => 'لا يمكن ترك هذا الحقل فارغًا';

  @override
  String get invalidValue => 'قيمة غير صالحة';

  @override
  String get invalidEmail => 'بريد إلكتروني غير صالح';

  @override
  String get invalidURL => 'رابط غير صالح';

  @override
  String formLessThan(Object? value) => 'يجب أن يكون أقل من ${_number(value)}';

  @override
  String formGreaterThan(Object? value) =>
      'يجب أن يكون أكبر من ${_number(value)}';

  @override
  String formLessThanOrEqualTo(Object? value) =>
      'يجب أن يكون أقل من أو يساوي ${_number(value)}';

  @override
  String get formPhoneNumberInvalid => 'رقم الهاتف غير صالح';

  @override
  String get formPhoneNumberEmpty => 'رقم الهاتف مطلوب';

  @override
  String formGreaterThanOrEqualTo(Object? value) =>
      'يجب أن يكون أكبر من أو يساوي ${_number(value)}';

  @override
  String formBetweenInclusively(Object? min, Object? max) =>
      'يجب أن يكون بين ${_number(min)} و ${_number(max)} (شاملًا الطرفين)';

  @override
  String formEqualTo(Object? value) => 'يجب أن يساوي ${_number(value)}';

  @override
  String formBetweenExclusively(Object? min, Object? max) =>
      'يجب أن يكون بين ${_number(min)} و ${_number(max)} (غير شامل الطرفين)';

  @override
  String formLengthLessThan(int limit) => 'يجب ألا يقل عن $limit حرفًا';

  @override
  String formLengthGreaterThan(int limit) => 'يجب ألا يزيد عن $limit حرفًا';

  @override
  String get formPasswordDigits => 'يجب أن يحتوي على رقم واحد على الأقل';

  @override
  String get formPasswordLowercase =>
      'يجب أن يحتوي على حرف صغير واحد على الأقل';

  @override
  String get formPasswordUppercase =>
      'يجب أن يحتوي على حرف كبير واحد على الأقل';

  @override
  String get formPasswordSpecial => 'يجب أن يحتوي على رمز خاص واحد على الأقل';

  @override
  String get commandSearch => 'اكتب أمرًا أو ابحث...';

  @override
  String get commandEmpty => 'لا توجد نتائج.';

  @override
  String get datePickerSelectYear => 'اختر سنة';

  @override
  String get abbreviatedMonday => 'إث';

  @override
  String get abbreviatedTuesday => 'ثل';

  @override
  String get abbreviatedWednesday => 'أر';

  @override
  String get abbreviatedThursday => 'خم';

  @override
  String get abbreviatedFriday => 'جم';

  @override
  String get abbreviatedSaturday => 'سب';

  @override
  String get abbreviatedSunday => 'أح';

  @override
  String get monthJanuary => 'يناير';

  @override
  String get monthFebruary => 'فبراير';

  @override
  String get monthMarch => 'مارس';

  @override
  String get monthApril => 'أبريل';

  @override
  String get monthMay => 'مايو';

  @override
  String get monthJune => 'يونيو';

  @override
  String get monthJuly => 'يوليو';

  @override
  String get monthAugust => 'أغسطس';

  @override
  String get monthSeptember => 'سبتمبر';

  @override
  String get monthOctober => 'أكتوبر';

  @override
  String get monthNovember => 'نوفمبر';

  @override
  String get monthDecember => 'ديسمبر';

  @override
  String get abbreviatedJanuary => 'ينا';

  @override
  String get abbreviatedFebruary => 'فبر';

  @override
  String get abbreviatedMarch => 'مار';

  @override
  String get abbreviatedApril => 'أبر';

  @override
  String get abbreviatedMay => 'ماي';

  @override
  String get abbreviatedJune => 'يون';

  @override
  String get abbreviatedJuly => 'يول';

  @override
  String get abbreviatedAugust => 'أغس';

  @override
  String get abbreviatedSeptember => 'سبت';

  @override
  String get abbreviatedOctober => 'أكت';

  @override
  String get abbreviatedNovember => 'نوف';

  @override
  String get abbreviatedDecember => 'ديس';

  @override
  String get dialogDismiss => 'رفض';

  @override
  String get chipInputRemoveChip => 'حذف';

  @override
  String get buttonCancel => 'إلغاء';

  @override
  String get buttonSave => 'حفظ';

  @override
  String get timeHour => 'ساعة';

  @override
  String get timeMinute => 'دقيقة';

  @override
  String get timeSecond => 'ثانية';

  @override
  String get timeAM => 'ص';

  @override
  String get timePM => 'م';

  @override
  String get colorRed => 'أحمر';

  @override
  String get colorGreen => 'أخضر';

  @override
  String get colorBlue => 'أزرق';

  @override
  String get colorAlpha => 'الشفافية';

  @override
  String get colorHue => 'التدرج';

  @override
  String get colorSaturation => 'التشبع';

  @override
  String get colorValue => 'القيمة';

  @override
  String get colorLightness => 'الإضاءة';

  @override
  String get menuCut => 'قص';

  @override
  String get menuCopy => 'نسخ';

  @override
  String get menuPaste => 'لصق';

  @override
  String get menuSelectAll => 'تحديد الكل';

  @override
  String get menuUndo => 'تراجع';

  @override
  String get menuRedo => 'إعادة';

  @override
  String get menuDelete => 'حذف';

  @override
  String get menuShare => 'مشاركة';

  @override
  String get menuSearchWeb => 'البحث في الويب';

  @override
  String get menuLiveTextInput => 'النص المباشر';

  @override
  String get placeholderDatePicker => 'اختر تاريخًا';

  @override
  String get placeholderTimePicker => 'اختر وقتًا';

  @override
  String get placeholderColorPicker => 'اختر لونًا';

  @override
  String get buttonPrevious => 'السابق';

  @override
  String get buttonNext => 'التالي';

  @override
  String get refreshTriggerPull => 'اسحب للتحديث';

  @override
  String get refreshTriggerRelease => 'أفلت للتحديث';

  @override
  String get refreshTriggerRefreshing => 'جارٍ التحديث...';

  @override
  String get refreshTriggerComplete => 'اكتمل التحديث';

  @override
  String get colorPickerTabRGB => 'RGB';

  @override
  String get colorPickerTabHSV => 'HSV';

  @override
  String get colorPickerTabHSL => 'HSL';

  @override
  String get colorPickerTabHEX => 'HEX';

  @override
  String get commandMoveUp => 'تحريك لأعلى';

  @override
  String get commandMoveDown => 'تحريك لأسفل';

  @override
  String get commandActivate => 'تحديد';

  @override
  String get timeDaysAbbreviation => 'يي';

  @override
  String get timeHoursAbbreviation => 'سس';

  @override
  String get timeMinutesAbbreviation => 'دد';

  @override
  String get timeSecondsAbbreviation => 'ثث';

  @override
  String get placeholderDurationPicker => 'اختر مدة';

  @override
  String get durationDay => 'يوم';

  @override
  String get durationHour => 'ساعة';

  @override
  String get durationMinute => 'دقيقة';

  @override
  String get durationSecond => 'ثانية';

  @override
  String get dropzoneIdle => 'تصفح لرفع الملفات';

  @override
  String get dropzoneDragging => 'أفلت الملفات للرفع';

  @override
  String get dropzoneUploading => 'جارٍ رفع الملفات...';

  @override
  String get dropzoneSuccess => 'الملفات جاهزة';

  @override
  String get dropzoneError => 'أصلح الأخطاء للمتابعة';

  @override
  String get dropzoneDisabled => 'رفع الملفات معطل';

  @override
  String get dropzoneBrowse => 'تصفح الملفات';

  @override
  String get emptyStateEmptyTitle => 'لا يوجد شيء هنا بعد';

  @override
  String get emptyStateEmptyDescription => 'أنشئ العنصر الأول للبدء.';

  @override
  String get emptyStateNoResultsTitle => 'لم يتم العثور على نتائج';

  @override
  String get emptyStateNoResultsDescription =>
      'حاول ضبط عوامل التصفية أو عبارات البحث.';

  @override
  String get emptyStateErrorTitle => 'حدث خطأ ما';

  @override
  String get emptyStateErrorDescription =>
      'تعذر تحميل هذه البيانات. حاول مرة أخرى بعد قليل.';

  @override
  String get filterSearch => 'بحث';

  @override
  String get filterSort => 'فرز';

  @override
  String get filterDateRange => 'النطاق الزمني';

  @override
  String get filterClearAll => 'مسح الكل';

  @override
  String get filterFilters => 'عوامل التصفية';

  @override
  String filterActiveCount(int count) =>
      '${_number(count)} من عوامل التصفية النشطة';

  @override
  String filterResultsCount(int count) => '${_number(count)} من النتائج';

  @override
  String get fileUploadChoose => 'اختر ملفًا';

  @override
  String get fileUploadNoFile => 'لم يتم اختيار ملف';

  @override
  String get fileUploadPickFailed => 'فشل اختيار الملف.';

  @override
  String get fileUploadTooMany => 'تم اختيار ملفات كثيرة جدًا.';

  @override
  String get fileUploadTooLarge => 'الملف كبير جدًا.';

  @override
  String get fileUploadInvalidType => 'نوع الملف غير مسموح به.';

  @override
  String get fileUploadUploadFailed => 'فشل الرفع.';

  @override
  String fileUploadUploadFailedFor(String name) => 'فشل الرفع للملف $name.';

  @override
  String get fileUploadStatusQueued => 'في الانتظار';

  @override
  String get fileUploadStatusUploading => 'جارٍ الرفع';

  @override
  String get fileUploadStatusCompleted => 'مكتمل';

  @override
  String get fileUploadStatusFailed => 'فشل';

  @override
  String get fileUploadUnknownType => 'ملف';

  @override
  String get fileUploadRemove => 'إزالة الملف';

  @override
  String get fileUploadRetry => 'إعادة محاولة الرفع';

  @override
  String get fileUploadPreview => 'معاينة الملف';

  @override
  String get fileUploadDownload => 'تنزيل الملف';

  @override
  String get errorSomethingWentWrong => 'حدث خطأ ما';

  @override
  String get errorUnexpectedMessage =>
      'يرجى المحاولة مرة أخرى أو الاتصال بالدعم إذا استمرت المشكلة.';

  @override
  String get errorActionRetry => 'إعادة المحاولة';

  @override
  String get errorActionReport => 'الإبلاغ';

  @override
  String get errorActionBack => 'رجوع';

  @override
  String get errorActionLogin => 'تسجيل الدخول';

  @override
  String get errorActionSettings => 'الإعدادات';

  @override
  String get errorActionContactSupport => 'الاتصال بالدعم';

  @override
  String get errorBadRequest => 'طلب غير صالح';

  @override
  String get errorBadRequestMessage =>
      'الطلب غير صالح. يرجى المراجعة والمحاولة مرة أخرى.';

  @override
  String get errorUnauthorized => 'غير مصرح';

  @override
  String get errorLoginRequiredMessage => 'يرجى تسجيل الدخول للمتابعة.';

  @override
  String get errorAccessDenied => 'تم رفض الوصول';

  @override
  String get errorAccessDeniedMessage => 'ليس لديك إذن لتنفيذ هذا الإجراء.';

  @override
  String get errorNotFound => 'غير موجود';

  @override
  String get errorNotFoundMessage => 'تعذر العثور على ما كنت تبحث عنه.';

  @override
  String get errorConflict => 'تعارض';

  @override
  String get errorConflictMessage => 'يتعارض هذا الإجراء مع البيانات الموجودة.';

  @override
  String get errorInvalidData => 'بيانات غير صالحة';

  @override
  String get errorInvalidDataMessage => 'بعض الحقول تحتاج إلى انتباهك.';

  @override
  String get errorTooManyRequests => 'طلبات كثيرة جدًا';

  @override
  String get errorTooManyRequestsMessage =>
      'يرجى الانتظار قليلًا ثم المحاولة مرة أخرى.';

  @override
  String get errorServerError => 'خطأ في الخادم';

  @override
  String get errorServerErrorMessage =>
      'واجه الخادم مشكلة. يرجى المحاولة مرة أخرى.';

  @override
  String get errorRequestTimedOut => 'انتهت مهلة الطلب';

  @override
  String get errorRequestTimedOutMessage => 'يستغرق الخادم وقتًا طويلًا للرد.';

  @override
  String get errorAuthenticationRequired => 'المصادقة مطلوبة';

  @override
  String get errorInvalidInput => 'إدخال غير صالح';

  @override
  String get errorReviewFieldsMessage => 'يرجى مراجعة الحقول المميزة.';

  @override
  String get errorPlatformError => 'خطأ في المنصة';

  @override
  String get errorDeviceErrorMessage => 'حدث خطأ ما على هذا الجهاز.';

  @override
  String get errorConnectionFailed => 'فشل الاتصال';

  @override
  String get errorConnectionFailedMessage =>
      'تحقق من اتصالك بالإنترنت وحاول مرة أخرى.';

  @override
  String get errorSecureConnectionFailed => 'فشل الاتصال الآمن';

  @override
  String get errorSecureConnectionMessage => 'تعذر إنشاء اتصال آمن.';

  @override
  String get tableResizeColumn => 'تغيير حجم العمود';

  @override
  String get tableResizeRow => 'تغيير حجم الصف';

  @override
  String get resizableHandle => 'مقبض تغيير الحجم';

  @override
  String get spellCheckNoSuggestions => 'لا توجد اقتراحات';

  @override
  String get announcementLoading => 'جارٍ التحميل';

  @override
  String get announcementSuccess => 'نجاح';

  @override
  String get announcementFailure => 'فشل';

  @override
  String get toolbarMore => 'المزيد';

  @override
  String get toolbarMoreActions => 'المزيد من الإجراءات';

  @override
  String get treeCollapse => 'طي';

  @override
  String get treeExpand => 'توسيع';

  @override
  String get markdownDetails => 'التفاصيل';

  @override
  String get carouselLabel => 'كاروسيل مميز';

  @override
  String get carouselPrimaryAction => 'أضف إلى الدردشة';

  @override
  String carouselItemPreview(Object? title) =>
      'معاينة الميزة: ${title ?? mediaUntitled}';

  @override
  String carouselPageOf(int position, int length) =>
      'الصفحة ${_number(position)} من ${_number(length)}';

  @override
  String stepperStep(int index) => 'الخطوة ${_number(index + 1)}';

  @override
  String paginationPage(Object? page) => 'الصفحة ${_number(page)}';

  @override
  String chartSeriesDefault(int index) => 'السلسلة ${_number(index + 1)}';

  @override
  String chartSliceDefault(int index) => 'الشريحة ${_number(index)}';

  @override
  String chartCategoryDefault(int index) => 'الفئة ${_number(index)}';

  @override
  String get chartValueDefault => 'القيمة';

  @override
  String get chartKindLine => 'خط';

  @override
  String get chartKindArea => 'مساحة';

  @override
  String get chartKindBar => 'شريط';

  @override
  String get chartKindDonut => 'دونت';

  @override
  String get chartKindPie => 'دائري';

  @override
  String get chartKindSparkline => 'خط مصغر';

  @override
  String get chartKindScatter => 'مبعثر';

  @override
  String get chartKindRadar => 'راداري';

  @override
  String get chartKindRadial => 'شعاعي';

  @override
  String chartSummaryEmpty(Object? kind) => 'مخطط $kind بدون بيانات';

  @override
  String chartSummary(int series, int points, Object? kind) =>
      'مخطط $kind يحتوي على ${_number(series)} من السلاسل و ${_number(points)} من النقاط';

  @override
  String get colorFieldHsv => 'حقل ألوان HSV';

  @override
  String get colorFieldHsl => 'حقل ألوان HSL';

  @override
  String get actionClear => 'مسح';

  @override
  String get actionApply => 'تطبيق';

  @override
  String get actionVerify => 'تحقق';

  @override
  String get actionResend => 'إعادة الإرسال';

  @override
  String resendInSeconds(int seconds) =>
      'إعادة الإرسال خلال ${_number(seconds)} ث';

  @override
  String get authCode => 'الرمز';

  @override
  String get authEmail => 'البريد الإلكتروني';

  @override
  String get authPassword => 'كلمة المرور';

  @override
  String get authName => 'الاسم';

  @override
  String get authSignIn => 'تسجيل الدخول';

  @override
  String get authForgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get authRememberMe => 'تذكرني';

  @override
  String get authCreateAccount => 'إنشاء حساب';

  @override
  String get actionClose => 'إغلاق';

  @override
  String get mediaPlay => 'تشغيل';

  @override
  String get mediaPause => 'إيقاف مؤقت';

  @override
  String get mediaMute => 'كتم';

  @override
  String get mediaUnmute => 'إلغاء الكتم';

  @override
  String get mediaVolume => 'مستوى الصوت';

  @override
  String get mediaSeek => 'تقديم';

  @override
  String get mediaDownload => 'تنزيل';

  @override
  String get mediaAudioPlayer => 'مشغل الصوت';

  @override
  String get mediaVideoPlayer => 'مشغل الفيديو';

  @override
  String get mediaUntitled => 'بدون عنوان';

  @override
  String get mediaPlaybackFailed => 'فشل التشغيل';

  @override
  String get mediaPreviousTrack => 'المقطع السابق';

  @override
  String get mediaNextTrack => 'المقطع التالي';

  @override
  String get mediaShuffleDisable => 'تعطيل التشغيل العشوائي';

  @override
  String get mediaShuffleEnable => 'تمكين التشغيل العشوائي';

  @override
  String get mediaRepeatDisable => 'تعطيل التكرار';

  @override
  String get mediaRepeatEnable => 'تمكين التكرار';

  @override
  String mediaPlaybackSpeed(Object? speed) =>
      'سرعة التشغيل ${speed}x، انقر للتغيير';

  @override
  String mediaPositionOf(Object position, Object duration) =>
      '$position من $duration';

  @override
  String mediaHours(int count) =>
      count == 1 ? 'ساعة واحدة' : '${_number(count)} ساعات';

  @override
  String mediaMinutes(int count) =>
      count == 1 ? 'دقيقة واحدة' : '${_number(count)} دقائق';

  @override
  String mediaSeconds(int count) =>
      count == 1 ? 'ثانية واحدة' : '${_number(count)} ثوانٍ';

  @override
  String get signaturePadLabel => 'لوحة التوقيع';

  @override
  String get qrCodeLabel => 'رمز QR';

  @override
  String get marqueeContent => 'محتوى الشريط المتحرك';

  @override
  String mediaSkipBack(int seconds) => 'رجوع ${_number(seconds)} ثانية';

  @override
  String mediaSkipForward(int seconds) => 'تقديم ${_number(seconds)} ثانية';

  @override
  String get mediaCaptionsShow => 'إظهار الترجمة';

  @override
  String get mediaCaptionsHide => 'إخفاء الترجمة';

  @override
  String get mediaCaptionsOn => 'الترجمة مفعّلة';

  @override
  String get mediaCaptionsOff => 'الترجمة معطّلة';

  @override
  String get mediaFullscreen => 'ملء الشاشة';

  @override
  String mediaMoreOptionsSpeed(Object? speed) =>
      'مزيد من الخيارات، سرعة التشغيل ${speed}x';

  @override
  String mediaSpeed(Object? speed) => 'السرعة ${speed}x';

  @override
  String get actionStartTrial => 'بدء التجربة المجانية';

  @override
  String get authFirstName => 'الاسم الأول';

  @override
  String get authLastName => 'اسم العائلة';

  @override
  String get authPasswordHint => '8 أحرف على الأقل.';

  @override
  String get authUseDifferentEmail => 'استخدام بريد إلكتروني مختلف';

  @override
  String get authWorkEmail => 'البريد الإلكتروني للعمل';

  @override
  String get chartTotalLabel => 'الإجمالي';

  @override
  String get mediaQualityAuto => 'الجودة تلقائية';
}
