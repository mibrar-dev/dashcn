---
title: "Class: ScrollMetricsSnapshot"
description: "An immutable copy of the scroll position values scroll components need,  plus the values derived from them (progress, edge fractions, thumb  geometry)."
---

```dart
/// An immutable copy of the scroll position values scroll components need,
/// plus the values derived from them (progress, edge fractions, thumb
/// geometry).
class ScrollMetricsSnapshot {
  /// Creates a snapshot from explicit values.
  const ScrollMetricsSnapshot({required this.pixels, this.minScrollExtent = 0, required this.maxScrollExtent, required this.viewportDimension, this.axis = Axis.vertical, this.axisDirection = AxisDirection.down});
  /// Reads a snapshot from a live [ScrollMetrics] (a scroll notification's).
  factory ScrollMetricsSnapshot.fromMetrics(ScrollMetrics metrics);
  /// Current scroll offset.
  final double pixels;
  /// Lower bound of [pixels].
  final double minScrollExtent;
  /// Upper bound of [pixels].
  final double maxScrollExtent;
  /// Size of the visible window.
  final double viewportDimension;
  /// Scroll axis.
  final Axis axis;
  /// Direction content moves when scrolling forward.
  final AxisDirection axisDirection;
  /// Total distance the position can travel, never negative.
  double get scrollableExtent;
  /// Whether the content extends beyond the viewport.
  bool get canScroll;
  /// Whether [pixels] sits at or before the leading edge.
  bool get atStart;
  /// Whether [pixels] sits at or past the trailing edge.
  bool get atEnd;
  /// Whether the axis starts at the right/bottom ([AxisDirection.up] or
  /// [AxisDirection.left]).
  bool get reversed;
  /// Position between the edges: 0 at [minScrollExtent], 1 at
  /// [maxScrollExtent]; 0 when there is nothing to scroll.
  double get progress;
  /// Signed distance outside the edges: negative before the start, positive
  /// past the end, zero while in range.
  double get overscrollPixels;
  /// Leading fade strength: 0 at the leading edge, 1 once the position is
  /// [extent] past it. A non-positive [extent] yields 0.
  double leadingFadeFraction(double extent);
  /// Trailing fade strength: 0 at the trailing edge, 1 when the position is
  /// [extent] before it.
  double trailingFadeFraction(double extent);
  /// Leading overscroll strength: 0 while in range, 1 when dragged [extent]
  /// before the leading edge.
  double leadingOverscrollFraction(double extent);
  /// Trailing overscroll strength: 0 while in range, 1 when dragged [extent]
  /// past the trailing edge.
  double trailingOverscrollFraction(double extent);
  /// Length of a scrollbar thumb in a track [trackExtent] long.
  ///
  /// Reflects the visible fraction of the content and never shrinks below
  /// [minExtent] (itself capped at the track length).
  double thumbExtent(double trackExtent, {double minExtent = kMinScrollbarThumbExtent});
  /// Distance of the thumb from the leading edge of its track, between 0 and
  /// `trackExtent - thumbExtent`.
  ///
  /// [reversed] defaults to this snapshot's own orientation, which puts the
  /// thumb at the far end when the axis is reversed (up/left).
  double thumbOffset(double trackExtent, double thumbExtent, {bool? reversed});
  /// Scroll offset that places the thumb [thumbOffset] from the leading edge;
  /// the inverse of [thumbOffset].
  double pixelsForThumbOffset({required double thumbOffset, required double trackExtent, required double thumbExtent});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
