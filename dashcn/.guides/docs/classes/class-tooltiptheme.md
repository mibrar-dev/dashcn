---
title: "Class: TooltipTheme"
description: "Visual contract of the tooltip surface."
---

```dart
/// Visual contract of the tooltip surface.
class TooltipTheme extends ComponentThemeData implements Mergeable<TooltipTheme> {
  /// Creates a tooltip theme.
  const TooltipTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.foreground, this.borderRadius, this.padding, this.textStyle, this.surfaceBlur});
  /// Surface fill; null resolves the `primary` token.
  final ThemedColor? background;
  /// Label colour; null resolves the `primaryForeground` token.
  final ThemedColor? foreground;
  /// Corner radius; null resolves `borderRadiusSm`.
  final BorderRadiusGeometry? borderRadius;
  /// Inner padding; null resolves the density base gap at 0.75x.
  final EdgeInsetsGeometry? padding;
  /// Label style; its color is ignored (taken from [foreground]).
  final TextStyle? textStyle;
  /// Backdrop blur radius; null resolves the app theme's `surfaceBlur`.
  final double? surfaceBlur;
  /// Returns a copy with the given fields replaced.
  TooltipTheme copyWith({ValueGetter<ThemedColor?>? background, ValueGetter<ThemedColor?>? foreground, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<TextStyle?>? textStyle, ValueGetter<double?>? surfaceBlur});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  TooltipTheme merge(TooltipTheme? fallback);
  /// State scales step at t < 0.5; dimensions lerp.
  static TooltipTheme lerp(TooltipTheme a, TooltipTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
