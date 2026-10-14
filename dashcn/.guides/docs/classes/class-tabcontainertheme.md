---
title: "Class: TabContainerTheme"
description: "Default builders for [TabContainer]; null means the built-in layout."
---

```dart
/// Default builders for [TabContainer]; null means the built-in layout.
class TabContainerTheme extends ComponentThemeData implements Mergeable<TabContainerTheme> {
  /// Creates a container theme.
  const TabContainerTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.builder, this.childBuilder});
  /// Default layout builder; null lays children in a column.
  final TabBuilder? builder;
  /// Default wrapper per tab child; null passes children through.
  final TabChildBuilder? childBuilder;
  /// Returns a copy with the given builders replaced.
  TabContainerTheme copyWith({ValueGetter<TabBuilder?>? builder, ValueGetter<TabChildBuilder?>? childBuilder});
  /// Receiver wins per field.
  TabContainerTheme merge(TabContainerTheme? fallback);
  /// Builders step at `t = 0.5`.
  static TabContainerTheme lerp(TabContainerTheme a, TabContainerTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
