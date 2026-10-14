---
title: "Class: MenuTheme"
description: "Item-row contract: upstream `px-2 py-1."
---

```dart
/// Item-row contract: upstream `px-2 py-1.5 text-sm rounded-sm`, hover fill
/// `accent` with `accentForeground` text. Disabled rows are never themed:
/// the row dims to 50% opacity instead.
class MenuTheme extends ComponentThemeData implements Mergeable<MenuTheme> {
  /// Creates a menu item theme.
  const MenuTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.foreground, this.itemPadding, this.textStyle, this.borderRadius, this.subMenuOffset});
  /// Per-state row fill; null draws none.
  final StateValue<ThemedColor>? background;
  /// Per-state label/icon colour.
  final StateValue<ThemedColor>? foreground;
  /// Inner padding of one row; null resolves px-2 py-1.5.
  final EdgeInsetsGeometry? itemPadding;
  /// Label style; its colour is ignored (taken from [foreground]).
  final TextStyle? textStyle;
  /// Row corner radius; null resolves `borderRadiusSm`.
  final BorderRadiusGeometry? borderRadius;
  /// Submenu offset; null resolves Offset(8, -4).
  final Offset? subMenuOffset;
  /// Returns a copy with the given fields replaced.
  MenuTheme copyWith({ValueGetter<StateValue<ThemedColor>?>? background, ValueGetter<StateValue<ThemedColor>?>? foreground, ValueGetter<EdgeInsetsGeometry?>? itemPadding, ValueGetter<TextStyle?>? textStyle, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<Offset?>? subMenuOffset});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  MenuTheme merge(MenuTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
