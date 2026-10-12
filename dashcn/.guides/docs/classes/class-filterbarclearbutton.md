---
title: "Class: FilterBarClearButton"
description: "The clear-all action of a `FilterBar`."
---

```dart
/// The clear-all action of a `FilterBar`.
class FilterBarClearButton extends StatelessWidget {
  /// Creates the clear button.
  const FilterBarClearButton({super.key, required this.enabled, required this.onPressed, this.dense = false});
  /// Whether the action is active.
  final bool enabled;
  /// Called when pressed.
  final VoidCallback onPressed;
  /// Compact size.
  final bool dense;
  Widget build(BuildContext context);
}
```
