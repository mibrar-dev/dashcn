---
title: "Class: MultiCalendarValue"
description: "Any number of selected dates."
---

```dart
/// Any number of selected dates.
class MultiCalendarValue extends CalendarValue {
  /// Selects [dates].
  const MultiCalendarValue(this.dates);
  final List<DateTime> dates;
  CalendarValueLookup lookupDate(DateTime date);
  CalendarValueLookup lookupMonth(int year, int month);
  CalendarValueLookup lookupYear(int year);
  bool operator ==(Object other);
  int get hashCode;
}
```
