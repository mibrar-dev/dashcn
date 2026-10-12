---
title: "Class: ControlledComponentData"
description: "The state [ControlledComponentAdapter."
---

```dart
/// The state [ControlledComponentAdapter.builder] receives each build.
///
/// [value] is the value to render, [onChanged] is the only way to request a
/// change, and [enabled] says whether to wire up interaction at all.
class ControlledComponentData<T> {
  /// Creates the data handed to a builder.
  const ControlledComponentData({required this.value, required this.onChanged, required this.enabled});
  /// The value to display.
  final T value;
  /// Requests a new value.
  final ValueChanged<T> onChanged;
  /// Whether the component accepts input.
  final bool enabled;
}
```
