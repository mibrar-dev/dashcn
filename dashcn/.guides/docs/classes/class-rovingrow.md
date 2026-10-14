---
title: "Class: RovingRow"
description: "One focusable row in a [RovingGroup]: owns its focus node, registers its  traversal slot, and paints the row from resolved values."
---

```dart
/// One focusable row in a [RovingGroup]: owns its focus node, registers its
/// traversal slot, and paints the row from resolved values.
///
/// Theme-free by design: callers resolve their four theme legs and pass
/// concrete colours. Submenu behaviour (open on hover/ArrowRight) stays with
/// the caller through [onHover]/[onOpen].
class RovingRow extends StatefulWidget {
  /// Creates a roving row.
  const RovingRow({super.key, required this.child, this.leading, this.trailing, this.showChevron = false, this.reserveLeading = false, this.enabled = true, this.focusNode, this.onPressed, this.onHover, this.fill, this.highlightFill, this.foreground, this.highlightForeground, this.radius, this.padding, this.textStyle, this.minHeight = 32, this.label, this.onOpen, this.onClose, this.isOpen});
  /// Row content.
  final Widget child;
  /// Leading widget (indicator, icon or gutter spacer).
  final Widget? leading;
  /// Trailing widget.
  final Widget? trailing;
  /// Whether a submenu chevron follows [trailing].
  final bool showChevron;
  /// Whether to reserve a 16px leading gutter when [leading] is null.
  final bool reserveLeading;
  /// Whether the row interacts and takes part in traversal.
  final bool enabled;
  /// Focus node; owned internally when null.
  final FocusNode? focusNode;
  /// Called on tap and on Enter/Space while focused.
  final VoidCallback? onPressed;
  /// Called when the hover state changes.
  final ValueChanged<bool>? onHover;
  /// Resolved row fill; null draws none.
  final Color? fill;
  /// Resolved fill while hovered/focused/pressed; null resolves the `accent`
  /// token. Rows always show a hover/focus highlight (upstream
  /// `focus:bg-accent`).
  final Color? highlightFill;
  /// Resolved label/icon colour; null resolves the `foreground` token.
  final Color? foreground;
  /// Resolved label/icon colour while hovered/focused/pressed; null resolves
  /// the `accentForeground` token (upstream `focus:text-accent-foreground`).
  final Color? highlightForeground;
  /// Resolved corner radius; null resolves `borderRadiusSm`.
  final BorderRadius? radius;
  /// Resolved inner padding; null resolves px-2 py-1.5.
  final EdgeInsetsGeometry? padding;
  /// Resolved label style; its colour is ignored.
  final TextStyle? textStyle;
  /// Minimum row height.
  final double minHeight;
  /// Typeahead text; null falls back to a `Text` child's data.
  final String? label;
  /// Opens the row's nested level (ArrowRight).
  final VoidCallback? onOpen;
  /// Closes the row's nested level, if any.
  final VoidCallback? onClose;
  /// Whether the row's nested level is open.
  final bool Function()? isOpen;
  State<RovingRow> createState();
}
```
