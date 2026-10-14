---
title: "Class: MenuGroup"
description: "A keyboard-navigable list of rows over [RovingGroup] (headers and  separators render without taking focus)."
---

```dart
/// A keyboard-navigable list of rows over [RovingGroup] (headers and
/// separators render without taking focus).
///
/// Inline surfaces never take focus on mount; pass `autofocus: true` for an
/// opened overlay menu (the `show*` helpers do this for you).
class MenuGroup extends RovingGroup {
  MenuGroup({super.key, required super.children, super.builder = columnMenuBuilder, super.parent, super.direction, super.itemPadding = EdgeInsets.zero, super.subMenuOffset, super.onDismissed, super.autofocus = false});
}
```
