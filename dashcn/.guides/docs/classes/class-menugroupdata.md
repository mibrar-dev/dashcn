---
title: "Class: MenuGroupData"
description: "Shared state of one [RovingGroup]: hierarchy links and the close fan-out."
---

```dart
/// Shared state of one [RovingGroup]: hierarchy links and the close fan-out.
class MenuGroupData {
  /// Creates group data.
  MenuGroupData({this.parent, this.hasLeading = false, this.direction = Axis.vertical, this.itemPadding = EdgeInsets.zero, this.subMenuOffset, this.onDismissed});
  /// Parent group; null for the root group of a menu.
  final MenuGroupData? parent;
  /// Whether any row reserves a leading gutter.
  final bool hasLeading;
  /// Layout direction of the rows.
  final Axis direction;
  /// Extra padding added to every row.
  final EdgeInsets itemPadding;
  /// Nested-level offset; null resolves the caller's default.
  final Offset? subMenuOffset;
  /// Called when the root group closes.
  final VoidCallback? onDismissed;
  /// Traversal slots, in child order.
  final List<MenuNavSlot> slots;
  /// Open child groups, for subtree closes.
  final List<MenuGroupData> subgroups;
  /// Whether any tracked nested level is open.
  bool get hasOpenPopovers;
  /// Closes this level and every open level below it.
  void closeOthers();
  /// Closes the whole menu by bubbling to the root.
  void closeAll();
  /// The root group of this menu.
  MenuGroupData get root;
}
```
