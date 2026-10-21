// Media-player semantics and control labels for [ComponentLocalizations].

/// Media-player text for [ComponentLocalizations]: audio/video chrome,
/// spoken durations, signature pad, QR code and marquee.
///
/// Applied by `ComponentLocalizations`; every getter has an English default and
/// translated locale tables may override it.
mixin ComponentLocalizationsMedia {
  /// Semantics label of a play control.
  String get mediaPlay => 'Play';

  /// Semantics label of a pause control.
  String get mediaPause => 'Pause';

  /// Semantics label of a mute control (audio is audible).
  String get mediaMute => 'Mute';

  /// Semantics label of an unmute control (audio is muted).
  String get mediaUnmute => 'Unmute';

  /// Semantics label of a volume slider.
  String get mediaVolume => 'Volume';

  /// Semantics label of a seek slider.
  String get mediaSeek => 'Seek';

  /// Semantics label of a download control.
  String get mediaDownload => 'Download';

  /// Default semantics label of an `audio_player`.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  /// Override per instance with `AudioPlayer.semanticLabel`.
  String get mediaAudioPlayer => 'Audio player';

  /// Default semantics label of a `video_player`.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  /// Override per instance with `VideoPlayer.semanticLabel`.
  String get mediaVideoPlayer => 'Video player';

  /// Fallback title when an audio track exposes no title.
  String get mediaUntitled => 'Untitled';

  /// Error text of a `video_player` that failed to load.
  String get mediaPlaybackFailed => 'Playback failed';

  /// Semantics label of a previous-track control.
  String get mediaPreviousTrack => 'Previous track';

  /// Semantics label of a next-track control.
  String get mediaNextTrack => 'Next track';

  /// Semantics label of a shuffle-off control (shuffling is on).
  String get mediaShuffleDisable => 'Disable shuffle';

  /// Semantics label of a shuffle-on control (shuffling is off).
  String get mediaShuffleEnable => 'Enable shuffle';

  /// Semantics label of a repeat-off control (repeating is on).
  String get mediaRepeatDisable => 'Disable repeat';

  /// Semantics label of a repeat-on control (repeating is off).
  String get mediaRepeatEnable => 'Enable repeat';

  /// Semantics label of a playback-speed control showing [speed].
  String mediaPlaybackSpeed(Object? speed) =>
      'Playback speed ${speed}x, tap to change';

  /// Slider valuetext joining [position] and [duration] spoken durations.
  String mediaPositionOf(Object position, Object duration) =>
      '$position of $duration';

  /// Spoken hours component of a media duration ([count] hours).
  String mediaHours(int count) => count == 1 ? '1 hour' : '$count hours';

  /// Spoken minutes component of a media duration ([count] minutes).
  String mediaMinutes(int count) => count == 1 ? '1 minute' : '$count minutes';

  /// Spoken seconds component of a media duration ([count] seconds).
  String mediaSeconds(int count) => count == 1 ? '1 second' : '$count seconds';

  /// Semantics label of a skip-backward control moving [seconds] seconds.
  String mediaSkipBack(int seconds) => 'Back $seconds seconds';

  /// Semantics label of a skip-forward control moving [seconds] seconds.
  String mediaSkipForward(int seconds) => 'Forward $seconds seconds';

  /// Semantics label of a show-captions control.
  String get mediaCaptionsShow => 'Show captions';

  /// Semantics label of a hide-captions control.
  String get mediaCaptionsHide => 'Hide captions';

  /// Semantics label of a captions toggle when captions are on.
  String get mediaCaptionsOn => 'Captions on';

  /// Semantics label of a captions toggle when captions are off.
  String get mediaCaptionsOff => 'Captions off';

  /// Semantics label of a fullscreen control.
  String get mediaFullscreen => 'Fullscreen';

  /// Semantics label of a more-options control showing [speed].
  String mediaMoreOptionsSpeed(Object? speed) =>
      'More options, playback speed ${speed}x';

  /// Semantics label of a speed preset of [speed].
  String mediaSpeed(Object? speed) => 'Speed ${speed}x';

  /// Visible quality note in the player more-menu (auto quality).
  String get mediaQualityAuto => 'Quality Auto';

  /// Visible live badge in the `video_player` control bar header.
  String get mediaLiveBadge => 'LIVE';

  /// Default semantics label of a `signature_pad`.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  /// Override per instance with `SignaturePad.semanticsLabel`.
  String get signaturePadLabel => 'Signature pad';

  /// Default semantics label of a `qr_code` image.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  /// Override per instance with `QrCode.semanticsLabel`.
  String get qrCodeLabel => 'QR code';

  /// Semantics label of an `overflow_marquee` scrolling region.
  String get marqueeContent => 'Marquee scrolling content';
}
