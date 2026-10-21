import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

/// Hebrew (`he`) locale data.
///
/// Translations only: anything this table does not override falls
/// through to the English default on [ComponentLocalizations]. Text
/// direction is not handled here - Flutter resolves it from
/// [WidgetsLocalizations] and [Directionality].
class ComponentLocalizationsHe extends ComponentLocalizations {
  /// Creates the Hebrew strings.
  const ComponentLocalizationsHe([super.locale = const Locale('he')]);

  /// Formats [value] as a number in this locale, or returns it
  /// verbatim when it is not a number.
  String _number(Object? value) {
    if (value is! num) return '$value';
    return intl.NumberFormat.decimalPattern(localeName).format(value);
  }

  @override
  String get formNotEmpty => 'שדה זה אינו יכול להיות ריק';

  @override
  String get invalidValue => 'ערך לא תקין';

  @override
  String get invalidEmail => 'כתובת אימייל לא תקינה';

  @override
  String get invalidURL => 'כתובת URL לא תקינה';

  @override
  String formLessThan(Object? value) => 'חייב להיות קטן מ-${_number(value)}';

  @override
  String formGreaterThan(Object? value) =>
      'חייב להיות גדול מ-${_number(value)}';

  @override
  String formLessThanOrEqualTo(Object? value) =>
      'חייב להיות קטן מ-${_number(value)} או שווה לו';

  @override
  String get formPhoneNumberInvalid => 'מספר הטלפון אינו תקין';

  @override
  String get formPhoneNumberEmpty => 'יש להזין מספר טלפון';

  @override
  String formGreaterThanOrEqualTo(Object? value) =>
      'חייב להיות גדול מ-${_number(value)} או שווה לו';

  @override
  String formBetweenInclusively(Object? min, Object? max) =>
      'חייב להיות בין ${_number(min)} ל-${_number(max)} (כולל)';

  @override
  String formEqualTo(Object? value) => 'חייב להיות שווה ל-${_number(value)}';

  @override
  String formBetweenExclusively(Object? min, Object? max) =>
      'חייב להיות בין ${_number(min)} ל-${_number(max)} (לא כולל)';

  @override
  String formLengthLessThan(int limit) => 'חייב להכיל לפחות $limit תווים';

  @override
  String formLengthGreaterThan(int limit) =>
      'חייב להכיל לכל היותר $limit תווים';

  @override
  String get formPasswordDigits => 'חייב להכיל לפחות ספרה אחת';

  @override
  String get formPasswordLowercase => 'חייב להכיל לפחות אות קטנה אחת';

  @override
  String get formPasswordUppercase => 'חייב להכיל לפחות אות גדולה אחת';

  @override
  String get formPasswordSpecial => 'חייב להכיל לפחות תו מיוחד אחד';

  @override
  String get commandSearch => 'הקלד פקודה או חפש...';

  @override
  String get commandEmpty => 'לא נמצאו תוצאות.';

  @override
  String get datePickerSelectYear => 'בחר שנה';

  @override
  String get abbreviatedMonday => 'ב׳';

  @override
  String get abbreviatedTuesday => 'ג׳';

  @override
  String get abbreviatedWednesday => 'ד׳';

  @override
  String get abbreviatedThursday => 'ה׳';

  @override
  String get abbreviatedFriday => 'ו׳';

  @override
  String get abbreviatedSaturday => 'ש׳';

  @override
  String get abbreviatedSunday => 'א׳';

  @override
  String get monthJanuary => 'ינואר';

  @override
  String get monthFebruary => 'פברואר';

  @override
  String get monthMarch => 'מרץ';

  @override
  String get monthApril => 'אפריל';

  @override
  String get monthMay => 'מאי';

  @override
  String get monthJune => 'יוני';

  @override
  String get monthJuly => 'יולי';

  @override
  String get monthAugust => 'אוגוסט';

  @override
  String get monthSeptember => 'ספטמבר';

  @override
  String get monthOctober => 'אוקטובר';

  @override
  String get monthNovember => 'נובמבר';

  @override
  String get monthDecember => 'דצמבר';

  @override
  String get abbreviatedJanuary => 'ינו׳';

  @override
  String get abbreviatedFebruary => 'פבר׳';

  @override
  String get abbreviatedMarch => 'מרץ';

  @override
  String get abbreviatedApril => 'אפר׳';

  @override
  String get abbreviatedMay => 'מאי';

  @override
  String get abbreviatedJune => 'יוני';

  @override
  String get abbreviatedJuly => 'יולי';

  @override
  String get abbreviatedAugust => 'אוג׳';

  @override
  String get abbreviatedSeptember => 'ספט׳';

  @override
  String get abbreviatedOctober => 'אוק׳';

  @override
  String get abbreviatedNovember => 'נוב׳';

  @override
  String get abbreviatedDecember => 'דצמ׳';

  @override
  String get dialogDismiss => 'סגירה';

  @override
  String get chipInputRemoveChip => 'מחיקה';

  @override
  String get buttonCancel => 'ביטול';

  @override
  String get buttonSave => 'שמירה';

  @override
  String get timeHour => 'שעה';

  @override
  String get timeMinute => 'דקה';

  @override
  String get timeSecond => 'שנייה';

  @override
  String get timeAM => 'לפנה״צ';

  @override
  String get timePM => 'אחה״צ';

  @override
  String get colorRed => 'אדום';

  @override
  String get colorGreen => 'ירוק';

  @override
  String get colorBlue => 'כחול';

  @override
  String get colorAlpha => 'אלפא';

  @override
  String get colorHue => 'גוון';

  @override
  String get colorSaturation => 'רוויה';

  @override
  String get colorValue => 'ערך';

  @override
  String get colorLightness => 'בהירות';

  @override
  String get menuCut => 'גזור';

  @override
  String get menuCopy => 'העתק';

  @override
  String get menuPaste => 'הדבק';

  @override
  String get menuSelectAll => 'בחר הכול';

  @override
  String get menuUndo => 'בטל';

  @override
  String get menuRedo => 'בצע שוב';

  @override
  String get menuDelete => 'מחק';

  @override
  String get menuShare => 'שתף';

  @override
  String get menuSearchWeb => 'חפש באינטרנט';

  @override
  String get menuLiveTextInput => 'טקסט חי';

  @override
  String get placeholderDatePicker => 'בחר תאריך';

  @override
  String get placeholderTimePicker => 'בחר שעה';

  @override
  String get placeholderColorPicker => 'בחר צבע';

  @override
  String get buttonPrevious => 'הקודם';

  @override
  String get buttonNext => 'הבא';

  @override
  String get refreshTriggerPull => 'משוך כדי לרענן';

  @override
  String get refreshTriggerRelease => 'שחרר כדי לרענן';

  @override
  String get refreshTriggerRefreshing => 'מרענן...';

  @override
  String get refreshTriggerComplete => 'הרענון הושלם';

  @override
  String get colorPickerTabRGB => 'RGB';

  @override
  String get colorPickerTabHSV => 'HSV';

  @override
  String get colorPickerTabHSL => 'HSL';

  @override
  String get colorPickerTabHEX => 'HEX';

  @override
  String get commandMoveUp => 'הזז למעלה';

  @override
  String get commandMoveDown => 'הזז למטה';

  @override
  String get commandActivate => 'בחר';

  @override
  String get timeDaysAbbreviation => 'יי';

  @override
  String get timeHoursAbbreviation => 'שש';

  @override
  String get timeMinutesAbbreviation => 'דד';

  @override
  String get timeSecondsAbbreviation => 'שנ';

  @override
  String get placeholderDurationPicker => 'בחר משך זמן';

  @override
  String get durationDay => 'יום';

  @override
  String get durationHour => 'שעה';

  @override
  String get durationMinute => 'דקה';

  @override
  String get durationSecond => 'שנייה';

  @override
  String get dropzoneIdle => 'עיון להעלאת קבצים';

  @override
  String get dropzoneDragging => 'שחרר קבצים להעלאה';

  @override
  String get dropzoneUploading => 'מעלה קבצים...';

  @override
  String get dropzoneSuccess => 'הקבצים מוכנים';

  @override
  String get dropzoneError => 'תקן שגיאות כדי להמשיך';

  @override
  String get dropzoneDisabled => 'העלאת קבצים מושבתת';

  @override
  String get dropzoneBrowse => 'עיון בקבצים';

  @override
  String get emptyStateEmptyTitle => 'אין כאן כלום עדיין';

  @override
  String get emptyStateEmptyDescription => 'צור את הפריט הראשון כדי להתחיל.';

  @override
  String get emptyStateNoResultsTitle => 'לא נמצאו תוצאות';

  @override
  String get emptyStateNoResultsDescription =>
      'נסה להתאים את המסננים או את מונחי החיפוש.';

  @override
  String get emptyStateErrorTitle => 'משהו השתבש';

  @override
  String get emptyStateErrorDescription =>
      'לא הצלחנו לטעון את הנתונים. נסה שוב בעוד רגע.';

  @override
  String get filterSearch => 'חיפוש';

  @override
  String get filterSort => 'מיון';

  @override
  String get filterDateRange => 'טווח תאריכים';

  @override
  String get filterClearAll => 'נקה הכל';

  @override
  String get filterFilters => 'מסננים';

  @override
  String filterActiveCount(int count) => '${_number(count)} מסננים פעילים';

  @override
  String filterResultsCount(int count) => '${_number(count)} תוצאות';

  @override
  String get fileUploadChoose => 'בחר קובץ';

  @override
  String get fileUploadNoFile => 'לא נבחר קובץ';

  @override
  String get fileUploadPickFailed => 'בחירת הקובץ נכשלה.';

  @override
  String get fileUploadTooMany => 'נבחרו קבצים רבים מדי.';

  @override
  String get fileUploadTooLarge => 'הקובץ גדול מדי.';

  @override
  String get fileUploadInvalidType => 'סוג הקובץ אינו מותר.';

  @override
  String get fileUploadUploadFailed => 'ההעלאה נכשלה.';

  @override
  String fileUploadUploadFailedFor(String name) => 'ההעלאה נכשלה עבור $name.';

  @override
  String get fileUploadStatusQueued => 'ממתין';

  @override
  String get fileUploadStatusUploading => 'מעלה';

  @override
  String get fileUploadStatusCompleted => 'הושלם';

  @override
  String get fileUploadStatusFailed => 'נכשל';

  @override
  String get fileUploadUnknownType => 'קובץ';

  @override
  String get fileUploadRemove => 'הסר קובץ';

  @override
  String get fileUploadRetry => 'נסה להעלות שוב';

  @override
  String get fileUploadPreview => 'תצוגה מקדימה של הקובץ';

  @override
  String get fileUploadDownload => 'הורד קובץ';

  @override
  String get errorSomethingWentWrong => 'משהו השתבש';

  @override
  String get errorUnexpectedMessage => 'נסה שוב או פנה לתמיכה אם הבעיה נמשכת.';

  @override
  String get errorActionRetry => 'נסה שוב';

  @override
  String get errorActionReport => 'דווח';

  @override
  String get errorActionBack => 'חזרה';

  @override
  String get errorActionLogin => 'התחברות';

  @override
  String get errorActionSettings => 'הגדרות';

  @override
  String get errorActionContactSupport => 'פנה לתמיכה';

  @override
  String get errorBadRequest => 'בקשה לא תקינה';

  @override
  String get errorBadRequestMessage => 'הבקשה לא הייתה תקינה. בדוק ונסה שוב.';

  @override
  String get errorUnauthorized => 'לא מורשה';

  @override
  String get errorLoginRequiredMessage => 'התחבר כדי להמשיך.';

  @override
  String get errorAccessDenied => 'הגישה נדחתה';

  @override
  String get errorAccessDeniedMessage => 'אין לך הרשאה לבצע פעולה זו.';

  @override
  String get errorNotFound => 'לא נמצא';

  @override
  String get errorNotFoundMessage => 'לא מצאנו את מה שחיפשת.';

  @override
  String get errorConflict => 'קונפליקט';

  @override
  String get errorConflictMessage => 'פעולה זו מתנגשת עם נתונים קיימים.';

  @override
  String get errorInvalidData => 'נתונים לא תקינים';

  @override
  String get errorInvalidDataMessage => 'שדות מסוימים דורשים את תשומת לבך.';

  @override
  String get errorTooManyRequests => 'יותר מדי בקשות';

  @override
  String get errorTooManyRequestsMessage => 'המתן רגע ונסה שוב.';

  @override
  String get errorServerError => 'שגיאת שרת';

  @override
  String get errorServerErrorMessage => 'השרת נתקל בבעיה. נסה שוב.';

  @override
  String get errorRequestTimedOut => 'הבקשה פגה';

  @override
  String get errorRequestTimedOutMessage => 'לשרת לוקח יותר מדי זמן להגיב.';

  @override
  String get errorAuthenticationRequired => 'נדרש אימות';

  @override
  String get errorInvalidInput => 'קלט לא תקין';

  @override
  String get errorReviewFieldsMessage => 'בדוק את השדות המודגשים.';

  @override
  String get errorPlatformError => 'שגיאת פלטפורמה';

  @override
  String get errorDeviceErrorMessage => 'משהו השתבש במכשיר הזה.';

  @override
  String get errorConnectionFailed => 'החיבור נכשל';

  @override
  String get errorConnectionFailedMessage => 'בדוק את חיבור האינטרנט ונסה שוב.';

  @override
  String get errorSecureConnectionFailed => 'החיבור המאובטח נכשל';

  @override
  String get errorSecureConnectionMessage => 'לא הצלחנו ליצור חיבור מאובטח.';

  @override
  String get tableResizeColumn => 'שנה גודל עמודה';

  @override
  String get tableResizeRow => 'שנה גודל שורה';

  @override
  String get resizableHandle => 'ידית שינוי גודל';

  @override
  String get spellCheckNoSuggestions => 'אין הצעות';

  @override
  String get announcementLoading => 'טוען';

  @override
  String get announcementSuccess => 'הצלחה';

  @override
  String get announcementFailure => 'כישלון';

  @override
  String get toolbarMore => 'עוד';

  @override
  String get toolbarMoreActions => 'פעולות נוספות';

  @override
  String get treeCollapse => 'כווץ';

  @override
  String get treeExpand => 'הרחב';

  @override
  String get markdownDetails => 'פרטים';

  @override
  String get carouselLabel => 'קרוסלת תוכן';

  @override
  String get carouselPrimaryAction => 'הוסף לצ׳אט';

  @override
  String carouselItemPreview(Object? title) =>
      'תצוגה מקדימה: ${title ?? mediaUntitled}';

  @override
  String carouselPageOf(int position, int length) =>
      'עמוד ${_number(position)} מתוך ${_number(length)}';

  @override
  String stepperStep(int index) => 'שלב ${_number(index + 1)}';

  @override
  String paginationPage(Object? page) => 'עמוד ${_number(page)}';

  @override
  String chartSeriesDefault(int index) => 'סדרה ${_number(index + 1)}';

  @override
  String chartSliceDefault(int index) => 'פרוסה ${_number(index)}';

  @override
  String chartCategoryDefault(int index) => 'קטגוריה ${_number(index)}';

  @override
  String get chartValueDefault => 'ערך';

  @override
  String get chartKindLine => 'קו';

  @override
  String get chartKindArea => 'שטח';

  @override
  String get chartKindBar => 'עמודה';

  @override
  String get chartKindDonut => 'דונאט';

  @override
  String get chartKindPie => 'עוגה';

  @override
  String get chartKindSparkline => 'ספארקליין';

  @override
  String get chartKindScatter => 'פיזור';

  @override
  String get chartKindRadar => 'מכ״ם';

  @override
  String get chartKindRadial => 'רדיאלי';

  @override
  String chartSummaryEmpty(Object? kind) => 'תרשים $kind ללא נתונים';

  @override
  String chartSummary(int series, int points, Object? kind) =>
      'תרשים $kind עם ${_number(series)} סדרות ו־${_number(points)} נקודות';

  @override
  String get colorFieldHsv => 'שדה צבע HSV';

  @override
  String get colorFieldHsl => 'שדה צבע HSL';

  @override
  String get actionClear => 'נקה';

  @override
  String get actionApply => 'החל';

  @override
  String get actionVerify => 'אמת';

  @override
  String get actionResend => 'שלח שוב';

  @override
  String resendInSeconds(int seconds) =>
      'שליחה חוזרת בעוד ${_number(seconds)} שניות';

  @override
  String get authCode => 'קוד';

  @override
  String get authEmail => 'דוא״ל';

  @override
  String get authPassword => 'סיסמה';

  @override
  String get authName => 'שם';

  @override
  String get authSignIn => 'התחברות';

  @override
  String get authForgotPassword => 'שכחת סיסמה?';

  @override
  String get authRememberMe => 'זכור אותי';

  @override
  String get authCreateAccount => 'צור חשבון';

  @override
  String get actionClose => 'סגור';

  @override
  String get mediaPlay => 'נגן';

  @override
  String get mediaPause => 'השהה';

  @override
  String get mediaMute => 'השתק';

  @override
  String get mediaUnmute => 'בטל השתקה';

  @override
  String get mediaVolume => 'עוצמת קול';

  @override
  String get mediaSeek => 'דלג';

  @override
  String get mediaDownload => 'הורד';

  @override
  String get mediaAudioPlayer => 'נגן אודיו';

  @override
  String get mediaVideoPlayer => 'נגן וידאו';

  @override
  String get mediaUntitled => 'ללא כותרת';

  @override
  String get mediaPlaybackFailed => 'הניגון נכשל';

  @override
  String get mediaPreviousTrack => 'הרצועה הקודמת';

  @override
  String get mediaNextTrack => 'הרצועה הבאה';

  @override
  String get mediaShuffleDisable => 'כבה ערבוב';

  @override
  String get mediaShuffleEnable => 'הפעל ערבוב';

  @override
  String get mediaRepeatDisable => 'כבה חזרה';

  @override
  String get mediaRepeatEnable => 'הפעל חזרה';

  @override
  String mediaPlaybackSpeed(Object? speed) =>
      'מהירות ניגון ${speed}x, הקש לשינוי';

  @override
  String mediaPositionOf(Object position, Object duration) =>
      '$position מתוך $duration';

  @override
  String mediaHours(int count) =>
      count == 1 ? 'שעה אחת' : '${_number(count)} שעות';

  @override
  String mediaMinutes(int count) =>
      count == 1 ? 'דקה אחת' : '${_number(count)} דקות';

  @override
  String mediaSeconds(int count) =>
      count == 1 ? 'שנייה אחת' : '${_number(count)} שניות';

  @override
  String get signaturePadLabel => 'לוח חתימה';

  @override
  String get qrCodeLabel => 'קוד QR';

  @override
  String get marqueeContent => 'תוכן נע';

  @override
  String mediaSkipBack(int seconds) => 'אחורה ${_number(seconds)} שניות';

  @override
  String mediaSkipForward(int seconds) => 'קדימה ${_number(seconds)} שניות';

  @override
  String get mediaCaptionsShow => 'הצג כתוביות';

  @override
  String get mediaCaptionsHide => 'הסתר כתוביות';

  @override
  String get mediaCaptionsOn => 'כתוביות מופעלות';

  @override
  String get mediaCaptionsOff => 'כתוביות כבויות';

  @override
  String get mediaFullscreen => 'מסך מלא';

  @override
  String mediaMoreOptionsSpeed(Object? speed) =>
      'אפשרויות נוספות, מהירות ניגון ${speed}x';

  @override
  String mediaSpeed(Object? speed) => 'מהירות ${speed}x';

  @override
  String get actionStartTrial => 'התחל ניסיון בחינם';

  @override
  String get authFirstName => 'שם פרטי';

  @override
  String get authLastName => 'שם משפחה';

  @override
  String get authPasswordHint => '8 תווים לפחות.';

  @override
  String get authUseDifferentEmail => 'השתמש בכתובת דוא״ל אחרת';

  @override
  String get authWorkEmail => 'דוא״ל בעבודה';

  @override
  String get chartTotalLabel => 'סה״כ';

  @override
  String get mediaQualityAuto => 'איכות אוטומטית';
}
