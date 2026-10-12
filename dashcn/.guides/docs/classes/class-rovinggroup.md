---
title: "Class: RovingGroup"
description: "An index-ordered keyboard group: one tab stop, arrows move between enabled  rows (wrapping), Home/End jump, typing selects by prefix, ArrowRight opens  the focused row's nested level, Escape closes (one level, or all at root)."
---

```dart
/// An index-ordered keyboard group: one tab stop, arrows move between enabled
/// rows (wrapping), Home/End jump, typing selects by prefix, ArrowRight opens
/// the focused row's nested level, Escape closes (one level, or all at root).
class RovingGroup extends StatefulWidget {
  /// Creates a roving group.
  const RovingGroup({super.key, required this.children, required this.builder, this.parent, this.hasLeading = false, this.direction = Axis.vertical, this.itemPadding = EdgeInsets.zero, this.subMenuOffset, this.onDismissed, this.autofocus = false, this.onEscape});
  /// The rows of this group.
  final List<Widget> children;
  /// Lays out the rows.
  final Widget Function(BuildContext context, List<Widget> children) builder;
  /// Parent group data; null for a root group.
  final MenuGroupData? parent;
  /// Whether any row reserves a leading gutter.
  final bool hasLeading;
  /// Layout direction.
  final Axis direction;
  /// Extra row padding.
  final EdgeInsets itemPadding;
  /// Nested-level offset; null resolves the caller's default.
  final Offset? subMenuOffset;
  /// Called when the root group closes.
  final VoidCallback? onDismissed;
  /// Whether the group takes focus on mount.
  ///
  /// Defaults to false so inline surfaces never steal the page's initial
  /// focus; overlay helpers pass true for the opened menu.
  final bool autofocus;
  /// Escape handler; null closes one level (all of them at the root).
  final VoidCallback? onEscape;
  State<RovingGroup> createState();
}
```
