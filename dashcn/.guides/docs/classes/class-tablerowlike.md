---
title: "Class: TableRowLike"
description: "The fields a table row model exposes to [flattenTableCells]."
---

```dart
/// The fields a table row model exposes to [flattenTableCells].
abstract class TableRowLike<T extends TableCellLike> {
  /// Cells of the row.
  List<T> get cells;
  /// Whether the row is selected.
  bool get selected;
}
```
