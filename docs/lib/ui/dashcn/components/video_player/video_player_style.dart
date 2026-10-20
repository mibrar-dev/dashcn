// Registry-owned theme data for the `video_player` component.
//
// User-owned overrides live in `video_player_theme.dart`; CLI updates may
// replace this file. The widget resolves the four legs through
// `resolveComponentStyle<VideoPlayerTheme, VideoPlayerTheme>`.

import 'package:flutter/widgets.dart';

import '../../foundation/constants.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';

/// Visual contract of the video player chrome.
class VideoPlayerTheme extends ComponentThemeData
    implements Mergeable<VideoPlayerTheme> {
  /// Creates a video player theme.
  const VideoPlayerTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.background,
    this.scrim,
    this.foreground,
    this.accent,
    this.track,
    this.buffered,
    this.thumb,
    this.borderRadius,
    this.controlsPadding,
    this.controlSize,
    this.iconSize,
    this.trackHeight,
    this.timeTextStyle,
    this.captionsTextStyle,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.fadeDuration,
    this.controlsTimeout,
  });

  /// Frame background behind the video/poster.
  final ThemedColor? background;

  /// Gradient/scrim behind the control bar.
  final ThemedColor? scrim;

  /// Icons and labels on the scrim.
  final ThemedColor? foreground;

  /// Played fill of the scrub bar.
  final ThemedColor? accent;

  /// Unplayed track of the scrub bar.
  final ThemedColor? track;

  /// Buffered fill of the scrub bar.
  final ThemedColor? buffered;

  /// Scrub thumb fill.
  final ThemedColor? thumb;

  /// Corner radius of the frame.
  final BorderRadiusGeometry? borderRadius;

  /// Padding inside the control bar.
  final EdgeInsetsGeometry? controlsPadding;

  /// Diameter of the centre play button.
  final double? controlSize;

  /// Icon size for bar buttons.
  final double? iconSize;

  /// Scrub track height.
  final double? trackHeight;

  /// Time label text style.
  final TextStyle? timeTextStyle;

  /// Captions text style.
  final TextStyle? captionsTextStyle;

  /// Surface opacity leg for the floating control bar.
  final double? surfaceOpacity;

  /// Surface blur leg for the floating control bar.
  final double? surfaceBlur;

  /// Fade duration for controls and overlay.
  final Duration? fadeDuration;

  /// Auto-hide delay for the control bar.
  final Duration? controlsTimeout;

  /// Returns a copy with the given fields replaced.
  VideoPlayerTheme copyWith({
    ValueGetter<ThemedColor?>? background,
    ValueGetter<ThemedColor?>? scrim,
    ValueGetter<ThemedColor?>? foreground,
    ValueGetter<ThemedColor?>? accent,
    ValueGetter<ThemedColor?>? track,
    ValueGetter<ThemedColor?>? buffered,
    ValueGetter<ThemedColor?>? thumb,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<EdgeInsetsGeometry?>? controlsPadding,
    ValueGetter<double?>? controlSize,
    ValueGetter<double?>? iconSize,
    ValueGetter<double?>? trackHeight,
    ValueGetter<TextStyle?>? timeTextStyle,
    ValueGetter<TextStyle?>? captionsTextStyle,
    ValueGetter<double?>? surfaceOpacity,
    ValueGetter<double?>? surfaceBlur,
    ValueGetter<Duration?>? fadeDuration,
    ValueGetter<Duration?>? controlsTimeout,
  }) {
    return VideoPlayerTheme(
      themeDensity: themeDensity,
      themeSpacing: themeSpacing,
      themeShadows: themeShadows,
      background: background == null ? this.background : background(),
      scrim: scrim == null ? this.scrim : scrim(),
      foreground: foreground == null ? this.foreground : foreground(),
      accent: accent == null ? this.accent : accent(),
      track: track == null ? this.track : track(),
      buffered: buffered == null ? this.buffered : buffered(),
      thumb: thumb == null ? this.thumb : thumb(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      controlsPadding: controlsPadding == null
          ? this.controlsPadding
          : controlsPadding(),
      controlSize: controlSize == null ? this.controlSize : controlSize(),
      iconSize: iconSize == null ? this.iconSize : iconSize(),
      trackHeight: trackHeight == null ? this.trackHeight : trackHeight(),
      timeTextStyle: timeTextStyle == null
          ? this.timeTextStyle
          : timeTextStyle(),
      captionsTextStyle: captionsTextStyle == null
          ? this.captionsTextStyle
          : captionsTextStyle(),
      surfaceOpacity: surfaceOpacity == null
          ? this.surfaceOpacity
          : surfaceOpacity(),
      surfaceBlur: surfaceBlur == null ? this.surfaceBlur : surfaceBlur(),
      fadeDuration: fadeDuration == null ? this.fadeDuration : fadeDuration(),
      controlsTimeout: controlsTimeout == null
          ? this.controlsTimeout
          : controlsTimeout(),
    );
  }

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  VideoPlayerTheme merge(VideoPlayerTheme? fallback) {
    if (fallback == null) return this;
    return VideoPlayerTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      background: background ?? fallback.background,
      scrim: scrim ?? fallback.scrim,
      foreground: foreground ?? fallback.foreground,
      accent: accent ?? fallback.accent,
      track: track ?? fallback.track,
      buffered: buffered ?? fallback.buffered,
      thumb: thumb ?? fallback.thumb,
      borderRadius: borderRadius ?? fallback.borderRadius,
      controlsPadding: controlsPadding ?? fallback.controlsPadding,
      controlSize: controlSize ?? fallback.controlSize,
      iconSize: iconSize ?? fallback.iconSize,
      trackHeight: trackHeight ?? fallback.trackHeight,
      timeTextStyle: timeTextStyle ?? fallback.timeTextStyle,
      captionsTextStyle: captionsTextStyle ?? fallback.captionsTextStyle,
      surfaceOpacity: surfaceOpacity ?? fallback.surfaceOpacity,
      surfaceBlur: surfaceBlur ?? fallback.surfaceBlur,
      fadeDuration: fadeDuration ?? fallback.fadeDuration,
      controlsTimeout: controlsTimeout ?? fallback.controlsTimeout,
    );
  }

  /// Discrete fields step at t < 0.5; geometry lerps.
  static VideoPlayerTheme lerp(
    VideoPlayerTheme a,
    VideoPlayerTheme b,
    double t,
  ) {
    return VideoPlayerTheme(
      themeDensity: t < 0.5 ? a.themeDensity : b.themeDensity,
      themeSpacing: t < 0.5 ? a.themeSpacing : b.themeSpacing,
      themeShadows: t < 0.5 ? a.themeShadows : b.themeShadows,
      background: t < 0.5 ? a.background : b.background,
      scrim: t < 0.5 ? a.scrim : b.scrim,
      foreground: t < 0.5 ? a.foreground : b.foreground,
      accent: t < 0.5 ? a.accent : b.accent,
      track: t < 0.5 ? a.track : b.track,
      buffered: t < 0.5 ? a.buffered : b.buffered,
      thumb: t < 0.5 ? a.thumb : b.thumb,
      borderRadius: t < 0.5 ? a.borderRadius : b.borderRadius,
      controlsPadding: t < 0.5 ? a.controlsPadding : b.controlsPadding,
      controlSize: t < 0.5 ? a.controlSize : b.controlSize,
      iconSize: t < 0.5 ? a.iconSize : b.iconSize,
      trackHeight: t < 0.5 ? a.trackHeight : b.trackHeight,
      timeTextStyle: t < 0.5 ? a.timeTextStyle : b.timeTextStyle,
      captionsTextStyle: t < 0.5 ? a.captionsTextStyle : b.captionsTextStyle,
      surfaceOpacity: t < 0.5 ? a.surfaceOpacity : b.surfaceOpacity,
      surfaceBlur: t < 0.5 ? a.surfaceBlur : b.surfaceBlur,
      fadeDuration: t < 0.5 ? a.fadeDuration : b.fadeDuration,
      controlsTimeout: t < 0.5 ? a.controlsTimeout : b.controlsTimeout,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VideoPlayerTheme &&
        other.themeDensity == themeDensity &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.background == background &&
        other.scrim == scrim &&
        other.foreground == foreground &&
        other.accent == accent &&
        other.track == track &&
        other.buffered == buffered &&
        other.thumb == thumb &&
        other.borderRadius == borderRadius &&
        other.controlsPadding == controlsPadding &&
        other.controlSize == controlSize &&
        other.iconSize == iconSize &&
        other.trackHeight == trackHeight &&
        other.timeTextStyle == timeTextStyle &&
        other.captionsTextStyle == captionsTextStyle &&
        other.surfaceOpacity == surfaceOpacity &&
        other.surfaceBlur == surfaceBlur &&
        other.fadeDuration == fadeDuration &&
        other.controlsTimeout == controlsTimeout;
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[
    themeDensity,
    themeSpacing,
    themeShadows,
    background,
    scrim,
    foreground,
    accent,
    track,
    buffered,
    thumb,
    borderRadius,
    controlsPadding,
    controlSize,
    iconSize,
    trackHeight,
    timeTextStyle,
    captionsTextStyle,
    surfaceOpacity,
    surfaceBlur,
    fadeDuration,
    controlsTimeout,
  ]);
}

/// Token-derived baseline; every unset override field falls through here.
const VideoPlayerTheme videoPlayerDefaults = VideoPlayerTheme(
  background: ThemedColor.value(Color(0xFF000000)),
  scrim: ThemedColor.value(Color(0x99000000)),
  foreground: ThemedColor.value(Color(0xFFFFFFFF)),
  accent: ThemedColor.ref(ColorRef.primary),
  track: ThemedColor.value(Color(0x59FFFFFF)),
  buffered: ThemedColor.value(Color(0x99FFFFFF)),
  thumb: ThemedColor.value(Color(0xFFFFFFFF)),
  controlSize: 56,
  iconSize: 20,
  trackHeight: 4,
  fadeDuration: kDefaultDuration,
  controlsTimeout: Duration(seconds: 3),
);
