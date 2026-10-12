---
title: "Class: GooeyStackLayout"
description: "Offsets one region's toasts away from their shared edge."
---

```dart
/// Offsets one region's toasts away from their shared edge.
///
/// The newest toast (index 0) sits nearest the edge; every older one is pushed
/// [gap] further away. [overlapOffset] replaces the gap when the region asks
/// for overlap stacking, and [maxVisible] hides the tail of the stack
/// (`0` keeps everything).
class GooeyStackLayout {
  /// Creates a layout.
  const GooeyStackLayout({this.gap = kGooeyStackGap, this.overlapOffset, this.maxVisible = 0});
  /// Distance between stacked toasts.
  final double gap;
  /// Per-item offset used instead of [gap] when overlap stacking is on.
  final double? overlapOffset;
  /// Maximum visible entries; `0` keeps all of them.
  final int maxVisible;
  /// Whether the entry at [index] is visible.
  bool isVisible(int index);
  /// Offset of the entry at [index] from the region edge.
  double offsetAt(int index);
}
```
