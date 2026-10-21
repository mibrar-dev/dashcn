import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

/// Turkish (`tr`) locale data.
///
/// Translations only: anything this table does not override falls
/// through to the English default on [ComponentLocalizations]. Text
/// direction is not handled here - Flutter resolves it from
/// [WidgetsLocalizations] and [Directionality].
class ComponentLocalizationsTr extends ComponentLocalizations {
  /// Creates the Turkish strings.
  const ComponentLocalizationsTr([super.locale = const Locale('tr')]);

  /// Formats [value] as a number in this locale, or returns it
  /// verbatim when it is not a number.
  String _number(Object? value) {
    if (value is! num) return '$value';
    return intl.NumberFormat.decimalPattern(localeName).format(value);
  }

  @override
  String get formNotEmpty => 'Bu alan boş bırakılamaz';

  @override
  String get invalidValue => 'Geçersiz değer';

  @override
  String get invalidEmail => 'Geçersiz e-posta adresi';

  @override
  String get invalidURL => 'Geçersiz URL';

  @override
  String formLessThan(Object? value) =>
      '${_number(value)} değerinden küçük olmalıdır';

  @override
  String formGreaterThan(Object? value) =>
      '${_number(value)} değerinden büyük olmalıdır';

  @override
  String formLessThanOrEqualTo(Object? value) =>
      '${_number(value)} değerinden küçük veya ona eşit olmalıdır';

  @override
  String get formPhoneNumberInvalid => 'Telefon numarası geçersiz';

  @override
  String get formPhoneNumberEmpty => 'Telefon numarası gereklidir';

  @override
  String formGreaterThanOrEqualTo(Object? value) =>
      '${_number(value)} değerinden büyük veya ona eşit olmalıdır';

  @override
  String formBetweenInclusively(Object? min, Object? max) =>
      '${_number(min)} ile ${_number(max)} arasında olmalıdır (uçlar dahil)';

  @override
  String formEqualTo(Object? value) =>
      '${_number(value)} değerine eşit olmalıdır';

  @override
  String formBetweenExclusively(Object? min, Object? max) =>
      '${_number(min)} ile ${_number(max)} arasında olmalıdır (uçlar hariç)';

  @override
  String formLengthLessThan(int limit) => 'En az $limit karakter olmalıdır';

  @override
  String formLengthGreaterThan(int limit) =>
      'En fazla $limit karakter olmalıdır';

  @override
  String get formPasswordDigits => 'En az bir rakam içermelidir';

  @override
  String get formPasswordLowercase => 'En az bir küçük harf içermelidir';

  @override
  String get formPasswordUppercase => 'En az bir büyük harf içermelidir';

  @override
  String get formPasswordSpecial => 'En az bir özel karakter içermelidir';

  @override
  String get commandSearch => 'Bir komut yazın veya arayın...';

  @override
  String get commandEmpty => 'Sonuç bulunamadı.';

  @override
  String get datePickerSelectYear => 'Bir yıl seçin';

  @override
  String get abbreviatedMonday => 'Pzt';

  @override
  String get abbreviatedTuesday => 'Sal';

  @override
  String get abbreviatedWednesday => 'Çar';

  @override
  String get abbreviatedThursday => 'Per';

  @override
  String get abbreviatedFriday => 'Cum';

  @override
  String get abbreviatedSaturday => 'Cmt';

  @override
  String get abbreviatedSunday => 'Paz';

  @override
  String get monthJanuary => 'Ocak';

  @override
  String get monthFebruary => 'Şubat';

  @override
  String get monthMarch => 'Mart';

  @override
  String get monthApril => 'Nisan';

  @override
  String get monthMay => 'Mayıs';

  @override
  String get monthJune => 'Haziran';

  @override
  String get monthJuly => 'Temmuz';

  @override
  String get monthAugust => 'Ağustos';

  @override
  String get monthSeptember => 'Eylül';

  @override
  String get monthOctober => 'Ekim';

  @override
  String get monthNovember => 'Kasım';

  @override
  String get monthDecember => 'Aralık';

  @override
  String get abbreviatedJanuary => 'Oca';

  @override
  String get abbreviatedFebruary => 'Şub';

  @override
  String get abbreviatedMarch => 'Mar';

  @override
  String get abbreviatedApril => 'Nis';

  @override
  String get abbreviatedMay => 'May';

  @override
  String get abbreviatedJune => 'Haz';

  @override
  String get abbreviatedJuly => 'Tem';

  @override
  String get abbreviatedAugust => 'Ağu';

  @override
  String get abbreviatedSeptember => 'Eyl';

  @override
  String get abbreviatedOctober => 'Eki';

  @override
  String get abbreviatedNovember => 'Kas';

  @override
  String get abbreviatedDecember => 'Ara';

  @override
  String get dialogDismiss => 'Kapat';

  @override
  String get chipInputRemoveChip => 'Sil';

  @override
  String get buttonCancel => 'İptal';

  @override
  String get buttonSave => 'Kaydet';

  @override
  String get timeHour => 'Saat';

  @override
  String get timeMinute => 'Dakika';

  @override
  String get timeSecond => 'Saniye';

  @override
  String get timeAM => 'ÖÖ';

  @override
  String get timePM => 'ÖS';

  @override
  String get colorRed => 'Kırmızı';

  @override
  String get colorGreen => 'Yeşil';

  @override
  String get colorBlue => 'Mavi';

  @override
  String get colorAlpha => 'Alfa';

  @override
  String get colorHue => 'Ton';

  @override
  String get colorSaturation => 'Doy';

  @override
  String get colorValue => 'Değ';

  @override
  String get colorLightness => 'Aç';

  @override
  String get menuCut => 'Kes';

  @override
  String get menuCopy => 'Kopyala';

  @override
  String get menuPaste => 'Yapıştır';

  @override
  String get menuSelectAll => 'Tümünü Seç';

  @override
  String get menuUndo => 'Geri Al';

  @override
  String get menuRedo => 'Yinele';

  @override
  String get menuDelete => 'Sil';

  @override
  String get menuShare => 'Paylaş';

  @override
  String get menuSearchWeb => 'Web\'de Ara';

  @override
  String get menuLiveTextInput => 'Canlı Metin';

  @override
  String get placeholderDatePicker => 'Bir tarih seçin';

  @override
  String get placeholderTimePicker => 'Bir saat seçin';

  @override
  String get placeholderColorPicker => 'Bir renk seçin';

  @override
  String get buttonPrevious => 'Önceki';

  @override
  String get buttonNext => 'Sonraki';

  @override
  String get refreshTriggerPull => 'Yenilemek için çekin';

  @override
  String get refreshTriggerRelease => 'Yenilemek için bırakın';

  @override
  String get refreshTriggerRefreshing => 'Yenileniyor...';

  @override
  String get refreshTriggerComplete => 'Yenileme tamamlandı';

  @override
  String get colorPickerTabRGB => 'RGB';

  @override
  String get colorPickerTabHSV => 'HSV';

  @override
  String get colorPickerTabHSL => 'HSL';

  @override
  String get colorPickerTabHEX => 'HEX';

  @override
  String get commandMoveUp => 'Yukarı Taşı';

  @override
  String get commandMoveDown => 'Aşağı Taşı';

  @override
  String get commandActivate => 'Seç';

  @override
  String get timeDaysAbbreviation => 'GG';

  @override
  String get timeHoursAbbreviation => 'SS';

  @override
  String get timeMinutesAbbreviation => 'DD';

  @override
  String get timeSecondsAbbreviation => 'SN';

  @override
  String get placeholderDurationPicker => 'Bir süre seçin';

  @override
  String get durationDay => 'Gün';

  @override
  String get durationHour => 'Saat';

  @override
  String get durationMinute => 'Dakika';

  @override
  String get durationSecond => 'Saniye';

  @override
  String get dropzoneIdle => 'Dosya yüklemek için göz atın';

  @override
  String get dropzoneDragging => 'Yüklemek için dosyaları bırakın';

  @override
  String get dropzoneUploading => 'Dosyalar yükleniyor...';

  @override
  String get dropzoneSuccess => 'Dosyalar hazır';

  @override
  String get dropzoneError => 'Devam etmek için hataları düzeltin';

  @override
  String get dropzoneDisabled => 'Dosya yükleme devre dışı';

  @override
  String get dropzoneBrowse => 'Dosyalara göz at';

  @override
  String get emptyStateEmptyTitle => 'Burada henüz bir şey yok';

  @override
  String get emptyStateEmptyDescription =>
      'Başlamak için ilk öğenizi oluşturun.';

  @override
  String get emptyStateNoResultsTitle => 'Sonuç bulunamadı';

  @override
  String get emptyStateNoResultsDescription =>
      'Filtrelerinizi veya arama terimlerinizi değiştirmeyi deneyin.';

  @override
  String get emptyStateErrorTitle => 'Bir şeyler ters gitti';

  @override
  String get emptyStateErrorDescription =>
      'Bu veriler yüklenemedi. Bir süre sonra tekrar deneyin.';

  @override
  String get filterSearch => 'Ara';

  @override
  String get filterSort => 'Sırala';

  @override
  String get filterDateRange => 'Tarih aralığı';

  @override
  String get filterClearAll => 'Tümünü temizle';

  @override
  String get filterFilters => 'Filtreler';

  @override
  String filterActiveCount(int count) => '${_number(count)} etkin filtre';

  @override
  String filterResultsCount(int count) => '${_number(count)} sonuç';

  @override
  String get fileUploadChoose => 'Dosya seç';

  @override
  String get fileUploadNoFile => 'Dosya seçilmedi';

  @override
  String get fileUploadPickFailed => 'Dosya seçimi başarısız oldu.';

  @override
  String get fileUploadTooMany => 'Çok fazla dosya seçildi.';

  @override
  String get fileUploadTooLarge => 'Dosya çok büyük.';

  @override
  String get fileUploadInvalidType => 'Dosya türüne izin verilmiyor.';

  @override
  String get fileUploadUploadFailed => 'Yükleme başarısız oldu.';

  @override
  String fileUploadUploadFailedFor(String name) => '$name yüklenemedi.';

  @override
  String get fileUploadStatusQueued => 'Sırada';

  @override
  String get fileUploadStatusUploading => 'Yükleniyor';

  @override
  String get fileUploadStatusCompleted => 'Tamamlandı';

  @override
  String get fileUploadStatusFailed => 'Başarısız';

  @override
  String get fileUploadUnknownType => 'Dosya';

  @override
  String get fileUploadRemove => 'Dosyayı kaldır';

  @override
  String get fileUploadRetry => 'Yüklemeyi yeniden dene';

  @override
  String get fileUploadPreview => 'Dosyayı önizle';

  @override
  String get fileUploadDownload => 'Dosyayı indir';

  @override
  String get errorSomethingWentWrong => 'Bir şeyler ters gitti';

  @override
  String get errorUnexpectedMessage =>
      'Lütfen tekrar deneyin veya sorun devam ederse destek ile iletişime geçin.';

  @override
  String get errorActionRetry => 'Tekrar dene';

  @override
  String get errorActionReport => 'Bildir';

  @override
  String get errorActionBack => 'Geri dön';

  @override
  String get errorActionLogin => 'Giriş yap';

  @override
  String get errorActionSettings => 'Ayarlar';

  @override
  String get errorActionContactSupport => 'Destek ile iletişime geç';

  @override
  String get errorBadRequest => 'Geçersiz istek';

  @override
  String get errorBadRequestMessage =>
      'İstek geçersizdi. Gözden geçirip tekrar deneyin.';

  @override
  String get errorUnauthorized => 'Yetkisiz';

  @override
  String get errorLoginRequiredMessage => 'Devam etmek için giriş yapın.';

  @override
  String get errorAccessDenied => 'Erişim reddedildi';

  @override
  String get errorAccessDeniedMessage => 'Bu işlemi yapma izniniz yok.';

  @override
  String get errorNotFound => 'Bulunamadı';

  @override
  String get errorNotFoundMessage => 'Aradığınız şeyi bulamadık.';

  @override
  String get errorConflict => 'Çakışma';

  @override
  String get errorConflictMessage => 'Bu işlem mevcut verilerle çakışıyor.';

  @override
  String get errorInvalidData => 'Geçersiz veri';

  @override
  String get errorInvalidDataMessage =>
      'Bazı alanların dikkatinize ihtiyacı var.';

  @override
  String get errorTooManyRequests => 'Çok fazla istek';

  @override
  String get errorTooManyRequestsMessage =>
      'Lütfen biraz bekleyip tekrar deneyin.';

  @override
  String get errorServerError => 'Sunucu hatası';

  @override
  String get errorServerErrorMessage =>
      'Sunucuda bir sorun oluştu. Lütfen tekrar deneyin.';

  @override
  String get errorRequestTimedOut => 'İstek zaman aşımına uğradı';

  @override
  String get errorRequestTimedOutMessage =>
      'Sunucu yanıt vermekte çok gecikiyor.';

  @override
  String get errorAuthenticationRequired => 'Kimlik doğrulama gerekli';

  @override
  String get errorInvalidInput => 'Geçersiz giriş';

  @override
  String get errorReviewFieldsMessage =>
      'Lütfen vurgulanan alanları gözden geçirin.';

  @override
  String get errorPlatformError => 'Platform hatası';

  @override
  String get errorDeviceErrorMessage => 'Bu cihazda bir şeyler ters gitti.';

  @override
  String get errorConnectionFailed => 'Bağlantı başarısız oldu';

  @override
  String get errorConnectionFailedMessage =>
      'İnternet bağlantınızı kontrol edip tekrar deneyin.';

  @override
  String get errorSecureConnectionFailed => 'Güvenli bağlantı başarısız oldu';

  @override
  String get errorSecureConnectionMessage => 'Güvenli bağlantı kurulamadı.';

  @override
  String get tableResizeColumn => 'Sütunu yeniden boyutlandır';

  @override
  String get tableResizeRow => 'Satırı yeniden boyutlandır';

  @override
  String get resizableHandle => 'Yeniden boyutlandırma tutamacı';

  @override
  String get spellCheckNoSuggestions => 'Öneri yok';

  @override
  String get announcementLoading => 'Yükleniyor';

  @override
  String get announcementSuccess => 'Başarılı';

  @override
  String get announcementFailure => 'Başarısız';

  @override
  String get toolbarMore => 'Diğer';

  @override
  String get toolbarMoreActions => 'Diğer işlemler';

  @override
  String get treeCollapse => 'Daralt';

  @override
  String get treeExpand => 'Genişlet';

  @override
  String get markdownDetails => 'Ayrıntılar';

  @override
  String get carouselLabel => 'Öne çıkan karusel';

  @override
  String get carouselPrimaryAction => 'Sohbete ekle';

  @override
  String carouselItemPreview(Object? title) =>
      'Öne çıkan önizleme: ${title ?? mediaUntitled}';

  @override
  String carouselPageOf(int position, int length) =>
      '${_number(length)} sayfadan ${_number(position)}. sayfa';

  @override
  String stepperStep(int index) => '${_number(index + 1)}. adım';

  @override
  String paginationPage(Object? page) => 'Sayfa ${_number(page)}';

  @override
  String chartSeriesDefault(int index) => 'Seri ${_number(index + 1)}';

  @override
  String chartSliceDefault(int index) => 'Dilim ${_number(index)}';

  @override
  String chartCategoryDefault(int index) => 'Kategori ${_number(index)}';

  @override
  String get chartValueDefault => 'Değer';

  @override
  String get chartKindLine => 'Çizgi';

  @override
  String get chartKindArea => 'Alan';

  @override
  String get chartKindBar => 'Çubuk';

  @override
  String get chartKindDonut => 'Halka';

  @override
  String get chartKindPie => 'Pasta';

  @override
  String get chartKindSparkline => 'Seyrek çizgi';

  @override
  String get chartKindScatter => 'Dağılım';

  @override
  String get chartKindRadar => 'Radar';

  @override
  String get chartKindRadial => 'Radyal';

  @override
  String chartSummaryEmpty(Object? kind) => 'Verisiz $kind grafiği';

  @override
  String chartSummary(int series, int points, Object? kind) =>
      '$kind grafiği: ${_number(series)} seri, ${_number(points)} nokta';

  @override
  String get colorFieldHsv => 'HSV renk alanı';

  @override
  String get colorFieldHsl => 'HSL renk alanı';

  @override
  String get actionClear => 'Temizle';

  @override
  String get actionApply => 'Uygula';

  @override
  String get actionVerify => 'Doğrula';

  @override
  String get actionResend => 'Yeniden gönder';

  @override
  String resendInSeconds(int seconds) =>
      '${_number(seconds)} sn içinde yeniden gönder';

  @override
  String get authCode => 'Kod';

  @override
  String get authEmail => 'E-posta';

  @override
  String get authPassword => 'Parola';

  @override
  String get authName => 'Ad';

  @override
  String get authSignIn => 'Giriş yap';

  @override
  String get authForgotPassword => 'Parolanızı mı unuttunuz?';

  @override
  String get authRememberMe => 'Beni hatırla';

  @override
  String get authCreateAccount => 'Hesap oluştur';

  @override
  String get actionClose => 'Kapat';

  @override
  String get mediaPlay => 'Oynat';

  @override
  String get mediaPause => 'Duraklat';

  @override
  String get mediaMute => 'Sessize al';

  @override
  String get mediaUnmute => 'Sesi aç';

  @override
  String get mediaVolume => 'Ses düzeyi';

  @override
  String get mediaSeek => 'Ara';

  @override
  String get mediaDownload => 'İndir';

  @override
  String get mediaAudioPlayer => 'Ses oynatıcı';

  @override
  String get mediaVideoPlayer => 'Video oynatıcı';

  @override
  String get mediaUntitled => 'Başlıksız';

  @override
  String get mediaPlaybackFailed => 'Oynatma başarısız oldu';

  @override
  String get mediaPreviousTrack => 'Önceki parça';

  @override
  String get mediaNextTrack => 'Sonraki parça';

  @override
  String get mediaShuffleDisable => 'Karıştırmayı kapat';

  @override
  String get mediaShuffleEnable => 'Karıştırmayı aç';

  @override
  String get mediaRepeatDisable => 'Tekrarı kapat';

  @override
  String get mediaRepeatEnable => 'Tekrarı aç';

  @override
  String mediaPlaybackSpeed(Object? speed) =>
      'Oynatma hızı: ${speed}x, değiştirmek için dokun';

  @override
  String mediaPositionOf(Object position, Object duration) =>
      '$position / $duration';

  @override
  String mediaHours(int count) =>
      count == 1 ? '1 saat' : '${_number(count)} saat';

  @override
  String mediaMinutes(int count) =>
      count == 1 ? '1 dakika' : '${_number(count)} dakika';

  @override
  String mediaSeconds(int count) =>
      count == 1 ? '1 saniye' : '${_number(count)} saniye';

  @override
  String get signaturePadLabel => 'İmza alanı';

  @override
  String get qrCodeLabel => 'QR kodu';

  @override
  String get marqueeContent => 'Kayan içerik';

  @override
  String mediaSkipBack(int seconds) => '${_number(seconds)} saniye geri';

  @override
  String mediaSkipForward(int seconds) => '${_number(seconds)} saniye ileri';

  @override
  String get mediaCaptionsShow => 'Altyazıları göster';

  @override
  String get mediaCaptionsHide => 'Altyazıları gizle';

  @override
  String get mediaCaptionsOn => 'Altyazılar açık';

  @override
  String get mediaCaptionsOff => 'Altyazılar kapalı';

  @override
  String get mediaFullscreen => 'Tam ekran';

  @override
  String mediaMoreOptionsSpeed(Object? speed) =>
      'Diğer seçenekler, oynatma hızı: ${speed}x';

  @override
  String mediaSpeed(Object? speed) => 'Hız: ${speed}x';

  @override
  String get actionStartTrial => 'Ücretsiz denemeyi başlat';

  @override
  String get authFirstName => 'Ad';

  @override
  String get authLastName => 'Soyad';

  @override
  String get authPasswordHint => 'En az 8 karakter.';

  @override
  String get authUseDifferentEmail => 'Farklı bir e-posta kullan';

  @override
  String get authWorkEmail => 'İş e-postası';

  @override
  String get chartTotalLabel => 'Toplam';

  @override
  String get mediaQualityAuto => 'Kalite Otomatik';

  @override
  String get mediaLiveBadge => 'CANLI';

  @override
  String get blockDontHaveAccount => 'Hesabınız yok mu?';

  @override
  String get blockAlreadyHaveAccount => 'Zaten bir hesabınız var mı?';

  @override
  String get blockNoAccountYet => 'Henüz hesabınız yok mu?';

  @override
  String get blockHaveAnAccount => 'Hesabınız var mı?';

  @override
  String get blockCreateOne => 'Oluşturun';

  @override
  String get blockCreateAccount => 'Hesap oluştur';

  @override
  String get blockCreateYourAccount => 'Hesabınızı oluşturun';

  @override
  String get blockForgotYourPassword => 'Şifrenizi mi unuttunuz?';

  @override
  String get blockBackToSignIn => 'Girişe dön';

  @override
  String get blockEnterCredentialsWorkspace =>
      'Çalışma alanınıza erişmek için kimlik bilgilerinizi girin.';

  @override
  String get blockEnterCredentialsContinue =>
      'Devam etmek için kimlik bilgilerinizi girin.';

  @override
  String get blockEnterDetailsContinue =>
      'Devam etmek için bilgilerinizi aşağıya girin.';

  @override
  String get blockEnterEmailCreateAccount =>
      'Hesabınızı oluşturmak için e-postanızı aşağıya girin.';

  @override
  String get blockSignedInWelcomeBack => 'Giriş yapıldı — tekrar hoş geldiniz.';

  @override
  String get blockAccountCreatedVerify =>
      'Hesap oluşturuldu — doğrulamak için gelen kutunuzu kontrol edin.';

  @override
  String get blockTrialStartedVerify =>
      'Deneme başlatıldı — doğrulamak için gelen kutunuzu kontrol edin.';

  @override
  String get blockPasswordsDoNotMatch => 'Parolalar eşleşmiyor.';

  @override
  String get blockCurrentPassword => 'Mevcut parola';

  @override
  String get blockNewPassword => 'Yeni parola';

  @override
  String get blockConfirmNewPassword => 'Yeni parolayı onaylayın';

  @override
  String get blockUpdatePassword => 'Parolayı güncelle';

  @override
  String get blockPasswordUpdated => 'Parola güncellendi.';

  @override
  String get blockPasswordHintChange =>
      'En az 8 karakter. Değiştirmek sizi başka yerlerde oturumdan çıkarır.';

  @override
  String get blockUsername => 'Kullanıcı adı';

  @override
  String get blockUsernameHint => 'Küçük harfler, rakamlar, alt çizgiler.';

  @override
  String get blockYourAvatar => 'Avatarınız';

  @override
  String get blockUploadImage => 'Görsel yükle';

  @override
  String get blockBio => 'Biyografi';

  @override
  String get blockBioHint => 'Bize kendinizden biraz bahsedin';

  @override
  String get blockBioCounterHint => 'En fazla 160 karakter.';

  @override
  String get blockProfileSaved => 'Profil kaydedildi.';

  @override
  String get blockSaveChanges => 'Değişiklikleri kaydet';

  @override
  String get blockInviteMember => 'Üye davet et';

  @override
  String get blockRoleAdmin => 'Yönetici';

  @override
  String get blockRoleOwner => 'Sahip';

  @override
  String get blockRoleMember => 'Üye';

  @override
  String get blockTeam => 'Ekip';

  @override
  String get blockProfile => 'Profil';

  @override
  String get blockSignInWithEmail => 'E-postayla giriş yap';

  @override
  String get blockSignUp => 'Kaydol';

  @override
  String get blockPickWayYouPrefer => 'Tercih ettiğiniz yöntemi seçin.';

  @override
  String blockContinueWith(Object? provider) => '$provider ile devam et';

  @override
  String get blockCreating => 'Oluşturuluyor…';

  @override
  String get blockSigningIn => 'Giriş yapılıyor…';

  @override
  String get blockSending => 'Gönderiliyor…';

  @override
  String get blockSaving => 'Kaydediliyor…';

  @override
  String get blockPaying => 'Ödeniyor…';

  @override
  String get blockSendResetLink => 'Sıfırlama bağlantısı gönder';

  @override
  String get blockResetPassword => 'Parolayı sıfırla';

  @override
  String get blockResetLinkSent =>
      'Sıfırlama bağlantısı gönderildi. Devam etmek için gelen kutunuzu kontrol edin.';

  @override
  String get blockWeWillEmailReset =>
      'Size e-postayla bir sıfırlama bağlantısı göndereceğiz.';

  @override
  String get blockMustAcceptTerms =>
      'Devam etmek için koşulları kabul etmelisiniz.';

  @override
  String get blockCheckInbox => 'Gelen kutunuzu kontrol edin';

  @override
  String get blockEnterSixDigitCode =>
      'Size gönderdiğimiz 6 haneli kodu girin.';

  @override
  String get blockCodeVerifiedSignedIn => 'Kod doğrulandı. Giriş yaptınız.';

  @override
  String get blockEmailVerifiedSet => 'E-posta doğrulandı — her şey hazır.';

  @override
  String get blockVerifyYourEmail => 'E-postanızı doğrulayın';

  @override
  String blockWeSentCodeTo(Object? email) =>
      '$email adresine altı haneli bir kod gönderdik.';

  @override
  String get blockDidntGetCode => 'Kodu almadınız mı?';

  @override
  String get blockBack => 'Geri';

  @override
  String get blockBackToCart => 'Sepete dön';

  @override
  String get blockBackToSettings => 'Ayarlara dön';

  @override
  String get blockOneAccountEverything => 'Her şey için tek hesap.';

  @override
  String get blockStartTrialNoCard =>
      '14 günlük denemenizi başlatın. Kredi kartı gerekmez.';

  @override
  String get blockNotifications => 'Bildirimler';

  @override
  String get blockNotifChoose =>
      'Ne hakkında ve nerede bilgi almak istediğinizi seçin.';

  @override
  String get blockEmailNotifications => 'E-posta bildirimleri';

  @override
  String get blockPushNotifications => 'Anlık bildirimler';

  @override
  String get blockMentionsReplies => 'Bahsetmeler ve yanıtlar';

  @override
  String get blockDeliveredToDevices => 'Cihazlarınıza iletildi';

  @override
  String blockEmailChannel(Object? channel) => 'E-posta · $channel';

  @override
  String blockPushChannel(Object? channel) => 'Anlık · $channel';

  @override
  String get blockQuietHours => 'Sessiz saatler';

  @override
  String get blockWeeklyDigest => 'Haftalık özet';

  @override
  String get blockWeeklyDigestBlurb =>
      'Olan biten her şeyle her pazartesi bir e-posta.';

  @override
  String get blockPreferencesSaved => 'Tercihler kaydedildi.';

  @override
  String get blockSavePreferences => 'Tercihleri kaydet';

  @override
  String get blockReset => 'Sıfırla';

  @override
  String get blockWelcomeAboard => 'Hoş geldiniz';

  @override
  String get blockQuickTour =>
      'Uygulamayı kullanmaya başlamadan önce hızlı bir tur.';

  @override
  String get blockStayInLoop => 'Haberdar olun';

  @override
  String get blockMessagesArriveMoment =>
      'Mesajlar ve güncellemeler olduğu anda ulaşır.';

  @override
  String get blockNeverMissThing => 'Hiçbir şeyi kaçırmayın';

  @override
  String get blockNotifPermissionBlurb =>
      'Yalnızca önemli olanları göndeririz: yanıtlar, hatırlatıcılar ve güvenlik uyarıları. Bunu daha sonra değiştirebilirsiniz.';

  @override
  String get blockEnableNotifications => 'Bildirimler açılsın mı?';

  @override
  String get blockAllowNotifications => 'Bildirimlere izin ver';

  @override
  String get blockAllowNotificationsBlurb =>
      'Uygulamadan en iyi şekilde yararlanmak için bildirimlere izin verin.';

  @override
  String get blockNotNow => 'Şimdi değil';

  @override
  String get blockSkip => 'Atla';

  @override
  String get blockGetStarted => 'Başlayın';

  @override
  String get blockMessages => 'Mesajlar';

  @override
  String get blockNoConversations => 'Konuşma yok';

  @override
  String get blockPullRefreshChat =>
      'Yenilemek için çekin veya yeni bir sohbet başlatın.';

  @override
  String get blockMute => 'Sessize al';

  @override
  String get blockMuted => 'Sessize alındı';

  @override
  String get blockAttach => 'Ekle';

  @override
  String get blockAttachFile => 'Dosya';

  @override
  String get blockAttachPhoto => 'Fotoğraf';

  @override
  String get blockWriteMessage => 'Mesaj yazın…';

  @override
  String get blockYourCart => 'Sepetiniz';

  @override
  String get blockAddSomethingFirst => 'Önce sevdiğiniz bir şey ekleyin.';

  @override
  String get blockCartEmpty => 'Sepet boş';

  @override
  String get blockCheckout => 'Ödeme';

  @override
  String blockQty(int quantity) => 'Adet $quantity';

  @override
  String blockPayTotal(Object? amount) => '$amount öde';

  @override
  String get blockPayment => 'Ödeme';

  @override
  String get blockCardNumber => 'Kart numarası';

  @override
  String get blockExpiry => 'Son kullanma';

  @override
  String get blockCvc => 'CVC';

  @override
  String get blockDeliveryAddress => 'Teslimat adresi';

  @override
  String get blockStreet => 'Sokak';

  @override
  String get blockCity => 'Şehir';

  @override
  String get blockSaveAndContinue => 'Kaydet ve devam et';

  @override
  String get blockOrderPlaced => 'Sipariş verildi';

  @override
  String get blockOrderThanks =>
      'Bizden alışveriş yaptığınız için teşekkürler. Onay yolda.';

  @override
  String get blockContinueShopping => 'Alışverişe devam et';

  @override
  String get blockSchedule => 'Program';

  @override
  String get blockPickDateRangeReport =>
      'Raporunuz için bir tarih aralığı seçin.';

  @override
  String get blockPickDateRange => 'Tarih aralığı seç';

  @override
  String get blockTapAnotherDay =>
      'aralığı genişletmek için başka bir güne dokunun';

  @override
  String get blockBookMeeting => 'Toplantı planla';

  @override
  String get blockPickDayTime => 'Bir gün, ardından size uygun bir saat seçin.';

  @override
  String get blockFourSlots => '30 dakikalık dört slot kaldı. Birini seçin.';

  @override
  String blockPickedSlot(Object? slot) => '$slot seçildi, 30 dakika.';

  @override
  String get blockOverview => 'Genel bakış';

  @override
  String get blockRevenueOrdersBlurb =>
      'Gelir, abonelikler ve en son siparişler.';

  @override
  String get blockTotalRevenue => 'Toplam gelir';

  @override
  String get blockSubscriptions => 'Abonelikler';

  @override
  String get blockSales => 'Satışlar';

  @override
  String get blockRevenueByMonth => 'Aya göre gelir';

  @override
  String get blockRecentSales => 'Son satışlar';

  @override
  String get blockViewAll => 'Tümünü gör';

  @override
  String get blockTransactions => 'İşlemler';

  @override
  String get blockFilterTransactions => 'İşlemleri filtrele';

  @override
  String get blockCustomer => 'Müşteri';

  @override
  String get blockAmount => 'Tutar';

  @override
  String get blockMethod => 'Yöntem';

  @override
  String get blockStatus => 'Durum';

  @override
  String get blockPaid => 'Ödendi';

  @override
  String get blockPending => 'Bekliyor';

  @override
  String get blockRefunded => 'İade edildi';

  @override
  String blockNoTransactions(Object? query) =>
      '“$query” ile eşleşen işlem yok.';

  @override
  String blockDeltaFromLastMonth(Object? delta) => 'geçen aya göre $delta';

  @override
  String get blockAnalytics => 'Analiz';

  @override
  String get blockSessionsDevicesBlurb =>
      'Oturumlar, cihazlar ve trafiğin geldiği yer.';

  @override
  String get blockSearchReports => 'Raporlarda ara';

  @override
  String get blockLast30Days => 'Son 30 gün';

  @override
  String get blockAllDevices => 'Tüm cihazlar';

  @override
  String get blockSessions => 'Oturumlar';

  @override
  String get blockUsers => 'Kullanıcılar';

  @override
  String get blockAvgSession => 'Ort. oturum';

  @override
  String get blockBounceRate => 'Hemen çıkma oranı';

  @override
  String get blockConversions => 'Dönüşümler';

  @override
  String get blockByDevice => 'Cihaza göre';

  @override
  String get blockDesktop => 'Masaüstü';

  @override
  String get blockMobile => 'Mobil';

  @override
  String get blockTablet => 'Tablet';

  @override
  String get blockDirect => 'Doğrudan';

  @override
  String get blockReferral => 'Yönlendirme';

  @override
  String get blockSocial => 'Sosyal';

  @override
  String get blockTrafficSources => 'Trafik kaynakları';

  @override
  String get blockVisitors => 'Ziyaretçiler';

  @override
  String get blockHome => 'Ana sayfa';

  @override
  String get blockInbox => 'Gelen kutusu';

  @override
  String get blockCalendar => 'Takvim';

  @override
  String get blockCompose => 'Oluştur';

  @override
  String get blockMarkAllRead => 'Tümünü okundu işaretle';

  @override
  String get blockStarred => 'Yıldızlı';

  @override
  String get blockSnoozed => 'Ertelendi';

  @override
  String get blockUnread => 'Okunmadı';

  @override
  String get blockDocuments => 'Belgeler';

  @override
  String get blockReports => 'Raporlar';

  @override
  String get blockDashboard => 'Pano';

  @override
  String get blockStorage => 'Depolama';

  @override
  String get blockNavigation => 'Gezinme';

  @override
  String get blockSharedWithYou => 'Sizinle paylaşıldı';

  @override
  String get blockRecentProjects => 'Son projeler';

  @override
  String get blockStorageUsed => 'Kullanılan depolama';

  @override
  String get blockOpen => 'Aç';

  @override
  String get blockLive => 'Canlı';

  @override
  String get blockMembers => 'Üyeler';

  @override
  String get blockProjects => 'Projeler';

  @override
  String get blockDeploys => 'Dağıtımlar';

  @override
  String get blockActivity => 'Etkinlik';

  @override
  String get blockRecentFiles => 'Son dosyalar';

  @override
  String get blockUsageThisMonth => 'Bu ayki kullanım';

  @override
  String get blockUpgradePlan => 'Planı yükselt';

  @override
  String blockNoMatches(Object? query) => '“$query” için sonuç yok.';

  @override
  String get blockWorkspaces => 'Çalışma alanları';

  @override
  String get blockPricing => 'Fiyatlandırma';

  @override
  String get blockPlansScale => 'Sizinle büyüyen planlar';

  @override
  String get blockPlansBlurb =>
      'Ücretsiz başlayın, ekibiniz büyüdüğünde yükseltin. Her plan eksiksiz bileşen kitaplığı ve tema hazır ayarlarını içerir.';

  @override
  String get blockPerUserMonth => 'kullanıcı başına / ay';

  @override
  String get blockSubscribe => 'Abone ol';

  @override
  String get blockContactSales => 'Satış ile iletişime geç';

  @override
  String get blockPromoCode => 'Promosyon kodu';

  @override
  String get blockApplyCode => 'Kodu uygula';

  @override
  String get blockHaveCodeEnter => 'Kodunuz var mı? Aşağıya girin.';

  @override
  String get blockCodeAppliedDiscount =>
      'Kod uygulandı — indiriminiz ödemede görünür.';

  @override
  String get blockFaqTitle => 'Sorular';

  @override
  String get blockFaqChangePlans => 'Planı daha sonra değiştirebilir miyim?';

  @override
  String get blockFaqChangePlansAnswer =>
      'Evet. Yükseltmeler hemen uygulanır, düşürmeler gelecek döngüden itibaren.';

  @override
  String get blockFaqFreeTrial => 'Ücretsiz deneme var mı?';

  @override
  String get blockFaqFreeTrialAnswer =>
      'Her plan 14 günle başlar, kart gerekmez.';

  @override
  String get blockAccount => 'Hesap';

  @override
  String get blockGeneral => 'Genel';

  @override
  String get blockAppearance => 'Görünüm';

  @override
  String get blockDarkMode => 'Koyu mod';

  @override
  String get blockPreferences => 'Tercihler';

  @override
  String get blockSignOut => 'Oturumu kapat';

  @override
  String get blockSignOutConfirm => 'Oturum kapatılsın mı?';

  @override
  String get blockSignOutBlurb =>
      'Daha sonra her zaman tekrar giriş yapabilirsiniz.';

  @override
  String get blockSounds => 'Sesler';

  @override
  String get blockWhatYouGet => 'Neler alırsınız';

  @override
  String get blockAllComponentCategories => 'Tüm bileşen kategorileri';

  @override
  String get blockPrioritySupport => 'Öncelikli destek';

  @override
  String get blockUnlimitedProjectsTrial => 'Deneme sırasında sınırsız proje';

  @override
  String get blockTrialDaysLeft => 'Denemenizde 14 gün kaldı';

  @override
  String get blockStarterChat => 'Sohbet';

  @override
  String get blockStarterShop => 'Mağaza';

  @override
  String get blockStarterCart => 'Sepet';

  @override
  String get blockAddToCart => 'Sepete ekle';
}
