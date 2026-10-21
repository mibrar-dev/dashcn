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
}
