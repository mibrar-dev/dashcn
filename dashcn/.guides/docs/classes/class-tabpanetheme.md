---
title: "Class: TabPaneTheme"
description: "Theme of the [TabPane] bar and content card."
---

```dart
/// Theme of the [TabPane] bar and content card.
class TabPaneTheme extends ComponentThemeData implements Mergeable<TabPaneTheme> {
  /// Creates a tab pane theme.
  const TabPaneTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.borderColor, this.borderWidth, this.borderRadius, this.barHeight, this.tabSpacing});
  /// Content and focused-tab fill. Default: `card`.
  final ThemedColor? background;
  /// Content and tab border colour. Default: `border`.
  final ThemedColor? borderColor;
  /// Border width. Default: 1.
  final double? borderWidth;
  /// Content radius. Default: ambient `radiusLg`.
  final BorderRadiusGeometry? borderRadius;
  /// Tab bar height. Default: 32.
  final double? barHeight;
  /// Gap between adjacent tabs. Default: 4.
  final double? tabSpacing;
  /// Returns a copy with the given rows replaced.
  TabPaneTheme copyWith({ValueGetter<ThemedColor?>? background, ValueGetter<ThemedColor?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<double?>? barHeight, ValueGetter<double?>? tabSpacing});
  /// Receiver wins per field.
  TabPaneTheme merge(TabPaneTheme? fallback);
  /// Scalars lerp; colours and geometry step at `t = 0.5`.
  static TabPaneTheme lerp(TabPaneTheme a, TabPaneTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
