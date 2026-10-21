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
}
