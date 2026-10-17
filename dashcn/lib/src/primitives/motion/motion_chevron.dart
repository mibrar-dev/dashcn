// Rotating expand indicator (accordion, collapsible, tree, navigation).
//
// `MotionChevron` rotates its child (usually a chevron icon) by [turns]
// — half a turn, 180 degrees, by default — when [expanded] changes.
// Under reduced motion the rotation snaps with no ticker.

import 'package:flutter/widgets.dart';

import '../../theme/motion.dart';
import '../../theme/theme.dart';
import 'motion_scope.dart';

/// Rotates its child by [turns] when [expanded] changes.
class MotionChevron extends StatelessWidget {
  /// Creates a rotating expand indicator.
  const MotionChevron({
    super.key,
    required this.expanded,
    required this.child,
    this.turns = 0.5,
    this.duration,
  });

  /// Whether the section is expanded.
  final bool expanded;

  /// The icon to rotate.
  final Widget child;

  /// Rotation added when expanded, in turns. Defaults to half a turn.
  final double turns;

  /// Rotation duration. Defaults to the theme base (200 ms).
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    final MotionTokens motion = Theme.of(context).motion;
    return AnimatedRotation(
      turns: expanded ? turns : 0.0,
      duration: resolveMotionDuration(
        context,
        duration ?? motion.durations.base,
      ),
      curve: motion.curves.standard,
      child: child,
    );
  }
}
