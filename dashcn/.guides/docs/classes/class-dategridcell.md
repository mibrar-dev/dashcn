---
title: "Class: DateGridCell"
description: "A single cell of a [monthGrid]: a date plus its position in the grid."
---

```dart
/// A single cell of a [monthGrid]: a date plus its position in the grid.
class DateGridCell {
  /// Creates a grid cell.
  const DateGridCell({required this.date, required this.indexInRow, required this.rowIndex, required this.fromAnotherMonth});
  /// The date this cell shows.
  final DateTime date;
  /// Column of this cell, 0-6, counting from the first day of the week.
  final int indexInRow;
  /// Row of this cell, 0-based.
  final int rowIndex;
  /// Whether the date falls outside the grid's primary month.
  final bool fromAnotherMonth;
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
