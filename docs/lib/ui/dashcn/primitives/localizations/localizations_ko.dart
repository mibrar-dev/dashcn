import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

/// Korean (`ko`) locale data.
///
/// Translations only: anything this table does not override falls
/// through to the English default on [ComponentLocalizations]. Text
/// direction is not handled here - Flutter resolves it from
/// [WidgetsLocalizations] and [Directionality].
class ComponentLocalizationsKo extends ComponentLocalizations {
  /// Creates the Korean strings.
  const ComponentLocalizationsKo([super.locale = const Locale('ko')]);

  /// Formats [value] as a number in this locale, or returns it
  /// verbatim when it is not a number.
  String _number(Object? value) {
    if (value is! num) return '$value';
    return intl.NumberFormat.decimalPattern(localeName).format(value);
  }

  @override
  String get formNotEmpty => '이 항목은 비워 둘 수 없습니다';

  @override
  String get invalidValue => '잘못된 값입니다';

  @override
  String get invalidEmail => '잘못된 이메일 주소입니다';

  @override
  String get invalidURL => '잘못된 URL입니다';

  @override
  String formLessThan(Object? value) => '${_number(value)}보다 작아야 합니다';

  @override
  String formGreaterThan(Object? value) => '${_number(value)}보다 커야 합니다';

  @override
  String formLessThanOrEqualTo(Object? value) => '${_number(value)} 이하여야 합니다';

  @override
  String get formPhoneNumberInvalid => '전화번호가 잘못되었습니다';

  @override
  String get formPhoneNumberEmpty => '전화번호를 입력하세요';

  @override
  String formGreaterThanOrEqualTo(Object? value) =>
      '${_number(value)} 이상이어야 합니다';

  @override
  String formBetweenInclusively(Object? min, Object? max) =>
      '${_number(min)}에서 ${_number(max)} 사이여야 합니다 (경계 포함)';

  @override
  String formEqualTo(Object? value) => '${_number(value)}와(과) 같아야 합니다';

  @override
  String formBetweenExclusively(Object? min, Object? max) =>
      '${_number(min)}에서 ${_number(max)} 사이여야 합니다 (경계 제외)';

  @override
  String formLengthLessThan(int limit) => '$limit자 이상이어야 합니다';

  @override
  String formLengthGreaterThan(int limit) => '$limit자 이하여야 합니다';

  @override
  String get formPasswordDigits => '숫자를 하나 이상 포함해야 합니다';

  @override
  String get formPasswordLowercase => '소문자를 하나 이상 포함해야 합니다';

  @override
  String get formPasswordUppercase => '대문자를 하나 이상 포함해야 합니다';

  @override
  String get formPasswordSpecial => '특수문자를 하나 이상 포함해야 합니다';

  @override
  String get commandSearch => '명령어를 입력하거나 검색하세요...';

  @override
  String get commandEmpty => '결과가 없습니다.';

  @override
  String get datePickerSelectYear => '연도 선택';

  @override
  String get abbreviatedMonday => '월';

  @override
  String get abbreviatedTuesday => '화';

  @override
  String get abbreviatedWednesday => '수';

  @override
  String get abbreviatedThursday => '목';

  @override
  String get abbreviatedFriday => '금';

  @override
  String get abbreviatedSaturday => '토';

  @override
  String get abbreviatedSunday => '일';

  @override
  String get monthJanuary => '1월';

  @override
  String get monthFebruary => '2월';

  @override
  String get monthMarch => '3월';

  @override
  String get monthApril => '4월';

  @override
  String get monthMay => '5월';

  @override
  String get monthJune => '6월';

  @override
  String get monthJuly => '7월';

  @override
  String get monthAugust => '8월';

  @override
  String get monthSeptember => '9월';

  @override
  String get monthOctober => '10월';

  @override
  String get monthNovember => '11월';

  @override
  String get monthDecember => '12월';

  @override
  String get abbreviatedJanuary => '1월';

  @override
  String get abbreviatedFebruary => '2월';

  @override
  String get abbreviatedMarch => '3월';

  @override
  String get abbreviatedApril => '4월';

  @override
  String get abbreviatedMay => '5월';

  @override
  String get abbreviatedJune => '6월';

  @override
  String get abbreviatedJuly => '7월';

  @override
  String get abbreviatedAugust => '8월';

  @override
  String get abbreviatedSeptember => '9월';

  @override
  String get abbreviatedOctober => '10월';

  @override
  String get abbreviatedNovember => '11월';

  @override
  String get abbreviatedDecember => '12월';

  @override
  String get dialogDismiss => '닫기';

  @override
  String get chipInputRemoveChip => '삭제';

  @override
  String get buttonCancel => '취소';

  @override
  String get buttonSave => '저장';

  @override
  String get timeHour => '시';

  @override
  String get timeMinute => '분';

  @override
  String get timeSecond => '초';

  @override
  String get timeAM => '오전';

  @override
  String get timePM => '오후';

  @override
  String get colorRed => '빨강';

  @override
  String get colorGreen => '초록';

  @override
  String get colorBlue => '파랑';

  @override
  String get colorAlpha => '알파';

  @override
  String get colorHue => '색조';

  @override
  String get colorSaturation => '채도';

  @override
  String get colorValue => '명도';

  @override
  String get colorLightness => '휘도';

  @override
  String get menuCut => '잘라내기';

  @override
  String get menuCopy => '복사';

  @override
  String get menuPaste => '붙여넣기';

  @override
  String get menuSelectAll => '전체 선택';

  @override
  String get menuUndo => '실행 취소';

  @override
  String get menuRedo => '다시 실행';

  @override
  String get menuDelete => '삭제';

  @override
  String get menuShare => '공유';

  @override
  String get menuSearchWeb => '웹에서 검색';

  @override
  String get menuLiveTextInput => '라이브 텍스트';

  @override
  String get placeholderDatePicker => '날짜 선택';

  @override
  String get placeholderTimePicker => '시간 선택';

  @override
  String get placeholderColorPicker => '색상 선택';

  @override
  String get buttonPrevious => '이전';

  @override
  String get buttonNext => '다음';

  @override
  String get refreshTriggerPull => '당겨서 새로 고침';

  @override
  String get refreshTriggerRelease => '놓아서 새로 고침';

  @override
  String get refreshTriggerRefreshing => '새로 고치는 중...';

  @override
  String get refreshTriggerComplete => '새로 고침 완료';

  @override
  String get colorPickerTabRGB => 'RGB';

  @override
  String get colorPickerTabHSV => 'HSV';

  @override
  String get colorPickerTabHSL => 'HSL';

  @override
  String get colorPickerTabHEX => 'HEX';

  @override
  String get commandMoveUp => '위로 이동';

  @override
  String get commandMoveDown => '아래로 이동';

  @override
  String get commandActivate => '선택';

  @override
  String get timeDaysAbbreviation => '일';

  @override
  String get timeHoursAbbreviation => '시';

  @override
  String get timeMinutesAbbreviation => '분';

  @override
  String get timeSecondsAbbreviation => '초';

  @override
  String get placeholderDurationPicker => '기간 선택';

  @override
  String get durationDay => '일';

  @override
  String get durationHour => '시간';

  @override
  String get durationMinute => '분';

  @override
  String get durationSecond => '초';

  @override
  String get dropzoneIdle => '파일을 업로드하려면 찾아보기';

  @override
  String get dropzoneDragging => '파일을 드롭하여 업로드';

  @override
  String get dropzoneUploading => '파일을 업로드하는 중...';

  @override
  String get dropzoneSuccess => '파일 준비 완료';

  @override
  String get dropzoneError => '계속하려면 오류를 수정하세요';

  @override
  String get dropzoneDisabled => '파일 업로드가 비활성화됨';

  @override
  String get dropzoneBrowse => '파일 찾아보기';

  @override
  String get emptyStateEmptyTitle => '아직 아무것도 없습니다';

  @override
  String get emptyStateEmptyDescription => '시작하려면 첫 항목을 만드세요.';

  @override
  String get emptyStateNoResultsTitle => '결과를 찾을 수 없습니다';

  @override
  String get emptyStateNoResultsDescription => '필터나 검색어를 조정해 보세요.';

  @override
  String get emptyStateErrorTitle => '문제가 발생했습니다';

  @override
  String get emptyStateErrorDescription => '이 데이터를 로드할 수 없습니다. 잠시 후 다시 시도하세요.';

  @override
  String get filterSearch => '검색';

  @override
  String get filterSort => '정렬';

  @override
  String get filterDateRange => '날짜 범위';

  @override
  String get filterClearAll => '모두 지우기';

  @override
  String get filterFilters => '필터';

  @override
  String filterActiveCount(int count) => '활성 필터 ${_number(count)}개';

  @override
  String filterResultsCount(int count) => '결과 ${_number(count)}개';

  @override
  String get fileUploadChoose => '파일 선택';

  @override
  String get fileUploadNoFile => '선택된 파일 없음';

  @override
  String get fileUploadPickFailed => '파일 선택에 실패했습니다.';

  @override
  String get fileUploadTooMany => '파일을 너무 많이 선택했습니다.';

  @override
  String get fileUploadTooLarge => '파일이 너무 큽니다.';

  @override
  String get fileUploadInvalidType => '허용되지 않는 파일 형식입니다.';

  @override
  String get fileUploadUploadFailed => '업로드에 실패했습니다.';

  @override
  String fileUploadUploadFailedFor(String name) => '$name 업로드에 실패했습니다.';

  @override
  String get fileUploadStatusQueued => '대기 중';

  @override
  String get fileUploadStatusUploading => '업로드 중';

  @override
  String get fileUploadStatusCompleted => '완료됨';

  @override
  String get fileUploadStatusFailed => '실패';

  @override
  String get fileUploadUnknownType => '파일';

  @override
  String get fileUploadRemove => '파일 제거';

  @override
  String get fileUploadRetry => '업로드 다시 시도';

  @override
  String get fileUploadPreview => '파일 미리 보기';

  @override
  String get fileUploadDownload => '파일 다운로드';

  @override
  String get errorSomethingWentWrong => '문제가 발생했습니다';

  @override
  String get errorUnexpectedMessage => '다시 시도하거나 문제가 지속되면 지원팀에 문의하세요.';

  @override
  String get errorActionRetry => '다시 시도';

  @override
  String get errorActionReport => '신고';

  @override
  String get errorActionBack => '뒤로 가기';

  @override
  String get errorActionLogin => '로그인';

  @override
  String get errorActionSettings => '설정';

  @override
  String get errorActionContactSupport => '지원팀에 문의';

  @override
  String get errorBadRequest => '잘못된 요청';

  @override
  String get errorBadRequestMessage => '요청이 유효하지 않습니다. 검토한 후 다시 시도하세요.';

  @override
  String get errorUnauthorized => '권한 없음';

  @override
  String get errorLoginRequiredMessage => '계속하려면 로그인하세요.';

  @override
  String get errorAccessDenied => '액세스 거부됨';

  @override
  String get errorAccessDeniedMessage => '이 작업을 수행할 권한이 없습니다.';

  @override
  String get errorNotFound => '찾을 수 없음';

  @override
  String get errorNotFoundMessage => '찾으시는 내용을 발견하지 못했습니다.';

  @override
  String get errorConflict => '충돌';

  @override
  String get errorConflictMessage => '이 작업이 기존 데이터와 충돌합니다.';

  @override
  String get errorInvalidData => '유효하지 않은 데이터';

  @override
  String get errorInvalidDataMessage => '일부 필드를 확인해야 합니다.';

  @override
  String get errorTooManyRequests => '요청이 너무 많습니다';

  @override
  String get errorTooManyRequestsMessage => '잠시 기다렸다가 다시 시도하세요.';

  @override
  String get errorServerError => '서버 오류';

  @override
  String get errorServerErrorMessage => '서버에 문제가 발생했습니다. 다시 시도하세요.';

  @override
  String get errorRequestTimedOut => '요청 시간 초과';

  @override
  String get errorRequestTimedOutMessage => '서버 응답이 너무 오래 걸립니다.';

  @override
  String get errorAuthenticationRequired => '인증 필요';

  @override
  String get errorInvalidInput => '유효하지 않은 입력';

  @override
  String get errorReviewFieldsMessage => '강조 표시된 필드를 검토하세요.';

  @override
  String get errorPlatformError => '플랫폼 오류';

  @override
  String get errorDeviceErrorMessage => '이 기기에서 문제가 발생했습니다.';

  @override
  String get errorConnectionFailed => '연결 실패';

  @override
  String get errorConnectionFailedMessage => '인터넷 연결을 확인하고 다시 시도하세요.';

  @override
  String get errorSecureConnectionFailed => '보안 연결 실패';

  @override
  String get errorSecureConnectionMessage => '보안 연결을 설정할 수 없습니다.';

  @override
  String get tableResizeColumn => '열 크기 조정';

  @override
  String get tableResizeRow => '행 크기 조정';

  @override
  String get resizableHandle => '크기 조정 핸들';

  @override
  String get spellCheckNoSuggestions => '제안 없음';

  @override
  String get announcementLoading => '로드 중';

  @override
  String get announcementSuccess => '성공';

  @override
  String get announcementFailure => '실패';

  @override
  String get toolbarMore => '더보기';

  @override
  String get toolbarMoreActions => '작업 더보기';

  @override
  String get treeCollapse => '접기';

  @override
  String get treeExpand => '펼치기';

  @override
  String get markdownDetails => '세부 정보';

  @override
  String get carouselLabel => '추천 캐러셀';

  @override
  String get carouselPrimaryAction => '채팅에 추가';

  @override
  String carouselItemPreview(Object? title) =>
      '추천 미리 보기: ${title ?? mediaUntitled}';

  @override
  String carouselPageOf(int position, int length) =>
      '${_number(length)}페이지 중 ${_number(position)}페이지';

  @override
  String stepperStep(int index) => '${_number(index + 1)}단계';

  @override
  String paginationPage(Object? page) => '${_number(page)}페이지';

  @override
  String chartSeriesDefault(int index) => '시리즈 ${_number(index + 1)}';

  @override
  String chartSliceDefault(int index) => '조각 ${_number(index)}';

  @override
  String chartCategoryDefault(int index) => '카테고리 ${_number(index)}';

  @override
  String get chartValueDefault => '값';

  @override
  String get chartKindLine => '선';

  @override
  String get chartKindArea => '영역';

  @override
  String get chartKindBar => '막대';

  @override
  String get chartKindDonut => '도넛';

  @override
  String get chartKindPie => '원';

  @override
  String get chartKindSparkline => '스파크라인';

  @override
  String get chartKindScatter => '산점도';

  @override
  String get chartKindRadar => '레이더';

  @override
  String get chartKindRadial => '방사형';

  @override
  String chartSummaryEmpty(Object? kind) => '데이터 없는 $kind 차트';

  @override
  String chartSummary(int series, int points, Object? kind) =>
      '$kind 차트: 시리즈 ${_number(series)}개, 포인트 ${_number(points)}개';

  @override
  String get colorFieldHsv => 'HSV 색상 필드';

  @override
  String get colorFieldHsl => 'HSL 색상 필드';

  @override
  String get actionClear => '지우기';

  @override
  String get actionApply => '적용';

  @override
  String get actionVerify => '확인';

  @override
  String get actionResend => '다시 보내기';

  @override
  String resendInSeconds(int seconds) => '${_number(seconds)}초 후 다시 보내기';

  @override
  String get authCode => '코드';

  @override
  String get authEmail => '이메일';

  @override
  String get authPassword => '비밀번호';

  @override
  String get authName => '이름';

  @override
  String get authSignIn => '로그인';

  @override
  String get authForgotPassword => '비밀번호를 잊으셨나요?';

  @override
  String get authRememberMe => '로그인 상태 유지';

  @override
  String get authCreateAccount => '계정 만들기';

  @override
  String get actionClose => '닫기';

  @override
  String get mediaPlay => '재생';

  @override
  String get mediaPause => '일시 정지';

  @override
  String get mediaMute => '음소거';

  @override
  String get mediaUnmute => '음소거 해제';

  @override
  String get mediaVolume => '음량';

  @override
  String get mediaSeek => '탐색';

  @override
  String get mediaDownload => '다운로드';

  @override
  String get mediaAudioPlayer => '오디오 플레이어';

  @override
  String get mediaVideoPlayer => '비디오 플레이어';

  @override
  String get mediaUntitled => '제목 없음';

  @override
  String get mediaPlaybackFailed => '재생에 실패했습니다';

  @override
  String get mediaPreviousTrack => '이전 트랙';

  @override
  String get mediaNextTrack => '다음 트랙';

  @override
  String get mediaShuffleDisable => '셔플 끄기';

  @override
  String get mediaShuffleEnable => '셔플 켜기';

  @override
  String get mediaRepeatDisable => '반복 끄기';

  @override
  String get mediaRepeatEnable => '반복 켜기';

  @override
  String mediaPlaybackSpeed(Object? speed) => '재생 속도 ${speed}x (탭하여 변경)';

  @override
  String mediaPositionOf(Object position, Object duration) =>
      '$position / $duration';

  @override
  String mediaHours(int count) => '${_number(count)}시간';

  @override
  String mediaMinutes(int count) => '${_number(count)}분';

  @override
  String mediaSeconds(int count) => '${_number(count)}초';

  @override
  String get signaturePadLabel => '서명란';

  @override
  String get qrCodeLabel => 'QR 코드';

  @override
  String get marqueeContent => '스크롤 콘텐츠';

  @override
  String mediaSkipBack(int seconds) => '${_number(seconds)}초 뒤로';

  @override
  String mediaSkipForward(int seconds) => '${_number(seconds)}초 앞으로';

  @override
  String get mediaCaptionsShow => '자막 표시';

  @override
  String get mediaCaptionsHide => '자막 숨기기';

  @override
  String get mediaCaptionsOn => '자막 켜짐';

  @override
  String get mediaCaptionsOff => '자막 꺼짐';

  @override
  String get mediaFullscreen => '전체 화면';

  @override
  String mediaMoreOptionsSpeed(Object? speed) => '옵션 더보기, 재생 속도 ${speed}x';

  @override
  String mediaSpeed(Object? speed) => '속도 ${speed}x';

  @override
  String get actionStartTrial => '무료 체험 시작';

  @override
  String get authFirstName => '이름';

  @override
  String get authLastName => '성';

  @override
  String get authPasswordHint => '8자 이상.';

  @override
  String get authUseDifferentEmail => '다른 이메일 사용';

  @override
  String get authWorkEmail => '직장 이메일';

  @override
  String get chartTotalLabel => '합계';

  @override
  String get mediaQualityAuto => '화질 자동';
}
