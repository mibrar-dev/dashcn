---
title: "Class: TableViewRow"
description: "One row of a `table`."
---

```dart
/// One row of a `table`.
class TableViewRow implements TableRowLike<TableViewCell> {
  /// Creates a row.
  const TableViewRow({required this.cells, this.selected = false});
  final List<TableViewCell> cells;
  final bool selected;
  bool operator ==(Object other);
  int get hashCode;
}
```
