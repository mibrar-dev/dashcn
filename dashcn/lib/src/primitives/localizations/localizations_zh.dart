import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

/// Chinese (`zh`) locale data.
///
/// Translations only: anything this table does not override falls
/// through to the English default on [ComponentLocalizations]. Text
/// direction is not handled here - Flutter resolves it from
/// [WidgetsLocalizations] and [Directionality].
class ComponentLocalizationsZh extends ComponentLocalizations {
  /// Creates the Chinese strings.
  const ComponentLocalizationsZh([super.locale = const Locale('zh')]);

  /// Formats [value] as a number in this locale, or returns it
  /// verbatim when it is not a number.
  String _number(Object? value) {
    if (value is! num) return '$value';
    return intl.NumberFormat.decimalPattern(localeName).format(value);
  }

  @override
  String get formNotEmpty => '此字段不能为空';

  @override
  String get invalidValue => '无效的值';

  @override
  String get invalidEmail => '无效的电子邮件地址';

  @override
  String get invalidURL => '无效的网址';

  @override
  String formLessThan(Object? value) => '必须小于 ${_number(value)}';

  @override
  String formGreaterThan(Object? value) => '必须大于 ${_number(value)}';

  @override
  String formLessThanOrEqualTo(Object? value) => '必须小于或等于 ${_number(value)}';

  @override
  String get formPhoneNumberInvalid => '电话号码无效';

  @override
  String get formPhoneNumberEmpty => '请输入电话号码';

  @override
  String formGreaterThanOrEqualTo(Object? value) => '必须大于或等于 ${_number(value)}';

  @override
  String formBetweenInclusively(Object? min, Object? max) =>
      '必须介于 ${_number(min)} 和 ${_number(max)} 之间（含端点）';

  @override
  String formEqualTo(Object? value) => '必须等于 ${_number(value)}';

  @override
  String formBetweenExclusively(Object? min, Object? max) =>
      '必须介于 ${_number(min)} 和 ${_number(max)} 之间（不含端点）';

  @override
  String formLengthLessThan(int limit) => '至少需要 $limit 个字符';

  @override
  String formLengthGreaterThan(int limit) => '最多只能有 $limit 个字符';

  @override
  String get formPasswordDigits => '必须包含至少一个数字';

  @override
  String get formPasswordLowercase => '必须包含至少一个小写字母';

  @override
  String get formPasswordUppercase => '必须包含至少一个大写字母';

  @override
  String get formPasswordSpecial => '必须包含至少一个特殊字符';

  @override
  String get commandSearch => '输入命令或搜索...';

  @override
  String get commandEmpty => '未找到结果。';

  @override
  String get datePickerSelectYear => '选择年份';

  @override
  String get abbreviatedMonday => '一';

  @override
  String get abbreviatedTuesday => '二';

  @override
  String get abbreviatedWednesday => '三';

  @override
  String get abbreviatedThursday => '四';

  @override
  String get abbreviatedFriday => '五';

  @override
  String get abbreviatedSaturday => '六';

  @override
  String get abbreviatedSunday => '日';

  @override
  String get monthJanuary => '一月';

  @override
  String get monthFebruary => '二月';

  @override
  String get monthMarch => '三月';

  @override
  String get monthApril => '四月';

  @override
  String get monthMay => '五月';

  @override
  String get monthJune => '六月';

  @override
  String get monthJuly => '七月';

  @override
  String get monthAugust => '八月';

  @override
  String get monthSeptember => '九月';

  @override
  String get monthOctober => '十月';

  @override
  String get monthNovember => '十一月';

  @override
  String get monthDecember => '十二月';

  @override
  String get abbreviatedJanuary => '1月';

  @override
  String get abbreviatedFebruary => '2月';

  @override
  String get abbreviatedMarch => '3月';

  @override
  String get abbreviatedApril => '4月';

  @override
  String get abbreviatedMay => '5月';

  @override
  String get abbreviatedJune => '6月';

  @override
  String get abbreviatedJuly => '7月';

  @override
  String get abbreviatedAugust => '8月';

  @override
  String get abbreviatedSeptember => '9月';

  @override
  String get abbreviatedOctober => '10月';

  @override
  String get abbreviatedNovember => '11月';

  @override
  String get abbreviatedDecember => '12月';

  @override
  String get dialogDismiss => '关闭';

  @override
  String get chipInputRemoveChip => '删除';

  @override
  String get buttonCancel => '取消';

  @override
  String get buttonSave => '保存';

  @override
  String get timeHour => '时';

  @override
  String get timeMinute => '分';

  @override
  String get timeSecond => '秒';

  @override
  String get timeAM => '上午';

  @override
  String get timePM => '下午';

  @override
  String get colorRed => '红';

  @override
  String get colorGreen => '绿';

  @override
  String get colorBlue => '蓝';

  @override
  String get colorAlpha => '透明度';

  @override
  String get colorHue => '色相';

  @override
  String get colorSaturation => '饱和度';

  @override
  String get colorValue => '明度';

  @override
  String get colorLightness => '亮度';

  @override
  String get menuCut => '剪切';

  @override
  String get menuCopy => '复制';

  @override
  String get menuPaste => '粘贴';

  @override
  String get menuSelectAll => '全选';

  @override
  String get menuUndo => '撤销';

  @override
  String get menuRedo => '重做';

  @override
  String get menuDelete => '删除';

  @override
  String get menuShare => '分享';

  @override
  String get menuSearchWeb => '网页搜索';

  @override
  String get menuLiveTextInput => '实时文本';

  @override
  String get placeholderDatePicker => '选择日期';

  @override
  String get placeholderTimePicker => '选择时间';

  @override
  String get placeholderColorPicker => '选择颜色';

  @override
  String get buttonPrevious => '上一步';

  @override
  String get buttonNext => '下一步';

  @override
  String get refreshTriggerPull => '下拉刷新';

  @override
  String get refreshTriggerRelease => '释放以刷新';

  @override
  String get refreshTriggerRefreshing => '正在刷新...';

  @override
  String get refreshTriggerComplete => '刷新完成';

  @override
  String get colorPickerTabRGB => 'RGB';

  @override
  String get colorPickerTabHSV => 'HSV';

  @override
  String get colorPickerTabHSL => 'HSL';

  @override
  String get colorPickerTabHEX => 'HEX';

  @override
  String get commandMoveUp => '上移';

  @override
  String get commandMoveDown => '下移';

  @override
  String get commandActivate => '选择';

  @override
  String get timeDaysAbbreviation => '日';

  @override
  String get timeHoursAbbreviation => '时';

  @override
  String get timeMinutesAbbreviation => '分';

  @override
  String get timeSecondsAbbreviation => '秒';

  @override
  String get placeholderDurationPicker => '选择时长';

  @override
  String get durationDay => '天';

  @override
  String get durationHour => '小时';

  @override
  String get durationMinute => '分钟';

  @override
  String get durationSecond => '秒';

  @override
  String get dropzoneIdle => '浏览以上传文件';

  @override
  String get dropzoneDragging => '拖放文件以上传';

  @override
  String get dropzoneUploading => '正在上传文件...';

  @override
  String get dropzoneSuccess => '文件已就绪';

  @override
  String get dropzoneError => '请修复错误以继续';

  @override
  String get dropzoneDisabled => '文件上传已禁用';

  @override
  String get dropzoneBrowse => '浏览文件';

  @override
  String get emptyStateEmptyTitle => '这里还没有内容';

  @override
  String get emptyStateEmptyDescription => '创建您的第一个项目以开始。';

  @override
  String get emptyStateNoResultsTitle => '未找到结果';

  @override
  String get emptyStateNoResultsDescription => '请尝试调整筛选条件或搜索词。';

  @override
  String get emptyStateErrorTitle => '出现了一些问题';

  @override
  String get emptyStateErrorDescription => '我们无法加载这些数据。请稍后再试。';

  @override
  String get filterSearch => '搜索';

  @override
  String get filterSort => '排序';

  @override
  String get filterDateRange => '日期范围';

  @override
  String get filterClearAll => '全部清除';

  @override
  String get filterFilters => '筛选';

  @override
  String filterActiveCount(int count) => '${_number(count)} 个生效的筛选';

  @override
  String filterResultsCount(int count) => '${_number(count)} 个结果';

  @override
  String get fileUploadChoose => '选择文件';

  @override
  String get fileUploadNoFile => '未选择文件';

  @override
  String get fileUploadPickFailed => '文件选择失败。';

  @override
  String get fileUploadTooMany => '选择的文件过多。';

  @override
  String get fileUploadTooLarge => '文件太大。';

  @override
  String get fileUploadInvalidType => '不允许此文件类型。';

  @override
  String get fileUploadUploadFailed => '上传失败。';

  @override
  String fileUploadUploadFailedFor(String name) => '$name 上传失败。';

  @override
  String get fileUploadStatusQueued => '排队中';

  @override
  String get fileUploadStatusUploading => '上传中';

  @override
  String get fileUploadStatusCompleted => '已完成';

  @override
  String get fileUploadStatusFailed => '失败';

  @override
  String get fileUploadUnknownType => '文件';

  @override
  String get fileUploadRemove => '移除文件';

  @override
  String get fileUploadRetry => '重试上传';

  @override
  String get fileUploadPreview => '预览文件';

  @override
  String get fileUploadDownload => '下载文件';

  @override
  String get errorSomethingWentWrong => '出现了一些问题';

  @override
  String get errorUnexpectedMessage => '请重试，如果问题仍然存在，请联系支持人员。';

  @override
  String get errorActionRetry => '重试';

  @override
  String get errorActionReport => '举报';

  @override
  String get errorActionBack => '返回';

  @override
  String get errorActionLogin => '登录';

  @override
  String get errorActionSettings => '设置';

  @override
  String get errorActionContactSupport => '联系支持人员';

  @override
  String get errorBadRequest => '错误的请求';

  @override
  String get errorBadRequestMessage => '请求无效。请检查后重试。';

  @override
  String get errorUnauthorized => '未授权';

  @override
  String get errorLoginRequiredMessage => '请登录以继续。';

  @override
  String get errorAccessDenied => '访问被拒绝';

  @override
  String get errorAccessDeniedMessage => '您没有执行此操作的权限。';

  @override
  String get errorNotFound => '未找到';

  @override
  String get errorNotFoundMessage => '我们找不到您要查找的内容。';

  @override
  String get errorConflict => '冲突';

  @override
  String get errorConflictMessage => '此操作与现有数据冲突。';

  @override
  String get errorInvalidData => '无效数据';

  @override
  String get errorInvalidDataMessage => '部分字段需要您的关注。';

  @override
  String get errorTooManyRequests => '请求过多';

  @override
  String get errorTooManyRequestsMessage => '请稍候片刻，然后重试。';

  @override
  String get errorServerError => '服务器错误';

  @override
  String get errorServerErrorMessage => '服务器遇到了问题。请重试。';

  @override
  String get errorRequestTimedOut => '请求超时';

  @override
  String get errorRequestTimedOutMessage => '服务器响应时间过长。';

  @override
  String get errorAuthenticationRequired => '需要身份验证';

  @override
  String get errorInvalidInput => '输入无效';

  @override
  String get errorReviewFieldsMessage => '请检查突出显示的字段。';

  @override
  String get errorPlatformError => '平台错误';

  @override
  String get errorDeviceErrorMessage => '此设备出现了一些问题。';

  @override
  String get errorConnectionFailed => '连接失败';

  @override
  String get errorConnectionFailedMessage => '请检查您的互联网连接，然后重试。';

  @override
  String get errorSecureConnectionFailed => '安全连接失败';

  @override
  String get errorSecureConnectionMessage => '我们无法建立安全连接。';

  @override
  String get tableResizeColumn => '调整列宽';

  @override
  String get tableResizeRow => '调整行高';

  @override
  String get resizableHandle => '大小调整手柄';

  @override
  String get spellCheckNoSuggestions => '没有建议';

  @override
  String get announcementLoading => '正在加载';

  @override
  String get announcementSuccess => '成功';

  @override
  String get announcementFailure => '失败';

  @override
  String get toolbarMore => '更多';

  @override
  String get toolbarMoreActions => '更多操作';

  @override
  String get treeCollapse => '收起';

  @override
  String get treeExpand => '展开';

  @override
  String get markdownDetails => '详情';

  @override
  String get carouselLabel => '精选轮播';

  @override
  String get carouselPrimaryAction => '添加到聊天';

  @override
  String carouselItemPreview(Object? title) => '精选预览：${title ?? mediaUntitled}';

  @override
  String carouselPageOf(int position, int length) =>
      '第 ${_number(position)} 页，共 ${_number(length)} 页';

  @override
  String stepperStep(int index) => '第 ${_number(index + 1)} 步';

  @override
  String paginationPage(Object? page) => '第 ${_number(page)} 页';

  @override
  String chartSeriesDefault(int index) => '系列 ${_number(index + 1)}';

  @override
  String chartSliceDefault(int index) => '切片 ${_number(index)}';

  @override
  String chartCategoryDefault(int index) => '类别 ${_number(index)}';

  @override
  String get chartValueDefault => '数值';

  @override
  String get chartKindLine => '折线';

  @override
  String get chartKindArea => '面积';

  @override
  String get chartKindBar => '柱状';

  @override
  String get chartKindDonut => '环形';

  @override
  String get chartKindPie => '饼形';

  @override
  String get chartKindSparkline => '迷你图';

  @override
  String get chartKindScatter => '散点';

  @override
  String get chartKindRadar => '雷达';

  @override
  String get chartKindRadial => '径向';

  @override
  String chartSummaryEmpty(Object? kind) => '无数据的 $kind 图表';

  @override
  String chartSummary(int series, int points, Object? kind) =>
      '$kind 图表：${_number(series)} 个系列，${_number(points)} 个数据点';

  @override
  String get colorFieldHsv => 'HSV 颜色区域';

  @override
  String get colorFieldHsl => 'HSL 颜色区域';

  @override
  String get actionClear => '清除';

  @override
  String get actionApply => '应用';

  @override
  String get actionVerify => '验证';

  @override
  String get actionResend => '重新发送';

  @override
  String resendInSeconds(int seconds) => '${_number(seconds)} 秒后重新发送';

  @override
  String get authCode => '验证码';

  @override
  String get authEmail => '电子邮箱';

  @override
  String get authPassword => '密码';

  @override
  String get authName => '姓名';

  @override
  String get authSignIn => '登录';

  @override
  String get authForgotPassword => '忘记密码？';

  @override
  String get authRememberMe => '记住我';

  @override
  String get authCreateAccount => '创建账号';

  @override
  String get actionClose => '关闭';

  @override
  String get mediaPlay => '播放';

  @override
  String get mediaPause => '暂停';

  @override
  String get mediaMute => '静音';

  @override
  String get mediaUnmute => '取消静音';

  @override
  String get mediaVolume => '音量';

  @override
  String get mediaSeek => '快进快退';

  @override
  String get mediaDownload => '下载';

  @override
  String get mediaAudioPlayer => '音频播放器';

  @override
  String get mediaVideoPlayer => '视频播放器';

  @override
  String get mediaUntitled => '未命名';

  @override
  String get mediaPlaybackFailed => '播放失败';

  @override
  String get mediaPreviousTrack => '上一首';

  @override
  String get mediaNextTrack => '下一首';

  @override
  String get mediaShuffleDisable => '关闭随机播放';

  @override
  String get mediaShuffleEnable => '开启随机播放';

  @override
  String get mediaRepeatDisable => '关闭重复播放';

  @override
  String get mediaRepeatEnable => '开启重复播放';

  @override
  String mediaPlaybackSpeed(Object? speed) => '播放速度 ${speed}x，点击更改';

  @override
  String mediaPositionOf(Object position, Object duration) =>
      '$position / $duration';

  @override
  String mediaHours(int count) => '${_number(count)} 小时';

  @override
  String mediaMinutes(int count) => '${_number(count)} 分钟';

  @override
  String mediaSeconds(int count) => '${_number(count)} 秒';

  @override
  String get signaturePadLabel => '签名区';

  @override
  String get qrCodeLabel => '二维码';

  @override
  String get marqueeContent => '滚动内容';

  @override
  String mediaSkipBack(int seconds) => '后退 ${_number(seconds)} 秒';

  @override
  String mediaSkipForward(int seconds) => '前进 ${_number(seconds)} 秒';

  @override
  String get mediaCaptionsShow => '显示字幕';

  @override
  String get mediaCaptionsHide => '隐藏字幕';

  @override
  String get mediaCaptionsOn => '字幕已开启';

  @override
  String get mediaCaptionsOff => '字幕已关闭';

  @override
  String get mediaFullscreen => '全屏';

  @override
  String mediaMoreOptionsSpeed(Object? speed) => '更多选项，播放速度 ${speed}x';

  @override
  String mediaSpeed(Object? speed) => '速度 ${speed}x';

  @override
  String get actionStartTrial => '开始免费试用';

  @override
  String get authFirstName => '名';

  @override
  String get authLastName => '姓';

  @override
  String get authPasswordHint => '至少8个字符。';

  @override
  String get authUseDifferentEmail => '使用其他电子邮箱';

  @override
  String get authWorkEmail => '工作邮箱';

  @override
  String get chartTotalLabel => '总计';

  @override
  String get mediaQualityAuto => '画质 自动';

  @override
  String get mediaLiveBadge => '直播';

  @override
  String get blockDontHaveAccount => '还没有帐户？';

  @override
  String get blockAlreadyHaveAccount => '已有帐户？';

  @override
  String get blockNoAccountYet => '还没有帐户吗？';

  @override
  String get blockHaveAnAccount => '有帐户吗？';

  @override
  String get blockCreateOne => '创建一个';

  @override
  String get blockCreateAccount => '创建帐户';

  @override
  String get blockCreateYourAccount => '创建您的帐户';

  @override
  String get blockForgotYourPassword => '忘记密码？';

  @override
  String get blockBackToSignIn => '返回登录';

  @override
  String get blockEnterCredentialsWorkspace => '输入您的凭据以访问工作区。';

  @override
  String get blockEnterCredentialsContinue => '输入您的凭据以继续。';

  @override
  String get blockEnterDetailsContinue => '在下方输入您的详细信息以继续。';

  @override
  String get blockEnterEmailCreateAccount => '在下方输入您的电子邮件以创建帐户。';

  @override
  String get blockSignedInWelcomeBack => '已登录——欢迎回来。';

  @override
  String get blockAccountCreatedVerify => '帐户已创建——请检查收件箱进行验证。';

  @override
  String get blockTrialStartedVerify => '试用已开始——请检查收件箱进行验证。';

  @override
  String get blockPasswordsDoNotMatch => '密码不匹配。';

  @override
  String get blockCurrentPassword => '当前密码';

  @override
  String get blockNewPassword => '新密码';

  @override
  String get blockConfirmNewPassword => '确认新密码';

  @override
  String get blockUpdatePassword => '更新密码';

  @override
  String get blockPasswordUpdated => '密码已更新。';

  @override
  String get blockPasswordHintChange => '至少8个字符。更改后您将在其他地方退出登录。';

  @override
  String get blockUsername => '用户名';

  @override
  String get blockUsernameHint => '小写字母、数字、下划线。';

  @override
  String get blockYourAvatar => '您的头像';

  @override
  String get blockUploadImage => '上传图片';

  @override
  String get blockBio => '简介';

  @override
  String get blockBioHint => '简单介绍一下自己';

  @override
  String get blockBioCounterHint => '最多160个字符。';

  @override
  String get blockProfileSaved => '个人资料已保存。';

  @override
  String get blockSaveChanges => '保存更改';

  @override
  String get blockInviteMember => '邀请成员';

  @override
  String get blockRoleAdmin => '管理员';

  @override
  String get blockRoleOwner => '所有者';

  @override
  String get blockRoleMember => '成员';

  @override
  String get blockTeam => '团队';

  @override
  String get blockProfile => '个人资料';

  @override
  String get blockSignInWithEmail => '使用电子邮件登录';

  @override
  String get blockSignUp => '注册';

  @override
  String get blockPickWayYouPrefer => '选择您喜欢的方式。';

  @override
  String blockContinueWith(Object? provider) => '使用 $provider 继续';

  @override
  String get blockCreating => '创建中…';

  @override
  String get blockSigningIn => '登录中…';

  @override
  String get blockSending => '发送中…';

  @override
  String get blockSaving => '保存中…';

  @override
  String get blockPaying => '支付中…';

  @override
  String get blockSendResetLink => '发送重置链接';

  @override
  String get blockResetPassword => '重置密码';

  @override
  String get blockResetLinkSent => '重置链接已发送。请检查收件箱以继续。';

  @override
  String get blockWeWillEmailReset => '我们将通过电子邮件向您发送重置链接。';

  @override
  String get blockMustAcceptTerms => '您必须接受条款才能继续。';

  @override
  String get blockCheckInbox => '检查收件箱';

  @override
  String get blockEnterSixDigitCode => '输入我们发送给您的6位验证码。';

  @override
  String get blockCodeVerifiedSignedIn => '验证码已验证。您已登录。';

  @override
  String get blockEmailVerifiedSet => '电子邮件已验证——一切就绪。';

  @override
  String get blockVerifyYourEmail => '验证您的电子邮件';

  @override
  String blockWeSentCodeTo(Object? email) => '我们已向 $email 发送了六位数验证码。';

  @override
  String get blockDidntGetCode => '没有收到验证码？';

  @override
  String get blockBack => '返回';

  @override
  String get blockBackToCart => '返回购物车';

  @override
  String get blockBackToSettings => '返回设置';

  @override
  String get blockOneAccountEverything => '一个帐户搞定一切。';

  @override
  String get blockStartTrialNoCard => '开始14天试用。无需信用卡。';

  @override
  String get blockNotifications => '通知';

  @override
  String get blockNotifChoose => '选择您想了解的内容和渠道。';

  @override
  String get blockEmailNotifications => '电子邮件通知';

  @override
  String get blockPushNotifications => '推送通知';

  @override
  String get blockMentionsReplies => '提及和回复';

  @override
  String get blockDeliveredToDevices => '已发送到您的设备';

  @override
  String blockEmailChannel(Object? channel) => '电子邮件 · $channel';

  @override
  String blockPushChannel(Object? channel) => '推送 · $channel';

  @override
  String get blockQuietHours => '免打扰时间';

  @override
  String get blockWeeklyDigest => '每周摘要';

  @override
  String get blockWeeklyDigestBlurb => '每周一发送一封包含所有动态的电子邮件。';

  @override
  String get blockPreferencesSaved => '偏好设置已保存。';

  @override
  String get blockSavePreferences => '保存偏好设置';

  @override
  String get blockReset => '重置';

  @override
  String get blockWelcomeAboard => '欢迎加入';

  @override
  String get blockQuickTour => '开始使用应用前的快速导览。';

  @override
  String get blockStayInLoop => '随时了解动态';

  @override
  String get blockMessagesArriveMoment => '消息和更新会在发生时即时送达。';

  @override
  String get blockNeverMissThing => '不再错过任何事';

  @override
  String get blockNotifPermissionBlurb => '我们只发送重要内容：回复、提醒和安全警报。您稍后可以更改。';

  @override
  String get blockEnableNotifications => '启用通知？';

  @override
  String get blockAllowNotifications => '允许通知';

  @override
  String get blockAllowNotificationsBlurb => '允许通知以充分利用该应用。';

  @override
  String get blockNotNow => '暂不';

  @override
  String get blockSkip => '跳过';

  @override
  String get blockGetStarted => '开始使用';

  @override
  String get blockMessages => '消息';

  @override
  String get blockNoConversations => '暂无会话';

  @override
  String get blockPullRefreshChat => '下拉刷新或开始新的聊天。';

  @override
  String get blockMute => '静音';

  @override
  String get blockMuted => '已静音';

  @override
  String get blockAttach => '添加附件';

  @override
  String get blockAttachFile => '文件';

  @override
  String get blockAttachPhoto => '照片';

  @override
  String get blockWriteMessage => '写消息…';

  @override
  String get blockYourCart => '您的购物车';

  @override
  String get blockAddSomethingFirst => '先添加一件您喜欢的商品。';

  @override
  String get blockCartEmpty => '购物车是空的';

  @override
  String get blockCheckout => '结账';

  @override
  String blockQty(int quantity) => '数量 $quantity';

  @override
  String blockPayTotal(Object? amount) => '支付 $amount';

  @override
  String get blockPayment => '付款';

  @override
  String get blockCardNumber => '卡号';

  @override
  String get blockExpiry => '有效期';

  @override
  String get blockCvc => 'CVC';

  @override
  String get blockDeliveryAddress => '收货地址';

  @override
  String get blockStreet => '街道';

  @override
  String get blockCity => '城市';

  @override
  String get blockSaveAndContinue => '保存并继续';

  @override
  String get blockOrderPlaced => '订单已提交';

  @override
  String get blockOrderThanks => '感谢您的惠顾。确认信息正在发送中。';

  @override
  String get blockContinueShopping => '继续购物';

  @override
  String get blockSchedule => '日程';

  @override
  String get blockPickDateRangeReport => '为您的报告选择日期范围。';

  @override
  String get blockPickDateRange => '选择日期范围';

  @override
  String get blockTapAnotherDay => '点按另一天以扩展范围';

  @override
  String get blockBookMeeting => '预订会议';

  @override
  String get blockPickDayTime => '先选择日期，再选择合适的时间。';

  @override
  String get blockFourSlots => '还剩四个30分钟的名额。请选择一个。';

  @override
  String blockPickedSlot(Object? slot) => '已选择 $slot，30分钟。';

  @override
  String get blockOverview => '概览';

  @override
  String get blockRevenueOrdersBlurb => '收入、订阅和最新订单。';

  @override
  String get blockTotalRevenue => '总收入';

  @override
  String get blockSubscriptions => '订阅';

  @override
  String get blockSales => '销售额';

  @override
  String get blockRevenueByMonth => '按月收入';

  @override
  String get blockRecentSales => '最近销售';

  @override
  String get blockViewAll => '查看全部';

  @override
  String get blockTransactions => '交易';

  @override
  String get blockFilterTransactions => '筛选交易';

  @override
  String get blockCustomer => '客户';

  @override
  String get blockAmount => '金额';

  @override
  String get blockMethod => '方式';

  @override
  String get blockStatus => '状态';

  @override
  String get blockPaid => '已付款';

  @override
  String get blockPending => '待处理';

  @override
  String get blockRefunded => '已退款';

  @override
  String blockNoTransactions(Object? query) => '没有与“$query”匹配的交易。';

  @override
  String blockDeltaFromLastMonth(Object? delta) => '比上个月 $delta';

  @override
  String get blockAnalytics => '分析';

  @override
  String get blockSessionsDevicesBlurb => '会话、设备以及流量来源。';

  @override
  String get blockSearchReports => '搜索报告';

  @override
  String get blockLast30Days => '最近30天';

  @override
  String get blockAllDevices => '所有设备';

  @override
  String get blockSessions => '会话';

  @override
  String get blockUsers => '用户';

  @override
  String get blockAvgSession => '平均会话';

  @override
  String get blockBounceRate => '跳出率';

  @override
  String get blockConversions => '转化';

  @override
  String get blockByDevice => '按设备';

  @override
  String get blockDesktop => '桌面端';

  @override
  String get blockMobile => '移动端';

  @override
  String get blockTablet => '平板';

  @override
  String get blockDirect => '直接';

  @override
  String get blockReferral => '推荐';

  @override
  String get blockSocial => '社交';

  @override
  String get blockTrafficSources => '流量来源';

  @override
  String get blockVisitors => '访客';

  @override
  String get blockHome => '首页';

  @override
  String get blockInbox => '收件箱';

  @override
  String get blockCalendar => '日历';

  @override
  String get blockCompose => '写邮件';

  @override
  String get blockMarkAllRead => '全部标为已读';

  @override
  String get blockStarred => '已加星标';

  @override
  String get blockSnoozed => '已稍后提醒';

  @override
  String get blockUnread => '未读';

  @override
  String get blockDocuments => '文档';

  @override
  String get blockReports => '报告';

  @override
  String get blockDashboard => '仪表盘';

  @override
  String get blockStorage => '存储';

  @override
  String get blockNavigation => '导航';

  @override
  String get blockSharedWithYou => '与您共享';

  @override
  String get blockRecentProjects => '最近的项目';

  @override
  String get blockStorageUsed => '已用存储';

  @override
  String get blockOpen => '打开';

  @override
  String get blockLive => '直播';

  @override
  String get blockMembers => '成员';

  @override
  String get blockProjects => '项目';

  @override
  String get blockDeploys => '部署';

  @override
  String get blockActivity => '动态';

  @override
  String get blockRecentFiles => '最近的文件';

  @override
  String get blockUsageThisMonth => '本月用量';

  @override
  String get blockUpgradePlan => '升级方案';

  @override
  String blockNoMatches(Object? query) => '没有与“$query”匹配的结果。';

  @override
  String get blockWorkspaces => '工作区';

  @override
  String get blockPricing => '定价';

  @override
  String get blockPlansScale => '与您共同成长的方案';

  @override
  String get blockPlansBlurb => '免费开始，当您的团队壮大时再升级。每个方案都包含完整的组件库和主题预设。';

  @override
  String get blockPerUserMonth => '每用户 / 每月';

  @override
  String get blockSubscribe => '订阅';

  @override
  String get blockContactSales => '联系销售';

  @override
  String get blockPromoCode => '优惠码';

  @override
  String get blockApplyCode => '使用优惠码';

  @override
  String get blockHaveCodeEnter => '有优惠码？请在下方输入。';

  @override
  String get blockCodeAppliedDiscount => '优惠码已应用——您的折扣将在结账时显示。';

  @override
  String get blockFaqTitle => '常见问题';

  @override
  String get blockFaqChangePlans => '以后可以更换方案吗？';

  @override
  String get blockFaqChangePlansAnswer => '可以。升级立即生效，降级自下个周期起生效。';

  @override
  String get blockFaqFreeTrial => '有免费试用吗？';

  @override
  String get blockFaqFreeTrialAnswer => '每个方案都从14天开始，无需银行卡。';

  @override
  String get blockAccount => '帐户';

  @override
  String get blockGeneral => '通用';

  @override
  String get blockAppearance => '外观';

  @override
  String get blockDarkMode => '深色模式';

  @override
  String get blockPreferences => '偏好设置';

  @override
  String get blockSignOut => '退出登录';

  @override
  String get blockSignOutConfirm => '要退出登录吗？';

  @override
  String get blockSignOutBlurb => '您稍后随时可以重新登录。';

  @override
  String get blockSounds => '声音';

  @override
  String get blockWhatYouGet => '包含内容';

  @override
  String get blockAllComponentCategories => '所有组件类别';

  @override
  String get blockPrioritySupport => '优先支持';

  @override
  String get blockUnlimitedProjectsTrial => '试用期内项目数量不限';

  @override
  String get blockTrialDaysLeft => '试用还剩14天';

  @override
  String get blockStarterChat => '聊天';

  @override
  String get blockStarterShop => '商店';

  @override
  String get blockStarterCart => '购物车';

  @override
  String get blockAddToCart => '加入购物车';
}
