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

  @override
  String get mediaLiveBadge => 'مباشر';

  @override
  String get blockDontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get blockAlreadyHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get blockNoAccountYet => 'لا يوجد حساب بعد؟';

  @override
  String get blockHaveAnAccount => 'لديك حساب؟';

  @override
  String get blockCreateOne => 'أنشئ واحدًا';

  @override
  String get blockCreateAccount => 'إنشاء حساب';

  @override
  String get blockCreateYourAccount => 'أنشئ حسابك';

  @override
  String get blockForgotYourPassword => 'نسيت كلمة المرور؟';

  @override
  String get blockBackToSignIn => 'العودة إلى تسجيل الدخول';

  @override
  String get blockEnterCredentialsWorkspace =>
      'أدخل بيانات الاعتماد للوصول إلى مساحة العمل.';

  @override
  String get blockEnterCredentialsContinue => 'أدخل بيانات الاعتماد للمتابعة.';

  @override
  String get blockEnterDetailsContinue => 'أدخل بياناتك أدناه للمتابعة.';

  @override
  String get blockEnterEmailCreateAccount =>
      'أدخل بريدك الإلكتروني أدناه لإنشاء حسابك.';

  @override
  String get blockSignedInWelcomeBack => 'تم تسجيل الدخول — أهلاً بعودتك.';

  @override
  String get blockAccountCreatedVerify =>
      'تم إنشاء الحساب — تحقق من بريدك الوارد لتفعيله.';

  @override
  String get blockTrialStartedVerify =>
      'بدأت الفترة التجريبية — تحقق من بريدك الوارد لتفعيلها.';

  @override
  String get blockPasswordsDoNotMatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get blockCurrentPassword => 'كلمة المرور الحالية';

  @override
  String get blockNewPassword => 'كلمة المرور الجديدة';

  @override
  String get blockConfirmNewPassword => 'تأكيد كلمة المرور الجديدة';

  @override
  String get blockUpdatePassword => 'تحديث كلمة المرور';

  @override
  String get blockPasswordUpdated => 'تم تحديث كلمة المرور.';

  @override
  String get blockPasswordHintChange =>
      '8 أحرف على الأقل. تغييرها يسجّل خروجك في أماكن أخرى.';

  @override
  String get blockUsername => 'اسم المستخدم';

  @override
  String get blockUsernameHint => 'أحرف صغيرة وأرقام وشرطات سفلية.';

  @override
  String get blockYourAvatar => 'صورتك الرمزية';

  @override
  String get blockUploadImage => 'تحميل صورة';

  @override
  String get blockBio => 'نبذة';

  @override
  String get blockBioHint => 'أخبرنا قليلاً عن نفسك';

  @override
  String get blockBioCounterHint => 'حتى 160 حرفًا.';

  @override
  String get blockProfileSaved => 'تم حفظ الملف الشخصي.';

  @override
  String get blockSaveChanges => 'حفظ التغييرات';

  @override
  String get blockInviteMember => 'دعوة عضو';

  @override
  String get blockRoleAdmin => 'مشرف';

  @override
  String get blockRoleOwner => 'مالك';

  @override
  String get blockRoleMember => 'عضو';

  @override
  String get blockTeam => 'الفريق';

  @override
  String get blockProfile => 'الملف الشخصي';

  @override
  String get blockSignInWithEmail => 'تسجيل الدخول بالبريد الإلكتروني';

  @override
  String get blockSignUp => 'إنشاء حساب';

  @override
  String get blockPickWayYouPrefer => 'اختر الطريقة التي تناسبك.';

  @override
  String blockContinueWith(Object? provider) => 'المتابعة باستخدام $provider';

  @override
  String get blockCreating => 'جارٍ الإنشاء…';

  @override
  String get blockSigningIn => 'جارٍ تسجيل الدخول…';

  @override
  String get blockSending => 'جارٍ الإرسال…';

  @override
  String get blockSaving => 'جارٍ الحفظ…';

  @override
  String get blockPaying => 'جارٍ الدفع…';

  @override
  String get blockSendResetLink => 'إرسال رابط إعادة التعيين';

  @override
  String get blockResetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get blockResetLinkSent =>
      'تم إرسال رابط إعادة التعيين. تحقق من بريدك الوارد للمتابعة.';

  @override
  String get blockWeWillEmailReset => 'سنرسل لك رابط إعادة التعيين عبر البريد.';

  @override
  String get blockMustAcceptTerms => 'يجب قبول الشروط للمتابعة.';

  @override
  String get blockCheckInbox => 'تحقق من بريدك الوارد';

  @override
  String get blockEnterSixDigitCode =>
      'أدخل الرمز المكوّن من 6 أرقام الذي أرسلناه إليك.';

  @override
  String get blockCodeVerifiedSignedIn => 'تم التحقق من الرمز. تم تسجيل دخولك.';

  @override
  String get blockEmailVerifiedSet => 'تم التحقق من البريد — كل شيء جاهز.';

  @override
  String get blockVerifyYourEmail => 'تحقق من بريدك الإلكتروني';

  @override
  String blockWeSentCodeTo(Object? email) =>
      'أرسلنا رمزًا من 6 أرقام إلى $email.';

  @override
  String get blockDidntGetCode => 'لم يصلك الرمز؟';

  @override
  String get blockBack => 'رجوع';

  @override
  String get blockBackToCart => 'العودة إلى السلة';

  @override
  String get blockBackToSettings => 'العودة إلى الإعدادات';

  @override
  String get blockOneAccountEverything => 'حساب واحد لكل شيء.';

  @override
  String get blockStartTrialNoCard =>
      'ابدأ تجربتك المجانية لمدة 14 يومًا. لا حاجة لبطاقة ائتمان.';

  @override
  String get blockNotifications => 'الإشعارات';

  @override
  String get blockNotifChoose => 'اختر ما تريد سماعه، وأين.';

  @override
  String get blockEmailNotifications => 'إشعارات البريد الإلكتروني';

  @override
  String get blockPushNotifications => 'الإشعارات الفورية';

  @override
  String get blockMentionsReplies => 'المنشن والردود';

  @override
  String get blockDeliveredToDevices => 'تُسلَّم إلى أجهزتك';

  @override
  String blockEmailChannel(Object? channel) => 'البريد · $channel';

  @override
  String blockPushChannel(Object? channel) => 'فوري · $channel';

  @override
  String get blockQuietHours => 'ساعات الهدوء';

  @override
  String get blockWeeklyDigest => 'الملخص الأسبوعي';

  @override
  String get blockWeeklyDigestBlurb => 'بريد واحد كل يوم اثنين بكل ما حدث.';

  @override
  String get blockPreferencesSaved => 'تم حفظ التفضيلات.';

  @override
  String get blockSavePreferences => 'حفظ التفضيلات';

  @override
  String get blockReset => 'إعادة تعيين';

  @override
  String get blockWelcomeAboard => 'أهلاً بك';

  @override
  String get blockQuickTour => 'جولة سريعة قبل أن تبدأ استخدام التطبيق.';

  @override
  String get blockStayInLoop => 'ابقَ على اطلاع';

  @override
  String get blockMessagesArriveMoment => 'تصل الرسائل والتحديثات لحظة حدوثها.';

  @override
  String get blockNeverMissThing => 'لا يفوتك شيء';

  @override
  String get blockNotifPermissionBlurb =>
      'نرسل فقط ما يهم: الردود والتذكيرات وتنبيهات الأمان. يمكنك تغيير ذلك لاحقًا.';

  @override
  String get blockEnableNotifications => 'تفعيل الإشعارات؟';

  @override
  String get blockAllowNotifications => 'السماح بالإشعارات';

  @override
  String get blockAllowNotificationsBlurb =>
      'اسمح بالإشعارات لتحصل على أفضل تجربة من التطبيق.';

  @override
  String get blockNotNow => 'ليس الآن';

  @override
  String get blockSkip => 'تخطَّ';

  @override
  String get blockGetStarted => 'ابدأ';

  @override
  String get blockMessages => 'الرسائل';

  @override
  String get blockNoConversations => 'لا توجد محادثات';

  @override
  String get blockPullRefreshChat => 'اسحب للتحديث أو ابدأ محادثة جديدة.';

  @override
  String get blockMute => 'كتم';

  @override
  String get blockMuted => 'مكتوم';

  @override
  String get blockAttach => 'إرفاق';

  @override
  String get blockAttachFile => 'ملف';

  @override
  String get blockAttachPhoto => 'صورة';

  @override
  String get blockWriteMessage => 'اكتب رسالة…';

  @override
  String get blockYourCart => 'سلة التسوق';

  @override
  String get blockAddSomethingFirst => 'أضف شيئًا يعجبك أولاً.';

  @override
  String get blockCartEmpty => 'السلة فارغة';

  @override
  String get blockCheckout => 'إتمام الطلب';

  @override
  String blockQty(int quantity) => 'الكمية $quantity';

  @override
  String blockPayTotal(Object? amount) => 'ادفع $amount';

  @override
  String get blockPayment => 'الدفع';

  @override
  String get blockCardNumber => 'رقم البطاقة';

  @override
  String get blockExpiry => 'تاريخ الانتهاء';

  @override
  String get blockCvc => 'CVC';

  @override
  String get blockDeliveryAddress => 'عنوان التوصيل';

  @override
  String get blockStreet => 'الشارع';

  @override
  String get blockCity => 'المدينة';

  @override
  String get blockSaveAndContinue => 'حفظ ومتابعة';

  @override
  String get blockOrderPlaced => 'تم تقديم الطلب';

  @override
  String get blockOrderThanks =>
      'شكرًا لتسوقكم معنا. تأكيد الطلب في الطريق إليكم.';

  @override
  String get blockContinueShopping => 'مواصلة التسوق';

  @override
  String get blockSchedule => 'الجدول';

  @override
  String get blockPickDateRangeReport => 'اختر نطاقًا زمنيًا لتقريرك.';

  @override
  String get blockPickDateRange => 'اختر نطاقًا زمنيًا';

  @override
  String get blockTapAnotherDay => 'انقر يومًا آخر لتمديد النطاق';

  @override
  String get blockBookMeeting => 'احجز اجتماعًا';

  @override
  String get blockPickDayTime => 'اختر يومًا ثم وقتًا يناسبك.';

  @override
  String get blockFourSlots =>
      'تبقت أربعة مواعيد، 30 دقيقة لكل منها. اختر واحدًا.';

  @override
  String blockPickedSlot(Object? slot) => 'تم اختيار $slot، 30 دقيقة.';

  @override
  String get blockOverview => 'نظرة عامة';

  @override
  String get blockRevenueOrdersBlurb => 'الإيرادات والاشتراكات وأحدث الطلبات.';

  @override
  String get blockTotalRevenue => 'إجمالي الإيرادات';

  @override
  String get blockSubscriptions => 'الاشتراكات';

  @override
  String get blockSales => 'المبيعات';

  @override
  String get blockRevenueByMonth => 'الإيرادات حسب الشهر';

  @override
  String get blockRecentSales => 'أحدث المبيعات';

  @override
  String get blockViewAll => 'عرض الكل';

  @override
  String get blockTransactions => 'المعاملات';

  @override
  String get blockFilterTransactions => 'تصفية المعاملات';

  @override
  String get blockCustomer => 'العميل';

  @override
  String get blockAmount => 'المبلغ';

  @override
  String get blockMethod => 'الطريقة';

  @override
  String get blockStatus => 'الحالة';

  @override
  String get blockPaid => 'مدفوعة';

  @override
  String get blockPending => 'قيد الانتظار';

  @override
  String get blockRefunded => 'مستردة';

  @override
  String blockNoTransactions(Object? query) =>
      'لا توجد معاملات تطابق “$query”.';

  @override
  String blockDeltaFromLastMonth(Object? delta) => '$delta عن الشهر الماضي';

  @override
  String get blockAnalytics => 'التحليلات';

  @override
  String get blockSessionsDevicesBlurb => 'الجلسات والأجهزة ومصادر الزيارات.';

  @override
  String get blockSearchReports => 'البحث في التقارير';

  @override
  String get blockLast30Days => 'آخر 30 يومًا';

  @override
  String get blockAllDevices => 'كل الأجهزة';

  @override
  String get blockSessions => 'الجلسات';

  @override
  String get blockUsers => 'المستخدمون';

  @override
  String get blockAvgSession => 'متوسط الجلسة';

  @override
  String get blockBounceRate => 'معدل الارتداد';

  @override
  String get blockConversions => 'التحويلات';

  @override
  String get blockByDevice => 'حسب الجهاز';

  @override
  String get blockDesktop => 'سطح المكتب';

  @override
  String get blockMobile => 'الجوال';

  @override
  String get blockTablet => 'الجهاز اللوحي';

  @override
  String get blockDirect => 'مباشر';

  @override
  String get blockReferral => 'إحالة';

  @override
  String get blockSocial => 'اجتماعي';

  @override
  String get blockTrafficSources => 'مصادر الزيارات';

  @override
  String get blockVisitors => 'الزوار';

  @override
  String get blockHome => 'الرئيسية';

  @override
  String get blockInbox => 'البريد الوارد';

  @override
  String get blockCalendar => 'التقويم';

  @override
  String get blockCompose => 'إنشاء';

  @override
  String get blockMarkAllRead => 'تعليم الكل كمقروء';

  @override
  String get blockStarred => 'مميزة بنجمة';

  @override
  String get blockSnoozed => 'مؤجلة';

  @override
  String get blockUnread => 'غير مقروءة';

  @override
  String get blockDocuments => 'المستندات';

  @override
  String get blockReports => 'التقارير';

  @override
  String get blockDashboard => 'لوحة التحكم';

  @override
  String get blockStorage => 'التخزين';

  @override
  String get blockNavigation => 'التنقل';

  @override
  String get blockSharedWithYou => 'مُشارَك معك';

  @override
  String get blockRecentProjects => 'المشاريع الأخيرة';

  @override
  String get blockStorageUsed => 'المساحة المستخدمة';

  @override
  String get blockOpen => 'فتح';

  @override
  String get blockLive => 'مباشر';

  @override
  String get blockMembers => 'الأعضاء';

  @override
  String get blockProjects => 'المشاريع';

  @override
  String get blockDeploys => 'عمليات النشر';

  @override
  String get blockActivity => 'النشاط';

  @override
  String get blockRecentFiles => 'الملفات الأخيرة';

  @override
  String get blockUsageThisMonth => 'الاستخدام هذا الشهر';

  @override
  String get blockUpgradePlan => 'ترقية الخطة';

  @override
  String blockNoMatches(Object? query) => 'لا توجد نتائج مطابقة لـ “$query”.';

  @override
  String get blockWorkspaces => 'مساحات العمل';

  @override
  String get blockPricing => 'الأسعار';

  @override
  String get blockPlansScale => 'خطط تنمو معك';

  @override
  String get blockPlansBlurb =>
      'ابدأ مجانًا وقم بالترقية عندما ينمو فريقك. كل خطة تشمل مكتبة المكونات الكاملة وإعدادات المظهر.';

  @override
  String get blockPerUserMonth => 'لكل مستخدم شهريًا';

  @override
  String get blockSubscribe => 'اشترك';

  @override
  String get blockContactSales => 'تواصل مع المبيعات';

  @override
  String get blockPromoCode => 'الرمز الترويجي';

  @override
  String get blockApplyCode => 'تطبيق الرمز';

  @override
  String get blockHaveCodeEnter => 'لديك رمز؟ أدخله أدناه.';

  @override
  String get blockCodeAppliedDiscount =>
      'تم تطبيق الرمز — يظهر خصمك عند الدفع.';

  @override
  String get blockFaqTitle => 'الأسئلة';

  @override
  String get blockFaqChangePlans => 'هل يمكنني تغيير الخطة لاحقًا؟';

  @override
  String get blockFaqChangePlansAnswer =>
      'نعم. الترقيات فورية، والتخفيضات من الدورة القادمة.';

  @override
  String get blockFaqFreeTrial => 'هل هناك فترة تجريبية مجانية؟';

  @override
  String get blockFaqFreeTrialAnswer =>
      'كل خطة تبدأ بـ 14 يومًا، دون الحاجة إلى بطاقة.';

  @override
  String get blockAccount => 'الحساب';

  @override
  String get blockGeneral => 'عام';

  @override
  String get blockAppearance => 'المظهر';

  @override
  String get blockDarkMode => 'الوضع الداكن';

  @override
  String get blockPreferences => 'التفضيلات';

  @override
  String get blockSignOut => 'تسجيل الخروج';

  @override
  String get blockSignOutConfirm => 'تسجيل الخروج؟';

  @override
  String get blockSignOutBlurb => 'يمكنك دائمًا تسجيل الدخول لاحقًا.';

  @override
  String get blockSounds => 'الأصوات';

  @override
  String get blockWhatYouGet => 'ماذا تحصل عليه';

  @override
  String get blockAllComponentCategories => 'كل فئات المكونات';

  @override
  String get blockPrioritySupport => 'دعم ذو أولوية';

  @override
  String get blockUnlimitedProjectsTrial => 'مشاريع غير محدودة أثناء التجربة';

  @override
  String get blockTrialDaysLeft => 'تبقى 14 يومًا على تجربتك';

  @override
  String get blockStarterChat => 'المحادثة';

  @override
  String get blockStarterShop => 'المتجر';

  @override
  String get blockStarterCart => 'السلة';

  @override
  String get blockAddToCart => 'أضف إلى السلة';
}
