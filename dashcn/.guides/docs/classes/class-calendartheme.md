---
title: "Class: CalendarTheme"
description: "Visual contract of the calendar grid."
---

```dart
/// Visual contract of the calendar grid. One flat set of rows: the three grids
/// differ only in cell size, and a disabled cell is the grid dimmed to 50%,
/// not a fourth colour.
///
/// Colour rows, falling back to the token in brackets: `cellBackground`
/// (transparent) and `cellForeground` (`foreground`) per state,
/// `todayBackground` (`secondary`), `selectedBackground` (`primary`),
/// `selectedForeground` (`primaryForeground`), `rangeBackground` (`secondary`).
///
/// Dimension and text rows, falling back when null: `cellBorderRadius`
/// (`borderRadiusMd`), `cellWidth` (32, or 56 for the month and year grids),
/// `cellHeight` (32, or 40 for those), `gap` (the density base gap),
/// `weekdayTextStyle` (xSmall) and `cellTextStyle` (14). Both text rows ignore
/// the colour, because the colour rows own that.
class CalendarTheme extends ComponentThemeData implements Mergeable<CalendarTheme> {
  /// Creates a calendar theme.
  const CalendarTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.cellBackground, this.cellForeground, this.todayBackground, this.selectedBackground, this.selectedForeground, this.rangeBackground, this.cellBorderRadius, this.cellWidth, this.cellHeight, this.gap, this.weekdayTextStyle, this.cellTextStyle});
  final StateValue<ThemedColor>? cellBackground;
  final StateValue<ThemedColor>? cellForeground;
  final ThemedColor? todayBackground;
  final ThemedColor? selectedBackground;
  final ThemedColor? selectedForeground;
  final ThemedColor? rangeBackground;
  final BorderRadiusGeometry? cellBorderRadius;
  final double? cellWidth;
  final double? cellHeight;
  final double? gap;
  final TextStyle? weekdayTextStyle;
  final TextStyle? cellTextStyle;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  CalendarTheme merge(CalendarTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
