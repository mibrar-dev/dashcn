---
title: "Class: RawTableLayout"
description: "Low-level table layout widget."
---

```dart
/// Low-level table layout widget.
///
/// Lays out [children] on a grid whose columns and rows are sized by [width]
/// and [height], with optional frozen rows/columns and scroll offsets.
class RawTableLayout extends MultiChildRenderObjectWidget {
  /// Creates a raw table layout.
  const RawTableLayout({super.key, super.children, required this.width, required this.height, required this.clipBehavior, this.frozenColumn, this.frozenRow, this.verticalOffset, this.horizontalOffset, this.viewportSize, this.textDirection = TextDirection.ltr});
  /// Column width supplier.
  final TableSizeSupplier width;
  /// Row height supplier.
  final TableSizeSupplier height;
  /// How content is clipped.
  final Clip clipBehavior;
  /// Frozen column predicate.
  final CellPredicate? frozenColumn;
  /// Frozen row predicate.
  final CellPredicate? frozenRow;
  /// Vertical scroll offset.
  final double? verticalOffset;
  /// Horizontal scroll offset.
  final double? horizontalOffset;
  /// Size of the visible viewport.
  final Size? viewportSize;
  /// Direction columns run in (columns stay logical under RTL).
  final TextDirection textDirection;
  RenderTableLayout createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, RenderTableLayout renderObject);
}
```
