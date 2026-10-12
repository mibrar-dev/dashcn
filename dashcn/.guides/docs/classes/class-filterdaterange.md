---
title: "Class: FilterDateRange"
description: "A start/end date span; either end may be null."
---

```dart
/// A start/end date span; either end may be null.
class FilterDateRange {
  /// Creates a date range.
  const FilterDateRange({this.start, this.end});
  /// First day, or null.
  final DateTime? start;
  /// Last day, or null.
  final DateTime? end;
  /// Whether both ends are null.
  bool get isEmpty;
  bool operator ==(Object other);
  int get hashCode;
}
```
