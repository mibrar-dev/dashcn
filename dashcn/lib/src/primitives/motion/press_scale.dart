// Press-down scale: the shared press feedback for interactive components.
// PressScale scales its child to the pressed scale (~0.96) while a pointer
// is down and springs back on release or cancel. Transform-only: layout
// and hit-testing never change. Under reduced motion the child builds
// unscaled with no ticker.

import 'package:flutter/widgets.dart';

import '../../theme/motion.dart';
import '../../theme/theme.dart';
import 'motion_scope.dart';

/// Scales [child] down while pressed, back on release.
///
/// Wrap pressable surfaces that do not already go through `Clickable`
/// press states (calendar day cells, pagination dots). Components built on
/// `Clickable` get the same effect from the press transform there.
class PressScale extends StatefulWidget {
  /// Creates a press scale wrapper.
  const PressScale({
    super.key,
    required this.child,
    this.pressedScale = 0.96,
    this.enabled = true,
  });

  /// The wrapped child.
  final Widget child;

  /// Scale applied while pressed. Defaults to 0.96.
  final double pressedScale;

  /// When false the child builds unscaled and no listener is attached.
  final bool enabled;

  @override
  State<PressScale> createState() => PressScaleState();
}

/// State of [PressScale].
///
/// Public for tests, which drive [handlePressDown] and [handlePressUp]
/// directly.
class PressScaleState extends State<PressScale> {
  bool _pressed = false;

  /// Whether the child is currently showing the pressed scale.
  bool get pressed => _pressed;

  /// Shows the pressed scale.
  void handlePressDown() {
    if (!widget.enabled || _pressed) return;
    setState(() => _pressed = true);
  }

  /// Returns to the resting scale.
  void handlePressUp() {
    if (!_pressed) return;
    setState(() => _pressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final MotionTokens motion = Theme.of(context).motion;
    final Duration duration = resolveMotionDuration(
      context,
      motion.durations.instant,
    );
    // The default pressed scale tracks the intensity press scale in one place
    // (standard 0.96); an explicit widget leg always wins.
    final double pressedScale = widget.pressedScale == 0.96
        ? motion.pressScale
        : widget.pressedScale;
    Widget child = AnimatedScale(
      scale: _pressed ? pressedScale : 1.0,
      duration: duration,
      curve: motion.curves.standard,
      child: widget.child,
    );
    if (!widget.enabled) {
      return child;
    }
    child = Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => handlePressDown(),
      onPointerUp: (_) => handlePressUp(),
      onPointerCancel: (_) => handlePressUp(),
      child: child,
    );
    return child;
  }
}
