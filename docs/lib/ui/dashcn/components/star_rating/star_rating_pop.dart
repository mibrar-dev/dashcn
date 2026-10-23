// The selected-star pop: a star that becomes selected grows from 1.0 to 1.2
// and springs back to 1.0 (MOTION.md: star rating). The pop plays once per
// selection and is transform-only, so layout never shifts. Under reduced
// motion there is no scale at all: the star simply takes its end state.

import 'package:flutter/widgets.dart';

import '../../primitives/motion/motion_scope.dart';
import '../../theme/motion.dart';
import '../../theme/theme.dart';

/// Peak scale of the pop (1.0 to 1.2 and back).
const double _starPopPeak = 1.2;

/// Wraps a star and pops it when [selected] turns true.
class StarPop extends StatefulWidget {
  /// Creates a star pop wrapper.
  const StarPop({super.key, required this.selected, required this.child});

  /// Whether the star is (at least partly) selected.
  final bool selected;

  /// The star to pop.
  final Widget child;

  @override
  State<StarPop> createState() => StarPopState();
}

/// State of [StarPop].
///
/// Public for tests, which read [scale] at fixed pump times.
class StarPopState extends State<StarPop> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);

  /// Current scale: 1.0 at rest, rising to 1.2 and back during the pop.
  double get scale {
    if (motionReduced(context)) return 1.0;
    final double t = _controller.value;
    if (t <= 0.4) {
      return 1.0 + (_starPopPeak - 1.0) * (t / 0.4);
    }
    return _starPopPeak - (_starPopPeak - 1.0) * ((t - 0.4) / 0.6);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final MotionTokens motion = Theme.of(context).motion;
    _controller.duration = motion.scaledDuration(motion.durations.base);
  }

  @override
  void didUpdateWidget(covariant StarPop oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected && !oldWidget.selected && !motionReduced(context)) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        return Transform.scale(scale: scale, child: child);
      },
    );
  }
}
