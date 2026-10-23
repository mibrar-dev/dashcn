// Sliding active indicator: one pill that glides behind a row of items to the
// active item, instead of each item drawing its own selected background.
//
// [SlidingIndicator] lays [child] out as-is and paints a pill behind it. After
// each frame it reads the box of the item keyed by [activeKey] (relative to
// its own box) and animates the pill's rectangle there over the theme base
// token (200 ms, standard curve). Reduced motion (or the theme master switch)
// jumps straight to the new rectangle with no ticker.
//
// Widgets-only (no Material/Cupertino).

import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import 'motion_scope.dart';

/// Glides a pill behind [child] to the item whose key is [activeKey].
class SlidingIndicator extends StatefulWidget {
  /// Creates a sliding indicator.
  const SlidingIndicator({
    super.key,
    required this.activeKey,
    required this.color,
    required this.borderRadius,
    required this.child,
    this.underline = false,
  });

  /// When true the indicator is a [underlineThickness] bar along the bottom
  /// edge of the active item, painted over the items (no pointer hits).
  /// Used where items paint opaque fills (pagination pages).
  final bool underline;

  /// Global key attached to the active item inside [child]; null hides the pill.
  final GlobalKey? activeKey;

  /// Fill of the pill.
  final Color color;

  /// Thickness of the underline variant.
  static const double underlineThickness = 2;

  /// Corner radius of the pill.
  final BorderRadiusGeometry borderRadius;

  /// The items. Keys must be attached to the items, not to this widget.
  final Widget child;

  @override
  State<SlidingIndicator> createState() => SlidingIndicatorState();
}

/// State of [SlidingIndicator]; exposes the measured [rect] for tests.
class SlidingIndicatorState extends State<SlidingIndicator> {
  Rect? _rect;

  /// Current pill rectangle in this widget's coordinates, once measured.
  Rect? get rect => _rect;

  void _measure() {
    if (!mounted) {
      return;
    }
    final RenderObject? self = context.findRenderObject();
    final GlobalKey? key = widget.activeKey;
    final RenderObject? item = key?.currentContext?.findRenderObject();
    if (self is! RenderBox || !self.hasSize) {
      return;
    }
    if (item is! RenderBox || !item.hasSize) {
      if (_rect != null) {
        setState(() => _rect = null);
      }
      return;
    }
    final Offset origin = self.globalToLocal(item.localToGlobal(Offset.zero));
    final Rect box = origin & item.size;
    final Rect next = widget.underline
        ? Rect.fromLTWH(
            box.left,
            box.bottom - SlidingIndicator.underlineThickness,
            box.width,
            SlidingIndicator.underlineThickness,
          )
        : box;
    if (next != _rect) {
      setState(() => _rect = next);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Re-measure after every frame; a setState only happens when the item's
    // rectangle actually moved, so this settles in one extra frame.
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
    final Rect? rect = _rect;
    final ThemeData theme = Theme.of(context);
    final Widget pill = rect == null
        ? const SizedBox.shrink()
        : AnimatedPositioned(
            left: rect.left,
            top: rect.top,
            width: rect.width,
            height: rect.height,
            duration: resolveMotionDuration(
              context,
              theme.motion.durations.base,
            ),
            curve: theme.motion.curves.standard,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: widget.borderRadius,
              ),
            ),
          );
    if (widget.underline) {
      return Stack(
        children: <Widget>[
          widget.child,
          Positioned.fill(
            child: IgnorePointer(child: Stack(children: <Widget>[pill])),
          ),
        ],
      );
    }
    return Stack(children: <Widget>[pill, widget.child]);
  }
}
