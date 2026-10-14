---
title: "Class: NavigationItemRow"
description: "The layout/interaction half of one navigation item."
---

```dart
/// The layout/interaction half of one navigation item.
///
/// The caller resolves the theme slices (`background`, `foreground`, ...) and
/// passes plain values, so this file never reads a component theme.
class NavigationItemRow extends StatefulWidget {
  /// Creates a navigation row.
  const NavigationItemRow({super.key, required this.child, this.label, this.selected = false, this.enabled = true, this.showLabel = false, this.position = NavigationLabelPosition.bottom, this.spacing = 8, this.labelStyle, this.overflow = TextOverflow.clip, this.wrapLabel, this.background, this.foreground, this.borderColor, this.borderWidth = 1, this.padding, this.minHeight, this.textStyle, this.onPressed, this.focusNode, this.registryValue});
  /// Main content (usually an icon).
  final Widget child;
  /// Optional label.
  final Widget? label;
  /// Whether the row is the current selection.
  final bool selected;
  /// Whether the row accepts input.
  final bool enabled;
  /// Whether the label is expanded; it collapses with an animation otherwise.
  final bool showLabel;
  /// Label position relative to [child].
  final NavigationLabelPosition position;
  /// Space between the icon and the label.
  final double spacing;
  /// Label text style; its colour is taken from [foreground].
  final TextStyle? labelStyle;
  /// Label text overflow when no [wrapLabel] handles it.
  final TextOverflow overflow;
  /// Extra wrapper for the label (marquee, tooltip); null uses [overflow].
  final Widget Function(Widget label)? wrapLabel;
  /// Per-state fill.
  final StateValue<ThemedColor>? background;
  /// Per-state foreground for the content and label.
  final StateValue<ThemedColor>? foreground;
  /// Per-state border; null draws none.
  final StateValue<ThemedColor>? borderColor;
  /// Border width used when [borderColor] resolves non-null.
  final double borderWidth;
  /// Row padding; null resolves `navigationItemDefaultPadding` (12x8).
  final EdgeInsetsGeometry? padding;
  /// Content box minimum height; null adds none.
  final double? minHeight;
  /// Text style before the foreground colour is applied.
  final TextStyle? textStyle;
  /// Called when the row is pressed.
  final VoidCallback? onPressed;
  /// Focus node; one is created and disposed when null.
  final FocusNode? focusNode;
  /// Value registered with the nearest `RovingGroupRegistry<int>`; null skips
  /// registration.
  final int? registryValue;
  State<NavigationItemRow> createState();
}
```
