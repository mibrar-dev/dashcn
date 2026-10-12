---
title: "Class: CalendarView"
description: "The month a calendar is showing: only *where the grid looks*."
---

```dart
/// The month a calendar is showing: only *where the grid looks*. Which dates
/// are selected is a separate [CalendarValue]. Midnight-anchored throughout, so
/// a DST transition cannot shift a cell.
class CalendarView {
  const CalendarView(this.year, this.month);
  factory CalendarView.fromDateTime(DateTime date);
  final int year;
  final int month;
  /// The next month, rolling into January.
  CalendarView get next;
  /// The previous month, rolling into December.
  CalendarView get previous;
  static DateTime monthStart(DateTime date);
  bool operator ==(Object other);
  int get hashCode;
}
```
