---
title: "Class: SelectRow"
description: "One selectable row: a [RovingRow] with the optional trailing check  indicator (upstream reserves the gutter whenever something is selected)."
---

```dart
/// One selectable row: a [RovingRow] with the optional trailing check
/// indicator (upstream reserves the gutter whenever something is selected).
///
/// Place it inside a `MenuGroup`; the row joins that group's traversal and
/// paints the shared menu row hover/focus highlight. Plain-text labels stay
/// on one line (`maxLines: 1`, ellipsis) so the popup grows to the widest
/// option instead of wrapping per character; the viewport is the only cap.
class SelectRow extends StatelessWidget {
  /// Creates a select row.
  const SelectRow({super.key, required this.child, this.selected = false, this.reserveIndicator = false, this.enabled = true, this.onPressed, this.padding, this.minHeight = 32});
  /// Row content.
  final Widget child;
  /// Whether the check indicator is shown.
  final bool selected;
  /// Whether the check gutter is reserved while [selected] is false.
  final bool reserveIndicator;
  /// Whether the row can be activated.
  final bool enabled;
  /// Called on tap and on Enter/Space while focused.
  final VoidCallback? onPressed;
  /// Row padding; null resolves the menu row default (upstream `px-2 py-1.5`)
  /// against the ambient density.
  final EdgeInsetsGeometry? padding;
  /// Minimum row height.
  final double minHeight;
  /// Default row padding for a selectable row: upstream `px-2 py-1.5`, as
  /// density multipliers resolved at build.
  static const EdgeInsetsGeometry defaultRowPadding = EdgeInsetsDensity.pxSymmetric(horizontal: 8, vertical: 6);
  Widget build(BuildContext context);
}
```
