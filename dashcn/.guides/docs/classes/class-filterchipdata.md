---
title: "Class: FilterChipData"
description: "One removable chip: [key] identifies it, [label] is what users read."
---

```dart
/// One removable chip: [key] identifies it, [label] is what users read.
class FilterChipData {
  /// Creates a chip.
  const FilterChipData({required this.key, required this.label});
  /// Stable identity used by [FilterStateExtensions.withoutChip].
  final String key;
  /// Chip text.
  final String label;
  bool operator ==(Object other);
  int get hashCode;
}
```
