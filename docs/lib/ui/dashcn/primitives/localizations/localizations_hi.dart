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

  @override
  String get blockDontHaveAccount => 'खाता नहीं है?';

  @override
  String get blockAlreadyHaveAccount => 'क्या पहले से खाता है?';

  @override
  String get blockNoAccountYet => 'अभी तक खाता नहीं है?';

  @override
  String get blockHaveAnAccount => 'खाता है?';

  @override
  String get blockCreateOne => 'एक बनाएं';

  @override
  String get blockCreateAccount => 'खाता बनाएं';

  @override
  String get blockCreateYourAccount => 'अपना खाता बनाएं';

  @override
  String get blockForgotYourPassword => 'पासवर्ड भूल गए?';

  @override
  String get blockBackToSignIn => 'साइन इन पर वापस जाएं';

  @override
  String get blockEnterCredentialsWorkspace =>
      'अपने कार्यक्षेत्र तक पहुंचने के लिए अपने क्रेडेंशियल दर्ज करें।';

  @override
  String get blockEnterCredentialsContinue =>
      'जारी रखने के लिए अपने क्रेडेंशियल दर्ज करें।';

  @override
  String get blockEnterDetailsContinue =>
      'जारी रखने के लिए नीचे अपना विवरण दर्ज करें।';

  @override
  String get blockEnterEmailCreateAccount =>
      'अपना खाता बनाने के लिए नीचे अपना ईमेल दर्ज करें।';

  @override
  String get blockSignedInWelcomeBack => 'साइन इन हो गया — वापस स्वागत है।';

  @override
  String get blockAccountCreatedVerify =>
      'खाता बन गया — सत्यापित करने के लिए अपना इनबॉक्स देखें।';

  @override
  String get blockTrialStartedVerify =>
      'परीक्षण शुरू हो गया — सत्यापित करने के लिए अपना इनबॉक्स देखें।';

  @override
  String get blockPasswordsDoNotMatch => 'पासवर्ड मेल नहीं खाते।';

  @override
  String get blockCurrentPassword => 'वर्तमान पासवर्ड';

  @override
  String get blockNewPassword => 'नया पासवर्ड';

  @override
  String get blockConfirmNewPassword => 'नए पासवर्ड की पुष्टि करें';

  @override
  String get blockUpdatePassword => 'पासवर्ड अपडेट करें';

  @override
  String get blockPasswordUpdated => 'पासवर्ड अपडेट हो गया।';

  @override
  String get blockPasswordHintChange =>
      'कम से कम 8 वर्ण। इसे बदलने से आप अन्य जगहों से साइन आउट हो जाएंगे।';

  @override
  String get blockUsername => 'उपयोगकर्ता नाम';

  @override
  String get blockUsernameHint => 'छोटे अक्षर, अंक, अंडरस्कोर।';

  @override
  String get blockYourAvatar => 'आपका अवतार';

  @override
  String get blockUploadImage => 'छवि अपलोड करें';

  @override
  String get blockBio => 'परिचय';

  @override
  String get blockBioHint => 'अपने बारे में थोड़ा बताएं';

  @override
  String get blockBioCounterHint => 'अधिकतम 160 वर्ण।';

  @override
  String get blockProfileSaved => 'प्रोफ़ाइल सहेजी गई।';

  @override
  String get blockSaveChanges => 'परिवर्तन सहेजें';

  @override
  String get blockInviteMember => 'सदस्य आमंत्रित करें';

  @override
  String get blockRoleAdmin => 'व्यवस्थापक';

  @override
  String get blockRoleOwner => 'स्वामी';

  @override
  String get blockRoleMember => 'सदस्य';

  @override
  String get blockTeam => 'टीम';

  @override
  String get blockProfile => 'प्रोफ़ाइल';

  @override
  String get blockSignInWithEmail => 'ईमेल से साइन इन करें';

  @override
  String get blockSignUp => 'साइन अप करें';

  @override
  String get blockPickWayYouPrefer => 'अपना पसंदीदा तरीका चुनें।';

  @override
  String blockContinueWith(Object? provider) => '$provider के साथ जारी रखें';

  @override
  String get blockCreating => 'बनाया जा रहा है…';

  @override
  String get blockSigningIn => 'साइन इन हो रहा है…';

  @override
  String get blockSending => 'भेजा जा रहा है…';

  @override
  String get blockSaving => 'सहेजा जा रहा है…';

  @override
  String get blockPaying => 'भुगतान हो रहा है…';

  @override
  String get blockSendResetLink => 'रीसेट लिंक भेजें';

  @override
  String get blockResetPassword => 'पासवर्ड रीसेट करें';

  @override
  String get blockResetLinkSent =>
      'रीसेट लिंक भेजा गया। जारी रखने के लिए अपना इनबॉक्स देखें।';

  @override
  String get blockWeWillEmailReset => 'हम आपको ईमेल से रीसेट लिंक भेजेंगे।';

  @override
  String get blockMustAcceptTerms =>
      'जारी रखने के लिए आपको शर्तें स्वीकार करनी होंगी।';

  @override
  String get blockCheckInbox => 'अपना इनबॉक्स देखें';

  @override
  String get blockEnterSixDigitCode =>
      'आपको भेजा गया 6 अंकों का कोड दर्ज करें।';

  @override
  String get blockCodeVerifiedSignedIn => 'कोड सत्यापित। आप साइन इन हैं।';

  @override
  String get blockEmailVerifiedSet => 'ईमेल सत्यापित — सब तैयार है।';

  @override
  String get blockVerifyYourEmail => 'अपना ईमेल सत्यापित करें';

  @override
  String blockWeSentCodeTo(Object? email) =>
      'हमने $email पर छह अंकों का कोड भेजा है।';

  @override
  String get blockDidntGetCode => 'कोड नहीं मिला?';

  @override
  String get blockBack => 'पीछे';

  @override
  String get blockBackToCart => 'कार्ट पर वापस जाएं';

  @override
  String get blockBackToSettings => 'सेटिंग्स पर वापस जाएं';

  @override
  String get blockOneAccountEverything => 'सब कुछ के लिए एक खाता।';

  @override
  String get blockStartTrialNoCard =>
      'अपना 14-दिवसीय परीक्षण शुरू करें। क्रेडिट कार्ड की आवश्यकता नहीं।';

  @override
  String get blockNotifications => 'सूचनाएं';

  @override
  String get blockNotifChoose =>
      'चुनें कि आप किस बारे में और कहां सुनना चाहते हैं।';

  @override
  String get blockEmailNotifications => 'ईमेल सूचनाएं';

  @override
  String get blockPushNotifications => 'पुश सूचनाएं';

  @override
  String get blockMentionsReplies => 'उल्लेख और उत्तर';

  @override
  String get blockDeliveredToDevices => 'आपके उपकरणों पर वितरित';

  @override
  String blockEmailChannel(Object? channel) => 'ईमेल · $channel';

  @override
  String blockPushChannel(Object? channel) => 'पुश · $channel';

  @override
  String get blockQuietHours => 'शांत समय';

  @override
  String get blockWeeklyDigest => 'साप्ताहिक सारांश';

  @override
  String get blockWeeklyDigestBlurb => 'हर सोमवार को सब कुछ के साथ एक ईमेल।';

  @override
  String get blockPreferencesSaved => 'प्राथमिकताएं सहेजी गईं।';

  @override
  String get blockSavePreferences => 'प्राथमिकताएं सहेजें';

  @override
  String get blockReset => 'रीसेट करें';

  @override
  String get blockWelcomeAboard => 'स्वागत है';

  @override
  String get blockQuickTour => 'ऐप का उपयोग शुरू करने से पहले एक त्वरित परिचय।';

  @override
  String get blockStayInLoop => 'अपडेट रहें';

  @override
  String get blockMessagesArriveMoment => 'संदेश और अपडेट होते ही पहुंचते हैं।';

  @override
  String get blockNeverMissThing => 'कुछ भी न चूकें';

  @override
  String get blockNotifPermissionBlurb =>
      'हम केवल महत्वपूर्ण भेजते हैं: उत्तर, अनुस्मारक और सुरक्षा अलर्ट। आप इसे बाद में बदल सकते हैं।';

  @override
  String get blockEnableNotifications => 'सूचनाएं सक्षम करें?';

  @override
  String get blockAllowNotifications => 'सूचनाओं की अनुमति दें';

  @override
  String get blockAllowNotificationsBlurb =>
      'ऐप का भरपूर लाभ लेने के लिए सूचनाओं की अनुमति दें।';

  @override
  String get blockNotNow => 'अभी नहीं';

  @override
  String get blockSkip => 'छोड़ें';

  @override
  String get blockGetStarted => 'शुरू करें';

  @override
  String get blockMessages => 'संदेश';

  @override
  String get blockNoConversations => 'कोई वार्तालाप नहीं';

  @override
  String get blockPullRefreshChat =>
      'रीफ़्रेश करने के लिए खींचें या नई चैट शुरू करें।';

  @override
  String get blockMute => 'म्यूट करें';

  @override
  String get blockMuted => 'म्यूट किया गया';

  @override
  String get blockAttach => 'संलग्न करें';

  @override
  String get blockAttachFile => 'फ़ाइल';

  @override
  String get blockAttachPhoto => 'फ़ोटो';

  @override
  String get blockWriteMessage => 'संदेश लिखें…';

  @override
  String get blockYourCart => 'आपकी कार्ट';

  @override
  String get blockAddSomethingFirst => 'पहले कुछ ऐसा जोड़ें जो आपको पसंद हो।';

  @override
  String get blockCartEmpty => 'कार्ट खाली है';

  @override
  String get blockCheckout => 'चेकआउट';

  @override
  String blockQty(int quantity) => 'मात्रा $quantity';

  @override
  String blockPayTotal(Object? amount) => '$amount का भुगतान करें';

  @override
  String get blockPayment => 'भुगतान';

  @override
  String get blockCardNumber => 'कार्ड नंबर';

  @override
  String get blockExpiry => 'समाप्ति';

  @override
  String get blockCvc => 'CVC';

  @override
  String get blockDeliveryAddress => 'वितरण पता';

  @override
  String get blockStreet => 'गली';

  @override
  String get blockCity => 'शहर';

  @override
  String get blockSaveAndContinue => 'सहेजें और जारी रखें';

  @override
  String get blockOrderPlaced => 'ऑर्डर हो गया';

  @override
  String get blockOrderThanks =>
      'हमारे साथ खरीदारी के लिए धन्यवाद। पुष्टि आ रही है।';

  @override
  String get blockContinueShopping => 'खरीदारी जारी रखें';

  @override
  String get blockSchedule => 'अनुसूची';

  @override
  String get blockPickDateRangeReport => 'अपनी रिपोर्ट के लिए तिथि सीमा चुनें।';

  @override
  String get blockPickDateRange => 'तिथि सीमा चुनें';

  @override
  String get blockTapAnotherDay => 'सीमा बढ़ाने के लिए दूसरे दिन पर टैप करें';

  @override
  String get blockBookMeeting => 'मीटिंग बुक करें';

  @override
  String get blockPickDayTime => 'एक दिन चुनें, फिर उपयुक्त समय चुनें।';

  @override
  String get blockFourSlots => '30-30 मिनट के चार स्लॉट बचे हैं। एक चुनें।';

  @override
  String blockPickedSlot(Object? slot) => '$slot चुना गया, 30 मिनट।';

  @override
  String get blockOverview => 'अवलोकन';

  @override
  String get blockRevenueOrdersBlurb =>
      'राजस्व, सदस्यताएं और सबसे हाल के ऑर्डर।';

  @override
  String get blockTotalRevenue => 'कुल राजस्व';

  @override
  String get blockSubscriptions => 'सदस्यताएं';

  @override
  String get blockSales => 'बिक्री';

  @override
  String get blockRevenueByMonth => 'माह अनुसार राजस्व';

  @override
  String get blockRecentSales => 'हाल की बिक्री';

  @override
  String get blockViewAll => 'सभी देखें';

  @override
  String get blockTransactions => 'लेनदेन';

  @override
  String get blockFilterTransactions => 'लेनदेन फ़िल्टर करें';

  @override
  String get blockCustomer => 'ग्राहक';

  @override
  String get blockAmount => 'राशि';

  @override
  String get blockMethod => 'विधि';

  @override
  String get blockStatus => 'स्थिति';

  @override
  String get blockPaid => 'भुगतान किया गया';

  @override
  String get blockPending => 'लंबित';

  @override
  String get blockRefunded => 'वापस किया गया';

  @override
  String blockNoTransactions(Object? query) =>
      '“$query” से कोई लेनदेन मेल नहीं खाता।';

  @override
  String blockDeltaFromLastMonth(Object? delta) => 'पिछले महीने से $delta';

  @override
  String get blockAnalytics => 'विश्लेषण';

  @override
  String get blockSessionsDevicesBlurb =>
      'सत्र, उपकरण और ट्रैफ़िक कहां से आया।';

  @override
  String get blockSearchReports => 'रिपोर्ट खोजें';

  @override
  String get blockLast30Days => 'पिछले 30 दिन';

  @override
  String get blockAllDevices => 'सभी उपकरण';

  @override
  String get blockSessions => 'सत्र';

  @override
  String get blockUsers => 'उपयोगकर्ता';

  @override
  String get blockAvgSession => 'औसत सत्र';

  @override
  String get blockBounceRate => 'बाउंस दर';

  @override
  String get blockConversions => 'रूपांतरण';

  @override
  String get blockByDevice => 'उपकरण अनुसार';

  @override
  String get blockDesktop => 'डेस्कटॉप';

  @override
  String get blockMobile => 'मोबाइल';

  @override
  String get blockTablet => 'टैबलेट';

  @override
  String get blockDirect => 'प्रत्यक्ष';

  @override
  String get blockReferral => 'रेफ़रल';

  @override
  String get blockSocial => 'सोशल';

  @override
  String get blockTrafficSources => 'ट्रैफ़िक स्रोत';

  @override
  String get blockVisitors => 'आगंतुक';

  @override
  String get blockHome => 'होम';

  @override
  String get blockInbox => 'इनबॉक्स';

  @override
  String get blockCalendar => 'कैलेंडर';

  @override
  String get blockCompose => 'लिखें';

  @override
  String get blockMarkAllRead => 'सभी को पढ़ा हुआ चिह्नित करें';

  @override
  String get blockStarred => 'तारांकित';

  @override
  String get blockSnoozed => 'स्थगित';

  @override
  String get blockUnread => 'अपठित';

  @override
  String get blockDocuments => 'दस्तावेज़';

  @override
  String get blockReports => 'रिपोर्ट';

  @override
  String get blockDashboard => 'डैशबोर्ड';

  @override
  String get blockStorage => 'संग्रहण';

  @override
  String get blockNavigation => 'नेविगेशन';

  @override
  String get blockSharedWithYou => 'आपके साथ साझा किया गया';

  @override
  String get blockRecentProjects => 'हाल के प्रोजेक्ट';

  @override
  String get blockStorageUsed => 'उपयोग किया गया संग्रहण';

  @override
  String get blockOpen => 'खोलें';

  @override
  String get blockLive => 'लाइव';

  @override
  String get blockMembers => 'सदस्य';

  @override
  String get blockProjects => 'प्रोजेक्ट';

  @override
  String get blockDeploys => 'परिनियोजन';

  @override
  String get blockActivity => 'गतिविधि';

  @override
  String get blockRecentFiles => 'हाल की फ़ाइलें';

  @override
  String get blockUsageThisMonth => 'इस माह का उपयोग';

  @override
  String get blockUpgradePlan => 'योजना अपग्रेड करें';

  @override
  String blockNoMatches(Object? query) => '“$query” के लिए कोई परिणाम नहीं।';

  @override
  String get blockWorkspaces => 'कार्यक्षेत्र';

  @override
  String get blockPricing => 'मूल्य निर्धारण';

  @override
  String get blockPlansScale => 'योजनाएं जो आपके साथ बढ़ें';

  @override
  String get blockPlansBlurb =>
      'मुफ़्त में शुरू करें, जब आपकी टीम बढ़े तो अपग्रेड करें। हर योजना में पूर्ण घटक लाइब्रेरी और थीम प्रीसेट शामिल हैं।';

  @override
  String get blockPerUserMonth => 'प्रति उपयोगकर्ता / माह';

  @override
  String get blockSubscribe => 'सदस्यता लें';

  @override
  String get blockContactSales => 'बिक्री से संपर्क करें';

  @override
  String get blockPromoCode => 'प्रोमो कोड';

  @override
  String get blockApplyCode => 'कोड लागू करें';

  @override
  String get blockHaveCodeEnter => 'कोड है? नीचे दर्ज करें।';

  @override
  String get blockCodeAppliedDiscount =>
      'कोड लागू — आपकी छूट चेकआउट पर दिखेगी।';

  @override
  String get blockFaqTitle => 'प्रश्न';

  @override
  String get blockFaqChangePlans => 'क्या मैं बाद में योजना बदल सकता हूं?';

  @override
  String get blockFaqChangePlansAnswer =>
      'हां। अपग्रेड तुरंत लागू होते हैं, डाउनग्रेड अगले चक्र से।';

  @override
  String get blockFaqFreeTrial => 'क्या मुफ़्त परीक्षण है?';

  @override
  String get blockFaqFreeTrialAnswer =>
      'हर योजना 14 दिनों से शुरू होती है, कार्ड की आवश्यकता नहीं।';

  @override
  String get blockAccount => 'खाता';

  @override
  String get blockGeneral => 'सामान्य';

  @override
  String get blockAppearance => 'दिखावट';

  @override
  String get blockDarkMode => 'डार्क मोड';

  @override
  String get blockPreferences => 'प्राथमिकताएं';

  @override
  String get blockSignOut => 'साइन आउट करें';

  @override
  String get blockSignOutConfirm => 'साइन आउट करें?';

  @override
  String get blockSignOutBlurb => 'आप बाद में हमेशा वापस साइन इन कर सकते हैं।';

  @override
  String get blockSounds => 'ध्वनियां';

  @override
  String get blockWhatYouGet => 'आपको क्या मिलता है';

  @override
  String get blockAllComponentCategories => 'सभी घटक श्रेणियां';

  @override
  String get blockPrioritySupport => 'प्राथमिकता सहायता';

  @override
  String get blockUnlimitedProjectsTrial => 'परीक्षण के दौरान असीमित प्रोजेक्ट';

  @override
  String get blockTrialDaysLeft => 'आपके परीक्षण में 14 दिन बचे हैं';

  @override
  String get blockStarterChat => 'चैट';

  @override
  String get blockStarterShop => 'दुकान';

  @override
  String get blockStarterCart => 'कार्ट';

  @override
  String get blockAddToCart => 'कार्ट में जोड़ें';
}
