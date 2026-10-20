// Presence primitive: exit animations for conditionally-removed content.
//
// Inline banners (alerts, error messages), chips and list rows are usually
// removed by a parent conditional (`if (show) ...`), so an enter-only wrapper
// like `MotionEnter` vanishes instantly on removal. `MotionPresence` fixes
// that: while [visible] is true it shows [child] (playing the enter); when
// [visible] flips to false it KEEPS the child mounted, plays the exit, then
// unmounts and reports [onExited]. Re-showing mid-exit replays the enter.
//
// Widgets-only (no Material/Cupertino). Transform/opacity only, so layout
// never jumps while the exit plays. Under reduced motion (or
// `MotionSpec.disabled`, or the theme master switch) the child swaps
// instantly with no ticker running.

import 'package:flutter/widgets.dart';

import '../../theme/motion.dart';
import '../../theme/theme.dart';
import 'motion_spec.dart';

/// Default enter: fade in while sliding down 6 px into place (matches
/// `MotionEnter`).
Widget presenceEnterTransition(Widget child, Animation<double> animation) {
  return FadeTransition(
    opacity: animation,
    child: AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (BuildContext context, Widget? child) {
        final MotionTokens motion = Theme.of(context).motion;
        final Offset offset = motion.scaledOffset(const Offset(0, -6));
        return Transform.translate(
          offset: offset * (1.0 - animation.value),
          child: child,
        );
      },
    ),
  );
}

/// Default exit: fade out while drifting up 4 px.
Widget presenceExitTransition(Widget child, Animation<double> animation) {
  return FadeTransition(
    opacity: animation,
    child: AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (BuildContext context, Widget? child) {
        final MotionTokens motion = Theme.of(context).motion;
        final Offset offset = motion.scaledOffset(const Offset(0, -4));
        return Transform.translate(
          offset: offset * (1.0 - animation.value),
          child: child,
        );
      },
    ),
  );
}

/// Keeps [child] mounted while its exit animation plays.
///
/// Drives [visible]: true shows the child (enter runs on first show and on
/// every false→true flip), false plays the exit, then unmounts the child and
/// calls [onExited]. A true→false→true flip mid-exit replays the enter from
/// the current position.
class MotionPresence extends StatefulWidget {
  /// Creates a presence wrapper.
  const MotionPresence({
    super.key,
    required this.visible,
    required this.child,
    this.motion,
    this.enterDuration,
    this.exitDuration,
    this.enterCurve,
    this.exitCurve,
    this.enter,
    this.exit,
    this.delay = Duration.zero,
    this.onExited,
  });

  /// Whether the child is shown. Flip to false to play the exit.
  final bool visible;

  /// The content shown while visible (and while the exit plays).
  final Widget child;

  /// Per-instance override. Wins over the explicit legs below.
  final MotionSpec? motion;

  /// Enter duration. Defaults to the theme base (200 ms).
  final Duration? enterDuration;

  /// Exit duration. Defaults to the theme base (200 ms).
  final Duration? exitDuration;

  /// Enter curve. Defaults to emphasized-out.
  final Curve? enterCurve;

  /// Exit curve. Defaults to emphasized-in.
  final Curve? exitCurve;

  /// Custom enter transition. Defaults to fade + slide down.
  final MotionTransitionBuilder? enter;

  /// Custom exit transition. Defaults to fade + drift up.
  final MotionTransitionBuilder? exit;

  /// Start delay applied to the enter only.
  final Duration delay;

  /// Called once the exit completes and the child unmounts.
  final VoidCallback? onExited;

  @override
  State<MotionPresence> createState() => MotionPresenceState();
}

/// State of [MotionPresence].
///
/// Public for tests, which drive [visible] flips and read [isGone] and
/// [progress] at fixed pump times.
class MotionPresenceState extends State<MotionPresence>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);
  late Animation<double> _enter = const AlwaysStoppedAnimation<double>(1);
  late Animation<double> _exit = const AlwaysStoppedAnimation<double>(1);
  bool _gone = false;
  bool _exiting = false;

  /// Whether the child has unmounted after the exit.
  bool get isGone => _gone;

  /// Current visual progress: enter 0→1 while showing, exit 1→0 while
  /// hiding. Always 1 under reduced motion.
  double get progress => _reduced ? 1.0 : _controller.value;

  bool get _reduced {
    if (widget.motion?.disabled ?? false) {
      return true;
    }
    final media = MediaQuery.maybeOf(context);
    if (media != null && media.disableAnimations) {
      return true;
    }
    return !Theme.of(context).motion.enabled;
  }

  MotionTransitionBuilder get _enterBuilder =>
      widget.motion?.enter ?? widget.enter ?? presenceEnterTransition;

  MotionTransitionBuilder get _exitBuilder =>
      widget.motion?.exit ?? widget.exit ?? presenceExitTransition;

  @override
  void initState() {
    super.initState();
    _gone = !widget.visible;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolve();
    if (_reduced) {
      _gone = !widget.visible;
      _exiting = false;
      _controller.value = widget.visible ? 1.0 : 0.0;
      return;
    }
    if (widget.visible && (_gone || _exiting)) {
      _gone = false;
      _exiting = false;
      _controller.forward();
    } else if (!widget.visible && !_gone && !_exiting) {
      _startExit();
    } else if (widget.visible && !_controller.isCompleted) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant MotionPresence oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool durationsChanged =
        widget.enterDuration != oldWidget.enterDuration ||
        widget.exitDuration != oldWidget.exitDuration ||
        widget.enterCurve != oldWidget.enterCurve ||
        widget.exitCurve != oldWidget.exitCurve ||
        widget.delay != oldWidget.delay ||
        widget.motion != oldWidget.motion;
    if (durationsChanged) {
      _resolve();
    }
    if (_reduced) {
      final bool wasGone = _gone;
      _gone = !widget.visible;
      _exiting = false;
      _controller.value = widget.visible ? 1.0 : 0.0;
      if (wasGone != _gone && _gone) {
        widget.onExited?.call();
      }
      return;
    }
    if (widget.visible == oldWidget.visible) {
      return;
    }
    if (widget.visible) {
      _gone = false;
      _exiting = false;
      _resolve();
      _controller.forward();
    } else {
      _startExit();
    }
  }

  /// Resolves the controller length (delay + enter) and the phase curves.
  void _resolve() {
    final MotionTokens motion = Theme.of(context).motion;
    final MotionSpec? spec = widget.motion;
    final Duration enter = spec != null
        ? spec.resolveEnterDuration(
            context,
            widget.enterDuration ?? motion.durations.base,
          )
        : motion.resolveOverlayEnterDuration(
            widget.enterDuration ?? motion.durations.base,
          );
    final Duration exit = spec != null
        ? spec.resolveExitDuration(
            context,
            widget.exitDuration ?? motion.durations.base,
          )
        : motion.resolveOverlayExitDuration(
            widget.exitDuration ?? motion.durations.base,
          );
    final Duration delay = spec != null
        ? spec.resolveDelay(context)
        : motion.scaledDuration(widget.delay);
    final Curve enterCurve = spec != null
        ? spec.resolveEnterCurve(context, motion.curves.emphasizedOut)
        : motion.resolveOverlayEnterCurve(
            widget.enterCurve ?? motion.curves.emphasizedOut,
          );
    final Curve exitCurve = spec != null
        ? spec.resolveExitCurve(context, motion.curves.emphasizedIn)
        : motion.resolveOverlayExitCurve(
            widget.exitCurve ?? motion.curves.emphasizedIn,
          );
    _enter = _controller.drive(
      CurveTween(curve: Interval(0.0, 1.0, curve: enterCurve)),
    );
    _exit = _controller.drive(
      CurveTween(curve: Interval(0.0, 1.0, curve: exitCurve)),
    );
    // The controller always spans the ENTER length (delay lead-in included);
    // the exit reuses the same span so a mid-exit re-show continues smoothly.
    final int totalMs = delay.inMilliseconds + enter.inMilliseconds;
    _controller.duration = Duration(milliseconds: totalMs <= 0 ? 1 : totalMs);
    _exitDuration = exit;
  }

  Duration _exitDuration = const Duration(milliseconds: 200);

  void _startExit() {
    if (_reduced) {
      _gone = true;
      _exiting = false;
      widget.onExited?.call();
      return;
    }
    _exiting = true;
    // Replay from the top over the EXIT length: swap the duration, then
    // reverse to zero. Mid-exit re-shows flip back to the enter length.
    _controller.duration = _exitDuration.inMilliseconds <= 0
        ? const Duration(milliseconds: 1)
        : _exitDuration;
    _controller.reverse().then((_) {
      if (!mounted || widget.visible) {
        return;
      }
      setState(() {
        _gone = true;
        _exiting = false;
      });
      widget.onExited?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_gone || (_reduced && !widget.visible)) {
      return const SizedBox.shrink();
    }
    if (_reduced) {
      return widget.child;
    }
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        if (_exiting) {
          return _exitBuilder(child!, _exit);
        }
        return _enterBuilder(child!, _enter);
      },
    );
  }
}
