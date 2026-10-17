// Staggered fade-up for first-show lists.
// StaggerChildren wraps each child in a fade-slide with a growing
// start delay (35 ms per index, at most [maxStaggered] items staggered;
// later items share the last delay). Layout comes from [layout], which
// defaults to a [Column]; pass a custom builder for rows, grids or other
// arrangements. Transform/opacity only, so layout never jumps. Under
// reduced motion every child builds final with no tickers or timers.

import 'package:flutter/widgets.dart';

import 'fade_slide_in.dart';

/// Staggers the fade-up of [children] on first show.
class StaggerChildren extends StatelessWidget {
  /// Creates staggered first-show children.
  const StaggerChildren({
    super.key,
    required this.children,
    this.layout,
    this.step = const Duration(milliseconds: 35),
    this.maxStaggered = 6,
    this.offset = const Offset(0, 8),
    this.duration,
    this.curve,
  });

  /// The items to stagger.
  final List<Widget> children;

  /// Lays out the staggered items. Defaults to a `Column`.
  final Widget Function(BuildContext context, List<Widget> items)? layout;

  /// Delay added per index.
  final Duration step;

  /// At most this many items get growing delays; later items reuse the
  /// last delay.
  final int maxStaggered;

  /// Slide distance each item arrives from.
  final Offset offset;

  /// Per-item transition duration. Defaults to the theme base.
  final Duration? duration;

  /// Per-item transition curve. Defaults to emphasized-out.
  final Curve? curve;

  @override
  Widget build(BuildContext context) {
    final int capped = maxStaggered < 1 ? 1 : maxStaggered;
    final List<Widget> items = <Widget>[
      for (int i = 0; i < children.length; i++)
        FadeSlideIn(
          offset: offset,
          duration: duration,
          curve: curve,
          delay: step * (i < capped ? i : capped - 1),
          child: children[i],
        ),
    ];
    final builder = layout;
    if (builder != null) {
      return builder(context, items);
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: items,
    );
  }
}
