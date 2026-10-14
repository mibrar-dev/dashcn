---
title: "Class: SelectItem"
description: "One selectable popup row."
---

```dart
/// One selectable popup row. Place it in [Select.items] or build it from
/// [Select.builder]; traversal, hover focus and the check indicator come
/// from the shared select row.
class SelectItem<T> extends StatelessWidget {
  /// Creates a select row.
  const SelectItem({super.key, required this.value, required this.child, this.enabled = true});
  /// The value this row selects.
  final T value;
  /// Row content.
  final Widget child;
  /// Whether the row can be activated (on top of the select's own state).
  final bool enabled;
  Widget build(BuildContext context);
}
```
