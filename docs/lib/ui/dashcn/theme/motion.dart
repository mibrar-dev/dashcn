// Motion tokens: durations, curves, intensity and the enabled flag.
// Every component animation in the kit resolves its timing through
// MotionTokens, read as Theme.of(context).motion. Durations stay in the
// subtle/fast band (100-300 ms); curves are restrained except the spring
// curve, which adds a small overshoot for press-release and pop-in effects.
// When MotionTokens.enabled is false — or the platform reports reduced
// motion via MediaQuery.disableAnimations — every helper in
// primitives/motion/ collapses to zero duration and the end value, so the
// final state is identical with no tickers or timers running. Preset JSON
// files carry no motion values; the defaults below apply.
//
// Intensity scales every animation from one place: [MotionIntensity.standard]
// is today's values (the default). Subtle shortens and softens, expressive
// lengthens and deepens, custom uses the explicit custom legs. See
// [MotionTokens.durationMultiplier], [MotionTokens.pressScale],
// [MotionTokens.enterOffset] and [MotionTokens.resolveEnterCurve].

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

/// Motion intensity: how much animation the theme applies.
///
/// Standard is today's values (the default). Subtle shortens and softens,
/// expressive lengthens and deepens, custom uses the explicit custom legs
/// on [MotionTokens]. Multipliers live in one place
/// ([MotionTokens.durationMultiplier], [MotionTokens.pressScale],
/// [MotionTokens.enterOffset]).
enum MotionIntensity {
  /// Shorter, softer motion (0.75x durations, 0.98 press, 4 px enter).
  subtle,

  /// Today's values (1.0x durations, 0.96 press, 8 px enter). The default.
  standard,

  /// Longer, deeper motion (1.5x durations, 0.94 press, 12 px enter).
  expressive,

  /// Explicit custom legs on [MotionTokens].
  custom,
}

/// Curve choice for the custom intensity leg.
///
/// Stored by name so it round-trips through the theme document JSON and the
/// Get Code Dart export. Resolved against [MotionCurves] by
/// [MotionTokens.resolveEnterCurve].
enum MotionCurveName {
  /// Default state-change ease.
  standard,

  /// Default enter ease.
  emphasizedOut,

  /// Default exit ease.
  emphasizedIn,

  /// Spring overshoot.
  spring;

  /// Parses a serialised name; unknown names fall back to emphasized-out.
  static MotionCurveName parse(String? name) {
    return switch (name) {
      'standard' => MotionCurveName.standard,
      'emphasizedIn' => MotionCurveName.emphasizedIn,
      'spring' => MotionCurveName.spring,
      'emphasizedOut' || _ => MotionCurveName.emphasizedOut,
    };
  }

  /// Serialised name for the theme document and the Dart export.
  String get wireName => switch (this) {
    MotionCurveName.standard => 'standard',
    MotionCurveName.emphasizedOut => 'emphasizedOut',
    MotionCurveName.emphasizedIn => 'emphasizedIn',
    MotionCurveName.spring => 'spring',
  };

  /// Resolves the choice against [curves].
  Curve resolve(MotionCurves curves) {
    return switch (this) {
      MotionCurveName.standard => curves.standard,
      MotionCurveName.emphasizedOut => curves.emphasizedOut,
      MotionCurveName.emphasizedIn => curves.emphasizedIn,
      MotionCurveName.spring => curves.spring,
    };
  }
}

/// Motion configuration for the ambient theme.
///
/// Read as `Theme.of(context).motion`. Durations and curves carry the
/// defaults above; [enabled] is the Theme Studio motion toggle. When false,
/// every motion helper resolves to zero duration and the end value.
/// [intensity] scales every animation from one place; [customDurationMultiplier],
/// [customPressScale], [customEnterOffset] and [customCurve] apply only when
/// [intensity] is [MotionIntensity.custom]. The category legs
/// ([overlayEnterDuration], [overlayExitDuration], [stateDuration] and the
/// three category curves) retime one family of animations from one place;
/// null keeps the component's own default, so adding them never changes
/// today's timing until a user sets a leg.
@immutable
class MotionTokens {
  /// Creates motion tokens.
  const MotionTokens({
    this.durations = const MotionDurations(),
    this.curves = const MotionCurves(),
    this.enabled = true,
    this.intensity = MotionIntensity.standard,
    this.customDurationMultiplier = 1.0,
    this.customPressScale = 0.96,
    this.customEnterOffset = 8.0,
    this.customCurve = MotionCurveName.emphasizedOut,
    this.overlayEnterDuration,
    this.overlayExitDuration,
    this.stateDuration,
    this.overlayEnterCurve,
    this.overlayExitCurve,
    this.stateCurve,
  });

  /// Named durations (100/150/200/300 ms) before the intensity multiplier.
  final MotionDurations durations;

  /// Named curves (standard, emphasized-out/in, spring).
  final MotionCurves curves;

  /// Master switch. False collapses every animation to its end value.
  final bool enabled;

  /// How much animation applies. Defaults to standard (today's values).
  final MotionIntensity intensity;

  /// Duration multiplier used only for [MotionIntensity.custom].
  final double customDurationMultiplier;

  /// Press scale used only for [MotionIntensity.custom].
  final double customPressScale;

  /// Enter offset in logical px used only for [MotionIntensity.custom].
  final double customEnterOffset;

  /// Enter curve used only for [MotionIntensity.custom].
  final MotionCurveName customCurve;

  /// Category leg: how long overlay ENTER transitions run (popovers, dialogs,
  /// toasts, sheets). Null keeps each component's own default.
  final Duration? overlayEnterDuration;

  /// Category leg: how long overlay EXIT transitions run. Null keeps each
  /// component's own default.
  final Duration? overlayExitDuration;

  /// Category leg: how long state-change transitions run (toggles, checks,
  /// tabs, progress, badge/chip paint, error show/hide). Null keeps each
  /// component's own default.
  final Duration? stateDuration;

  /// Category leg: curve for overlay ENTER transitions. Null keeps the
  /// component default (usually emphasized-out).
  final Curve? overlayEnterCurve;

  /// Category leg: curve for overlay EXIT transitions. Null keeps the
  /// component default (usually emphasized-in).
  final Curve? overlayExitCurve;

  /// Category leg: curve for state-change transitions. Null keeps the
  /// component default (usually standard).
  final Curve? stateCurve;

  /// Duration multiplier for the current intensity, in one place.
  ///
  /// Subtle 0.75x, standard 1.0x, expressive 1.5x, custom the explicit leg.
  double get durationMultiplier {
    return switch (intensity) {
      MotionIntensity.subtle => 0.75,
      MotionIntensity.standard => 1.0,
      MotionIntensity.expressive => 1.5,
      MotionIntensity.custom => customDurationMultiplier,
    };
  }

  /// Press scale for the current intensity, in one place.
  ///
  /// Subtle 0.98, standard 0.96, expressive 0.94, custom the explicit leg.
  /// Clamped to 0.8..1.0 so a custom document cannot invert or hide content.
  double get pressScale {
    final double raw = switch (intensity) {
      MotionIntensity.subtle => 0.98,
      MotionIntensity.standard => 0.96,
      MotionIntensity.expressive => 0.94,
      MotionIntensity.custom => customPressScale,
    };
    return raw.clamp(0.8, 1.0).toDouble();
  }

  /// Enter offset in logical px for the current intensity, in one place.
  ///
  /// Subtle 4 px, standard 8 px, expressive 12 px, custom the explicit leg.
  /// Clamped to 0..24 px so a custom document cannot throw content off-screen.
  double get enterOffset {
    final double raw = switch (intensity) {
      MotionIntensity.subtle => 4.0,
      MotionIntensity.standard => 8.0,
      MotionIntensity.expressive => 12.0,
      MotionIntensity.custom => customEnterOffset,
    };
    return raw.clamp(0.0, 24.0).toDouble();
  }

  /// Scales [base] by the intensity duration multiplier.
  Duration scaledDuration(Duration base) {
    final int micros = (base.inMicroseconds * durationMultiplier).round();
    return Duration(microseconds: micros < 0 ? 0 : micros);
  }

  /// Scales an enter [offset] proportionally to the intensity enter offset.
  ///
  /// The standard 8 px is the reference: subtle halves every slide, expressive
  /// grows it by half, custom scales by `customEnterOffset / 8`. Zero stays
  /// zero so centred grows (dialogs) never drift.
  Offset scaledOffset(Offset base) {
    if (base == Offset.zero) {
      return base;
    }
    return base * (enterOffset / 8.0);
  }

  /// Effective begin scale for scale-and-fade enters (popovers, dialogs).
  ///
  /// Derived from the press scale in one place: `1 - (1 - pressScale)`.
  /// Standard gives 0.96, subtle 0.98, expressive 0.94, custom the custom leg.
  double get enterBeginScale => pressScale;

  /// Resolves the enter curve for the current intensity.
  ///
  /// Custom uses [customCurve]; every preset keeps the caller's [base]
  /// (usually emphasized-out). Pass the widget's explicit curve as [base]
  /// and the override as [override]: an explicit widget leg always wins.
  Curve resolveEnterCurve(Curve base, {Curve? override}) {
    if (override != null) {
      return override;
    }
    if (intensity == MotionIntensity.custom) {
      return customCurve.resolve(curves);
    }
    return base;
  }

  /// Resolves an overlay ENTER duration from one place.
  ///
  /// Precedence: explicit per-instance leg, then the theme category leg
  /// ([overlayEnterDuration]), then the caller's [base] (each overlay keeps
  /// its own default, so unset legs reproduce today's timing exactly).
  /// The winner scales with the intensity multiplier.
  Duration resolveOverlayEnterDuration(Duration base, {Duration? override}) {
    return scaledDuration(override ?? overlayEnterDuration ?? base);
  }

  /// Resolves an overlay EXIT duration from one place.
  ///
  /// Same precedence as the enter leg: per-instance, category
  /// ([overlayExitDuration]), then the caller's [base].
  Duration resolveOverlayExitDuration(Duration base, {Duration? override}) {
    return scaledDuration(override ?? overlayExitDuration ?? base);
  }

  /// Resolves a state-change duration from one place.
  ///
  /// Same precedence: per-instance, category ([stateDuration]), [base].
  Duration resolveStateDuration(Duration base, {Duration? override}) {
    return scaledDuration(override ?? stateDuration ?? base);
  }

  /// Resolves an overlay ENTER curve: per-instance, category
  /// ([overlayEnterCurve]), then the caller's [base].
  Curve resolveOverlayEnterCurve(Curve base, {Curve? override}) {
    if (override != null) {
      return override;
    }
    return overlayEnterCurve ?? resolveEnterCurve(base);
  }

  /// Resolves an overlay EXIT curve: per-instance, category
  /// ([overlayExitCurve]), then the caller's [base].
  Curve resolveOverlayExitCurve(Curve base, {Curve? override}) {
    if (override != null) {
      return override;
    }
    return overlayExitCurve ?? base;
  }

  /// Resolves a state-change curve: per-instance, category ([stateCurve]),
  /// then the caller's [base].
  Curve resolveStateCurve(Curve base, {Curve? override}) {
    if (override != null) {
      return override;
    }
    return stateCurve ?? base;
  }

  /// Returns a copy with the given fields replaced.
  MotionTokens copyWith({
    MotionDurations? durations,
    MotionCurves? curves,
    bool? enabled,
    MotionIntensity? intensity,
    double? customDurationMultiplier,
    double? customPressScale,
    double? customEnterOffset,
    MotionCurveName? customCurve,
    Duration? overlayEnterDuration,
    Duration? overlayExitDuration,
    Duration? stateDuration,
    Curve? overlayEnterCurve,
    Curve? overlayExitCurve,
    Curve? stateCurve,
  }) {
    return MotionTokens(
      durations: durations ?? this.durations,
      curves: curves ?? this.curves,
      enabled: enabled ?? this.enabled,
      intensity: intensity ?? this.intensity,
      customDurationMultiplier:
          customDurationMultiplier ?? this.customDurationMultiplier,
      customPressScale: customPressScale ?? this.customPressScale,
      customEnterOffset: customEnterOffset ?? this.customEnterOffset,
      customCurve: customCurve ?? this.customCurve,
      overlayEnterDuration: overlayEnterDuration ?? this.overlayEnterDuration,
      overlayExitDuration: overlayExitDuration ?? this.overlayExitDuration,
      stateDuration: stateDuration ?? this.stateDuration,
      overlayEnterCurve: overlayEnterCurve ?? this.overlayEnterCurve,
      overlayExitCurve: overlayExitCurve ?? this.overlayExitCurve,
      stateCurve: stateCurve ?? this.stateCurve,
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
        other.enabled == enabled &&
        other.intensity == intensity &&
        other.customDurationMultiplier == customDurationMultiplier &&
        other.customPressScale == customPressScale &&
        other.customEnterOffset == customEnterOffset &&
        other.customCurve == customCurve &&
        other.overlayEnterDuration == overlayEnterDuration &&
        other.overlayExitDuration == overlayExitDuration &&
        other.stateDuration == stateDuration &&
        other.overlayEnterCurve == overlayEnterCurve &&
        other.overlayExitCurve == overlayExitCurve &&
        other.stateCurve == stateCurve;
  }

  @override
  int get hashCode => Object.hash(
    durations,
    curves,
    enabled,
    intensity,
    customDurationMultiplier,
    customPressScale,
    customEnterOffset,
    customCurve,
    overlayEnterDuration,
    overlayExitDuration,
    stateDuration,
    overlayEnterCurve,
    overlayExitCurve,
    stateCurve,
  );
}
