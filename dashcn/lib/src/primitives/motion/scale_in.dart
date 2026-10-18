// Scale-and-fade enter transition for floating surfaces.
// ScaleIn grows its child from a begin scale (0.96) to full size while
// fading in, anchored at [alignment] — the trigger edge for popovers,
// the center for dialogs. Runs once on mount; transform-only, so layout
// never jumps. Under reduced motion the child builds final with no ticker.

import 'package:flutter/widgets.dart';

import '../../theme/motion.dart';
import '../../theme/theme.dart';

/// Scales its child from [beginScale] to 1 while fading in.
///
/// Runs once on mount.
class ScaleIn extends StatefulWidget {
  /// Creates a scale-and-fade enter transition.
  const ScaleIn({
    super.key,
    required this.child,
    this.beginScale = 0.96,
    this.alignment = Alignment.center,
    this.duration,
    this.curve,
  });

  /// The wrapped child.
  final Widget child;

  /// Starting scale. Defaults to 0.96.
  final double beginScale;

  /// Transform origin: the trigger edge for popovers, center for dialogs.
  final AlignmentGeometry alignment;

  /// Transition duration. Defaults to the theme base (200 ms).
  final Duration? duration;

  /// Transition curve. Defaults to emphasized-out.
  final Curve? curve;

  @override
  State<ScaleIn> createState() => ScaleInState();
}

/// State of `ScaleIn`.
///
/// Public for tests, which read [progress] at fixed pump times.
class ScaleInState extends State<ScaleIn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  /// Current animation progress (0..1). Always 1 under reduced motion.
  double get progress => _reduced ? 1.0 : _controller.value;

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
    final MotionTokens motion = Theme.of(context).motion;
    _controller.duration = motion.scaledDuration(
      widget.duration ?? motion.durations.base,
    );
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
  void didUpdateWidget(covariant ScaleIn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      final MotionTokens motion = Theme.of(context).motion;
      _controller.duration = motion.scaledDuration(
        widget.duration ?? motion.durations.base,
      );
    }
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
    final MotionTokens motion = Theme.of(context).motion;
    final Curve curve = motion.resolveEnterCurve(
      motion.curves.emphasizedOut,
      override: widget.curve,
    );
    // The default begin scale tracks the intensity press scale in one place
    // (standard 0.96); an explicit widget leg always wins.
    final double beginScale = widget.beginScale == 0.96
        ? motion.enterBeginScale
        : widget.beginScale;
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        final double t = curve.transform(_controller.value);
        final double scale = beginScale + (1.0 - beginScale) * t;
        return Opacity(
          opacity: t,
          child: Transform.scale(
            scale: scale,
            alignment: widget.alignment,
            child: child,
          ),
        );
      },
    );
  }
}
