---
title: "Class: MultiSelectItem"
description: "A checkbox row for a [MultiSelect] popup: toggles its value and keeps the  popup open (the menu's `MenuCheckboxItem` bound to the select data)."
---

```dart
/// A checkbox row for a [MultiSelect] popup: toggles its value and keeps the
/// popup open (the menu's `MenuCheckboxItem` bound to the select data).
class MultiSelectItem<T> extends StatelessWidget {
  /// Creates a multi-select checkbox row.
  const MultiSelectItem({super.key, required this.value, required this.child, this.enabled = true});
  /// The value this row toggles.
  final T value;
  /// Row content.
  final Widget child;
  /// Whether the row can be toggled (on top of the select's own state).
  final bool enabled;
  Widget build(BuildContext context);
}
```
