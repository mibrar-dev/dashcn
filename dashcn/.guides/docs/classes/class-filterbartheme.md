---
title: "Class: FilterBarTheme"
description: "Theme data for the `filter_bar` component."
---

```dart
/// Theme data for the `filter_bar` component.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class FilterBarTheme extends ComponentThemeData implements Mergeable<FilterBarTheme> {
  /// Creates a filter bar theme.
  const FilterBarTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.spacing, this.runSpacing, this.searchWidth, this.controlWidth, this.dense});
  /// Gap between controls on the same run.
  final double? spacing;
  /// Gap between wrapped runs.
  final double? runSpacing;
  /// Width of the search field.
  final double? searchWidth;
  /// Width of the sort and date controls.
  final double? controlWidth;
  /// Compact paddings and small buttons.
  final bool? dense;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  FilterBarTheme merge(FilterBarTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
