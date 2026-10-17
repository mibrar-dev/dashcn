// Gentle enter transition for inline banners (alerts, error banners).
//
// `MotionEnter` fades its child in while sliding it slightly down into
// place. Runs once on mount; transform/opacity only, so layout never
// jumps. Under reduced motion the child builds final with no ticker.

import 'package:flutter/widgets.dart';

import 'fade_slide_in.dart';

/// Fades its child in with a slight slide down.
///
/// Runs once on mount. Used by alerts, error banners and other inline
/// notices appearing at the top of a surface.
class MotionEnter extends StatelessWidget {
  /// Creates an enter transition.
  const MotionEnter({
    super.key,
    required this.child,
    this.offset = const Offset(0, -6),
    this.duration,
    this.curve,
    this.delay = Duration.zero,
  });

  /// The wrapped child.
  final Widget child;

  /// Slide distance the child arrives from. Defaults to 6 px above.
  final Offset offset;

  /// Transition duration. Defaults to the theme base (200 ms).
  final Duration? duration;

  /// Transition curve. Defaults to emphasized-out.
  final Curve? curve;

  /// Start delay.
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return FadeSlideIn(
      offset: offset,
      duration: duration,
      curve: curve,
      delay: delay,
      child: child,
    );
  }
}
