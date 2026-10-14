---
title: "Class: FilterBarSearchField"
description: "The search field of a `FilterBar` (leading icon + clear action)."
---

```dart
/// The search field of a `FilterBar` (leading icon + clear action).
class FilterBarSearchField extends StatelessWidget {
  /// Creates the search field.
  const FilterBarSearchField({super.key, required this.controller, required this.onChanged, this.width = 220});
  /// Owns the query text.
  final TextEditingController controller;
  /// Called on every edit (the bar debounces it).
  final ValueChanged<String> onChanged;
  /// Fixed field width.
  final double width;
  Widget build(BuildContext context);
}
```
