---
title: "Class: FilterBarSheetTrigger"
description: "The sheet trigger of a `FilterBar` (label plus active-filter count)."
---

```dart
/// The sheet trigger of a `FilterBar` (label plus active-filter count).
class FilterBarSheetTrigger extends StatelessWidget {
  /// Creates the sheet trigger.
  const FilterBarSheetTrigger({super.key, required this.activeCount, required this.onPressed, this.dense = false});
  /// Number of active filters, appended to the label when non-zero.
  final int activeCount;
  /// Opens the sheet.
  final VoidCallback onPressed;
  /// Compact size.
  final bool dense;
  Widget build(BuildContext context);
}
```
