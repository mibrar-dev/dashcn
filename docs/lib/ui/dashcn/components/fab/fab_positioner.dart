// The positions helper of the `fab` component: [FabPositioner] places a
// floating action button in one of the nine anchor positions of its parent
// (a `Stack`, a `Scaffold` body or any box).
//
// The alignment is directional, so the helper mirrors in RTL: `topStart`
// becomes top-right and `bottomEnd` becomes bottom-left.

import 'package:flutter/widgets.dart';

import '../../theme/density.dart';
import '../../theme/theme.dart';

/// Where a floating action button sits inside its parent.
enum FabPosition {
  /// Top, aligned to the start edge.
  topStart,

  /// Top, centred.
  topCenter,

  /// Top, aligned to the end edge.
  topEnd,

  /// Middle, aligned to the start edge.
  centerStart,

  /// Middle, centred.
  center,

  /// Middle, aligned to the end edge.
  centerEnd,

  /// Bottom, aligned to the start edge.
  bottomStart,

  /// Bottom, centred.
  bottomCenter,

  /// Bottom, aligned to the end edge.
  bottomEnd,
}

/// The directional alignment for [position].
AlignmentDirectional fabAlignmentFor(FabPosition position) {
  return switch (position) {
    FabPosition.topStart => AlignmentDirectional.topStart,
    FabPosition.topCenter => AlignmentDirectional.topCenter,
    FabPosition.topEnd => AlignmentDirectional.topEnd,
    FabPosition.centerStart => AlignmentDirectional.centerStart,
    FabPosition.center => AlignmentDirectional.center,
    FabPosition.centerEnd => AlignmentDirectional.centerEnd,
    FabPosition.bottomStart => AlignmentDirectional.bottomStart,
    FabPosition.bottomCenter => AlignmentDirectional.bottomCenter,
    FabPosition.bottomEnd => AlignmentDirectional.bottomEnd,
  };
}

/// Places [child] at [position] inside its parent.
///
/// The helper is a `Stack`-friendly widget: it fills the parent and aligns
/// the child with [position]. [padding] keeps the button off the parent's
/// edges (16 px by default, density-scaled) and [offset] nudges it further
/// (the offset is directional, so it mirrors in RTL).
class FabPositioner extends StatelessWidget {
  /// Creates a positions helper.
  const FabPositioner({
    super.key,
    required this.position,
    required this.child,
    this.padding,
    this.offset = Offset.zero,
  });

  /// Where the child sits.
  final FabPosition position;

  /// The floating action button.
  final Widget child;

  /// Space kept between the child and the parent's edges; null uses 16 px.
  final EdgeInsetsGeometry? padding;

  /// Extra nudge applied after the alignment (directional).
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final EdgeInsets resolvedPadding = resolveEdgeInsets(
      padding ?? fabPositionerDefaultPadding,
      ambient.density.baseContentPadding * ambient.scaling,
    ).resolve(Directionality.of(context));
    final bool rtl = Directionality.of(context) == TextDirection.rtl;
    final Offset resolvedOffset = rtl ? Offset(-offset.dx, offset.dy) : offset;
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Padding(
          padding: resolvedPadding,
          child: Align(
            alignment: fabAlignmentFor(position),
            child: Transform.translate(offset: resolvedOffset, child: child),
          ),
        ),
      ],
    );
  }
}

/// Default inset of the positions helper (16 px, density-scaled).
const EdgeInsetsGeometry fabPositionerDefaultPadding = EdgeInsetsDensity.pxAll(
  16,
);
