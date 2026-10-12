---
title: "Class: TabsTheme"
description: "Theme of the [Tabs] pill strip."
---

```dart
/// Theme of the [Tabs] pill strip. All fields nullable; null falls through.
class TabsTheme extends ComponentThemeData implements Mergeable<TabsTheme> {
  /// Creates a tabs theme.
  const TabsTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.containerColor, this.containerPadding, this.borderRadius, this.tabPadding, this.selectedColor, this.labelColor, this.selectedLabelColor, this.textStyle});
  /// Strip fill. Default: `muted`.
  final StateValue<ThemedColor>? containerColor;
  /// Strip padding. Default: all 3 (p-[3px]).
  final EdgeInsetsGeometry? containerPadding;
  /// Strip and selected-tab radius. Default: ambient `radiusLg`/`radiusMd`.
  final BorderRadiusGeometry? borderRadius;
  /// Tab padding, horizontal only (px-2); the label centers in the 30px
  /// trigger, so vertical padding would only stack on top of it.
  final EdgeInsetsGeometry? tabPadding;
  /// Selected tab fill. Default: `background`.
  final StateValue<ThemedColor>? selectedColor;
  /// Unselected label. Default: `mutedForeground`.
  final StateValue<ThemedColor>? labelColor;
  /// Selected label. Default: `foreground`.
  final StateValue<ThemedColor>? selectedLabelColor;
  /// Label style (colour ignored). Default: 14 w500.
  final TextStyle? textStyle;
  /// Returns a copy with the given rows replaced.
  TabsTheme copyWith({ValueGetter<StateValue<ThemedColor>?>? containerColor, ValueGetter<EdgeInsetsGeometry?>? containerPadding, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? tabPadding, ValueGetter<StateValue<ThemedColor>?>? selectedColor, ValueGetter<StateValue<ThemedColor>?>? labelColor, ValueGetter<StateValue<ThemedColor>?>? selectedLabelColor, ValueGetter<TextStyle?>? textStyle});
  /// Receiver wins per field.
  TabsTheme merge(TabsTheme? fallback);
  /// Scalars lerp; colours and geometry step at `t = 0.5`.
  static TabsTheme lerp(TabsTheme a, TabsTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
