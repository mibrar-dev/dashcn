---
title: "Class: FilterBarDateControl"
description: "The date-range control of a `FilterBar` (popover editor)."
---

```dart
/// The date-range control of a `FilterBar` (popover editor).
class FilterBarDateControl extends StatelessWidget {
  /// Creates the date control.
  const FilterBarDateControl({super.key, required this.value, required this.onChanged, this.width = 180});
  /// Selected span, or null.
  final FilterDateRange? value;
  /// Called with the next span (null clears it).
  final ValueChanged<FilterDateRange?> onChanged;
  /// Fixed control width.
  final double width;
  Widget build(BuildContext context);
}
```
