---
title: "Class: SelectableData"
description: "The selection scope the items of one group read."
---

```dart
/// The selection scope the items of one group read.
class SelectableData<T> {
  /// Creates the scope.
  const SelectableData({required this.selected, required this.enabled, this.onChanged});
  /// The currently selected value.
  final T? selected;
  /// Whether the group accepts input.
  final bool enabled;
  /// Reports a new selection; null makes the scope read-only, which is what an
  /// item outside a group sees.
  final ValueChanged<T>? onChanged;
  /// Selects [value] when the group accepts input.
  void select(T value);
  bool operator ==(Object other);
  int get hashCode;
}
```
