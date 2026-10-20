// The hide-on-scroll helper of the `fab` component: [FabHideOnScroll] slides
// its child out of the way while the user scrolls down and brings it back
// when the scroll turns up.
//
// The motion follows the theme tokens (fast/base durations, the standard
// curve) and collapses to zero under reduced motion.

import 'package:flutter/widgets.dart';

import '../../primitives/animated_value_builder.dart';
import '../../primitives/motion/motion_scope.dart';
import '../../theme/theme.dart';

/// Which scroll direction hides the child.
enum FabHideOnScrollDirection {
  /// Scrolling down hides the child, scrolling up shows it.
  down,

  /// Scrolling up hides the child, scrolling down shows it.
  up,

  /// Any scroll hides the child; only the top of the list shows it again.
  both,
}

/// Slides [child] away while the user scrolls.
///
/// Feed it a [ScrollController] (or let it read the notifications of the
/// scrollable above it). The child keeps its layout box, so nothing around
/// it moves; only the painted child slides and fades.
class FabHideOnScroll extends StatefulWidget {
  /// Creates a hide-on-scroll wrapper.
  const FabHideOnScroll({
    super.key,
    required this.child,
    this.controller,
    this.direction = FabHideOnScrollDirection.down,
    this.threshold = 6,
    this.offset = 32,
    this.duration,
    this.curve,
    this.enabled = true,
  });

  /// The floating action button.
  final Widget child;

  /// The scroll controller to watch; null reads scroll notifications
  /// instead.
  final ScrollController? controller;

  /// Which scroll direction hides the child.
  final FabHideOnScrollDirection direction;

  /// Pixels of scroll needed before the child reacts.
  final double threshold;

  /// How far the child slides away.
  final double offset;

  /// Slide duration; null uses the theme's `fast` duration.
  final Duration? duration;

  /// Slide curve; null uses the theme's standard curve.
  final Curve? curve;

  /// Whether the helper reacts to scrolling at all.
  final bool enabled;

  @override
  State<FabHideOnScroll> createState() => _FabHideOnScrollState();
}

class _FabHideOnScrollState extends State<FabHideOnScroll> {
  bool _hidden = false;
  double _lastOffset = 0;
  bool _hasLast = false;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant FabHideOnScroll oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_onScroll);
      widget.controller?.addListener(_onScroll);
      _hasLast = false;
    }
    if (!widget.enabled && _hidden) {
      setState(() => _hidden = false);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final ScrollController? controller = widget.controller;
    if (controller == null || !controller.hasClients) {
      return;
    }
    final double offset = controller.position.pixels;
    if (!_hasLast) {
      // The first notification may already carry a scroll: the baseline is
      // the position's own initial offset, so the delta is never swallowed.
      _lastOffset = controller.initialScrollOffset;
      _hasLast = true;
    }
    final double delta = offset - _lastOffset;
    _lastOffset = offset;
    _applyDelta(delta);
  }

  void _applyDelta(double delta) {
    if (!widget.enabled || delta.abs() < widget.threshold) {
      return;
    }
    final bool scrollingDown = delta > 0;
    final bool hide = switch (widget.direction) {
      FabHideOnScrollDirection.down => scrollingDown,
      FabHideOnScrollDirection.up => !scrollingDown,
      FabHideOnScrollDirection.both => true,
    };
    if (hide == _hidden) {
      return;
    }
    setState(() => _hidden = hide);
  }

  bool _handleNotification(ScrollNotification notification) {
    if (notification.depth != 0) {
      return false;
    }
    if (notification is ScrollUpdateNotification) {
      final double delta = notification.scrollDelta ?? 0;
      _applyDelta(delta);
    } else if (notification is ScrollStartNotification) {
      _hasLast = false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final Duration duration =
        widget.duration ??
        resolveMotionDuration(context, ambient.motion.durations.fast);
    final Curve curve = widget.curve ?? ambient.motion.curves.standard;
    final double travel = widget.direction == FabHideOnScrollDirection.up
        ? -widget.offset
        : widget.offset;

    Widget child = AnimatedValueBuilder<double>(
      value: _hidden ? 1 : 0,
      duration: duration,
      curve: curve,
      builder: (BuildContext context, double t, Widget? inner) {
        return Transform.translate(
          offset: Offset(0, travel * t),
          child: Opacity(opacity: 1 - t, child: inner),
        );
      },
      child: widget.child,
    );

    if (widget.controller != null) {
      return child;
    }
    return NotificationListener<ScrollNotification>(
      onNotification: _handleNotification,
      child: child,
    );
  }
}
