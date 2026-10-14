---
title: "Class: FilterBarSortControl"
description: "The sort dropdown of a `FilterBar`."
---

```dart
/// The sort dropdown of a `FilterBar`.
class FilterBarSortControl extends StatelessWidget {
  /// Creates the sort control.
  const FilterBarSortControl({super.key, required this.value, required this.options, required this.onChanged, this.width = 180});
  /// Selected option id, or null.
  final String? value;
  /// Options offered by the dropdown.
  final List<FilterSortOption> options;
  /// Called with the next option id (null clears the sort).
  final ValueChanged<String?> onChanged;
  /// Fixed control width.
  final double width;
  Widget build(BuildContext context);
}
```
