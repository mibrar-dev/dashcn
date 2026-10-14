// Edge anchoring and region layout for gooey toasts.
//
// Pure geometry and one thin widget: nothing here owns state or imports a
// component, so the `gooey_toast` controller only has to resolve a
// [ToastPlacement] (from `primitives/toast_queue`) into screen anchors and ask
// how far a region stacks. Keeping the maths here is what lets the controller
// stay readable.
//
// Anchors are *physical* edges resolved with a `TextDirection` mirror: a leading
// toast sits on the left in LTR and on the right in RTL, so RTL keeps the toast
// next to the text it belongs to.

import 'package:flutter/widgets.dart';

import '../toast_queue/toast_placement.dart';

/// Distance from the window edge a gooey toast anchors at.
const double kGooeyEdgeInset = 16;

/// Distance between two toasts stacked in one region.
const double kGooeyStackGap = 8;

/// Resolved screen anchors of one gooey toast.
///
/// Exactly one horizontal (left/right) and one vertical (top/bottom) anchor is
/// set; the other of each pair is null so the toast keeps its intrinsic size on
/// that axis.
@immutable
class GooeyEdgeAnchors {
  /// Creates anchors.
  const GooeyEdgeAnchors({this.left, this.right, this.top, this.bottom});

  /// Anchors for [placement] inside [viewport].
  ///
  /// `leading`/`trailing` resolve through [textDirection] so an RTL layout
  /// mirrors the horizontal anchor. A horizontally centred toast spans the full
  /// width and is centred by its child's alignment, never by a left inset.
  factory GooeyEdgeAnchors.resolve({
    required ToastPlacement placement,
    required double width,
    required Size viewport,
    required TextDirection textDirection,
    double inset = kGooeyEdgeInset,
  }) {
    final double? left;
    final double? right;
    if (placement.isCenter) {
      left = 0;
      right = 0;
    } else {
      final bool onLeft = placement.isLeading
          ? textDirection == TextDirection.ltr
          : textDirection == TextDirection.rtl;
      left = onLeft ? inset : null;
      right = onLeft ? null : inset;
    }
    return GooeyEdgeAnchors(
      left: left,
      right: right,
      top: placement.isTop ? inset : null,
      bottom: placement.isTop ? null : inset,
    );
  }

  /// Left inset, or null when the toast anchors right.
  final double? left;

  /// Right inset, or null when the toast anchors left or centre.
  final double? right;

  /// Top inset, or null when the toast anchors to the bottom.
  final double? top;

  /// Bottom inset, or null when the toast anchors to the top.
  final double? bottom;
}

/// Offsets one region's toasts away from their shared edge.
///
/// The newest toast (index 0) sits nearest the edge; every older one is pushed
/// [gap] further away. [overlapOffset] replaces the gap when the region asks
/// for overlap stacking, and [maxVisible] hides the tail of the stack
/// (`0` keeps everything).
@immutable
class GooeyStackLayout {
  /// Creates a layout.
  const GooeyStackLayout({
    this.gap = kGooeyStackGap,
    this.overlapOffset,
    this.maxVisible = 0,
  });

  /// Distance between stacked toasts.
  final double gap;

  /// Per-item offset used instead of [gap] when overlap stacking is on.
  final double? overlapOffset;

  /// Maximum visible entries; `0` keeps all of them.
  final int maxVisible;

  /// Whether the entry at [index] is visible.
  bool isVisible(int index) => maxVisible <= 0 || index < maxVisible;

  /// Offset of the entry at [index] from the region edge.
  double offsetAt(int index) {
    if (index <= 0) {
      return 0;
    }
    return index * (overlapOffset ?? gap);
  }
}

/// Places one gooey toast inside an [Overlay]'s stack at [anchors].
///
/// [offset] is the distance pushed away from the shared edge; it animates, so a
/// toast leaving the region slides the remaining ones into place instead of
/// jumping.
class GooeyAnchoredEntry extends StatelessWidget {
  /// Creates an anchored entry.
  const GooeyAnchoredEntry({
    super.key,
    required this.anchors,
    required this.offset,
    this.duration = const Duration(milliseconds: 220),
    required this.child,
  });

  /// Resolved anchors of this toast.
  final GooeyEdgeAnchors anchors;

  /// Distance pushed away from the region edge.
  final double offset;

  /// Reflow duration of the stack offset.
  final Duration duration;

  /// Toast content.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bool centred = anchors.left != null && anchors.right != null;
    return AnimatedPositioned(
      duration: duration,
      curve: Curves.easeOutCubic,
      top: anchors.top == null ? null : anchors.top! + offset,
      bottom: anchors.bottom == null ? null : anchors.bottom! + offset,
      left: anchors.left,
      right: anchors.right,
      child: centred
          ? Align(
              alignment: anchors.top != null
                  ? Alignment.topCenter
                  : Alignment.bottomCenter,
              child: child,
            )
          : child,
    );
  }
}
