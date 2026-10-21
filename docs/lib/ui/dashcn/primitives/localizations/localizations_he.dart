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

  @override
  String get mediaLiveBadge => 'חי';

  @override
  String get blockDontHaveAccount => 'אין לך חשבון?';

  @override
  String get blockAlreadyHaveAccount => 'כבר יש לך חשבון?';

  @override
  String get blockNoAccountYet => 'עדיין אין לך חשבון?';

  @override
  String get blockHaveAnAccount => 'יש לך חשבון?';

  @override
  String get blockCreateOne => 'צור אחד';

  @override
  String get blockCreateAccount => 'צור חשבון';

  @override
  String get blockCreateYourAccount => 'צור את החשבון שלך';

  @override
  String get blockForgotYourPassword => 'שכחת את הסיסמה?';

  @override
  String get blockBackToSignIn => 'חזרה להתחברות';

  @override
  String get blockEnterCredentialsWorkspace =>
      'הזן את פרטי ההתחברות כדי לגשת לסביבת העבודה.';

  @override
  String get blockEnterCredentialsContinue =>
      'הזן את פרטי ההתחברות כדי להמשיך.';

  @override
  String get blockEnterDetailsContinue => 'הזן את הפרטים שלך למטה כדי להמשיך.';

  @override
  String get blockEnterEmailCreateAccount =>
      'הזן את הדוא״ל שלך למטה כדי ליצור חשבון.';

  @override
  String get blockSignedInWelcomeBack => 'מחובר — ברוך שובך.';

  @override
  String get blockAccountCreatedVerify =>
      'החשבון נוצר — בדוק את תיבת הדואר כדי לאמת אותו.';

  @override
  String get blockTrialStartedVerify =>
      'תקופת הניסיון החלה — בדוק את תיבת הדואר כדי לאמת אותה.';

  @override
  String get blockPasswordsDoNotMatch => 'הסיסמאות אינן תואמות.';

  @override
  String get blockCurrentPassword => 'סיסמה נוכחית';

  @override
  String get blockNewPassword => 'סיסמה חדשה';

  @override
  String get blockConfirmNewPassword => 'אשר את הסיסמה החדשה';

  @override
  String get blockUpdatePassword => 'עדכן סיסמה';

  @override
  String get blockPasswordUpdated => 'הסיסמה עודכנה.';

  @override
  String get blockPasswordHintChange =>
      '8 תווים לפחות. שינוי ינתק אותך במקומות אחרים.';

  @override
  String get blockUsername => 'שם משתמש';

  @override
  String get blockUsernameHint => 'אותיות קטנות, ספרות, קו תחתון.';

  @override
  String get blockYourAvatar => 'האווטאר שלך';

  @override
  String get blockUploadImage => 'העלה תמונה';

  @override
  String get blockBio => 'ביוגרפיה';

  @override
  String get blockBioHint => 'ספר לנו קצת על עצמך';

  @override
  String get blockBioCounterHint => 'עד 160 תווים.';

  @override
  String get blockProfileSaved => 'הפרופיל נשמר.';

  @override
  String get blockSaveChanges => 'שמור שינויים';

  @override
  String get blockInviteMember => 'הזמן חבר';

  @override
  String get blockRoleAdmin => 'מנהל';

  @override
  String get blockRoleOwner => 'בעלים';

  @override
  String get blockRoleMember => 'חבר';

  @override
  String get blockTeam => 'צוות';

  @override
  String get blockProfile => 'פרופיל';

  @override
  String get blockSignInWithEmail => 'התחבר עם דוא״ל';

  @override
  String get blockSignUp => 'הירשם';

  @override
  String get blockPickWayYouPrefer => 'בחר את הדרך המועדפת עליך.';

  @override
  String blockContinueWith(Object? provider) => 'המשך עם $provider';

  @override
  String get blockCreating => 'יוצר…';

  @override
  String get blockSigningIn => 'מתחבר…';

  @override
  String get blockSending => 'שולח…';

  @override
  String get blockSaving => 'שומר…';

  @override
  String get blockPaying => 'משלם…';

  @override
  String get blockSendResetLink => 'שלח קישור לאיפוס';

  @override
  String get blockResetPassword => 'אפס סיסמה';

  @override
  String get blockResetLinkSent =>
      'קישור האיפוס נשלח. בדוק את תיבת הדואר כדי להמשיך.';

  @override
  String get blockWeWillEmailReset => 'נשלח לך קישור לאיפוס בדוא״ל.';

  @override
  String get blockMustAcceptTerms => 'עליך לאשר את התנאים כדי להמשיך.';

  @override
  String get blockCheckInbox => 'בדוק את תיבת הדואר';

  @override
  String get blockEnterSixDigitCode => 'הזן את הקוד בן 6 הספרות ששלחנו לך.';

  @override
  String get blockCodeVerifiedSignedIn => 'הקוד אומת. אתה מחובר.';

  @override
  String get blockEmailVerifiedSet => 'הדוא״ל אומת — הכול מוכן.';

  @override
  String get blockVerifyYourEmail => 'אמת את הדוא״ל שלך';

  @override
  String blockWeSentCodeTo(Object? email) => 'שלחנו קוד בן 6 ספרות אל $email.';

  @override
  String get blockDidntGetCode => 'לא קיבלת את הקוד?';

  @override
  String get blockBack => 'חזרה';

  @override
  String get blockBackToCart => 'חזרה לעגלה';

  @override
  String get blockBackToSettings => 'חזרה להגדרות';

  @override
  String get blockOneAccountEverything => 'חשבון אחד להכול.';

  @override
  String get blockStartTrialNoCard =>
      'התחל ניסיון של 14 יום. אין צורך בכרטיס אשראי.';

  @override
  String get blockNotifications => 'התראות';

  @override
  String get blockNotifChoose => 'בחר על מה תרצה לשמוע, והיכן.';

  @override
  String get blockEmailNotifications => 'התראות דוא״ל';

  @override
  String get blockPushNotifications => 'התראות דחיפה';

  @override
  String get blockMentionsReplies => 'אזכורים ותגובות';

  @override
  String get blockDeliveredToDevices => 'נמסר למכשירים שלך';

  @override
  String blockEmailChannel(Object? channel) => 'דוא״ל · $channel';

  @override
  String blockPushChannel(Object? channel) => 'דחיפה · $channel';

  @override
  String get blockQuietHours => 'שעות שקטות';

  @override
  String get blockWeeklyDigest => 'סיכום שבועי';

  @override
  String get blockWeeklyDigestBlurb => 'דוא״ל אחד כל יום שני עם כל מה שקרה.';

  @override
  String get blockPreferencesSaved => 'ההעדפות נשמרו.';

  @override
  String get blockSavePreferences => 'שמור העדפות';

  @override
  String get blockReset => 'אפס';

  @override
  String get blockWelcomeAboard => 'ברוך הבא';

  @override
  String get blockQuickTour => 'סיור מהיר לפני שמתחילים להשתמש באפליקציה.';

  @override
  String get blockStayInLoop => 'הישאר מעודכן';

  @override
  String get blockMessagesArriveMoment =>
      'הודעות ועדכונים מגיעים ברגע שהם קורים.';

  @override
  String get blockNeverMissThing => 'אל תפספס דבר';

  @override
  String get blockNotifPermissionBlurb =>
      'אנחנו שולחים רק מה שחשוב: תגובות, תזכורות והתראות אבטחה. תוכל לשנות זאת מאוחר יותר.';

  @override
  String get blockEnableNotifications => 'להפעיל התראות?';

  @override
  String get blockAllowNotifications => 'אפשר התראות';

  @override
  String get blockAllowNotificationsBlurb =>
      'אפשר התראות כדי להפיק את המרב מהאפליקציה.';

  @override
  String get blockNotNow => 'לא עכשיו';

  @override
  String get blockSkip => 'דלג';

  @override
  String get blockGetStarted => 'התחל';

  @override
  String get blockMessages => 'הודעות';

  @override
  String get blockNoConversations => 'אין שיחות';

  @override
  String get blockPullRefreshChat => 'משוך לרענון או התחל צ׳אט חדש.';

  @override
  String get blockMute => 'השתק';

  @override
  String get blockMuted => 'מושתק';

  @override
  String get blockAttach => 'צרף';

  @override
  String get blockAttachFile => 'קובץ';

  @override
  String get blockAttachPhoto => 'תמונה';

  @override
  String get blockWriteMessage => 'כתוב הודעה…';

  @override
  String get blockYourCart => 'עגלת הקניות שלך';

  @override
  String get blockAddSomethingFirst => 'הוסף קודם משהו שאתה אוהב.';

  @override
  String get blockCartEmpty => 'העגלה ריקה';

  @override
  String get blockCheckout => 'לתשלום';

  @override
  String blockQty(int quantity) => 'כמות $quantity';

  @override
  String blockPayTotal(Object? amount) => 'שלם $amount';

  @override
  String get blockPayment => 'תשלום';

  @override
  String get blockCardNumber => 'מספר כרטיס';

  @override
  String get blockExpiry => 'תוקף';

  @override
  String get blockCvc => 'CVC';

  @override
  String get blockDeliveryAddress => 'כתובת למשלוח';

  @override
  String get blockStreet => 'רחוב';

  @override
  String get blockCity => 'עיר';

  @override
  String get blockSaveAndContinue => 'שמור והמשך';

  @override
  String get blockOrderPlaced => 'ההזמנה בוצעה';

  @override
  String get blockOrderThanks => 'תודה שקנית אצלנו. אישור בדרך אליך.';

  @override
  String get blockContinueShopping => 'המשך בקניות';

  @override
  String get blockSchedule => 'לוח זמנים';

  @override
  String get blockPickDateRangeReport => 'בחר טווח תאריכים לדוח שלך.';

  @override
  String get blockPickDateRange => 'בחר טווח תאריכים';

  @override
  String get blockTapAnotherDay => 'הקש על יום נוסף כדי להרחיב את הטווח';

  @override
  String get blockBookMeeting => 'קבע פגישה';

  @override
  String get blockPickDayTime => 'בחר יום, ואז שעה שמתאימה לך.';

  @override
  String get blockFourSlots => 'נותרו ארבעה מקומות של 30 דקות. בחר אחד.';

  @override
  String blockPickedSlot(Object? slot) => 'נבחר $slot, 30 דקות.';

  @override
  String get blockOverview => 'סקירה';

  @override
  String get blockRevenueOrdersBlurb => 'הכנסות, מנויים וההזמנות האחרונות.';

  @override
  String get blockTotalRevenue => 'סך ההכנסות';

  @override
  String get blockSubscriptions => 'מנויים';

  @override
  String get blockSales => 'מכירות';

  @override
  String get blockRevenueByMonth => 'הכנסות לפי חודש';

  @override
  String get blockRecentSales => 'מכירות אחרונות';

  @override
  String get blockViewAll => 'הצג הכול';

  @override
  String get blockTransactions => 'עסקאות';

  @override
  String get blockFilterTransactions => 'סנן עסקאות';

  @override
  String get blockCustomer => 'לקוח';

  @override
  String get blockAmount => 'סכום';

  @override
  String get blockMethod => 'אמצעי';

  @override
  String get blockStatus => 'סטטוס';

  @override
  String get blockPaid => 'שולם';

  @override
  String get blockPending => 'ממתין';

  @override
  String get blockRefunded => 'הוחזר';

  @override
  String blockNoTransactions(Object? query) => 'אין עסקאות התואמות ל־“$query”.';

  @override
  String blockDeltaFromLastMonth(Object? delta) => '$delta מהחודש שעבר';

  @override
  String get blockAnalytics => 'ניתוחים';

  @override
  String get blockSessionsDevicesBlurb => 'הפעלות, מכשירים ומקור התנועה.';

  @override
  String get blockSearchReports => 'חיפוש דוחות';

  @override
  String get blockLast30Days => '30 הימים האחרונים';

  @override
  String get blockAllDevices => 'כל המכשירים';

  @override
  String get blockSessions => 'הפעלות';

  @override
  String get blockUsers => 'משתמשים';

  @override
  String get blockAvgSession => 'הפעלה ממוצעת';

  @override
  String get blockBounceRate => 'שיעור נטישה';

  @override
  String get blockConversions => 'המרות';

  @override
  String get blockByDevice => 'לפי מכשיר';

  @override
  String get blockDesktop => 'מחשב שולחני';

  @override
  String get blockMobile => 'נייד';

  @override
  String get blockTablet => 'טאבלט';

  @override
  String get blockDirect => 'ישיר';

  @override
  String get blockReferral => 'הפניה';

  @override
  String get blockSocial => 'חברתי';

  @override
  String get blockTrafficSources => 'מקורות תנועה';

  @override
  String get blockVisitors => 'מבקרים';

  @override
  String get blockHome => 'בית';

  @override
  String get blockInbox => 'תיבת דואר נכנס';

  @override
  String get blockCalendar => 'לוח שנה';

  @override
  String get blockCompose => 'כתוב';

  @override
  String get blockMarkAllRead => 'סמן הכול כנקרא';

  @override
  String get blockStarred => 'מסומנים בכוכב';

  @override
  String get blockSnoozed => 'נדחה';

  @override
  String get blockUnread => 'לא נקרא';

  @override
  String get blockDocuments => 'מסמכים';

  @override
  String get blockReports => 'דוחות';

  @override
  String get blockDashboard => 'לוח מחוונים';

  @override
  String get blockStorage => 'אחסון';

  @override
  String get blockNavigation => 'ניווט';

  @override
  String get blockSharedWithYou => 'משותף איתך';

  @override
  String get blockRecentProjects => 'פרויקטים אחרונים';

  @override
  String get blockStorageUsed => 'אחסון בשימוש';

  @override
  String get blockOpen => 'פתח';

  @override
  String get blockLive => 'חי';

  @override
  String get blockMembers => 'חברים';

  @override
  String get blockProjects => 'פרויקטים';

  @override
  String get blockDeploys => 'פריסות';

  @override
  String get blockActivity => 'פעילות';

  @override
  String get blockRecentFiles => 'קבצים אחרונים';

  @override
  String get blockUsageThisMonth => 'שימוש החודש';

  @override
  String get blockUpgradePlan => 'שדרג תוכנית';

  @override
  String blockNoMatches(Object? query) => 'אין תוצאות עבור “$query”.';

  @override
  String get blockWorkspaces => 'סביבות עבודה';

  @override
  String get blockPricing => 'תמחור';

  @override
  String get blockPlansScale => 'תוכניות שגדלות איתך';

  @override
  String get blockPlansBlurb =>
      'התחל בחינם, שדרג כשהצוות גדל. כל תוכנית כוללת את ספריית הרכיבים המלאה ואת הגדרות העיצוב.';

  @override
  String get blockPerUserMonth => 'למשתמש / לחודש';

  @override
  String get blockSubscribe => 'הירשם';

  @override
  String get blockContactSales => 'צור קשר עם מכירות';

  @override
  String get blockPromoCode => 'קוד הטבה';

  @override
  String get blockApplyCode => 'החל קוד';

  @override
  String get blockHaveCodeEnter => 'יש לך קוד? הזן אותו למטה.';

  @override
  String get blockCodeAppliedDiscount => 'הקוד הוחל — ההנחה תוצג בתשלום.';

  @override
  String get blockFaqTitle => 'שאלות';

  @override
  String get blockFaqChangePlans => 'האם אוכל להחליף תוכנית מאוחר יותר?';

  @override
  String get blockFaqChangePlansAnswer =>
      'כן. שדרוגים חלים מיד, הורדות דרגה מהמחזור הבא.';

  @override
  String get blockFaqFreeTrial => 'האם יש תקופת ניסיון בחינם?';

  @override
  String get blockFaqFreeTrialAnswer =>
      'כל תוכנית מתחילה ב־14 יום, ללא צורך בכרטיס.';

  @override
  String get blockAccount => 'חשבון';

  @override
  String get blockGeneral => 'כללי';

  @override
  String get blockAppearance => 'מראה';

  @override
  String get blockDarkMode => 'מצב כהה';

  @override
  String get blockPreferences => 'העדפות';

  @override
  String get blockSignOut => 'התנתק';

  @override
  String get blockSignOutConfirm => 'להתנתק?';

  @override
  String get blockSignOutBlurb => 'תמיד תוכל להתחבר שוב מאוחר יותר.';

  @override
  String get blockSounds => 'צלילים';

  @override
  String get blockWhatYouGet => 'מה מקבלים';

  @override
  String get blockAllComponentCategories => 'כל קטגוריות הרכיבים';

  @override
  String get blockPrioritySupport => 'תמיכה בעדיפות';

  @override
  String get blockUnlimitedProjectsTrial => 'פרויקטים ללא הגבלה במהלך הניסיון';

  @override
  String get blockTrialDaysLeft => 'נותרו 14 יום לניסיון';

  @override
  String get blockStarterChat => 'צ׳אט';

  @override
  String get blockStarterShop => 'חנות';

  @override
  String get blockStarterCart => 'עגלה';

  @override
  String get blockAddToCart => 'הוסף לעגלה';
}
