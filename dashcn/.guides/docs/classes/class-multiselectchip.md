---
title: "Class: MultiSelectChip"
description: "A removable chip for a [MultiSelect] trigger: shows [child] and removes  [value] from the selection when its close control is pressed."
---

```dart
/// A removable chip for a [MultiSelect] trigger: shows [child] and removes
/// [value] from the selection when its close control is pressed.
class MultiSelectChip<T> extends StatelessWidget {
  /// Creates a multi-select chip.
  const MultiSelectChip({super.key, required this.value, required this.child, this.enabled = true});
  /// The value this chip represents.
  final T value;
  /// Chip content.
  final Widget child;
  /// Whether the remove control is shown (on top of the select's state).
  final bool enabled;
  Widget build(BuildContext context);
}
```
