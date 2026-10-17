// Motion tokens: durations, curves and the enabled flag.
// Every component animation in the kit resolves its timing through
// MotionTokens, read as Theme.of(context).motion. Durations stay in the
// subtle/fast band (100-300 ms); curves are restrained except the spring
// curve, which adds a small overshoot for press-release and pop-in effects.
// When MotionTokens.enabled is false — or the platform reports reduced
// motion via MediaQuery.disableAnimations — every helper in
// primitives/motion/ collapses to zero duration and the end value, so the
// final state is identical with no tickers or timers running. Preset JSON
// files carry no motion values; the defaults below apply.

import 'package:flutter/widgets.dart';

/// Named durations for component motion.
///
/// All values sit in the subtle band: instant 100 ms, fast 150 ms,
/// base 200 ms, slow 300 ms.
@immutable
class MotionDurations {
  /// Creates motion durations.
  const MotionDurations({
    this.instant = const Duration(milliseconds: 100),
    this.fast = const Duration(milliseconds: 150),
    this.base = const Duration(milliseconds: 200),
    this.slow = const Duration(milliseconds: 300),
  });

  /// Press feedback and other immediate responses.
  final Duration instant;

  /// Focus rings, hover lifts and small fades.
  final Duration fast;

  /// Default enter/exit and expand transitions.
  final Duration base;

  /// Edge sheets, drawers and other travelling surfaces.
  final Duration slow;

  /// Returns a copy with the given fields replaced.
  MotionDurations copyWith({
    Duration? instant,
    Duration? fast,
    Duration? base,
    Duration? slow,
  }) {
    return MotionDurations(
      instant: instant ?? this.instant,
      fast: fast ?? this.fast,
      base: base ?? this.base,
      slow: slow ?? this.slow,
    );
  }

  /// Discrete lerp: durations step at the midpoint.
  static MotionDurations lerp(MotionDurations a, MotionDurations b, double t) {
    return t < 0.5 ? a : b;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MotionDurations &&
        other.instant == instant &&
        other.fast == fast &&
        other.base == base &&
        other.slow == slow;
  }

  @override
  int get hashCode => Object.hash(instant, fast, base, slow);
}

/// A spring-ish overshoot curve for press-release and pop-in effects.
///
/// A subtle ease-out-back: the value settles past 1 by a few percent and
/// comes back, which reads as a spring without a physics simulation.
/// [overshoot] tunes the peak (1.2 keeps it restrained).
@immutable
class MotionSpringCurve extends Curve {
  /// Creates a spring overshoot curve.
  const MotionSpringCurve([this.overshoot = 1.2]);

  /// Overshoot amount; 1.2 peaks a few percent past the end value.
  final double overshoot;

  @override
  double transformInternal(double t) {
    final double u = t - 1.0;
    return 1.0 + (overshoot + 1.0) * u * u * u + overshoot * u * u;
  }
}

/// Named curves for component motion.
@immutable
class MotionCurves {
  /// Creates motion curves.
  const MotionCurves({
    this.standard = const Cubic(0.4, 0.0, 0.2, 1.0),
    this.emphasizedOut = const Cubic(0.05, 0.7, 0.1, 1.0),
    this.emphasizedIn = const Cubic(0.3, 0.0, 0.8, 0.15),
    this.spring = const MotionSpringCurve(),
  });

  /// Default curve for state changes (press, toggle, focus).
  final Curve standard;

  /// Enter transitions (popovers, dialogs, toasts, alerts).
  final Curve emphasizedOut;

  /// Exit transitions (dialogs, popovers, toasts).
  final Curve emphasizedIn;

  /// Spring-ish overshoot for press-release and pop-in effects.
  final Curve spring;

  /// Returns a copy with the given fields replaced.
  MotionCurves copyWith({
    Curve? standard,
    Curve? emphasizedOut,
    Curve? emphasizedIn,
    Curve? spring,
  }) {
    return MotionCurves(
      standard: standard ?? this.standard,
      emphasizedOut: emphasizedOut ?? this.emphasizedOut,
      emphasizedIn: emphasizedIn ?? this.emphasizedIn,
      spring: spring ?? this.spring,
    );
  }

  /// Discrete lerp: curves step at the midpoint.
  static MotionCurves lerp(MotionCurves a, MotionCurves b, double t) {
    return t < 0.5 ? a : b;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MotionCurves &&
        other.standard == standard &&
        other.emphasizedOut == emphasizedOut &&
        other.emphasizedIn == emphasizedIn &&
        other.spring == spring;
  }

  @override
  int get hashCode =>
      Object.hash(standard, emphasizedOut, emphasizedIn, spring);
}

/// Motion configuration for the ambient theme.
///
/// Read as `Theme.of(context).motion`. Durations and curves carry the
/// defaults above; [enabled] is the Theme Studio motion toggle. When false,
/// every motion helper resolves to zero duration and the end value.
@immutable
class MotionTokens {
  /// Creates motion tokens.
  const MotionTokens({
    this.durations = const MotionDurations(),
    this.curves = const MotionCurves(),
    this.enabled = true,
  });

  /// Named durations (100/150/200/300 ms).
  final MotionDurations durations;

  /// Named curves (standard, emphasized-out/in, spring).
  final MotionCurves curves;

  /// Master switch. False collapses every animation to its end value.
  final bool enabled;

  /// Returns a copy with the given fields replaced.
  MotionTokens copyWith({
    MotionDurations? durations,
    MotionCurves? curves,
    bool? enabled,
  }) {
    return MotionTokens(
      durations: durations ?? this.durations,
      curves: curves ?? this.curves,
      enabled: enabled ?? this.enabled,
    );
  }

  /// Discrete lerp: motion configuration steps at the midpoint.
  static MotionTokens lerp(MotionTokens a, MotionTokens b, double t) {
    if (t <= 0.0) return a;
    if (t >= 1.0) return b;
    return t < 0.5 ? a : b;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MotionTokens &&
        other.durations == durations &&
        other.curves == curves &&
        other.enabled == enabled;
  }

  @override
  int get hashCode => Object.hash(durations, curves, enabled);
}
