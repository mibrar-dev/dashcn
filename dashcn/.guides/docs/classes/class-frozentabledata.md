---
title: "Class: FrozenTableData"
description: "Frozen rows and columns of a table."
---

```dart
/// Frozen rows and columns of a table.
class FrozenTableData {
  /// Creates frozen row/column ranges.
  const FrozenTableData({this.frozenRows = const <TableRef>[], this.frozenColumns = const <TableRef>[]});
  /// Rows kept visible during vertical scrolling.
  final Iterable<TableRef> frozenRows;
  /// Columns kept visible during horizontal scrolling.
  final Iterable<TableRef> frozenColumns;
  /// Whether the row at [index] with [span] is frozen.
  bool testRow(int index, int span);
  /// Whether the column at [index] with [span] is frozen.
  bool testColumn(int index, int span);
}
```
