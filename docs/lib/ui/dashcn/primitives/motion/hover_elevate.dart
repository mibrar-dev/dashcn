// Hover lift for cards and outlined surfaces.
//
// `HoverElevate` translates its child up by [lift] (2 px) while fading
// between [decoration] and [hoverDecoration] — the shadow transition.
// Transform/decoration only: layout never changes, and touch platforms
// (no hover) render the resting state. Under reduced motion both swap
// instantly with no ticker.

import 'package:flutter/widgets.dart';

import '../../theme/motion.dart';
import '../../theme/theme.dart';
import 'motion_scope.dart';

/// Lifts its child on hover with a shadow transition.
class HoverElevate extends StatefulWidget {
  /// Creates a hover lift wrapper.
  const HoverElevate({
    super.key,
    required this.child,
    required this.decoration,
    required this.hoverDecoration,
    this.lift = -2.0,
    this.duration,
    this.enabled = true,
  });

  /// The wrapped child.
  final Widget child;

  /// Resting decoration (surface fill, border, resting shadow).
  final Decoration decoration;

  /// Hover decoration (surface fill, border, elevated shadow).
  final Decoration hoverDecoration;

  /// Vertical travel in logical px. Defaults to −2 (up).
  final double lift;

  /// Transition duration. Defaults to the theme fast (150 ms).
  final Duration? duration;

  /// When false the resting decoration paints and hover is ignored.
  final bool enabled;

  @override
  State<HoverElevate> createState() => HoverElevateState();
}

/// State of `HoverElevate`.
///
/// Public for tests, which read [hovered].
class HoverElevateState extends State<HoverElevate> {
  bool _hovered = false;

  /// Whether the hover decoration is showing.
  bool get hovered => _hovered;

  void _setHovered(bool value) {
    if (!widget.enabled || _hovered == value) {
      return;
    }
    setState(() => _hovered = value);
  }

  @override
  Widget build(BuildContext context) {
    final MotionTokens motion = Theme.of(context).motion;
    final bool hovered = widget.enabled && _hovered;
    Widget child = AnimatedContainer(
      duration: resolveMotionDuration(
        context,
        widget.duration ?? motion.durations.fast,
      ),
      curve: motion.curves.standard,
      transform: hovered
          ? Matrix4.translationValues(0, widget.lift, 0)
          : Matrix4.identity(),
      decoration: hovered ? widget.hoverDecoration : widget.decoration,
      child: widget.child,
    );
    if (!widget.enabled) {
      return child;
    }
    return MouseRegion(
      onEnter: (_) => _setHovered(true),
      onExit: (_) => _setHovered(false),
      child: child,
    );
  }
}
