import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

/// Hindi (`hi`) locale data.
///
/// Translations only: anything this table does not override falls
/// through to the English default on [ComponentLocalizations]. Text
/// direction is not handled here - Flutter resolves it from
/// [WidgetsLocalizations] and [Directionality].
class ComponentLocalizationsHi extends ComponentLocalizations {
  /// Creates the Hindi strings.
  const ComponentLocalizationsHi([super.locale = const Locale('hi')]);

  /// Formats [value] as a number in this locale, or returns it
  /// verbatim when it is not a number.
  String _number(Object? value) {
    if (value is! num) return '$value';
    return intl.NumberFormat.decimalPattern(localeName).format(value);
  }

  @override
  String get formNotEmpty => 'यह फ़ील्ड खाली नहीं हो सकता';

  @override
  String get invalidValue => 'अमान्य मान';

  @override
  String get invalidEmail => 'अमान्य ईमेल';

  @override
  String get invalidURL => 'अमान्य URL';

  @override
  String formLessThan(Object? value) => '${_number(value)} से कम होना चाहिए';

  @override
  String formGreaterThan(Object? value) =>
      '${_number(value)} से अधिक होना चाहिए';

  @override
  String formLessThanOrEqualTo(Object? value) =>
      '${_number(value)} से कम या उसके बराबर होना चाहिए';

  @override
  String get formPhoneNumberInvalid => 'फ़ोन नंबर अमान्य है';

  @override
  String get formPhoneNumberEmpty => 'फ़ोन नंबर आवश्यक है';

  @override
  String formGreaterThanOrEqualTo(Object? value) =>
      '${_number(value)} से अधिक या उसके बराबर होना चाहिए';

  @override
  String formBetweenInclusively(Object? min, Object? max) =>
      '${_number(min)} और ${_number(max)} के बीच होना चाहिए (सहित)';

  @override
  String formEqualTo(Object? value) => '${_number(value)} के बराबर होना चाहिए';

  @override
  String formBetweenExclusively(Object? min, Object? max) =>
      '${_number(min)} और ${_number(max)} के बीच होना चाहिए (रहित)';

  @override
  String formLengthLessThan(int limit) => 'कम से कम $limit वर्ण होने चाहिए';

  @override
  String formLengthGreaterThan(int limit) => 'अधिकतम $limit वर्ण होने चाहिए';

  @override
  String get formPasswordDigits => 'कम से कम एक अंक होना चाहिए';

  @override
  String get formPasswordLowercase => 'कम से कम एक छोटा अक्षर होना चाहिए';

  @override
  String get formPasswordUppercase => 'कम से कम एक बड़ा अक्षर होना चाहिए';

  @override
  String get formPasswordSpecial => 'कम से कम एक विशेष वर्ण होना चाहिए';

  @override
  String get commandSearch => 'कमांड लिखें या खोजें...';

  @override
  String get commandEmpty => 'कोई परिणाम नहीं मिला.';

  @override
  String get datePickerSelectYear => 'वर्ष चुनें';

  @override
  String get abbreviatedMonday => 'सोम';

  @override
  String get abbreviatedTuesday => 'मंगल';

  @override
  String get abbreviatedWednesday => 'बुध';

  @override
  String get abbreviatedThursday => 'गुरु';

  @override
  String get abbreviatedFriday => 'शुक्र';

  @override
  String get abbreviatedSaturday => 'शनि';

  @override
  String get abbreviatedSunday => 'रवि';

  @override
  String get monthJanuary => 'जनवरी';

  @override
  String get monthFebruary => 'फ़रवरी';

  @override
  String get monthMarch => 'मार्च';

  @override
  String get monthApril => 'अप्रैल';

  @override
  String get monthMay => 'मई';

  @override
  String get monthJune => 'जून';

  @override
  String get monthJuly => 'जुलाई';

  @override
  String get monthAugust => 'अगस्त';

  @override
  String get monthSeptember => 'सितंबर';

  @override
  String get monthOctober => 'अक्तूबर';

  @override
  String get monthNovember => 'नवंबर';

  @override
  String get monthDecember => 'दिसंबर';

  @override
  String get abbreviatedJanuary => 'जन';

  @override
  String get abbreviatedFebruary => 'फ़र';

  @override
  String get abbreviatedMarch => 'मार्च';

  @override
  String get abbreviatedApril => 'अप्रै';

  @override
  String get abbreviatedMay => 'मई';

  @override
  String get abbreviatedJune => 'जून';

  @override
  String get abbreviatedJuly => 'जुल';

  @override
  String get abbreviatedAugust => 'अग';

  @override
  String get abbreviatedSeptember => 'सित';

  @override
  String get abbreviatedOctober => 'अक्तू';

  @override
  String get abbreviatedNovember => 'नव';

  @override
  String get abbreviatedDecember => 'दिस';

  @override
  String get dialogDismiss => 'खारिज करें';

  @override
  String get chipInputRemoveChip => 'मिटाएं';

  @override
  String get buttonCancel => 'रद्द करें';

  @override
  String get buttonSave => 'सहेजें';

  @override
  String get timeHour => 'घंटा';

  @override
  String get timeMinute => 'मिनट';

  @override
  String get timeSecond => 'सेकंड';

  @override
  String get timeAM => 'पूर्वाह्न';

  @override
  String get timePM => 'अपराह्न';

  @override
  String get colorRed => 'लाल';

  @override
  String get colorGreen => 'हरा';

  @override
  String get colorBlue => 'नीला';

  @override
  String get colorAlpha => 'अल्फ़ा';

  @override
  String get colorHue => 'रंगत';

  @override
  String get colorSaturation => 'संतृप्ति';

  @override
  String get colorValue => 'मान';

  @override
  String get colorLightness => 'चमक';

  @override
  String get menuCut => 'काटें';

  @override
  String get menuCopy => 'कॉपी करें';

  @override
  String get menuPaste => 'पेस्ट करें';

  @override
  String get menuSelectAll => 'सभी चुनें';

  @override
  String get menuUndo => 'पूर्ववत करें';

  @override
  String get menuRedo => 'फिर से करें';

  @override
  String get menuDelete => 'हटाएं';

  @override
  String get menuShare => 'शेयर करें';

  @override
  String get menuSearchWeb => 'वेब पर खोजें';

  @override
  String get menuLiveTextInput => 'लाइव टेक्स्ट';

  @override
  String get placeholderDatePicker => 'तारीख चुनें';

  @override
  String get placeholderTimePicker => 'समय चुनें';

  @override
  String get placeholderColorPicker => 'रंग चुनें';

  @override
  String get buttonPrevious => 'पिछला';

  @override
  String get buttonNext => 'अगला';

  @override
  String get refreshTriggerPull => 'रीफ़्रेश करने के लिए खींचें';

  @override
  String get refreshTriggerRelease => 'रीफ़्रेश करने के लिए छोड़ें';

  @override
  String get refreshTriggerRefreshing => 'रीफ़्रेश हो रहा है...';

  @override
  String get refreshTriggerComplete => 'रीफ़्रेश पूरा हुआ';

  @override
  String get colorPickerTabRGB => 'RGB';

  @override
  String get colorPickerTabHSV => 'HSV';

  @override
  String get colorPickerTabHSL => 'HSL';

  @override
  String get colorPickerTabHEX => 'HEX';

  @override
  String get commandMoveUp => 'ऊपर ले जाएं';

  @override
  String get commandMoveDown => 'नीचे ले जाएं';

  @override
  String get commandActivate => 'चुनें';

  @override
  String get timeDaysAbbreviation => 'दद';

  @override
  String get timeHoursAbbreviation => 'घघ';

  @override
  String get timeMinutesAbbreviation => 'मम';

  @override
  String get timeSecondsAbbreviation => 'सस';

  @override
  String get placeholderDurationPicker => 'अवधि चुनें';

  @override
  String get durationDay => 'दिन';

  @override
  String get durationHour => 'घंटा';

  @override
  String get durationMinute => 'मिनट';

  @override
  String get durationSecond => 'सेकंड';

  @override
  String get dropzoneIdle => 'फ़ाइलें अपलोड करने के लिए ब्राउज़ करें';

  @override
  String get dropzoneDragging => 'अपलोड करने के लिए फ़ाइलें छोड़ें';

  @override
  String get dropzoneUploading => 'फ़ाइलें अपलोड हो रही हैं...';

  @override
  String get dropzoneSuccess => 'फ़ाइलें तैयार हैं';

  @override
  String get dropzoneError => 'आगे बढ़ने के लिए त्रुटियाँ ठीक करें';

  @override
  String get dropzoneDisabled => 'फ़ाइल अपलोड अक्षम है';

  @override
  String get dropzoneBrowse => 'फ़ाइलें ब्राउज़ करें';

  @override
  String get emptyStateEmptyTitle => 'यहाँ अभी कुछ नहीं है';

  @override
  String get emptyStateEmptyDescription =>
      'शुरू करने के लिए अपना पहला आइटम बनाएँ।';

  @override
  String get emptyStateNoResultsTitle => 'कोई परिणाम नहीं मिला';

  @override
  String get emptyStateNoResultsDescription =>
      'अपने फ़िल्टर या खोज शब्द समायोजित करके देखें।';

  @override
  String get emptyStateErrorTitle => 'कुछ गड़बड़ हो गई';

  @override
  String get emptyStateErrorDescription =>
      'हम यह डेटा लोड नहीं कर सके। थोड़ी देर बाद पुनः प्रयास करें।';

  @override
  String get filterSearch => 'खोजें';

  @override
  String get filterSort => 'क्रमबद्ध करें';

  @override
  String get filterDateRange => 'तिथि सीमा';

  @override
  String get filterClearAll => 'सभी साफ़ करें';

  @override
  String get filterFilters => 'फ़िल्टर';

  @override
  String filterActiveCount(int count) => '${_number(count)} सक्रिय फ़िल्टर';

  @override
  String filterResultsCount(int count) => '${_number(count)} परिणाम';

  @override
  String get fileUploadChoose => 'फ़ाइल चुनें';

  @override
  String get fileUploadNoFile => 'कोई फ़ाइल नहीं चुनी गई';

  @override
  String get fileUploadPickFailed => 'फ़ाइल चुनना विफल रहा।';

  @override
  String get fileUploadTooMany => 'बहुत अधिक फ़ाइलें चुनी गईं।';

  @override
  String get fileUploadTooLarge => 'फ़ाइल बहुत बड़ी है।';

  @override
  String get fileUploadInvalidType => 'फ़ाइल प्रकार की अनुमति नहीं है।';

  @override
  String get fileUploadUploadFailed => 'अपलोड विफल रहा।';

  @override
  String fileUploadUploadFailedFor(String name) =>
      '$name के लिए अपलोड विफल रहा।';

  @override
  String get fileUploadStatusQueued => 'कतार में';

  @override
  String get fileUploadStatusUploading => 'अपलोड हो रहा है';

  @override
  String get fileUploadStatusCompleted => 'पूर्ण';

  @override
  String get fileUploadStatusFailed => 'विफल';

  @override
  String get fileUploadUnknownType => 'फ़ाइल';

  @override
  String get fileUploadRemove => 'फ़ाइल हटाएँ';

  @override
  String get fileUploadRetry => 'अपलोड पुनः प्रयास करें';

  @override
  String get fileUploadPreview => 'फ़ाइल का पूर्वावलोकन';

  @override
  String get fileUploadDownload => 'फ़ाइल डाउनलोड करें';

  @override
  String get errorSomethingWentWrong => 'कुछ गड़बड़ हो गई';

  @override
  String get errorUnexpectedMessage =>
      'कृपया पुनः प्रयास करें या समस्या बनी रहे तो सहायता से संपर्क करें।';

  @override
  String get errorActionRetry => 'पुनः प्रयास करें';

  @override
  String get errorActionReport => 'रिपोर्ट करें';

  @override
  String get errorActionBack => 'वापस जाएँ';

  @override
  String get errorActionLogin => 'लॉग इन करें';

  @override
  String get errorActionSettings => 'सेटिंग';

  @override
  String get errorActionContactSupport => 'सहायता से संपर्क करें';

  @override
  String get errorBadRequest => 'खराब अनुरोध';

  @override
  String get errorBadRequestMessage =>
      'अनुरोध अमान्य था। कृपया समीक्षा करें और पुनः प्रयास करें।';

  @override
  String get errorUnauthorized => 'अनधिकृत';

  @override
  String get errorLoginRequiredMessage => 'जारी रखने के लिए कृपया लॉग इन करें।';

  @override
  String get errorAccessDenied => 'पहुँच अस्वीकृत';

  @override
  String get errorAccessDeniedMessage =>
      'आपको यह क्रिया करने की अनुमति नहीं है।';

  @override
  String get errorNotFound => 'नहीं मिला';

  @override
  String get errorNotFoundMessage => 'आप जो खोज रहे थे वह हमें नहीं मिला।';

  @override
  String get errorConflict => 'टकराव';

  @override
  String get errorConflictMessage => 'यह क्रिया मौजूदा डेटा से टकराती है।';

  @override
  String get errorInvalidData => 'अमान्य डेटा';

  @override
  String get errorInvalidDataMessage =>
      'कुछ फ़ील्ड पर आपके ध्यान की आवश्यकता है।';

  @override
  String get errorTooManyRequests => 'बहुत अधिक अनुरोध';

  @override
  String get errorTooManyRequestsMessage =>
      'कृपया थोड़ी देर प्रतीक्षा करें और पुनः प्रयास करें।';

  @override
  String get errorServerError => 'सर्वर त्रुटि';

  @override
  String get errorServerErrorMessage =>
      'सर्वर को कोई समस्या हुई। कृपया पुनः प्रयास करें।';

  @override
  String get errorRequestTimedOut => 'अनुरोध समयबाह्य हो गया';

  @override
  String get errorRequestTimedOutMessage =>
      'सर्वर को जवाब देने में बहुत समय लग रहा है।';

  @override
  String get errorAuthenticationRequired => 'प्रमाणीकरण आवश्यक है';

  @override
  String get errorInvalidInput => 'अमान्य इनपुट';

  @override
  String get errorReviewFieldsMessage =>
      'कृपया हाइलाइट किए गए फ़ील्ड की समीक्षा करें।';

  @override
  String get errorPlatformError => 'प्लेटफ़ॉर्म त्रुटि';

  @override
  String get errorDeviceErrorMessage => 'इस डिवाइस पर कुछ गड़बड़ हो गई।';

  @override
  String get errorConnectionFailed => 'कनेक्शन विफल रहा';

  @override
  String get errorConnectionFailedMessage =>
      'अपना इंटरनेट कनेक्शन जाँचें और पुनः प्रयास करें।';

  @override
  String get errorSecureConnectionFailed => 'सुरक्षित कनेक्शन विफल रहा';

  @override
  String get errorSecureConnectionMessage =>
      'हम सुरक्षित कनेक्शन स्थापित नहीं कर सके।';

  @override
  String get tableResizeColumn => 'कॉलम का आकार बदलें';

  @override
  String get tableResizeRow => 'पंक्ति का आकार बदलें';

  @override
  String get resizableHandle => 'आकार बदलने का हैंडल';

  @override
  String get spellCheckNoSuggestions => 'कोई सुझाव नहीं';

  @override
  String get announcementLoading => 'लोड हो रहा है';

  @override
  String get announcementSuccess => 'सफल';

  @override
  String get announcementFailure => 'विफल';

  @override
  String get toolbarMore => 'अधिक';

  @override
  String get toolbarMoreActions => 'अधिक क्रियाएँ';

  @override
  String get treeCollapse => 'समेटें';

  @override
  String get treeExpand => 'फैलाएँ';

  @override
  String get markdownDetails => 'विवरण';

  @override
  String get carouselLabel => 'चुनिंदा कैरोसेल';

  @override
  String get carouselPrimaryAction => 'चैट में जोड़ें';

  @override
  String carouselItemPreview(Object? title) =>
      'चुनिंदा पूर्वावलोकन: ${title ?? mediaUntitled}';

  @override
  String carouselPageOf(int position, int length) =>
      '${_number(length)} में से ${_number(position)}वाँ पृष्ठ';

  @override
  String stepperStep(int index) => 'चरण ${_number(index + 1)}';

  @override
  String paginationPage(Object? page) => 'पृष्ठ ${_number(page)}';

  @override
  String chartSeriesDefault(int index) => 'श्रृंखला ${_number(index + 1)}';

  @override
  String chartSliceDefault(int index) => 'टुकड़ा ${_number(index)}';

  @override
  String chartCategoryDefault(int index) => 'श्रेणी ${_number(index)}';

  @override
  String get chartValueDefault => 'मान';

  @override
  String get chartKindLine => 'रेखा';

  @override
  String get chartKindArea => 'क्षेत्र';

  @override
  String get chartKindBar => 'बार';

  @override
  String get chartKindDonut => 'डोनट';

  @override
  String get chartKindPie => 'पाई';

  @override
  String get chartKindSparkline => 'स्पार्कलाइन';

  @override
  String get chartKindScatter => 'स्कैटर';

  @override
  String get chartKindRadar => 'रडार';

  @override
  String get chartKindRadial => 'रेडियल';

  @override
  String chartSummaryEmpty(Object? kind) => 'बिना डेटा वाला $kind चार्ट';

  @override
  String chartSummary(int series, int points, Object? kind) =>
      '$kind चार्ट: ${_number(series)} श्रृंखलाएँ, ${_number(points)} बिंदु';

  @override
  String get colorFieldHsv => 'HSV रंग क्षेत्र';

  @override
  String get colorFieldHsl => 'HSL रंग क्षेत्र';

  @override
  String get actionClear => 'साफ़ करें';

  @override
  String get actionApply => 'लागू करें';

  @override
  String get actionVerify => 'सत्यापित करें';

  @override
  String get actionResend => 'पुनः भेजें';

  @override
  String resendInSeconds(int seconds) =>
      '${_number(seconds)} सेकंड में पुनः भेजें';

  @override
  String get actionClose => 'बंद करें';

  @override
  String get authCode => 'कोड';

  @override
  String get authEmail => 'ईमेल';

  @override
  String get authPassword => 'पासवर्ड';

  @override
  String get authName => 'नाम';

  @override
  String get authSignIn => 'साइन इन';

  @override
  String get authForgotPassword => 'पासवर्ड भूल गए?';

  @override
  String get authRememberMe => 'मुझे याद रखें';

  @override
  String get authCreateAccount => 'खाता बनाएँ';

  @override
  String get mediaPlay => 'चलाएँ';

  @override
  String get mediaPause => 'रोकें';

  @override
  String get mediaMute => 'म्यूट';

  @override
  String get mediaUnmute => 'अनम्यूट';

  @override
  String get mediaVolume => 'वॉल्यूम';

  @override
  String get mediaSeek => 'खोजें';

  @override
  String get mediaDownload => 'डाउनलोड';

  @override
  String get mediaAudioPlayer => 'ऑडियो प्लेयर';

  @override
  String get mediaVideoPlayer => 'वीडियो प्लेयर';

  @override
  String get mediaUntitled => 'शीर्षकहीन';

  @override
  String get mediaPlaybackFailed => 'प्लेबैक विफल रहा';

  @override
  String get mediaPreviousTrack => 'पिछला ट्रैक';

  @override
  String get mediaNextTrack => 'अगला ट्रैक';

  @override
  String get mediaShuffleDisable => 'शफ़ल बंद करें';

  @override
  String get mediaShuffleEnable => 'शफ़ल चालू करें';

  @override
  String get mediaRepeatDisable => 'दोहराना बंद करें';

  @override
  String get mediaRepeatEnable => 'दोहराना चालू करें';

  @override
  String mediaPlaybackSpeed(Object? speed) =>
      'प्लेबैक गति ${speed}x, बदलने के लिए टैप करें';

  @override
  String mediaPositionOf(Object position, Object duration) =>
      '$position / $duration';

  @override
  String mediaHours(int count) =>
      count == 1 ? '1 घंटा' : '${_number(count)} घंटे';

  @override
  String mediaMinutes(int count) =>
      count == 1 ? '1 मिनट' : '${_number(count)} मिनट';

  @override
  String mediaSeconds(int count) =>
      count == 1 ? '1 सेकंड' : '${_number(count)} सेकंड';

  @override
  String get signaturePadLabel => 'हस्ताक्षर क्षेत्र';

  @override
  String get qrCodeLabel => 'QR कोड';

  @override
  String get marqueeContent => 'स्क्रॉल हो रही सामग्री';

  @override
  String mediaSkipBack(int seconds) => '${_number(seconds)} सेकंड पीछे';

  @override
  String mediaSkipForward(int seconds) => '${_number(seconds)} सेकंड आगे';

  @override
  String get mediaCaptionsShow => 'कैप्शन दिखाएँ';

  @override
  String get mediaCaptionsHide => 'कैप्शन छिपाएँ';

  @override
  String get mediaCaptionsOn => 'कैप्शन चालू';

  @override
  String get mediaCaptionsOff => 'कैप्शन बंद';

  @override
  String get mediaFullscreen => 'पूर्ण स्क्रीन';

  @override
  String mediaMoreOptionsSpeed(Object? speed) =>
      'अधिक विकल्प, प्लेबैक गति ${speed}x';

  @override
  String mediaSpeed(Object? speed) => 'गति ${speed}x';

  @override
  String get actionStartTrial => 'मुफ़्त ट्रायल शुरू करें';

  @override
  String get authFirstName => 'पहला नाम';

  @override
  String get authLastName => 'उपनाम';

  @override
  String get authPasswordHint => 'कम से कम 8 अक्षर।';

  @override
  String get authUseDifferentEmail => 'कोई भिन्न ईमेल इस्तेमाल करें';

  @override
  String get authWorkEmail => 'कार्य ईमेल';

  @override
  String get chartTotalLabel => 'कुल';

  @override
  String get mediaQualityAuto => 'गुणवत्ता ऑटो';
}
