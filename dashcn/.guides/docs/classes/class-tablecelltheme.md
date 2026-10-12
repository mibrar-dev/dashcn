---
title: "Class: TableCellTheme"
description: "State-aware styling of one table cell."
---

```dart
/// State-aware styling of one table cell.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining states/fields.
class TableCellTheme implements Mergeable<TableCellTheme> {
  /// Creates a cell theme.
  const TableCellTheme({this.background, this.foreground, this.borderColor, this.borderWidth, this.textStyle, this.padding, this.minHeight});
  /// Per-state fill of the cell.
  final StateValue<ThemedColor>? background;
  /// Per-state text colour.
  final StateValue<ThemedColor>? foreground;
  /// Per-state bottom-border colour; null draws no border.
  final StateValue<ThemedColor>? borderColor;
  /// Bottom-border width used when [borderColor] resolves non-null.
  final double? borderWidth;
  /// Text style override; its colour is ignored (taken from [foreground]).
  final TextStyle? textStyle;
  /// Inner padding; null adds none.
  final EdgeInsetsGeometry? padding;
  /// Minimum cell height; null adds none.
  final double? minHeight;
  /// Returns a copy with the given fields replaced.
  TableCellTheme copyWith({ValueGetter<StateValue<ThemedColor>?>? background, ValueGetter<StateValue<ThemedColor>?>? foreground, ValueGetter<StateValue<ThemedColor>?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<TextStyle?>? textStyle, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<double?>? minHeight});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  TableCellTheme merge(TableCellTheme? fallback);
  /// State scales step at `t < 0.5`; dimensions are lerped.
  static TableCellTheme lerp(TableCellTheme a, TableCellTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
