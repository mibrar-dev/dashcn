// Registry-owned theme data for the `overflow_marquee` component: the
// [OverflowMarqueeTheme] container and `overflowMarqueeDefaults`.
// User-owned overrides live in `overflow_marquee_theme.dart`. All defaults
// are plain values, so the default theme stays const and resolves at build.

import 'dart:ui' show lerpDouble;

import 'package:flutter/widgets.dart';

import '../../foundation/geometry.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';

export '../../foundation/geometry.dart' show AxisDirectional;

/// Direction, speed, gap, and edge fade of one marquee.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class OverflowMarqueeTheme extends ComponentThemeData
    implements Mergeable<OverflowMarqueeTheme> {
  /// Creates a marquee theme.
  const OverflowMarqueeTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.direction,
    this.speed,
    this.gap,
    this.pauseOnHover,
    this.pauseOnFocus,
    this.loop,
    this.duration,
    this.delayDuration,
    this.step,
    this.fadePortion,
    this.curve,
  });

  /// Direction of the marquee scroll; null resolves `AxisDirectional.start`.
  final AxisDirectional? direction;

  /// Scroll speed in pixels per second; null resolves `50.0`.
  final double? speed;

  /// Space between repeating looped instances; null resolves `24.0`.
  final double? gap;

  /// Whether to pause scrolling on pointer hover; null resolves `true`.
  final bool? pauseOnHover;

  /// Whether to pause scrolling on keyboard focus; null resolves `true`.
  final bool? pauseOnFocus;

  /// Whether the marquee loops continuously; null resolves `true`.
  final bool? loop;

  /// Time of one [step] run; null resolves `1s`.
  final Duration? duration;

  /// Pause at each end of a run; null resolves `500ms`.
  final Duration? delayDuration;

  /// Pixels per [duration]; null resolves `100`.
  final double? step;

  /// Edge fade as a fraction of the visible extent; null resolves `0.1`.
  final double? fadePortion;

  /// Easing of each run; null resolves `Curves.linear`.
  final Curve? curve;

  /// Returns a copy with the given fields replaced.
  OverflowMarqueeTheme copyWith({
    ValueGetter<AxisDirectional?>? direction,
    ValueGetter<double?>? speed,
    ValueGetter<double?>? gap,
    ValueGetter<bool?>? pauseOnHover,
    ValueGetter<bool?>? pauseOnFocus,
    ValueGetter<bool?>? loop,
    ValueGetter<Duration?>? duration,
    ValueGetter<Duration?>? delayDuration,
    ValueGetter<double?>? step,
    ValueGetter<double?>? fadePortion,
    ValueGetter<Curve?>? curve,
  }) => OverflowMarqueeTheme(
    themeDensity: themeDensity,
    themeSpacing: themeSpacing,
    themeShadows: themeShadows,
    direction: direction == null ? this.direction : direction(),
    speed: speed == null ? this.speed : speed(),
    gap: gap == null ? this.gap : gap(),
    pauseOnHover: pauseOnHover == null ? this.pauseOnHover : pauseOnHover(),
    pauseOnFocus: pauseOnFocus == null ? this.pauseOnFocus : pauseOnFocus(),
    loop: loop == null ? this.loop : loop(),
    duration: duration == null ? this.duration : duration(),
    delayDuration: delayDuration == null ? this.delayDuration : delayDuration(),
    step: step == null ? this.step : step(),
    fadePortion: fadePortion == null ? this.fadePortion : fadePortion(),
    curve: curve == null ? this.curve : curve(),
  );

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  OverflowMarqueeTheme merge(OverflowMarqueeTheme? fallback) => fallback == null
      ? this
      : OverflowMarqueeTheme(
          themeDensity: themeDensity ?? fallback.themeDensity,
          themeSpacing: themeSpacing ?? fallback.themeSpacing,
          themeShadows: themeShadows ?? fallback.themeShadows,
          direction: direction ?? fallback.direction,
          speed: speed ?? fallback.speed,
          gap: gap ?? fallback.gap,
          pauseOnHover: pauseOnHover ?? fallback.pauseOnHover,
          pauseOnFocus: pauseOnFocus ?? fallback.pauseOnFocus,
          loop: loop ?? fallback.loop,
          duration: duration ?? fallback.duration,
          delayDuration: delayDuration ?? fallback.delayDuration,
          step: step ?? fallback.step,
          fadePortion: fadePortion ?? fallback.fadePortion,
          curve: curve ?? fallback.curve,
        );

  /// Discrete values step at t < 0.5; scalars are lerped.
  static OverflowMarqueeTheme lerp(
    OverflowMarqueeTheme a,
    OverflowMarqueeTheme b,
    double t,
  ) => OverflowMarqueeTheme(
    themeDensity: t < 0.5 ? a.themeDensity : b.themeDensity,
    themeSpacing: t < 0.5 ? a.themeSpacing : b.themeSpacing,
    themeShadows: t < 0.5 ? a.themeShadows : b.themeShadows,
    direction: t < 0.5 ? a.direction : b.direction,
    speed: lerpDouble(a.speed, b.speed, t),
    gap: lerpDouble(a.gap, b.gap, t),
    pauseOnHover: t < 0.5 ? a.pauseOnHover : b.pauseOnHover,
    pauseOnFocus: t < 0.5 ? a.pauseOnFocus : b.pauseOnFocus,
    loop: t < 0.5 ? a.loop : b.loop,
    duration: t < 0.5 ? a.duration : b.duration,
    delayDuration: t < 0.5 ? a.delayDuration : b.delayDuration,
    step: lerpDouble(a.step, b.step, t),
    fadePortion: lerpDouble(a.fadePortion, b.fadePortion, t),
    curve: t < 0.5 ? a.curve : b.curve,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OverflowMarqueeTheme &&
          other.themeDensity == themeDensity &&
          other.themeSpacing == themeSpacing &&
          other.themeShadows == themeShadows &&
          other.direction == direction &&
          other.speed == speed &&
          other.gap == gap &&
          other.pauseOnHover == pauseOnHover &&
          other.pauseOnFocus == pauseOnFocus &&
          other.loop == loop &&
          other.duration == duration &&
          other.delayDuration == delayDuration &&
          other.step == step &&
          other.fadePortion == fadePortion &&
          other.curve == curve);

  @override
  int get hashCode => Object.hash(
    themeDensity,
    themeSpacing,
    themeShadows,
    direction,
    speed,
    gap,
    pauseOnHover,
    pauseOnFocus,
    loop,
    duration,
    delayDuration,
    step,
    fadePortion,
    curve,
  );
}

/// Token-derived baseline; every unset override field falls through here.
const OverflowMarqueeTheme overflowMarqueeDefaults = OverflowMarqueeTheme(
  direction: AxisDirectional.start,
  speed: 50.0,
  gap: 24.0,
  pauseOnHover: true,
  pauseOnFocus: true,
  loop: true,
  duration: Duration(seconds: 1),
  delayDuration: Duration(milliseconds: 500),
  step: 100.0,
  fadePortion: 0.1,
);

/// Resolved geometry and playback settings for one marquee build.
class MarqueeSurface {
  /// Creates a resolved surface.
  const MarqueeSurface({
    required this.direction,
    required this.speed,
    required this.gap,
    required this.pauseOnHover,
    required this.pauseOnFocus,
    required this.loop,
    required this.duration,
    required this.delayDuration,
    required this.step,
    required this.fadePortion,
    required this.curve,
    required this.fadeColor,
  });

  /// Direction of the marquee scroll (start/end/up/down).
  final AxisDirectional direction;

  /// Scroll speed in pixels per second.
  final double speed;

  /// Gap between looping instances in pixels.
  final double gap;

  /// Whether to pause when hovered.
  final bool pauseOnHover;

  /// Whether to pause when keyboard focused.
  final bool pauseOnFocus;

  /// Whether to continuously loop.
  final bool loop;

  /// Time of one `step` run.
  final Duration duration;

  /// Pause at each end (legacy).
  final Duration delayDuration;

  /// Pixels per [duration].
  final double step;

  /// Edge fade as a fraction of the visible extent.
  final double fadePortion;

  /// Easing of each run.
  final Curve curve;

  /// Colour the edge fade blends into; ambient `background` token.
  final Color fadeColor;

  /// Resolves the axis corresponding to [direction].
  Axis get axis =>
      (direction == AxisDirectional.up || direction == AxisDirectional.down)
      ? Axis.vertical
      : Axis.horizontal;
}

/// Resolves the four theme legs plus widget-leg overrides into concrete
/// build values. Accepts either [AxisDirectional] or legacy [Axis] for [direction].
MarqueeSurface resolveMarqueeSurface(
  BuildContext context, {
  OverflowMarqueeTheme? widgetTheme,
  Object? direction,
  double? speed,
  double? gap,
  bool? pauseOnHover,
  bool? pauseOnFocus,
  bool? loop,
  Duration? duration,
  Duration? delayDuration,
  double? step,
  double? fadePortion,
  Curve? curve,
}) {
  final OverflowMarqueeTheme resolved =
      resolveComponentStyle<OverflowMarqueeTheme, OverflowMarqueeTheme>(
        context,
        widget: widgetTheme,
        select: (t) => t,
        defaults: overflowMarqueeDefaults,
      );

  // Normalize direction from Object? (AxisDirectional or Axis)
  final AxisDirectional resolvedDirection = switch (direction) {
    AxisDirectional d => d,
    Axis.vertical => AxisDirectional.up,
    Axis.horizontal => AxisDirectional.start,
    _ => resolved.direction ?? AxisDirectional.start,
  };

  final Duration effDuration =
      duration ?? resolved.duration ?? const Duration(seconds: 1);
  final double effStep = step ?? resolved.step ?? 100.0;

  final double effSpeed =
      speed ??
      resolved.speed ??
      (effDuration.inMicroseconds > 0
          ? (effStep / effDuration.inMicroseconds) * 1000000.0
          : 50.0);

  return MarqueeSurface(
    direction: resolvedDirection,
    speed: effSpeed,
    gap: gap ?? resolved.gap ?? 24.0,
    pauseOnHover: pauseOnHover ?? resolved.pauseOnHover ?? true,
    pauseOnFocus: pauseOnFocus ?? resolved.pauseOnFocus ?? true,
    loop: loop ?? resolved.loop ?? true,
    duration: effDuration,
    delayDuration:
        delayDuration ??
        resolved.delayDuration ??
        const Duration(milliseconds: 500),
    step: effStep,
    fadePortion: (fadePortion ?? resolved.fadePortion ?? 0.1).clamp(0.0, 0.5),
    curve: curve ?? resolved.curve ?? Curves.linear,
    fadeColor: Theme.of(context).colors.background,
  );
}
