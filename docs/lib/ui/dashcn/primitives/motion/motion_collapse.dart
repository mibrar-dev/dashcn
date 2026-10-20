// Collapse transition: height-to-zero removal for inline content.
//
// `MotionCollapse` shows [child] at full height while [visible] is true; when
// [visible] flips to false it keeps the child mounted, fades it while
// collapsing its height to zero (siblings slide up underneath it), then
// unmounts and reports [onExited]. Re-showing mid-exit re-expands. Use it for
// error messages under fields, dismissible chips and list rows — anywhere a
// parent conditional would otherwise cut the layout in one frame.
//
// The collapse clips its child, so overflowing shadows or focus rings are cut
// during the exit by design. Widgets-only (no Material/Cupertino). Under
// reduced motion (or `MotionSpec.disabled`, or the theme master switch) the
// child swaps instantly with no ticker running.

import 'package:flutter/widgets.dart';

import '../../theme/motion.dart';
import '../../theme/theme.dart';
import 'motion_spec.dart';

/// Collapses [child] to zero height while fading it out on removal.
///
/// Drives [visible]: true shows the child at full height, false plays the
/// height + fade exit, then unmounts the child and calls [onExited].
class MotionCollapse extends StatefulWidget {
  /// Creates a collapse wrapper.
  const MotionCollapse({
    super.key,
    required this.visible,
    required this.child,
    this.motion,
    this.enterDuration,
    this.exitDuration,
    this.enterCurve,
    this.exitCurve,
    this.onExited,
    this.alignment = Alignment.topCenter,
  });

  /// Whether the child is shown at full height.
  final bool visible;

  /// The content shown while visible (and while the exit plays).
  final Widget child;

  /// Per-instance override. Wins over the explicit legs below.
  final MotionSpec? motion;

  /// Expand duration. Defaults to the theme base (200 ms).
  final Duration? enterDuration;

  /// Collapse duration. Defaults to the theme base (200 ms).
  final Duration? exitDuration;

  /// Expand curve. Defaults to emphasized-out.
  final Curve? enterCurve;

  /// Collapse curve. Defaults to emphasized-in.
  final Curve? exitCurve;

  /// Called once the exit completes and the child unmounts.
  final VoidCallback? onExited;

  /// Which edge the collapse pins to (default top-center: content below
  /// slides up as the height shrinks).
  final AlignmentGeometry alignment;

  @override
  State<MotionCollapse> createState() => MotionCollapseState();
}

/// State of [MotionCollapse].
///
/// Public for tests, which drive [visible] flips and read [isGone] and
/// [progress] at fixed pump times.
class MotionCollapseState extends State<MotionCollapse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);
  bool _gone = false;

  /// Whether the child has unmounted after the exit.
  bool get isGone => _gone;

  /// Current visual progress: 1 is fully expanded, 0 fully collapsed.
  /// Always 1-or-0 (matching [widget.visible]) under reduced motion.
  double get progress =>
      _reduced ? (widget.visible ? 1.0 : 0.0) : _controller.value;

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

  Duration _enterDuration() {
    final MotionTokens motion = Theme.of(context).motion;
    final MotionSpec? spec = widget.motion;
    if (spec != null) {
      return spec.resolveEnterDuration(
        context,
        widget.enterDuration ?? motion.durations.base,
        state: true,
      );
    }
    return motion.resolveStateDuration(
      widget.enterDuration ?? motion.durations.base,
    );
  }

  Duration _exitDuration() {
    final MotionTokens motion = Theme.of(context).motion;
    final MotionSpec? spec = widget.motion;
    if (spec != null) {
      return spec.resolveExitDuration(
        context,
        widget.exitDuration ?? motion.durations.base,
        state: true,
      );
    }
    return motion.resolveStateDuration(
      widget.exitDuration ?? motion.durations.base,
    );
  }

  Curve _enterCurve() {
    final MotionTokens motion = Theme.of(context).motion;
    final MotionSpec? spec = widget.motion;
    if (spec != null) {
      return spec.resolveEnterCurve(context, motion.curves.emphasizedOut);
    }
    return motion.resolveStateCurve(
      widget.enterCurve ?? motion.curves.emphasizedOut,
    );
  }

  Curve _exitCurve() {
    final MotionTokens motion = Theme.of(context).motion;
    final MotionSpec? spec = widget.motion;
    if (spec != null) {
      return spec.resolveExitCurve(context, motion.curves.emphasizedIn);
    }
    return motion.resolveStateCurve(
      widget.exitCurve ?? motion.curves.emphasizedIn,
    );
  }

  @override
  void initState() {
    super.initState();
    _gone = !widget.visible;
    _controller.value = widget.visible ? 1.0 : 0.0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_reduced) {
      _gone = !widget.visible;
      _controller.value = widget.visible ? 1.0 : 0.0;
    }
  }

  @override
  void didUpdateWidget(covariant MotionCollapse oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible == oldWidget.visible) {
      return;
    }
    if (_reduced) {
      final bool wasGone = _gone;
      _gone = !widget.visible;
      _controller.value = widget.visible ? 1.0 : 0.0;
      if (wasGone != _gone && _gone) {
        widget.onExited?.call();
      }
      return;
    }
    if (widget.visible) {
      setState(() => _gone = false);
      _controller.duration = _enterDuration();
      _controller.forward();
    } else {
      _controller.duration = _exitDuration();
      _controller.reverse().then((_) {
        if (!mounted || widget.visible) {
          return;
        }
        setState(() => _gone = true);
        widget.onExited?.call();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_gone) {
      return const SizedBox.shrink();
    }
    if (_reduced) {
      return widget.visible ? widget.child : const SizedBox.shrink();
    }
    final Animation<double> curved = _controller.drive(
      CurveTween(
        curve: _controller.status == AnimationStatus.reverse
            ? _exitCurve()
            : _enterCurve(),
      ),
    );
    // Fade first so text never clips harshly, then collapse the height;
    // the clip pins to the chosen edge while siblings slide underneath.
    return ClipRect(
      child: FadeTransition(
        opacity: curved,
        child: SizeTransition(
          sizeFactor: curved,
          axis: Axis.vertical,
          alignment: widget.alignment,
          child: widget.child,
        ),
      ),
    );
  }
}
