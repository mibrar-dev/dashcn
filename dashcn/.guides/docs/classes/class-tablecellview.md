---
title: "Class: TableCellView"
description: "Renders one cell: hover tracking, a bottom border, padding and text style."
---

```dart
/// Renders one cell: hover tracking, a bottom border, padding and text style.
class TableCellView extends StatelessWidget {
  /// Creates a cell view.
  const TableCellView({super.key, required this.child, required this.current, required this.hoveredNotifier, this.draggingNotifier, this.columnHover = false, this.rowHover = true, this.selected = false, this.enabled = true, this.background, this.foreground, this.borderColor, this.borderWidth, this.textStyle, this.padding, this.minHeight});
  /// Cell content.
  final Widget child;
  /// This cell's grid range.
  final TableCellRange current;
  /// Notifier of the hovered cell range.
  final ValueNotifier<TableCellRange?> hoveredNotifier;
  /// Notifier of an active resize drag (suppresses hover while dragging).
  final ValueNotifier<TableResizeLine?>? draggingNotifier;
  /// Whether hovering another cell in the same column highlights this one.
  final bool columnHover;
  /// Whether hovering another cell in the same row highlights this one.
  final bool rowHover;
  /// Whether the row is selected.
  final bool selected;
  /// Whether the cell responds to hover.
  final bool enabled;
  /// Per-state fill.
  final StateValue<ThemedColor>? background;
  /// Per-state text colour.
  final StateValue<ThemedColor>? foreground;
  /// Per-state bottom-border colour.
  final StateValue<ThemedColor>? borderColor;
  /// Bottom-border width.
  final double? borderWidth;
  /// Text style override (colour comes from [foreground]).
  final TextStyle? textStyle;
  /// Inner padding.
  final EdgeInsetsGeometry? padding;
  /// Minimum cell height.
  final double? minHeight;
  Widget build(BuildContext context);
}
```
