// Registry-owned theme data for the `gooey_toast` component: the state and
// animation enums (variant tables), the [GooeyToastTheme] container with the
// per-state tone fields, and the token-derived `gooeyToastDefaults`.
//
// User-owned overrides live in `gooey_toast_theme.dart`; CLI updates may
// replace this file. The card reads the resolved theme through
// `resolveComponentStyle<GooeyToastTheme, GooeyToastTheme>`.

import 'dart:ui' show lerpDouble;

import 'package:flutter/widgets.dart';

import '../../primitives/animation.dart';
import '../../primitives/gooey/gooey_frame.dart';
import '../../primitives/gooey/gooey_content.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';

/// Open/close animation profile of a gooey toast.
enum GooeyToastAnimationStyle {
  sileo,
  smooth,
  snappy,
  bouncy,
  fluid,
  springEasing;

  /// Open/close duration for this profile.
  Duration get duration => switch (this) {
    GooeyToastAnimationStyle.sileo => const Duration(milliseconds: 600),
    GooeyToastAnimationStyle.smooth => const Duration(milliseconds: 760),
    GooeyToastAnimationStyle.snappy => const Duration(milliseconds: 420),
    GooeyToastAnimationStyle.bouncy => const Duration(milliseconds: 680),
    GooeyToastAnimationStyle.fluid => const Duration(milliseconds: 760),
    GooeyToastAnimationStyle.springEasing => const Duration(milliseconds: 600),
  };

  /// Open/close curve for this profile.
  Curve get curve => switch (this) {
    GooeyToastAnimationStyle.sileo => Curves.easeInOutCubic,
    GooeyToastAnimationStyle.smooth => Curves.easeInOutQuart,
    GooeyToastAnimationStyle.snappy => Curves.easeOutCubic,
    GooeyToastAnimationStyle.bouncy => Curves.elasticOut,
    GooeyToastAnimationStyle.fluid => const Cubic(0.20, 0.95, 0.20, 1.18),
    GooeyToastAnimationStyle.springEasing => const SileoSpringCurve(),
  };
}

/// Corner profile of the gooey silhouette.
enum GooeyToastShapeStyle {
  defaultShape,
  soft,
  sharp,
  capsule;

  /// Resolved roundness for a base [roundness] and pill height.
  double roundness(double base, double pillHeight) => switch (this) {
    GooeyToastShapeStyle.defaultShape => base * 1.35,
    GooeyToastShapeStyle.soft => base * 1.6,
    GooeyToastShapeStyle.sharp => base * 0.9,
    GooeyToastShapeStyle.capsule => pillHeight / 2,
  };
}

/// Animation profile of the expanded body content.
enum GooeyToastBodyAnimationStyle {
  fade,
  fadeSlide,
  fadeScale,
  none;

  /// Surface animation profile for this style.
  GooeySurfaceBodyAnimation animation() => switch (this) {
    GooeyToastBodyAnimationStyle.fade => GooeySurfaceBodyAnimation.fade,
    GooeyToastBodyAnimationStyle.fadeSlide =>
      GooeySurfaceBodyAnimation.fadeSlide,
    GooeyToastBodyAnimationStyle.fadeScale =>
      GooeySurfaceBodyAnimation.fadeScale,
    GooeyToastBodyAnimationStyle.none => GooeySurfaceBodyAnimation.none,
  };
}

/// Fixed status tones: the reference gooey-toast hues, tuned so every one of
/// them clears 3:1 against BOTH the light and the dark `popover` fill.
///
/// upstream ships no success/warning/info tokens, and the chart tokens change hue
/// per preset and mode (success read blue in dark, orange in light), so the
/// status tones are fixed constants instead of token references: the same
/// green, red, amber, blue, indigo and grey in every mode and preset.
/// [ensureToneContrast] (in `gooey_toast_options.dart`) still lifts a tone that
/// is too weak for a customised surface, so a user-chosen fill stays readable
/// without anyone re-checking the palette.
const Color gooeySuccessTone = Color(0xFF16A34A);

/// Fixed warning tone; see [gooeySuccessTone].
const Color gooeyWarningTone = Color(0xFFB45309);

/// Fixed info tone; see [gooeySuccessTone].
const Color gooeyInfoTone = Color(0xFF3B82F6);

/// Fixed action tone; see [gooeySuccessTone].
const Color gooeyActionTone = Color(0xFF6366F1);

/// Fixed loading tone; see [gooeySuccessTone].
const Color gooeyLoadingTone = Color(0xFF6B7280);

/// Fixed error tone; a static red (like the other status tones) so the error
/// colour is identical in every preset and clears 3:1 on the light surface —
/// the `destructive` token flips to a pale red in dark mode that is unreadable
/// on the light toast. See [gooeySuccessTone].
const Color gooeyErrorTone = Color(0xFFDC2626);

/// Surface fill: main's light near-white, inverted from the dark site so the
/// toast reads as a light card in dark mode. A fixed value (not a token) so the
/// silhouette colour is stable across presets and modes, like the reference;
/// user-overridable through the component theme.
const Color gooeySurfaceFill = Color(0xFFF7F8FA);

/// Compact title style before the state tone is applied.
const TextStyle gooeyTitleTextStyle = TextStyle(
  fontSize: 13.2,
  height: 1.0,
  fontWeight: FontWeight.w500,
);

/// Expanded description style; the colour comes from [GooeyToastTheme]
/// `descriptionColor` (resolved per build), so it stays null here.
const TextStyle gooeyDescriptionTextStyle = TextStyle(
  fontSize: 14,
  height: 1.43,
  fontWeight: FontWeight.w400,
);

/// Visual and timing contract of a gooey toast.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields. The six `*Tone` fields are
/// direct (Studio-editable) theme fields, so a customised toast keeps its
/// identity across presets instead of following a token that changes hue.
class GooeyToastTheme extends ComponentThemeData
    implements Mergeable<GooeyToastTheme> {
  const GooeyToastTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.width,
    this.fill,
    this.roundness,
    this.titleStyle,
    this.descriptionStyle,
    this.descriptionColor,
    this.duration,
    this.animationStyle,
    this.shapeStyle,
    this.bodyAnimationStyle,
    this.enableGooeyBlur,
    this.compactMorph,
    this.successTone,
    this.loadingTone,
    this.errorTone,
    this.warningTone,
    this.infoTone,
    this.actionTone,
  });

  final double? width;

  /// Surface fill. Default: main's light near-white (#F7F8FA), inverted from
  /// the dark site background so the toast reads as a light card.
  final ThemedColor? fill;

  final double? roundness;

  /// Compact title style; null uses `gooeyTitleTextStyle` in the state tone.
  final TextStyle? titleStyle;

  /// Expanded description style; null uses `gooeyDescriptionTextStyle`.
  final TextStyle? descriptionStyle;

  /// Expanded description colour, applied when the style carries none.
  /// Default: the `mutedForeground` token.
  final ThemedColor? descriptionColor;

  final Duration? duration;

  final GooeyToastAnimationStyle? animationStyle;

  final GooeyToastShapeStyle? shapeStyle;

  final GooeyToastBodyAnimationStyle? bodyAnimationStyle;

  final bool? enableGooeyBlur;

  /// Compact pill morph profile for in-place title/state changes.
  final GooeyCompactMorph? compactMorph;

  /// `success` accent. Default: the fixed [gooeySuccessTone] green.
  final ThemedColor? successTone;

  /// `loading` accent. Default: the fixed [gooeyLoadingTone] grey.
  final ThemedColor? loadingTone;

  /// `error` accent. Default: the fixed [gooeyErrorTone] red.
  final ThemedColor? errorTone;

  /// `warning` accent. Default: the fixed [gooeyWarningTone] amber.
  final ThemedColor? warningTone;

  /// `info` accent. Default: the fixed [gooeyInfoTone] blue.
  final ThemedColor? infoTone;

  /// `action` accent. Default: the fixed [gooeyActionTone] indigo.
  final ThemedColor? actionTone;

  /// Returns a copy with the given fields replaced.
  GooeyToastTheme copyWith({
    ValueGetter<double?>? width,
    ValueGetter<ThemedColor?>? fill,
    ValueGetter<double?>? roundness,
    ValueGetter<TextStyle?>? titleStyle,
    ValueGetter<TextStyle?>? descriptionStyle,
    ValueGetter<ThemedColor?>? descriptionColor,
    ValueGetter<Duration?>? duration,
    ValueGetter<GooeyToastAnimationStyle?>? animationStyle,
    ValueGetter<GooeyToastShapeStyle?>? shapeStyle,
    ValueGetter<GooeyToastBodyAnimationStyle?>? bodyAnimationStyle,
    ValueGetter<bool?>? enableGooeyBlur,
    ValueGetter<GooeyCompactMorph?>? compactMorph,
    ValueGetter<ThemedColor?>? successTone,
    ValueGetter<ThemedColor?>? loadingTone,
    ValueGetter<ThemedColor?>? errorTone,
    ValueGetter<ThemedColor?>? warningTone,
    ValueGetter<ThemedColor?>? infoTone,
    ValueGetter<ThemedColor?>? actionTone,
  }) {
    return GooeyToastTheme(
      themeDensity: themeDensity,
      themeSpacing: themeSpacing,
      themeShadows: themeShadows,
      width: width == null ? this.width : width(),
      fill: fill == null ? this.fill : fill(),
      roundness: roundness == null ? this.roundness : roundness(),
      titleStyle: titleStyle == null ? this.titleStyle : titleStyle(),
      descriptionStyle: descriptionStyle == null
          ? this.descriptionStyle
          : descriptionStyle(),
      descriptionColor: descriptionColor == null
          ? this.descriptionColor
          : descriptionColor(),
      duration: duration == null ? this.duration : duration(),
      animationStyle: animationStyle == null
          ? this.animationStyle
          : animationStyle(),
      shapeStyle: shapeStyle == null ? this.shapeStyle : shapeStyle(),
      bodyAnimationStyle: bodyAnimationStyle == null
          ? this.bodyAnimationStyle
          : bodyAnimationStyle(),
      enableGooeyBlur: enableGooeyBlur == null
          ? this.enableGooeyBlur
          : enableGooeyBlur(),
      compactMorph: compactMorph == null ? this.compactMorph : compactMorph(),
      successTone: successTone == null ? this.successTone : successTone(),
      loadingTone: loadingTone == null ? this.loadingTone : loadingTone(),
      errorTone: errorTone == null ? this.errorTone : errorTone(),
      warningTone: warningTone == null ? this.warningTone : warningTone(),
      infoTone: infoTone == null ? this.infoTone : infoTone(),
      actionTone: actionTone == null ? this.actionTone : actionTone(),
    );
  }

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  GooeyToastTheme merge(GooeyToastTheme? fallback) {
    if (fallback == null) {
      return this;
    }
    return GooeyToastTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      width: width ?? fallback.width,
      fill: fill ?? fallback.fill,
      roundness: roundness ?? fallback.roundness,
      titleStyle: titleStyle ?? fallback.titleStyle,
      descriptionStyle: descriptionStyle ?? fallback.descriptionStyle,
      descriptionColor: descriptionColor ?? fallback.descriptionColor,
      duration: duration ?? fallback.duration,
      animationStyle: animationStyle ?? fallback.animationStyle,
      shapeStyle: shapeStyle ?? fallback.shapeStyle,
      bodyAnimationStyle: bodyAnimationStyle ?? fallback.bodyAnimationStyle,
      enableGooeyBlur: enableGooeyBlur ?? fallback.enableGooeyBlur,
      compactMorph: compactMorph ?? fallback.compactMorph,
      successTone: successTone ?? fallback.successTone,
      loadingTone: loadingTone ?? fallback.loadingTone,
      errorTone: errorTone ?? fallback.errorTone,
      warningTone: warningTone ?? fallback.warningTone,
      infoTone: infoTone ?? fallback.infoTone,
      actionTone: actionTone ?? fallback.actionTone,
    );
  }

  /// Colours, styles and flags step at `t < 0.5`; dimensions interpolate.
  static GooeyToastTheme lerp(GooeyToastTheme a, GooeyToastTheme b, double t) {
    return GooeyToastTheme(
      themeDensity: t < 0.5 ? a.themeDensity : b.themeDensity,
      themeSpacing: t < 0.5 ? a.themeSpacing : b.themeSpacing,
      themeShadows: t < 0.5 ? a.themeShadows : b.themeShadows,
      width: lerpDouble(a.width, b.width, t),
      fill: t < 0.5 ? a.fill : b.fill,
      roundness: lerpDouble(a.roundness, b.roundness, t),
      titleStyle: TextStyle.lerp(a.titleStyle, b.titleStyle, t),
      descriptionStyle: TextStyle.lerp(
        a.descriptionStyle,
        b.descriptionStyle,
        t,
      ),
      descriptionColor: t < 0.5 ? a.descriptionColor : b.descriptionColor,
      duration: t < 0.5 ? a.duration : b.duration,
      animationStyle: t < 0.5 ? a.animationStyle : b.animationStyle,
      shapeStyle: t < 0.5 ? a.shapeStyle : b.shapeStyle,
      bodyAnimationStyle: t < 0.5 ? a.bodyAnimationStyle : b.bodyAnimationStyle,
      enableGooeyBlur: t < 0.5 ? a.enableGooeyBlur : b.enableGooeyBlur,
      compactMorph: t < 0.5 ? a.compactMorph : b.compactMorph,
      successTone: t < 0.5 ? a.successTone : b.successTone,
      loadingTone: t < 0.5 ? a.loadingTone : b.loadingTone,
      errorTone: t < 0.5 ? a.errorTone : b.errorTone,
      warningTone: t < 0.5 ? a.warningTone : b.warningTone,
      infoTone: t < 0.5 ? a.infoTone : b.infoTone,
      actionTone: t < 0.5 ? a.actionTone : b.actionTone,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is GooeyToastTheme &&
        other.themeDensity == themeDensity &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.width == width &&
        other.fill == fill &&
        other.roundness == roundness &&
        other.titleStyle == titleStyle &&
        other.descriptionStyle == descriptionStyle &&
        other.descriptionColor == descriptionColor &&
        other.duration == duration &&
        other.animationStyle == animationStyle &&
        other.shapeStyle == shapeStyle &&
        other.bodyAnimationStyle == bodyAnimationStyle &&
        other.enableGooeyBlur == enableGooeyBlur &&
        other.compactMorph == compactMorph &&
        other.successTone == successTone &&
        other.loadingTone == loadingTone &&
        other.errorTone == errorTone &&
        other.warningTone == warningTone &&
        other.infoTone == infoTone &&
        other.actionTone == actionTone;
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[
    themeDensity,
    themeSpacing,
    themeShadows,
    width,
    fill,
    roundness,
    titleStyle,
    descriptionStyle,
    descriptionColor,
    duration,
    animationStyle,
    shapeStyle,
    bodyAnimationStyle,
    enableGooeyBlur,
    compactMorph,
    successTone,
    loadingTone,
    errorTone,
    warningTone,
    infoTone,
    actionTone,
  ]);
}

/// Token-derived baseline; every unset override field falls through here. The
/// status tones are the fixed [gooeySuccessTone] family: the reference hues,
/// stable across presets and modes.
const GooeyToastTheme gooeyToastDefaults = GooeyToastTheme(
  width: 350,
  fill: ThemedColor.value(gooeySurfaceFill),
  roundness: 18,
  titleStyle: gooeyTitleTextStyle,
  descriptionStyle: gooeyDescriptionTextStyle,
  descriptionColor: ThemedColor.ref(ColorRef.mutedForeground),
  duration: Duration(milliseconds: 6000),
  animationStyle: GooeyToastAnimationStyle.sileo,
  shapeStyle: GooeyToastShapeStyle.defaultShape,
  bodyAnimationStyle: GooeyToastBodyAnimationStyle.fade,
  enableGooeyBlur: true,
  compactMorph: GooeyCompactMorph(),
  successTone: ThemedColor.value(gooeySuccessTone),
  loadingTone: ThemedColor.value(gooeyLoadingTone),
  errorTone: ThemedColor.value(gooeyErrorTone),
  warningTone: ThemedColor.value(gooeyWarningTone),
  infoTone: ThemedColor.value(gooeyInfoTone),
  actionTone: ThemedColor.value(gooeyActionTone),
);
