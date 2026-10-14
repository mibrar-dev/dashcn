---
title: "Class: MenubarTheme"
description: "Bar contract for the `menubar` component (B20 imports this; it owns only  `MenubarState`)."
---

```dart
/// Bar contract for the `menubar` component (B20 imports this; it owns only
/// `MenubarState`). Bordered by default (upstream `border bg-background`).
class MenubarTheme extends ComponentThemeData implements Mergeable<MenubarTheme> {
  /// Creates a menubar theme.
  const MenubarTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.border, this.background, this.borderColor, this.borderWidth, this.borderRadius, this.padding, this.subMenuOffset});
  /// Whether the bar draws its border; null resolves true.
  final bool? border;
  /// Bar fill; null resolves the `background` token.
  final ThemedColor? background;
  /// Border colour; null resolves the `border` token.
  final ThemedColor? borderColor;
  /// Border width; null resolves 1.0.
  final double? borderWidth;
  /// Corner radius; null resolves `borderRadiusMd`.
  final BorderRadiusGeometry? borderRadius;
  /// Inner padding; null resolves 4 on all sides.
  final EdgeInsetsGeometry? padding;
  /// Submenu offset; null resolves Offset(-4, 8).
  final Offset? subMenuOffset;
  /// Returns a copy with the given fields replaced.
  MenubarTheme copyWith({ValueGetter<bool?>? border, ValueGetter<ThemedColor?>? background, ValueGetter<ThemedColor?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<Offset?>? subMenuOffset});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  MenubarTheme merge(MenubarTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
