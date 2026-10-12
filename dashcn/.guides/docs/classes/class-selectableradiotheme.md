---
title: "Class: SelectableRadioTheme"
description: "Row styling shared by every selectable item."
---

```dart
/// Row styling shared by every selectable item.
class SelectableRadioTheme extends ComponentThemeData implements Mergeable<SelectableRadioTheme> {
  /// Creates a selectable-row theme.
  const SelectableRadioTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.unselected, this.selected, this.indicator, this.gap, this.itemPadding, this.labelStyle});
  /// Indicator style while the item is not selected.
  final RadioIndicatorStyle? unselected;
  /// Indicator style while the item is selected.
  final RadioIndicatorStyle? selected;
  /// Shared indicator style; a value row wins over it.
  final RadioIndicatorStyle? indicator;
  /// Space between the indicator and the label; null resolves 8.
  final double? gap;
  /// Padding around the row; null resolves 2 all round.
  final EdgeInsetsGeometry? itemPadding;
  /// Label text style; its colour falls back to `foreground`.
  final TextStyle? labelStyle;
  /// The indicator slice for [value], or null when this leg leaves it unset.
  RadioIndicatorStyle? forValue(bool value);
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  SelectableRadioTheme merge(SelectableRadioTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
