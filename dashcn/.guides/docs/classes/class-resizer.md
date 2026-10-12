---
title: "Class: Resizer"
description: "Manages the resizing of multiple [ResizableItem]s in a layout."
---

```dart
/// Manages the resizing of multiple [ResizableItem]s in a layout.
///
/// Handles dragging dividers, expanding/collapsing items, borrowing and
/// redistributing space between items and respecting min/max constraints.
class Resizer {
  /// The list of resizable items being managed.
  final List<ResizableItem> items;
  /// Ratio threshold for collapsing an item (0.0 to 1.0).
  ///
  /// When an item gets smaller than `min + (collapsedSize - min) *
  /// collapseRatio`, it collapses.
  final double collapseRatio;
  /// Ratio threshold for expanding a collapsed item (0.0 to 1.0).
  final double expandRatio;
  Resizer(this.items, {this.collapseRatio = 0.5, this.expandRatio = 0.5});
  /// Attempts to expand the item at [index] by [delta] in [direction].
  ///
  /// [direction] can be -1 (borrow from left), 0 (borrow from both sides) or
  /// 1 (borrow from right). Returns true when the expansion succeeded.
  bool attemptExpand(int index, int direction, double delta);
  /// Attempts to collapse the item at [index] in [direction].
  ///
  /// [direction] can be -1 (give space to left), 0 (give to both sides) or
  /// 1 (give space to right). Returns true when the collapse succeeded.
  bool attemptCollapse(int index, int direction);
  /// Attempts to expand a collapsed item at [index] in [direction].
  ///
  /// [direction] can be -1 (borrow from left), 0 (borrow from both sides) or
  /// 1 (borrow from right). Returns true when the expansion succeeded.
  bool attemptExpandCollapsed(int index, int direction);
  /// Handles dragging the divider at [index] by [delta] pixels.
  ///
  /// The divider at [index] is between item [index - 1] and item [index].
  void dragDivider(int index, double delta);
  /// Resets all items to their committed sizes and collapsed states.
  void reset();
}
```
