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

  @override
  String get blockDontHaveAccount => 'アカウントをお持ちでないですか?';

  @override
  String get blockAlreadyHaveAccount => 'すでにアカウントをお持ちですか?';

  @override
  String get blockNoAccountYet => 'まだアカウントがありませんか?';

  @override
  String get blockHaveAnAccount => 'アカウントをお持ちですか?';

  @override
  String get blockCreateOne => '作成する';

  @override
  String get blockCreateAccount => 'アカウントを作成';

  @override
  String get blockCreateYourAccount => 'アカウントを作成する';

  @override
  String get blockForgotYourPassword => 'パスワードをお忘れですか?';

  @override
  String get blockBackToSignIn => 'サインインに戻る';

  @override
  String get blockEnterCredentialsWorkspace => 'ワークスペースにアクセスするには資格情報を入力してください。';

  @override
  String get blockEnterCredentialsContinue => '続行するには資格情報を入力してください。';

  @override
  String get blockEnterDetailsContinue => '続行するには以下に詳細を入力してください。';

  @override
  String get blockEnterEmailCreateAccount => 'アカウントを作成するには以下にメールアドレスを入力してください。';

  @override
  String get blockSignedInWelcomeBack => 'サインインしました。おかえりなさい。';

  @override
  String get blockAccountCreatedVerify => 'アカウントを作成しました。確認のため受信トレイをご覧ください。';

  @override
  String get blockTrialStartedVerify => 'トライアルを開始しました。確認のため受信トレイをご覧ください。';

  @override
  String get blockPasswordsDoNotMatch => 'パスワードが一致しません。';

  @override
  String get blockCurrentPassword => '現在のパスワード';

  @override
  String get blockNewPassword => '新しいパスワード';

  @override
  String get blockConfirmNewPassword => '新しいパスワードを確認';

  @override
  String get blockUpdatePassword => 'パスワードを更新';

  @override
  String get blockPasswordUpdated => 'パスワードを更新しました。';

  @override
  String get blockPasswordHintChange => '8文字以上。変更すると他の場所からサインアウトします。';

  @override
  String get blockUsername => 'ユーザー名';

  @override
  String get blockUsernameHint => '小文字、数字、アンダースコア。';

  @override
  String get blockYourAvatar => 'あなたのアバター';

  @override
  String get blockUploadImage => '画像をアップロード';

  @override
  String get blockBio => '自己紹介';

  @override
  String get blockBioHint => 'あなたについて少し教えてください';

  @override
  String get blockBioCounterHint => '最大160文字。';

  @override
  String get blockProfileSaved => 'プロフィールを保存しました。';

  @override
  String get blockSaveChanges => '変更を保存';

  @override
  String get blockInviteMember => 'メンバーを招待';

  @override
  String get blockRoleAdmin => '管理者';

  @override
  String get blockRoleOwner => 'オーナー';

  @override
  String get blockRoleMember => 'メンバー';

  @override
  String get blockTeam => 'チーム';

  @override
  String get blockProfile => 'プロフィール';

  @override
  String get blockSignInWithEmail => 'メールでサインイン';

  @override
  String get blockSignUp => 'サインアップ';

  @override
  String get blockPickWayYouPrefer => 'お好みの方法を選んでください。';

  @override
  String blockContinueWith(Object? provider) => '$provider で続行';

  @override
  String get blockCreating => '作成中…';

  @override
  String get blockSigningIn => 'サインイン中…';

  @override
  String get blockSending => '送信中…';

  @override
  String get blockSaving => '保存中…';

  @override
  String get blockPaying => '支払い中…';

  @override
  String get blockSendResetLink => 'リセットリンクを送信';

  @override
  String get blockResetPassword => 'パスワードをリセット';

  @override
  String get blockResetLinkSent => 'リセットリンクを送信しました。続行するには受信トレイをご確認ください。';

  @override
  String get blockWeWillEmailReset => 'リセットリンクをメールでお送りします。';

  @override
  String get blockMustAcceptTerms => '続行するには利用規約に同意してください。';

  @override
  String get blockCheckInbox => '受信トレイを確認';

  @override
  String get blockEnterSixDigitCode => 'お送りした6桁のコードを入力してください。';

  @override
  String get blockCodeVerifiedSignedIn => 'コードを確認しました。サインインしています。';

  @override
  String get blockEmailVerifiedSet => 'メールを確認しました。準備完了です。';

  @override
  String get blockVerifyYourEmail => 'メールを確認する';

  @override
  String blockWeSentCodeTo(Object? email) => '$email に6桁のコードを送信しました。';

  @override
  String get blockDidntGetCode => 'コードが届きませんでしたか?';

  @override
  String get blockBack => '戻る';

  @override
  String get blockBackToCart => 'カートに戻る';

  @override
  String get blockBackToSettings => '設定に戻る';

  @override
  String get blockOneAccountEverything => 'すべてに1つのアカウント。';

  @override
  String get blockStartTrialNoCard => '14日間のトライアルを開始。クレジットカードは不要です。';

  @override
  String get blockNotifications => '通知';

  @override
  String get blockNotifChoose => '何についてどこで知りたいかを選択してください。';

  @override
  String get blockEmailNotifications => 'メール通知';

  @override
  String get blockPushNotifications => 'プッシュ通知';

  @override
  String get blockMentionsReplies => 'メンションと返信';

  @override
  String get blockDeliveredToDevices => 'お使いのデバイスに配信';

  @override
  String blockEmailChannel(Object? channel) => 'メール · $channel';

  @override
  String blockPushChannel(Object? channel) => 'プッシュ · $channel';

  @override
  String get blockQuietHours => 'クワイエットアワー';

  @override
  String get blockWeeklyDigest => '週間ダイジェスト';

  @override
  String get blockWeeklyDigestBlurb => '毎週月曜日に起きたことをまとめたメールを1通。';

  @override
  String get blockPreferencesSaved => '設定を保存しました。';

  @override
  String get blockSavePreferences => '設定を保存';

  @override
  String get blockReset => 'リセット';

  @override
  String get blockWelcomeAboard => 'ようこそ';

  @override
  String get blockQuickTour => 'アプリを使い始める前のクイックツアー。';

  @override
  String get blockStayInLoop => '最新情報をチェック';

  @override
  String get blockMessagesArriveMoment => 'メッセージと更新は発生した瞬間に届きます。';

  @override
  String get blockNeverMissThing => '見逃しなし';

  @override
  String get blockNotifPermissionBlurb =>
      '重要なものだけを送信します: 返信、リマインダー、セキュリティアラート。後で変更できます。';

  @override
  String get blockEnableNotifications => '通知を有効にしますか?';

  @override
  String get blockAllowNotifications => '通知を許可';

  @override
  String get blockAllowNotificationsBlurb => 'アプリを最大限に活用するには通知を許可してください。';

  @override
  String get blockNotNow => '後で';

  @override
  String get blockSkip => 'スキップ';

  @override
  String get blockGetStarted => 'はじめる';

  @override
  String get blockMessages => 'メッセージ';

  @override
  String get blockNoConversations => '会話がありません';

  @override
  String get blockPullRefreshChat => '引っ張って更新するか、新しいチャットを開始してください。';

  @override
  String get blockMute => 'ミュート';

  @override
  String get blockMuted => 'ミュート中';

  @override
  String get blockAttach => '添付';

  @override
  String get blockAttachFile => 'ファイル';

  @override
  String get blockAttachPhoto => '写真';

  @override
  String get blockWriteMessage => 'メッセージを書く…';

  @override
  String get blockYourCart => 'カート';

  @override
  String get blockAddSomethingFirst => 'まずお気に入りを1つ追加してください。';

  @override
  String get blockCartEmpty => 'カートは空です';

  @override
  String get blockCheckout => 'チェックアウト';

  @override
  String blockQty(int quantity) => '数量 $quantity';

  @override
  String blockPayTotal(Object? amount) => '$amount を支払う';

  @override
  String get blockPayment => 'お支払い';

  @override
  String get blockCardNumber => 'カード番号';

  @override
  String get blockExpiry => '有効期限';

  @override
  String get blockCvc => 'CVC';

  @override
  String get blockDeliveryAddress => '配送先住所';

  @override
  String get blockStreet => '番地';

  @override
  String get blockCity => '市区町村';

  @override
  String get blockSaveAndContinue => '保存して続行';

  @override
  String get blockOrderPlaced => '注文が確定しました';

  @override
  String get blockOrderThanks => 'お買い上げありがとうございます。確認メールをお送りします。';

  @override
  String get blockContinueShopping => '買い物を続ける';

  @override
  String get blockSchedule => 'スケジュール';

  @override
  String get blockPickDateRangeReport => 'レポートの期間を選択してください。';

  @override
  String get blockPickDateRange => '期間を選択';

  @override
  String get blockTapAnotherDay => '別の日をタップして期間を延長';

  @override
  String get blockBookMeeting => '会議を予約';

  @override
  String get blockPickDayTime => '日を選んでから都合のよい時間を選んでください。';

  @override
  String get blockFourSlots => '30分枠があと4つあります。1つ選択してください。';

  @override
  String blockPickedSlot(Object? slot) => '$slot を選択、30分。';

  @override
  String get blockOverview => '概要';

  @override
  String get blockRevenueOrdersBlurb => '収益、サブスクリプション、最新の注文。';

  @override
  String get blockTotalRevenue => '総収益';

  @override
  String get blockSubscriptions => 'サブスクリプション';

  @override
  String get blockSales => '売上';

  @override
  String get blockRevenueByMonth => '月別収益';

  @override
  String get blockRecentSales => '最近の売上';

  @override
  String get blockViewAll => 'すべて見る';

  @override
  String get blockTransactions => '取引';

  @override
  String get blockFilterTransactions => '取引を絞り込む';

  @override
  String get blockCustomer => '顧客';

  @override
  String get blockAmount => '金額';

  @override
  String get blockMethod => '方法';

  @override
  String get blockStatus => 'ステータス';

  @override
  String get blockPaid => '支払い済み';

  @override
  String get blockPending => '保留中';

  @override
  String get blockRefunded => '返金済み';

  @override
  String blockNoTransactions(Object? query) => '“$query”に一致する取引がありません。';

  @override
  String blockDeltaFromLastMonth(Object? delta) => '先月比 $delta';

  @override
  String get blockAnalytics => 'アナリティクス';

  @override
  String get blockSessionsDevicesBlurb => 'セッション、デバイス、トラフィックの流入元。';

  @override
  String get blockSearchReports => 'レポートを検索';

  @override
  String get blockLast30Days => '過去30日間';

  @override
  String get blockAllDevices => 'すべてのデバイス';

  @override
  String get blockSessions => 'セッション';

  @override
  String get blockUsers => 'ユーザー';

  @override
  String get blockAvgSession => '平均セッション';

  @override
  String get blockBounceRate => '直帰率';

  @override
  String get blockConversions => 'コンバージョン';

  @override
  String get blockByDevice => 'デバイス別';

  @override
  String get blockDesktop => 'デスクトップ';

  @override
  String get blockMobile => 'モバイル';

  @override
  String get blockTablet => 'タブレット';

  @override
  String get blockDirect => '直接';

  @override
  String get blockReferral => 'リファラル';

  @override
  String get blockSocial => 'ソーシャル';

  @override
  String get blockTrafficSources => 'トラフィックソース';

  @override
  String get blockVisitors => '訪問者';

  @override
  String get blockHome => 'ホーム';

  @override
  String get blockInbox => '受信トレイ';

  @override
  String get blockCalendar => 'カレンダー';

  @override
  String get blockCompose => '作成';

  @override
  String get blockMarkAllRead => 'すべて既読にする';

  @override
  String get blockStarred => 'スター付き';

  @override
  String get blockSnoozed => 'スヌーズ中';

  @override
  String get blockUnread => '未読';

  @override
  String get blockDocuments => 'ドキュメント';

  @override
  String get blockReports => 'レポート';

  @override
  String get blockDashboard => 'ダッシュボード';

  @override
  String get blockStorage => 'ストレージ';

  @override
  String get blockNavigation => 'ナビゲーション';

  @override
  String get blockSharedWithYou => 'あなたと共有';

  @override
  String get blockRecentProjects => '最近のプロジェクト';

  @override
  String get blockStorageUsed => '使用中のストレージ';

  @override
  String get blockOpen => '開く';

  @override
  String get blockLive => 'ライブ';

  @override
  String get blockMembers => 'メンバー';

  @override
  String get blockProjects => 'プロジェクト';

  @override
  String get blockDeploys => 'デプロイ';

  @override
  String get blockActivity => 'アクティビティ';

  @override
  String get blockRecentFiles => '最近のファイル';

  @override
  String get blockUsageThisMonth => '今月の使用量';

  @override
  String get blockUpgradePlan => 'プランをアップグレード';

  @override
  String blockNoMatches(Object? query) => '“$query”に一致する結果がありません。';

  @override
  String get blockWorkspaces => 'ワークスペース';

  @override
  String get blockPricing => '料金';

  @override
  String get blockPlansScale => 'あなたとともに成長するプラン';

  @override
  String get blockPlansBlurb =>
      '無料で開始し、チームの成長に合わせてアップグレード。すべてのプランに完全なコンポーネントライブラリとテーマプリセットが含まれます。';

  @override
  String get blockPerUserMonth => 'ユーザーあたり / 月';

  @override
  String get blockSubscribe => '申し込む';

  @override
  String get blockContactSales => '営業に問い合わせる';

  @override
  String get blockPromoCode => 'プロモコード';

  @override
  String get blockApplyCode => 'コードを適用';

  @override
  String get blockHaveCodeEnter => 'コードをお持ちですか? 以下に入力してください。';

  @override
  String get blockCodeAppliedDiscount => 'コードを適用しました。割引はチェックアウト時に表示されます。';

  @override
  String get blockFaqTitle => 'よくある質問';

  @override
  String get blockFaqChangePlans => '後でプランを変更できますか?';

  @override
  String get blockFaqChangePlansAnswer => 'はい。アップグレードは即時適用、ダウングレードは次回サイクルからです。';

  @override
  String get blockFaqFreeTrial => '無料トライアルはありますか?';

  @override
  String get blockFaqFreeTrialAnswer => 'すべてのプランは14日間から開始、カードは不要です。';

  @override
  String get blockAccount => 'アカウント';

  @override
  String get blockGeneral => '一般';

  @override
  String get blockAppearance => '外観';

  @override
  String get blockDarkMode => 'ダークモード';

  @override
  String get blockPreferences => '設定';

  @override
  String get blockSignOut => 'サインアウト';

  @override
  String get blockSignOutConfirm => 'サインアウトしますか?';

  @override
  String get blockSignOutBlurb => '後でいつでも再びサインインできます。';

  @override
  String get blockSounds => 'サウンド';

  @override
  String get blockWhatYouGet => '内容';

  @override
  String get blockAllComponentCategories => 'すべてのコンポーネントカテゴリ';

  @override
  String get blockPrioritySupport => '優先サポート';

  @override
  String get blockUnlimitedProjectsTrial => 'トライアル中は無制限のプロジェクト';

  @override
  String get blockTrialDaysLeft => 'トライアル残り14日';

  @override
  String get blockStarterChat => 'チャット';

  @override
  String get blockStarterShop => 'ショップ';

  @override
  String get blockStarterCart => 'カート';

  @override
  String get blockAddToCart => 'カートに追加';
}
