// Registry-owned theme data for the `skeleton` component: the [SkeletonTheme]
// container and the token-derived `skeletonDefaults`.
//
// User-owned overrides live in `skeleton_theme.dart`; CLI updates may replace
// this file.
//
// Shape sizes resolve from the density scale (compact default): a text line
// is one body step tall, an avatar is one control tall, rows are one row
// step tall. Every size field below is an override; null follows the
// ambient [DensityTokens] so presets and phone widths retime all shapes
// from one place.

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';

/// Per-instance style alias for [SkeletonTheme].
typedef SkeletonStyle = SkeletonTheme;

/// Visual contract of one skeleton placeholder.
class SkeletonTheme extends ComponentThemeData
    implements Mergeable<SkeletonTheme> {
  /// Creates a skeleton theme.
  const SkeletonTheme({
    super.themeDensity,
    super.themeDensityTokens,
    super.themeSpacing,
    super.themeShadows,
    this.fromColor,
    this.toColor,
    this.duration,
    this.curve,
    this.borderRadius,
    this.lineHeight,
    this.lineGap,
    this.avatarSize,
    this.rowHeight,
    this.surfaceOpacity,
    this.surfaceBlur,
  });

  /// Leading fill of the shimmer sweep; null resolves the `muted` token.
  final ThemedColor? fromColor;

  /// Trailing fill of the shimmer sweep; null resolves the `accent` token.
  final ThemedColor? toColor;

  /// Length of one sweep; null resolves [kSkeletonSweepDuration].
  ///
  /// The winning value is scaled by the theme motion intensity
  /// (`MotionTokens.scaledDuration`) and collapses to zero under reduced
  /// motion, so the placeholder parks mid-sweep with no ticker.
  final Duration? duration;

  /// Sweep easing; null resolves the motion `standard` curve.
  final Curve? curve;

  /// Corner radius of the placeholder; null resolves `radiusMd`.
  final BorderRadiusGeometry? borderRadius;

  /// Height of one [SkeletonLine] bar; null resolves the density
  /// `bodyTextSize` (14 compact, 15 comfortable, 16 touch).
  final double? lineHeight;

  /// Gap between [SkeletonLine] bars; null resolves the density `gap`
  /// (8 compact, 10 comfortable, 12 touch).
  final double? lineGap;

  /// Diameter of [SkeletonAvatar]; null resolves the density
  /// `controlHeight` (32 compact, 40 comfortable, 48 touch).
  final double? avatarSize;

  /// Minimum height of [SkeletonList] rows and [SkeletonTable] rows;
  /// null resolves the density `rowMinHeight` (32/40/48).
  final double? rowHeight;

  /// Surface fill opacity for [SkeletonCard]; null follows the ambient
  /// `ThemeData.surfaceOpacity` through the shared surface primitive.
  final double? surfaceOpacity;

  /// Frosted-glass blur sigma for [SkeletonCard]; null follows the ambient
  /// `ThemeData.surfaceBlur` through `GlassSurface`.
  final double? surfaceBlur;

  /// Returns a copy with the given fields replaced.
  SkeletonTheme copyWith({
    ValueGetter<ThemedColor?>? fromColor,
    ValueGetter<ThemedColor?>? toColor,
    ValueGetter<Duration?>? duration,
    ValueGetter<Curve?>? curve,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<double?>? lineHeight,
    ValueGetter<double?>? lineGap,
    ValueGetter<double?>? avatarSize,
    ValueGetter<double?>? rowHeight,
    ValueGetter<double?>? surfaceOpacity,
    ValueGetter<double?>? surfaceBlur,
  }) {
    return SkeletonTheme(
      themeDensity: themeDensity,
      themeDensityTokens: themeDensityTokens,
      themeSpacing: themeSpacing,
      themeShadows: themeShadows,
      fromColor: fromColor == null ? this.fromColor : fromColor(),
      toColor: toColor == null ? this.toColor : toColor(),
      duration: duration == null ? this.duration : duration(),
      curve: curve == null ? this.curve : curve(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      lineHeight: lineHeight == null ? this.lineHeight : lineHeight(),
      lineGap: lineGap == null ? this.lineGap : lineGap(),
      avatarSize: avatarSize == null ? this.avatarSize : avatarSize(),
      rowHeight: rowHeight == null ? this.rowHeight : rowHeight(),
      surfaceOpacity: surfaceOpacity == null
          ? this.surfaceOpacity
          : surfaceOpacity(),
      surfaceBlur: surfaceBlur == null ? this.surfaceBlur : surfaceBlur(),
    );
  }

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  SkeletonTheme merge(SkeletonTheme? fallback) {
    if (fallback == null) {
      return this;
    }
    return SkeletonTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeDensityTokens: themeDensityTokens ?? fallback.themeDensityTokens,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      fromColor: fromColor ?? fallback.fromColor,
      toColor: toColor ?? fallback.toColor,
      duration: duration ?? fallback.duration,
      curve: curve ?? fallback.curve,
      borderRadius: borderRadius ?? fallback.borderRadius,
      lineHeight: lineHeight ?? fallback.lineHeight,
      lineGap: lineGap ?? fallback.lineGap,
      avatarSize: avatarSize ?? fallback.avatarSize,
      rowHeight: rowHeight ?? fallback.rowHeight,
      surfaceOpacity: surfaceOpacity ?? fallback.surfaceOpacity,
      surfaceBlur: surfaceBlur ?? fallback.surfaceBlur,
    );
  }

  /// State scales step at t < 0.5; dimensions and durations lerp.
  static SkeletonTheme lerp(SkeletonTheme a, SkeletonTheme b, double t) {
    double? l(double? x, double? y) =>
        x == null || y == null ? (t < 0.5 ? x : y) : x + (y - x) * t;
    return SkeletonTheme(
      themeDensity: t < 0.5 ? a.themeDensity : b.themeDensity,
      themeDensityTokens: t < 0.5 ? a.themeDensityTokens : b.themeDensityTokens,
      themeSpacing: t < 0.5 ? a.themeSpacing : b.themeSpacing,
      themeShadows: t < 0.5 ? a.themeShadows : b.themeShadows,
      fromColor: t < 0.5 ? a.fromColor : b.fromColor,
      toColor: t < 0.5 ? a.toColor : b.toColor,
      duration: t < 0.5 ? a.duration : b.duration,
      curve: t < 0.5 ? a.curve : b.curve,
      borderRadius: BorderRadiusGeometry.lerp(
        a.borderRadius,
        b.borderRadius,
        t,
      ),
      lineHeight: l(a.lineHeight, b.lineHeight),
      lineGap: l(a.lineGap, b.lineGap),
      avatarSize: l(a.avatarSize, b.avatarSize),
      rowHeight: l(a.rowHeight, b.rowHeight),
      surfaceOpacity: l(a.surfaceOpacity, b.surfaceOpacity),
      surfaceBlur: l(a.surfaceBlur, b.surfaceBlur),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is SkeletonTheme &&
        other.themeDensity == themeDensity &&
        other.themeDensityTokens == themeDensityTokens &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.fromColor == fromColor &&
        other.toColor == toColor &&
        other.duration == duration &&
        other.curve == curve &&
        other.borderRadius == borderRadius &&
        other.lineHeight == lineHeight &&
        other.lineGap == lineGap &&
        other.avatarSize == avatarSize &&
        other.rowHeight == rowHeight &&
        other.surfaceOpacity == surfaceOpacity &&
        other.surfaceBlur == surfaceBlur;
  }

  @override
  int get hashCode => Object.hash(
    themeDensity,
    themeDensityTokens,
    themeSpacing,
    themeShadows,
    fromColor,
    toColor,
    duration,
    curve,
    borderRadius,
    lineHeight,
    lineGap,
    avatarSize,
    rowHeight,
    surfaceOpacity,
    surfaceBlur,
  );
}

/// One full sweep (1.5 s linear loop). The old `SkeletonThemeDefaults.duration` was one second for
/// a `Skeletonizer` `PulseEffect`, which sweeps 0 -> 1 -> 0, so one visual
/// pass took half of that.
const Duration kSkeletonSweepDuration = Duration(milliseconds: 1500);

/// Token-derived baseline; every unset override field falls through here.
const SkeletonTheme skeletonDefaults = SkeletonTheme(
  fromColor: ThemedColor.ref(ColorRef.muted),
  toColor: ThemedColor.ref(ColorRef.accent),
  duration: kSkeletonSweepDuration,
  curve: Curves.linear,
);

/// The sweep fraction at which [SkeletonTheme.fromColor] hands over to
/// [SkeletonTheme.toColor] and starts travelling back.
const double kSkeletonSweepHandover = 0.5;

/// Extra length used to fade the sweep in and out at both ends.
const double kSkeletonSweepFade = 0.15;
