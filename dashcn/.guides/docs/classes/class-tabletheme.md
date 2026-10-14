---
title: "Class: TableTheme"
description: "Table-level surface, border and resize-handle styling."
---

```dart
/// Table-level surface, border and resize-handle styling.
class TableTheme extends ComponentThemeData implements Mergeable<TableTheme> {
  /// Creates a table theme.
  const TableTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.borderColor, this.borderWidth, this.borderRadius, this.padding, this.cellTheme, this.resizerThickness, this.resizerColor});
  /// Fill of the table surface.
  final ThemedColor? background;
  /// Outer border colour; null draws no border.
  final ThemedColor? borderColor;
  /// Outer border width used when [borderColor] resolves non-null.
  final double? borderWidth;
  /// Outer corner radius; null resolves the ambient `radiusMd`.
  final BorderRadiusGeometry? borderRadius;
  /// Padding around the grid; null adds none.
  final EdgeInsetsGeometry? padding;
  /// Base cell theme merged under every row's own theme.
  final TableCellTheme? cellTheme;
  /// Thickness of the resize handles.
  final double? resizerThickness;
  /// Colour of an active resize handle.
  final ThemedColor? resizerColor;
  /// Returns a copy with the given fields replaced.
  TableTheme copyWith({ValueGetter<ThemedColor?>? background, ValueGetter<ThemedColor?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<TableCellTheme?>? cellTheme, ValueGetter<double?>? resizerThickness, ValueGetter<ThemedColor?>? resizerColor});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  TableTheme merge(TableTheme? fallback);
  /// Colours step at `t = 0.5`; geometry and cell theme are lerped.
  static TableTheme lerp(TableTheme a, TableTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
