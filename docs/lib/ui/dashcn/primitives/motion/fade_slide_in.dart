// Fade-and-slide enter transition for first-show content.
// FadeSlideIn fades its child from transparent while sliding it from
// an offset (default 8 px up into place). The animation runs once on mount;
// rebuilds keep the end state, so layout never jumps. Under reduced motion
// the child builds at full opacity with no ticker or timer.

import 'package:flutter/widgets.dart';

import '../../theme/motion.dart';
import '../../theme/theme.dart';

/// Fades its child in while sliding it from [offset] into place.
///
/// Runs once on mount. [delay] staggers siblings (see `StaggerChildren`):
/// the delay is an [Interval] lead-in on the same controller, so no timers
/// are involved and the animation also completes across a single elapse.
class FadeSlideIn extends StatefulWidget {
  /// Creates a fade-slide enter transition.
  const FadeSlideIn({
    super.key,
    required this.child,
    this.offset = const Offset(0, 8),
    this.duration,
    this.curve,
    this.delay = Duration.zero,
    this.beginOpacity = 0.0,
  });

  /// The wrapped child.
  final Widget child;

  /// Slide distance in logical px from which the child arrives.
  final Offset offset;

  /// Transition duration, excluding [delay]. Defaults to the theme base.
  final Duration? duration;

  /// Transition curve. Defaults to emphasized-out.
  final Curve? curve;

  /// Start delay, used to stagger siblings.
  final Duration delay;

  /// Starting opacity. Defaults to transparent.
  final double beginOpacity;

  @override
  State<FadeSlideIn> createState() => FadeSlideInState();
}

/// State of `FadeSlideIn`.
///
/// Public for tests, which read [progress] at fixed pump times.
class FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);
  late Animation<double> _progress = const AlwaysStoppedAnimation<double>(0);

  /// Current visual progress (0..1). Always 1 under reduced motion.
  double get progress => _reduced ? 1.0 : _progress.value;

  bool get _reduced {
    final media = MediaQuery.maybeOf(context);
    if (media != null && media.disableAnimations) {
      return true;
    }
    return !Theme.of(context).motion.enabled;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolve();
    if (_reduced) {
      if (_controller.value != 1.0) {
        _controller.value = 1.0;
      }
      return;
    }
    if (!_controller.isCompleted && !_controller.isAnimating) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant FadeSlideIn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration ||
        widget.curve != oldWidget.curve ||
        widget.delay != oldWidget.delay) {
      _resolve();
    }
  }

  /// Resolves the controller length (delay plus transition) and the
  /// interval-mapped progress curve from the theme and widget legs.
  /// Durations and delays scale with the intensity multiplier in one place.
  void _resolve() {
    final MotionTokens motion = Theme.of(context).motion;
    final Duration base = motion.scaledDuration(
      widget.duration ?? motion.durations.base,
    );
    final Duration delay = motion.scaledDuration(widget.delay);
    final Curve curve = motion.resolveEnterCurve(
      motion.curves.emphasizedOut,
      override: widget.curve,
    );
    final int totalMs = delay.inMilliseconds + base.inMilliseconds;
    _controller.duration = Duration(milliseconds: totalMs <= 0 ? 1 : totalMs);
    final double lead = totalMs <= 0 ? 0.0 : delay.inMilliseconds / totalMs;
    _progress = _controller.drive(
      CurveTween(curve: Interval(lead, 1.0, curve: curve)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_reduced) {
      return widget.child;
    }
    // The slide distance tracks the intensity enter offset in one place
    // (standard keeps the caller's 8 px); an explicit offset leg always wins
    // only when it differs from the default — custom offsets flow through
    // the intensity scale instead of bypassing it.
    final MotionTokens motion = Theme.of(context).motion;
    final Offset offset = motion.scaledOffset(widget.offset);
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        final double t = _progress.value;
        return Opacity(
          opacity: widget.beginOpacity + (1.0 - widget.beginOpacity) * t,
          child: Transform.translate(offset: offset * (1.0 - t), child: child),
        );
      },
    );
  }
}
