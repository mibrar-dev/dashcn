---
title: "Class: NavigationBarTheme"
description: "Container-level theme for the navigation bar family."
---

```dart
/// Container-level theme for the navigation bar family.
class NavigationBarTheme extends ComponentThemeData implements Mergeable<NavigationBarTheme> {
  /// Creates a navigation bar theme.
  const NavigationBarTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.backgroundColor, this.alignment, this.direction, this.spacing, this.labelType, this.labelPosition, this.labelSize, this.padding, this.itemStyle, this.activeItemStyle});
  /// Container fill; null resolves the `background` token for bar/rail and
  /// draws nothing for sidebars.
  final ThemedColor? backgroundColor;
  /// Main-axis distribution of the bar.
  final MainAxisAlignment? alignment;
  /// Layout direction; null resolves from the container type.
  final Axis? direction;
  /// Space between items.
  final double? spacing;
  /// When labels are shown.
  final NavigationLabelType? labelType;
  /// Where labels sit relative to icons.
  final NavigationLabelPosition? labelPosition;
  /// Label text size.
  final NavigationLabelSize? labelSize;
  /// Container padding; null resolves 12x8 (`px-3 py-2`), density-scaled
  /// through [navigationBarDefaultPadding].
  final EdgeInsetsGeometry? padding;
  /// Style of an unselected item.
  final NavigationItemStyle? itemStyle;
  /// Style of the selected item.
  final NavigationItemStyle? activeItemStyle;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  NavigationBarTheme merge(NavigationBarTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
