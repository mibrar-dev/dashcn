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

  @override
  String get blockDontHaveAccount => '계정이 없으신가요?';

  @override
  String get blockAlreadyHaveAccount => '이미 계정이 있으신가요?';

  @override
  String get blockNoAccountYet => '아직 계정이 없으신가요?';

  @override
  String get blockHaveAnAccount => '계정이 있으신가요?';

  @override
  String get blockCreateOne => '만들기';

  @override
  String get blockCreateAccount => '계정 만들기';

  @override
  String get blockCreateYourAccount => '계정 만들기';

  @override
  String get blockForgotYourPassword => '비밀번호를 잊으셨나요?';

  @override
  String get blockBackToSignIn => '로그인으로 돌아가기';

  @override
  String get blockEnterCredentialsWorkspace => '워크스페이스에 액세스하려면 자격 증명을 입력하세요.';

  @override
  String get blockEnterCredentialsContinue => '계속하려면 자격 증명을 입력하세요.';

  @override
  String get blockEnterDetailsContinue => '계속하려면 아래에 세부 정보를 입력하세요.';

  @override
  String get blockEnterEmailCreateAccount => '계정을 만들려면 아래에 이메일을 입력하세요.';

  @override
  String get blockSignedInWelcomeBack => '로그인됨 — 다시 오신 것을 환영합니다.';

  @override
  String get blockAccountCreatedVerify => '계정이 생성됨 — 확인하려면 받은 편지함을 확인하세요.';

  @override
  String get blockTrialStartedVerify => '체험이 시작됨 — 확인하려면 받은 편지함을 확인하세요.';

  @override
  String get blockPasswordsDoNotMatch => '비밀번호가 일치하지 않습니다.';

  @override
  String get blockCurrentPassword => '현재 비밀번호';

  @override
  String get blockNewPassword => '새 비밀번호';

  @override
  String get blockConfirmNewPassword => '새 비밀번호 확인';

  @override
  String get blockUpdatePassword => '비밀번호 업데이트';

  @override
  String get blockPasswordUpdated => '비밀번호가 업데이트됨.';

  @override
  String get blockPasswordHintChange => '8자 이상. 변경하면 다른 곳에서 로그아웃됩니다.';

  @override
  String get blockUsername => '사용자 이름';

  @override
  String get blockUsernameHint => '소문자, 숫자, 밑줄.';

  @override
  String get blockYourAvatar => '내 아바타';

  @override
  String get blockUploadImage => '이미지 업로드';

  @override
  String get blockBio => '소개';

  @override
  String get blockBioHint => '자신에 대해 조금 알려주세요';

  @override
  String get blockBioCounterHint => '최대 160자.';

  @override
  String get blockProfileSaved => '프로필이 저장됨.';

  @override
  String get blockSaveChanges => '변경 사항 저장';

  @override
  String get blockInviteMember => '구성원 초대';

  @override
  String get blockRoleAdmin => '관리자';

  @override
  String get blockRoleOwner => '소유자';

  @override
  String get blockRoleMember => '구성원';

  @override
  String get blockTeam => '팀';

  @override
  String get blockProfile => '프로필';

  @override
  String get blockSignInWithEmail => '이메일로 로그인';

  @override
  String get blockSignUp => '가입하기';

  @override
  String get blockPickWayYouPrefer => '원하는 방식을 선택하세요.';

  @override
  String blockContinueWith(Object? provider) => '$provider(으)로 계속하기';

  @override
  String get blockCreating => '만드는 중…';

  @override
  String get blockSigningIn => '로그인 중…';

  @override
  String get blockSending => '보내는 중…';

  @override
  String get blockSaving => '저장 중…';

  @override
  String get blockPaying => '결제 중…';

  @override
  String get blockSendResetLink => '재설정 링크 보내기';

  @override
  String get blockResetPassword => '비밀번호 재설정';

  @override
  String get blockResetLinkSent => '재설정 링크가 전송됨. 계속하려면 받은 편지함을 확인하세요.';

  @override
  String get blockWeWillEmailReset => '재설정 링크를 이메일로 보내드리겠습니다.';

  @override
  String get blockMustAcceptTerms => '계속하려면 약관에 동의해야 합니다.';

  @override
  String get blockCheckInbox => '받은 편지함 확인';

  @override
  String get blockEnterSixDigitCode => '보내드린 6자리 코드를 입력하세요.';

  @override
  String get blockCodeVerifiedSignedIn => '코드가 확인됨. 로그인되었습니다.';

  @override
  String get blockEmailVerifiedSet => '이메일이 확인됨 — 준비 완료.';

  @override
  String get blockVerifyYourEmail => '이메일 확인';

  @override
  String blockWeSentCodeTo(Object? email) => '$email(으)로 6자리 코드를 보냈습니다.';

  @override
  String get blockDidntGetCode => '코드를 받지 못하셨나요?';

  @override
  String get blockBack => '뒤로';

  @override
  String get blockBackToCart => '장바구니로 돌아가기';

  @override
  String get blockBackToSettings => '설정으로 돌아가기';

  @override
  String get blockOneAccountEverything => '모든 것을 위한 하나의 계정.';

  @override
  String get blockStartTrialNoCard => '14일 체험을 시작하세요. 신용카드가 필요 없습니다.';

  @override
  String get blockNotifications => '알림';

  @override
  String get blockNotifChoose => '무엇에 대해 어디에서 듣고 싶은지 선택하세요.';

  @override
  String get blockEmailNotifications => '이메일 알림';

  @override
  String get blockPushNotifications => '푸시 알림';

  @override
  String get blockMentionsReplies => '멘션 및 답글';

  @override
  String get blockDeliveredToDevices => '내 기기에 전송됨';

  @override
  String blockEmailChannel(Object? channel) => '이메일 · $channel';

  @override
  String blockPushChannel(Object? channel) => '푸시 · $channel';

  @override
  String get blockQuietHours => '방해 금지 시간';

  @override
  String get blockWeeklyDigest => '주간 다이제스트';

  @override
  String get blockWeeklyDigestBlurb => '일어난 모든 일을 담은 이메일, 매주 월요일.';

  @override
  String get blockPreferencesSaved => '환경설정이 저장됨.';

  @override
  String get blockSavePreferences => '환경설정 저장';

  @override
  String get blockReset => '재설정';

  @override
  String get blockWelcomeAboard => '환영합니다';

  @override
  String get blockQuickTour => '앱 사용 전 간단한 둘러보기.';

  @override
  String get blockStayInLoop => '소식을 받아보세요';

  @override
  String get blockMessagesArriveMoment => '메시지와 업데이트가 발생하는 즉시 도착합니다.';

  @override
  String get blockNeverMissThing => '아무것도 놓치지 마세요';

  @override
  String get blockNotifPermissionBlurb =>
      '중요한 것만 보냅니다: 답글, 리마인더 및 보안 알림. 나중에 변경할 수 있습니다.';

  @override
  String get blockEnableNotifications => '알림을 사용하시겠습니까?';

  @override
  String get blockAllowNotifications => '알림 허용';

  @override
  String get blockAllowNotificationsBlurb => '앱을 최대한 활용하려면 알림을 허용하세요.';

  @override
  String get blockNotNow => '나중에';

  @override
  String get blockSkip => '건너뛰기';

  @override
  String get blockGetStarted => '시작하기';

  @override
  String get blockMessages => '메시지';

  @override
  String get blockNoConversations => '대화 없음';

  @override
  String get blockPullRefreshChat => '당겨서 새로고침하거나 새 채팅을 시작하세요.';

  @override
  String get blockMute => '음소거';

  @override
  String get blockMuted => '음소거됨';

  @override
  String get blockAttach => '첨부';

  @override
  String get blockAttachFile => '파일';

  @override
  String get blockAttachPhoto => '사진';

  @override
  String get blockWriteMessage => '메시지 작성…';

  @override
  String get blockYourCart => '내 장바구니';

  @override
  String get blockAddSomethingFirst => '먼저 마음에 드는 것을 추가하세요.';

  @override
  String get blockCartEmpty => '장바구니가 비어 있음';

  @override
  String get blockCheckout => '결제하기';

  @override
  String blockQty(int quantity) => '수량 $quantity';

  @override
  String blockPayTotal(Object? amount) => '$amount 결제';

  @override
  String get blockPayment => '결제';

  @override
  String get blockCardNumber => '카드 번호';

  @override
  String get blockExpiry => '만료일';

  @override
  String get blockCvc => 'CVC';

  @override
  String get blockDeliveryAddress => '배송 주소';

  @override
  String get blockStreet => '도로명';

  @override
  String get blockCity => '도시';

  @override
  String get blockSaveAndContinue => '저장하고 계속하기';

  @override
  String get blockOrderPlaced => '주문이 완료됨';

  @override
  String get blockOrderThanks => '이용해 주셔서 감사합니다. 확인서가 전송 중입니다.';

  @override
  String get blockContinueShopping => '계속 쇼핑하기';

  @override
  String get blockSchedule => '일정';

  @override
  String get blockPickDateRangeReport => '보고서의 날짜 범위를 선택하세요.';

  @override
  String get blockPickDateRange => '날짜 범위 선택';

  @override
  String get blockTapAnotherDay => '다른 날짜를 탭하여 범위 확장';

  @override
  String get blockBookMeeting => '회의 예약';

  @override
  String get blockPickDayTime => '날짜를 고른 뒤 편한 시간을 선택하세요.';

  @override
  String get blockFourSlots => '30분 슬롯 4개 남음. 하나를 선택하세요.';

  @override
  String blockPickedSlot(Object? slot) => '$slot 선택, 30분.';

  @override
  String get blockOverview => '개요';

  @override
  String get blockRevenueOrdersBlurb => '수익, 구독 및 최근 주문.';

  @override
  String get blockTotalRevenue => '총 수익';

  @override
  String get blockSubscriptions => '구독';

  @override
  String get blockSales => '매출';

  @override
  String get blockRevenueByMonth => '월별 수익';

  @override
  String get blockRecentSales => '최근 매출';

  @override
  String get blockViewAll => '모두 보기';

  @override
  String get blockTransactions => '거래';

  @override
  String get blockFilterTransactions => '거래 필터링';

  @override
  String get blockCustomer => '고객';

  @override
  String get blockAmount => '금액';

  @override
  String get blockMethod => '수단';

  @override
  String get blockStatus => '상태';

  @override
  String get blockPaid => '결제됨';

  @override
  String get blockPending => '보류 중';

  @override
  String get blockRefunded => '환불됨';

  @override
  String blockNoTransactions(Object? query) => '“$query”와(과) 일치하는 거래가 없습니다.';

  @override
  String blockDeltaFromLastMonth(Object? delta) => '지난달 대비 $delta';

  @override
  String get blockAnalytics => '분석';

  @override
  String get blockSessionsDevicesBlurb => '세션, 기기 및 트래픽 유입 경로.';

  @override
  String get blockSearchReports => '보고서 검색';

  @override
  String get blockLast30Days => '지난 30일';

  @override
  String get blockAllDevices => '모든 기기';

  @override
  String get blockSessions => '세션';

  @override
  String get blockUsers => '사용자';

  @override
  String get blockAvgSession => '평균 세션';

  @override
  String get blockBounceRate => '이탈률';

  @override
  String get blockConversions => '전환';

  @override
  String get blockByDevice => '기기별';

  @override
  String get blockDesktop => '데스크톱';

  @override
  String get blockMobile => '모바일';

  @override
  String get blockTablet => '태블릿';

  @override
  String get blockDirect => '직접';

  @override
  String get blockReferral => '추천';

  @override
  String get blockSocial => '소셜';

  @override
  String get blockTrafficSources => '트래픽 소스';

  @override
  String get blockVisitors => '방문자';

  @override
  String get blockHome => '홈';

  @override
  String get blockInbox => '받은 편지함';

  @override
  String get blockCalendar => '캘린더';

  @override
  String get blockCompose => '쓰기';

  @override
  String get blockMarkAllRead => '모두 읽음으로 표시';

  @override
  String get blockStarred => '별표';

  @override
  String get blockSnoozed => '다시 알림';

  @override
  String get blockUnread => '읽지 않음';

  @override
  String get blockDocuments => '문서';

  @override
  String get blockReports => '보고서';

  @override
  String get blockDashboard => '대시보드';

  @override
  String get blockStorage => '저장소';

  @override
  String get blockNavigation => '탐색';

  @override
  String get blockSharedWithYou => '나와 공유됨';

  @override
  String get blockRecentProjects => '최근 프로젝트';

  @override
  String get blockStorageUsed => '사용 중인 저장소';

  @override
  String get blockOpen => '열기';

  @override
  String get blockLive => '라이브';

  @override
  String get blockMembers => '구성원';

  @override
  String get blockProjects => '프로젝트';

  @override
  String get blockDeploys => '배포';

  @override
  String get blockActivity => '활동';

  @override
  String get blockRecentFiles => '최근 파일';

  @override
  String get blockUsageThisMonth => '이번 달 사용량';

  @override
  String get blockUpgradePlan => '플랜 업그레이드';

  @override
  String blockNoMatches(Object? query) => '“$query”에 대한 결과 없음.';

  @override
  String get blockWorkspaces => '워크스페이스';

  @override
  String get blockPricing => '요금제';

  @override
  String get blockPlansScale => '함께 성장하는 플랜';

  @override
  String get blockPlansBlurb =>
      '무료로 시작하고 팀이 성장하면 업그레이드하세요. 모든 플랜에 전체 컴포넌트 라이브러리와 테마 프리셋이 포함됩니다.';

  @override
  String get blockPerUserMonth => '사용자당 / 월';

  @override
  String get blockSubscribe => '구독하기';

  @override
  String get blockContactSales => '영업팀에 문의';

  @override
  String get blockPromoCode => '프로모 코드';

  @override
  String get blockApplyCode => '코드 적용';

  @override
  String get blockHaveCodeEnter => '코드가 있으신가요? 아래에 입력하세요.';

  @override
  String get blockCodeAppliedDiscount => '코드가 적용됨 — 할인이 결제 시 표시됩니다.';

  @override
  String get blockFaqTitle => '질문';

  @override
  String get blockFaqChangePlans => '나중에 플랜을 변경할 수 있나요?';

  @override
  String get blockFaqChangePlansAnswer =>
      '예. 업그레이드는 즉시 적용되며 다운그레이드는 다음 주기부터 적용됩니다.';

  @override
  String get blockFaqFreeTrial => '무료 체험이 있나요?';

  @override
  String get blockFaqFreeTrialAnswer => '모든 플랜은 14일로 시작하며 카드가 필요 없습니다.';

  @override
  String get blockAccount => '계정';

  @override
  String get blockGeneral => '일반';

  @override
  String get blockAppearance => '모양';

  @override
  String get blockDarkMode => '다크 모드';

  @override
  String get blockPreferences => '환경설정';

  @override
  String get blockSignOut => '로그아웃';

  @override
  String get blockSignOutConfirm => '로그아웃하시겠습니까?';

  @override
  String get blockSignOutBlurb => '나중에 언제든 다시 로그인할 수 있습니다.';

  @override
  String get blockSounds => '사운드';

  @override
  String get blockWhatYouGet => '제공 내용';

  @override
  String get blockAllComponentCategories => '모든 컴포넌트 카테고리';

  @override
  String get blockPrioritySupport => '우선 지원';

  @override
  String get blockUnlimitedProjectsTrial => '체험 기간 중 무제한 프로젝트';

  @override
  String get blockTrialDaysLeft => '체험 14일 남음';

  @override
  String get blockStarterChat => '채팅';

  @override
  String get blockStarterShop => '쇼핑';

  @override
  String get blockStarterCart => '장바구니';

  @override
  String get blockAddToCart => '장바구니에 추가';
}
