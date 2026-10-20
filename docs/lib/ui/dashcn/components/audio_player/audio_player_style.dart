// Registry-owned theme data for the `audio_player` component.
//
// User-owned overrides live in `audio_player_theme.dart`; CLI updates may
// replace this file. Resolved via
// `resolveComponentStyle<AudioPlayerTheme, AudioPlayerTheme>`.

import 'package:flutter/widgets.dart';

import '../../foundation/constants.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';

/// Layout of the audio player.
enum AudioPlayerVariant {
  /// Single row: play, title, progress, time.
  compact,

  /// Cover art on top with full control rows.
  full,
}

/// Visual contract of the audio player.
class AudioPlayerTheme extends ComponentThemeData
    implements Mergeable<AudioPlayerTheme> {
  /// Creates an audio player theme.
  const AudioPlayerTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.background,
    this.foreground,
    this.mutedForeground,
    this.accent,
    this.track,
    this.buffered,
    this.thumb,
    this.coverBackground,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.coverSize,
    this.coverRadius,
    this.controlSize,
    this.iconSize,
    this.trackHeight,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.timeTextStyle,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.fadeDuration,
  });

  /// Player background.
  final ThemedColor? background;

  /// Primary text/icons.
  final ThemedColor? foreground;

  /// Secondary text.
  final ThemedColor? mutedForeground;

  /// Played fill of the progress bar.
  final ThemedColor? accent;

  /// Unplayed track.
  final ThemedColor? track;

  /// Buffered fill.
  final ThemedColor? buffered;

  /// Scrub thumb fill.
  final ThemedColor? thumb;

  /// Cover art placeholder.
  final ThemedColor? coverBackground;

  /// Border colour.
  final ThemedColor? borderColor;

  /// Border width.
  final double? borderWidth;

  /// Corner radius.
  final BorderRadiusGeometry? borderRadius;

  /// Padding of the player body.
  final EdgeInsetsGeometry? padding;

  /// Cover art edge (full layout).
  final double? coverSize;

  /// Cover art radius.
  final BorderRadiusGeometry? coverRadius;

  /// Play button diameter.
  final double? controlSize;

  /// Icon size for buttons.
  final double? iconSize;

  /// Progress track height.
  final double? trackHeight;

  /// Title text style.
  final TextStyle? titleTextStyle;

  /// Subtitle text style.
  final TextStyle? subtitleTextStyle;

  /// Time label text style.
  final TextStyle? timeTextStyle;

  /// Surface opacity leg for the player card.
  final double? surfaceOpacity;

  /// Surface blur leg for the player card.
  final double? surfaceBlur;

  /// Fade duration for state changes.
  final Duration? fadeDuration;

  /// Returns a copy with the given fields replaced.
  AudioPlayerTheme copyWith({
    ValueGetter<ThemedColor?>? background,
    ValueGetter<ThemedColor?>? foreground,
    ValueGetter<ThemedColor?>? mutedForeground,
    ValueGetter<ThemedColor?>? accent,
    ValueGetter<ThemedColor?>? track,
    ValueGetter<ThemedColor?>? buffered,
    ValueGetter<ThemedColor?>? thumb,
    ValueGetter<ThemedColor?>? coverBackground,
    ValueGetter<ThemedColor?>? borderColor,
    ValueGetter<double?>? borderWidth,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<double?>? coverSize,
    ValueGetter<BorderRadiusGeometry?>? coverRadius,
    ValueGetter<double?>? controlSize,
    ValueGetter<double?>? iconSize,
    ValueGetter<double?>? trackHeight,
    ValueGetter<TextStyle?>? titleTextStyle,
    ValueGetter<TextStyle?>? subtitleTextStyle,
    ValueGetter<TextStyle?>? timeTextStyle,
    ValueGetter<double?>? surfaceOpacity,
    ValueGetter<double?>? surfaceBlur,
    ValueGetter<Duration?>? fadeDuration,
  }) {
    return AudioPlayerTheme(
      themeDensity: themeDensity,
      themeSpacing: themeSpacing,
      themeShadows: themeShadows,
      background: background == null ? this.background : background(),
      foreground: foreground == null ? this.foreground : foreground(),
      mutedForeground: mutedForeground == null
          ? this.mutedForeground
          : mutedForeground(),
      accent: accent == null ? this.accent : accent(),
      track: track == null ? this.track : track(),
      buffered: buffered == null ? this.buffered : buffered(),
      thumb: thumb == null ? this.thumb : thumb(),
      coverBackground: coverBackground == null
          ? this.coverBackground
          : coverBackground(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      borderWidth: borderWidth == null ? this.borderWidth : borderWidth(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      padding: padding == null ? this.padding : padding(),
      coverSize: coverSize == null ? this.coverSize : coverSize(),
      coverRadius: coverRadius == null ? this.coverRadius : coverRadius(),
      controlSize: controlSize == null ? this.controlSize : controlSize(),
      iconSize: iconSize == null ? this.iconSize : iconSize(),
      trackHeight: trackHeight == null ? this.trackHeight : trackHeight(),
      titleTextStyle: titleTextStyle == null
          ? this.titleTextStyle
          : titleTextStyle(),
      subtitleTextStyle: subtitleTextStyle == null
          ? this.subtitleTextStyle
          : subtitleTextStyle(),
      timeTextStyle: timeTextStyle == null
          ? this.timeTextStyle
          : timeTextStyle(),
      surfaceOpacity: surfaceOpacity == null
          ? this.surfaceOpacity
          : surfaceOpacity(),
      surfaceBlur: surfaceBlur == null ? this.surfaceBlur : surfaceBlur(),
      fadeDuration: fadeDuration == null ? this.fadeDuration : fadeDuration(),
    );
  }

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  AudioPlayerTheme merge(AudioPlayerTheme? fallback) {
    if (fallback == null) return this;
    return AudioPlayerTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      background: background ?? fallback.background,
      foreground: foreground ?? fallback.foreground,
      mutedForeground: mutedForeground ?? fallback.mutedForeground,
      accent: accent ?? fallback.accent,
      track: track ?? fallback.track,
      buffered: buffered ?? fallback.buffered,
      thumb: thumb ?? fallback.thumb,
      coverBackground: coverBackground ?? fallback.coverBackground,
      borderColor: borderColor ?? fallback.borderColor,
      borderWidth: borderWidth ?? fallback.borderWidth,
      borderRadius: borderRadius ?? fallback.borderRadius,
      padding: padding ?? fallback.padding,
      coverSize: coverSize ?? fallback.coverSize,
      coverRadius: coverRadius ?? fallback.coverRadius,
      controlSize: controlSize ?? fallback.controlSize,
      iconSize: iconSize ?? fallback.iconSize,
      trackHeight: trackHeight ?? fallback.trackHeight,
      titleTextStyle: titleTextStyle ?? fallback.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? fallback.subtitleTextStyle,
      timeTextStyle: timeTextStyle ?? fallback.timeTextStyle,
      surfaceOpacity: surfaceOpacity ?? fallback.surfaceOpacity,
      surfaceBlur: surfaceBlur ?? fallback.surfaceBlur,
      fadeDuration: fadeDuration ?? fallback.fadeDuration,
    );
  }

  /// Discrete fields step at t < 0.5; geometry lerps.
  static AudioPlayerTheme lerp(
    AudioPlayerTheme a,
    AudioPlayerTheme b,
    double t,
  ) {
    return AudioPlayerTheme(
      themeDensity: t < 0.5 ? a.themeDensity : b.themeDensity,
      themeSpacing: t < 0.5 ? a.themeSpacing : b.themeSpacing,
      themeShadows: t < 0.5 ? a.themeShadows : b.themeShadows,
      background: t < 0.5 ? a.background : b.background,
      foreground: t < 0.5 ? a.foreground : b.foreground,
      mutedForeground: t < 0.5 ? a.mutedForeground : b.mutedForeground,
      accent: t < 0.5 ? a.accent : b.accent,
      track: t < 0.5 ? a.track : b.track,
      buffered: t < 0.5 ? a.buffered : b.buffered,
      thumb: t < 0.5 ? a.thumb : b.thumb,
      coverBackground: t < 0.5 ? a.coverBackground : b.coverBackground,
      borderColor: t < 0.5 ? a.borderColor : b.borderColor,
      borderWidth: t < 0.5 ? a.borderWidth : b.borderWidth,
      borderRadius: t < 0.5 ? a.borderRadius : b.borderRadius,
      padding: t < 0.5 ? a.padding : b.padding,
      coverSize: t < 0.5 ? a.coverSize : b.coverSize,
      coverRadius: t < 0.5 ? a.coverRadius : b.coverRadius,
      controlSize: t < 0.5 ? a.controlSize : b.controlSize,
      iconSize: t < 0.5 ? a.iconSize : b.iconSize,
      trackHeight: t < 0.5 ? a.trackHeight : b.trackHeight,
      titleTextStyle: t < 0.5 ? a.titleTextStyle : b.titleTextStyle,
      subtitleTextStyle: t < 0.5 ? a.subtitleTextStyle : b.subtitleTextStyle,
      timeTextStyle: t < 0.5 ? a.timeTextStyle : b.timeTextStyle,
      surfaceOpacity: t < 0.5 ? a.surfaceOpacity : b.surfaceOpacity,
      surfaceBlur: t < 0.5 ? a.surfaceBlur : b.surfaceBlur,
      fadeDuration: t < 0.5 ? a.fadeDuration : b.fadeDuration,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AudioPlayerTheme &&
        other.themeDensity == themeDensity &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.background == background &&
        other.foreground == foreground &&
        other.mutedForeground == mutedForeground &&
        other.accent == accent &&
        other.track == track &&
        other.buffered == buffered &&
        other.thumb == thumb &&
        other.coverBackground == coverBackground &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.coverSize == coverSize &&
        other.coverRadius == coverRadius &&
        other.controlSize == controlSize &&
        other.iconSize == iconSize &&
        other.trackHeight == trackHeight &&
        other.titleTextStyle == titleTextStyle &&
        other.subtitleTextStyle == subtitleTextStyle &&
        other.timeTextStyle == timeTextStyle &&
        other.surfaceOpacity == surfaceOpacity &&
        other.surfaceBlur == surfaceBlur &&
        other.fadeDuration == fadeDuration;
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[
    themeDensity,
    themeSpacing,
    themeShadows,
    background,
    foreground,
    mutedForeground,
    accent,
    track,
    buffered,
    thumb,
    coverBackground,
    borderColor,
    borderWidth,
    borderRadius,
    padding,
    coverSize,
    coverRadius,
    controlSize,
    iconSize,
    trackHeight,
    titleTextStyle,
    subtitleTextStyle,
    timeTextStyle,
    surfaceOpacity,
    surfaceBlur,
    fadeDuration,
  ]);
}

/// Token-derived baseline; every unset override field falls through here.
const AudioPlayerTheme audioPlayerDefaults = AudioPlayerTheme(
  background: ThemedColor.ref(ColorRef.card),
  foreground: ThemedColor.ref(ColorRef.cardForeground),
  mutedForeground: ThemedColor.ref(ColorRef.mutedForeground),
  accent: ThemedColor.ref(ColorRef.primary),
  track: ThemedColor.ref(ColorRef.secondary),
  buffered: ThemedColor.ref(ColorRef.muted),
  thumb: ThemedColor.ref(ColorRef.primary),
  coverBackground: ThemedColor.ref(ColorRef.muted),
  borderColor: ThemedColor.ref(ColorRef.border),
  borderWidth: 1,
  controlSize: 48,
  iconSize: 20,
  coverSize: 176,
  trackHeight: 4,
  fadeDuration: kDefaultDuration,
);
