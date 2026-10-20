// Per-instance motion override: retime or replace one widget's transition
// without touching the ambient theme.
//
// A `MotionSpec` overrides durations, curves and the start delay for the
// component that receives it, supplies custom enter/exit transition builders,
// or disables animation for that instance only (`disabled: true` snaps to the
// end value with no ticker — the same end state reduced motion produces).
// Every component touched by the motion pass accepts one as `motion`.
//
// Widgets-only (no Material/Cupertino). Reduced motion
// (`MediaQuery.disableAnimations` or the theme master switch) always wins:
// every resolver below returns the instant path when motion is reduced.

import 'package:flutter/widgets.dart';

import '../../theme/motion.dart';
import '../../theme/theme.dart';
import 'motion_scope.dart';

/// Builds the transition for one phase of a presence animation.
///
/// [animation] runs 0→1 on enter and 1→0 on exit; builders usually drive a
/// `FadeTransition` plus a slide or scale off it.
typedef MotionTransitionBuilder =
    Widget Function(Widget child, Animation<double> animation);

/// Fades [child] in/out, the default enter/exit transition.
Widget fadeMotionTransition(Widget child, Animation<double> animation) {
  return FadeTransition(opacity: animation, child: child);
}

/// Per-instance motion override.
///
/// All legs are optional: null keeps the theme resolution (category legs,
/// then the component default, scaled by the intensity multiplier).
/// [enterDuration]/[exitDuration] split the two phases; [duration] sets both
/// at once and loses to the split legs. Same for the curves. [delay] postpones
/// the enter only. [disabled] snaps this instance to its end value.
@immutable
class MotionSpec {
  /// Creates a per-instance motion override.
  const MotionSpec({
    this.duration,
    this.enterDuration,
    this.exitDuration,
    this.curve,
    this.enterCurve,
    this.exitCurve,
    this.delay = Duration.zero,
    this.enter,
    this.exit,
    this.disabled = false,
  });

  /// Duration for both phases when the split legs are null.
  final Duration? duration;

  /// Enter-phase duration. Wins over [duration].
  final Duration? enterDuration;

  /// Exit-phase duration. Wins over [duration].
  final Duration? exitDuration;

  /// Curve for both phases when the split legs are null.
  final Curve? curve;

  /// Enter-phase curve. Wins over [curve].
  final Curve? enterCurve;

  /// Exit-phase curve. Wins over [curve].
  final Curve? exitCurve;

  /// Start delay applied to the enter phase only.
  final Duration delay;

  /// Custom enter transition. Null keeps the component default.
  final MotionTransitionBuilder? enter;

  /// Custom exit transition. Null keeps the component default.
  final MotionTransitionBuilder? exit;

  /// When true this instance snaps to its end value with no ticker.
  final bool disabled;

  /// Whether this instance animates under [context].
  ///
  /// True unless explicitly [disabled], reduced motion is requested, or the
  /// theme master switch is off.
  bool animates(BuildContext context) {
    return !disabled && !motionReduced(context);
  }

  /// Resolves the enter duration: split leg, then [duration], then the theme
  /// overlay-enter chain, then [base]. Zero under reduced motion.
  Duration resolveEnterDuration(
    BuildContext context,
    Duration base, {
    bool state = false,
  }) {
    if (motionReduced(context) || disabled) {
      return Duration.zero;
    }
    final MotionTokens motion = Theme.of(context).motion;
    final Duration? explicit = enterDuration ?? duration;
    if (state) {
      return motion.resolveStateDuration(base, override: explicit);
    }
    return motion.resolveOverlayEnterDuration(base, override: explicit);
  }

  /// Resolves the exit duration, mirroring [resolveEnterDuration].
  Duration resolveExitDuration(
    BuildContext context,
    Duration base, {
    bool state = false,
  }) {
    if (motionReduced(context) || disabled) {
      return Duration.zero;
    }
    final MotionTokens motion = Theme.of(context).motion;
    final Duration? explicit = exitDuration ?? duration;
    if (state) {
      return motion.resolveStateDuration(base, override: explicit);
    }
    return motion.resolveOverlayExitDuration(base, override: explicit);
  }

  /// Resolves the enter curve: split leg, [curve], theme chain, [base].
  Curve resolveEnterCurve(BuildContext context, Curve base) {
    final MotionTokens motion = Theme.of(context).motion;
    return motion.resolveOverlayEnterCurve(base, override: enterCurve ?? curve);
  }

  /// Resolves the exit curve, mirroring [resolveEnterCurve].
  Curve resolveExitCurve(BuildContext context, Curve base) {
    final MotionTokens motion = Theme.of(context).motion;
    return motion.resolveOverlayExitCurve(base, override: exitCurve ?? curve);
  }

  /// Resolves the enter delay through the intensity multiplier.
  Duration resolveDelay(BuildContext context) {
    if (motionReduced(context) || disabled) {
      return Duration.zero;
    }
    return Theme.of(context).motion.scaledDuration(delay);
  }
}
