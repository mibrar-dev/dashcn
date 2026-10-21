import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

/// Japanese (`ja`) locale data.
///
/// Translations only: anything this table does not override falls
/// through to the English default on [ComponentLocalizations]. Text
/// direction is not handled here - Flutter resolves it from
/// [WidgetsLocalizations] and [Directionality].
class ComponentLocalizationsJa extends ComponentLocalizations {
  /// Creates the Japanese strings.
  const ComponentLocalizationsJa([super.locale = const Locale('ja')]);

  /// Formats [value] as a number in this locale, or returns it
  /// verbatim when it is not a number.
  String _number(Object? value) {
    if (value is! num) return '$value';
    return intl.NumberFormat.decimalPattern(localeName).format(value);
  }

  @override
  String get formNotEmpty => 'この項目は必須です';

  @override
  String get invalidValue => '無効な値です';

  @override
  String get invalidEmail => '無効なメールアドレスです';

  @override
  String get invalidURL => '無効なURLです';

  @override
  String formLessThan(Object? value) => '${_number(value)} 未満である必要があります';

  @override
  String formGreaterThan(Object? value) => '${_number(value)} より大きい必要があります';

  @override
  String formLessThanOrEqualTo(Object? value) =>
      '${_number(value)} 以下である必要があります';

  @override
  String get formPhoneNumberInvalid => '電話番号が無効です';

  @override
  String get formPhoneNumberEmpty => '電話番号は必須です';

  @override
  String formGreaterThanOrEqualTo(Object? value) =>
      '${_number(value)} 以上である必要があります';

  @override
  String formBetweenInclusively(Object? min, Object? max) =>
      '${_number(min)} 以上 ${_number(max)} 以下である必要があります';

  @override
  String formEqualTo(Object? value) => '${_number(value)} と等しい必要があります';

  @override
  String formBetweenExclusively(Object? min, Object? max) =>
      '${_number(min)} より大きく ${_number(max)} 未満である必要があります';

  @override
  String formLengthLessThan(int limit) => '$limit 文字以上で入力してください';

  @override
  String formLengthGreaterThan(int limit) => '$limit 文字以内で入力してください';

  @override
  String get formPasswordDigits => '数字を1文字以上含めてください';

  @override
  String get formPasswordLowercase => '小文字を1文字以上含めてください';

  @override
  String get formPasswordUppercase => '大文字を1文字以上含めてください';

  @override
  String get formPasswordSpecial => '記号を1文字以上含めてください';

  @override
  String get commandSearch => 'コマンドを入力または検索...';

  @override
  String get commandEmpty => '結果が見つかりません。';

  @override
  String get datePickerSelectYear => '年を選択';

  @override
  String get abbreviatedMonday => '月';

  @override
  String get abbreviatedTuesday => '火';

  @override
  String get abbreviatedWednesday => '水';

  @override
  String get abbreviatedThursday => '木';

  @override
  String get abbreviatedFriday => '金';

  @override
  String get abbreviatedSaturday => '土';

  @override
  String get abbreviatedSunday => '日';

  @override
  String get monthJanuary => '1月';

  @override
  String get monthFebruary => '2月';

  @override
  String get monthMarch => '3月';

  @override
  String get monthApril => '4月';

  @override
  String get monthMay => '5月';

  @override
  String get monthJune => '6月';

  @override
  String get monthJuly => '7月';

  @override
  String get monthAugust => '8月';

  @override
  String get monthSeptember => '9月';

  @override
  String get monthOctober => '10月';

  @override
  String get monthNovember => '11月';

  @override
  String get monthDecember => '12月';

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
  String get dialogDismiss => '閉じる';

  @override
  String get chipInputRemoveChip => '削除';

  @override
  String get buttonCancel => 'キャンセル';

  @override
  String get buttonSave => '保存';

  @override
  String get timeHour => '時';

  @override
  String get timeMinute => '分';

  @override
  String get timeSecond => '秒';

  @override
  String get timeAM => '午前';

  @override
  String get timePM => '午後';

  @override
  String get colorRed => '赤';

  @override
  String get colorGreen => '緑';

  @override
  String get colorBlue => '青';

  @override
  String get colorAlpha => 'アルファ';

  @override
  String get colorHue => '色相';

  @override
  String get colorSaturation => '彩度';

  @override
  String get colorValue => '明度';

  @override
  String get colorLightness => '輝度';

  @override
  String get menuCut => '切り取り';

  @override
  String get menuCopy => 'コピー';

  @override
  String get menuPaste => '貼り付け';

  @override
  String get menuSelectAll => 'すべて選択';

  @override
  String get menuUndo => '元に戻す';

  @override
  String get menuRedo => 'やり直し';

  @override
  String get menuDelete => '削除';

  @override
  String get menuShare => '共有';

  @override
  String get menuSearchWeb => 'ウェブで検索';

  @override
  String get menuLiveTextInput => 'ライブテキスト';

  @override
  String get placeholderDatePicker => '日付を選択';

  @override
  String get placeholderTimePicker => '時刻を選択';

  @override
  String get placeholderColorPicker => '色を選択';

  @override
  String get buttonPrevious => '前へ';

  @override
  String get buttonNext => '次へ';

  @override
  String get refreshTriggerPull => '引っ張って更新';

  @override
  String get refreshTriggerRelease => '離して更新';

  @override
  String get refreshTriggerRefreshing => '更新中...';

  @override
  String get refreshTriggerComplete => '更新が完了しました';

  @override
  String get colorPickerTabRGB => 'RGB';

  @override
  String get colorPickerTabHSV => 'HSV';

  @override
  String get colorPickerTabHSL => 'HSL';

  @override
  String get colorPickerTabHEX => 'HEX';

  @override
  String get commandMoveUp => '上へ移動';

  @override
  String get commandMoveDown => '下へ移動';

  @override
  String get commandActivate => '選択';

  @override
  String get timeDaysAbbreviation => '日';

  @override
  String get timeHoursAbbreviation => '時';

  @override
  String get timeMinutesAbbreviation => '分';

  @override
  String get timeSecondsAbbreviation => '秒';

  @override
  String get placeholderDurationPicker => '期間を選択';

  @override
  String get durationDay => '日';

  @override
  String get durationHour => '時間';

  @override
  String get durationMinute => '分';

  @override
  String get durationSecond => '秒';

  @override
  String get dropzoneIdle => 'ファイルをアップロードするには参照';

  @override
  String get dropzoneDragging => 'ファイルをドロップしてアップロード';

  @override
  String get dropzoneUploading => 'ファイルをアップロードしています...';

  @override
  String get dropzoneSuccess => 'ファイルの準備ができました';

  @override
  String get dropzoneError => '続行するにはエラーを修正してください';

  @override
  String get dropzoneDisabled => 'ファイルのアップロードは無効です';

  @override
  String get dropzoneBrowse => 'ファイルを参照';

  @override
  String get emptyStateEmptyTitle => 'まだ何もありません';

  @override
  String get emptyStateEmptyDescription => '開始するには最初のアイテムを作成してください。';

  @override
  String get emptyStateNoResultsTitle => '結果が見つかりませんでした';

  @override
  String get emptyStateNoResultsDescription => 'フィルターや検索語を調整してみてください。';

  @override
  String get emptyStateErrorTitle => '問題が発生しました';

  @override
  String get emptyStateErrorDescription =>
      'このデータを読み込めませんでした。しばらくしてからもう一度お試しください。';

  @override
  String get filterSearch => '検索';

  @override
  String get filterSort => '並べ替え';

  @override
  String get filterDateRange => '日付範囲';

  @override
  String get filterClearAll => 'すべてクリア';

  @override
  String get filterFilters => 'フィルター';

  @override
  String filterActiveCount(int count) => '有効なフィルター ${_number(count)} 件';

  @override
  String filterResultsCount(int count) => '${_number(count)} 件の結果';

  @override
  String get fileUploadChoose => 'ファイルを選択';

  @override
  String get fileUploadNoFile => 'ファイルが選択されていません';

  @override
  String get fileUploadPickFailed => 'ファイルの選択に失敗しました。';

  @override
  String get fileUploadTooMany => '選択されたファイルが多すぎます。';

  @override
  String get fileUploadTooLarge => 'ファイルが大きすぎます。';

  @override
  String get fileUploadInvalidType => 'このファイル形式は許可されていません。';

  @override
  String get fileUploadUploadFailed => 'アップロードに失敗しました。';

  @override
  String fileUploadUploadFailedFor(String name) => '$name のアップロードに失敗しました。';

  @override
  String get fileUploadStatusQueued => '待機中';

  @override
  String get fileUploadStatusUploading => 'アップロード中';

  @override
  String get fileUploadStatusCompleted => '完了';

  @override
  String get fileUploadStatusFailed => '失敗';

  @override
  String get fileUploadUnknownType => 'ファイル';

  @override
  String get fileUploadRemove => 'ファイルを削除';

  @override
  String get fileUploadRetry => 'アップロードを再試行';

  @override
  String get fileUploadPreview => 'ファイルをプレビュー';

  @override
  String get fileUploadDownload => 'ファイルをダウンロード';

  @override
  String get errorSomethingWentWrong => '問題が発生しました';

  @override
  String get errorUnexpectedMessage =>
      'もう一度お試しいただくか、問題が解決しない場合はサポートにお問い合わせください。';

  @override
  String get errorActionRetry => '再試行';

  @override
  String get errorActionReport => '報告';

  @override
  String get errorActionBack => '戻る';

  @override
  String get errorActionLogin => 'ログイン';

  @override
  String get errorActionSettings => '設定';

  @override
  String get errorActionContactSupport => 'サポートに問い合わせる';

  @override
  String get errorBadRequest => '無効なリクエスト';

  @override
  String get errorBadRequestMessage => 'リクエストが無効でした。確認してからもう一度お試しください。';

  @override
  String get errorUnauthorized => '認証されていません';

  @override
  String get errorLoginRequiredMessage => '続行するにはログインしてください。';

  @override
  String get errorAccessDenied => 'アクセスが拒否されました';

  @override
  String get errorAccessDeniedMessage => 'この操作を行う権限がありません。';

  @override
  String get errorNotFound => '見つかりませんでした';

  @override
  String get errorNotFoundMessage => 'お探しのものが見つかりませんでした。';

  @override
  String get errorConflict => '競合';

  @override
  String get errorConflictMessage => 'この操作は既存のデータと競合しています。';

  @override
  String get errorInvalidData => '無効なデータ';

  @override
  String get errorInvalidDataMessage => '一部のフィールドを確認してください。';

  @override
  String get errorTooManyRequests => 'リクエストが多すぎます';

  @override
  String get errorTooManyRequestsMessage => 'しばらく待ってからもう一度お試しください。';

  @override
  String get errorServerError => 'サーバーエラー';

  @override
  String get errorServerErrorMessage => 'サーバーで問題が発生しました。もう一度お試しください。';

  @override
  String get errorRequestTimedOut => 'リクエストがタイムアウトしました';

  @override
  String get errorRequestTimedOutMessage => 'サーバーの応答に時間がかかりすぎています。';

  @override
  String get errorAuthenticationRequired => '認証が必要です';

  @override
  String get errorInvalidInput => '無効な入力';

  @override
  String get errorReviewFieldsMessage => '強調表示されたフィールドを確認してください。';

  @override
  String get errorPlatformError => 'プラットフォームエラー';

  @override
  String get errorDeviceErrorMessage => 'このデバイスで問題が発生しました。';

  @override
  String get errorConnectionFailed => '接続に失敗しました';

  @override
  String get errorConnectionFailedMessage => 'インターネット接続を確認してからもう一度お試しください。';

  @override
  String get errorSecureConnectionFailed => 'セキュリティで保護された接続に失敗しました';

  @override
  String get errorSecureConnectionMessage => 'セキュリティで保護された接続を確立できませんでした。';

  @override
  String get tableResizeColumn => '列のサイズを変更';

  @override
  String get tableResizeRow => '行のサイズを変更';

  @override
  String get resizableHandle => 'サイズ変更ハンドル';

  @override
  String get spellCheckNoSuggestions => '候補がありません';

  @override
  String get announcementLoading => '読み込み中';

  @override
  String get announcementSuccess => '成功';

  @override
  String get announcementFailure => '失敗';

  @override
  String get toolbarMore => 'その他';

  @override
  String get toolbarMoreActions => 'その他の操作';

  @override
  String get treeCollapse => '折りたたむ';

  @override
  String get treeExpand => '展開する';

  @override
  String get markdownDetails => '詳細';

  @override
  String get carouselLabel => 'おすすめカルーセル';

  @override
  String get carouselPrimaryAction => 'チャットに追加';

  @override
  String carouselItemPreview(Object? title) =>
      'おすすめプレビュー: ${title ?? mediaUntitled}';

  @override
  String carouselPageOf(int position, int length) =>
      '${_number(length)} ページ中 ${_number(position)} ページ目';

  @override
  String stepperStep(int index) => 'ステップ ${_number(index + 1)}';

  @override
  String paginationPage(Object? page) => 'ページ ${_number(page)}';

  @override
  String chartSeriesDefault(int index) => 'シリーズ ${_number(index + 1)}';

  @override
  String chartSliceDefault(int index) => '区分 ${_number(index)}';

  @override
  String chartCategoryDefault(int index) => 'カテゴリ ${_number(index)}';

  @override
  String get chartValueDefault => '値';

  @override
  String get chartKindLine => '折れ線';

  @override
  String get chartKindArea => 'エリア';

  @override
  String get chartKindBar => '棒';

  @override
  String get chartKindDonut => 'ドーナツ';

  @override
  String get chartKindPie => '円';

  @override
  String get chartKindSparkline => 'スパークライン';

  @override
  String get chartKindScatter => '散布図';

  @override
  String get chartKindRadar => 'レーダー';

  @override
  String get chartKindRadial => '放射';

  @override
  String chartSummaryEmpty(Object? kind) => 'データのない $kind グラフ';

  @override
  String chartSummary(int series, int points, Object? kind) =>
      '$kind グラフ: シリーズ ${_number(series)} 件、ポイント ${_number(points)} 件';

  @override
  String get colorFieldHsv => 'HSV カラーフィールド';

  @override
  String get colorFieldHsl => 'HSL カラーフィールド';

  @override
  String get actionClear => 'クリア';

  @override
  String get actionApply => '適用';

  @override
  String get actionVerify => '確認';

  @override
  String get actionResend => '再送信';

  @override
  String resendInSeconds(int seconds) => '${_number(seconds)} 秒後に再送信';

  @override
  String get authCode => 'コード';

  @override
  String get authEmail => 'メールアドレス';

  @override
  String get authPassword => 'パスワード';

  @override
  String get authName => '名前';

  @override
  String get authSignIn => 'ログイン';

  @override
  String get authForgotPassword => 'パスワードをお忘れですか?';

  @override
  String get authRememberMe => 'ログイン状態を保持する';

  @override
  String get authCreateAccount => 'アカウントを作成';

  @override
  String get actionClose => '閉じる';

  @override
  String get mediaPlay => '再生';

  @override
  String get mediaPause => '一時停止';

  @override
  String get mediaMute => 'ミュート';

  @override
  String get mediaUnmute => 'ミュート解除';

  @override
  String get mediaVolume => '音量';

  @override
  String get mediaSeek => 'シーク';

  @override
  String get mediaDownload => 'ダウンロード';

  @override
  String get mediaAudioPlayer => 'オーディオプレーヤー';

  @override
  String get mediaVideoPlayer => 'ビデオプレーヤー';

  @override
  String get mediaUntitled => '無題';

  @override
  String get mediaPlaybackFailed => '再生に失敗しました';

  @override
  String get mediaPreviousTrack => '前のトラック';

  @override
  String get mediaNextTrack => '次のトラック';

  @override
  String get mediaShuffleDisable => 'シャッフルをオフにする';

  @override
  String get mediaShuffleEnable => 'シャッフルをオンにする';

  @override
  String get mediaRepeatDisable => 'リピートをオフにする';

  @override
  String get mediaRepeatEnable => 'リピートをオンにする';

  @override
  String mediaPlaybackSpeed(Object? speed) => '再生速度 ${speed}x (タップして変更)';

  @override
  String mediaPositionOf(Object position, Object duration) =>
      '$position / $duration';

  @override
  String mediaHours(int count) => '${_number(count)} 時間';

  @override
  String mediaMinutes(int count) => '${_number(count)} 分';

  @override
  String mediaSeconds(int count) => '${_number(count)} 秒';

  @override
  String get signaturePadLabel => '署名欄';

  @override
  String get qrCodeLabel => 'QR コード';

  @override
  String get marqueeContent => 'スクロールコンテンツ';

  @override
  String mediaSkipBack(int seconds) => '${_number(seconds)} 秒戻る';

  @override
  String mediaSkipForward(int seconds) => '${_number(seconds)} 秒進む';

  @override
  String get mediaCaptionsShow => '字幕を表示';

  @override
  String get mediaCaptionsHide => '字幕を非表示';

  @override
  String get mediaCaptionsOn => '字幕オン';

  @override
  String get mediaCaptionsOff => '字幕オフ';

  @override
  String get mediaFullscreen => '全画面';

  @override
  String mediaMoreOptionsSpeed(Object? speed) => 'その他のオプション、再生速度 ${speed}x';

  @override
  String mediaSpeed(Object? speed) => '速度 ${speed}x';

  @override
  String get actionStartTrial => '無料トライアルを開始';

  @override
  String get authFirstName => '名';

  @override
  String get authLastName => '姓';

  @override
  String get authPasswordHint => '8文字以上。';

  @override
  String get authUseDifferentEmail => '別のメールアドレスを使用';

  @override
  String get authWorkEmail => '仕事用メールアドレス';

  @override
  String get chartTotalLabel => '合計';

  @override
  String get mediaQualityAuto => '画質 自動';
}
