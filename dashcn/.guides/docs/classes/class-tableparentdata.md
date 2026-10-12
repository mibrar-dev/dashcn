---
title: "Class: TableParentData"
description: "Parent data that positions one cell inside a table layout."
---

```dart
/// Parent data that positions one cell inside a table layout.
class TableParentData extends ContainerBoxParentData<RenderBox> {
  /// Column index of this cell.
  int? column;
  /// Row index of this cell.
  int? row;
  /// Number of columns this cell spans.
  int? columnSpan;
  /// Number of rows this cell spans.
  int? rowSpan;
  /// Whether this cell contributes to column/row sizing.
  bool computeSize;
  /// Whether this cell's row is frozen.
  bool frozenRow;
  /// Whether this cell's column is frozen.
  bool frozenColumn;
}
```
