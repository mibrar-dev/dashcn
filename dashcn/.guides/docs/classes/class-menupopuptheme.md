---
title: "Class: MenuPopupTheme"
description: "Popup-surface contract (upstream popover: `bg-popover`, 1px `border`,  `rounded-md`, `shadow-md`, `p-1`, min-width 8rem)."
---

```dart
/// Popup-surface contract (upstream popover: `bg-popover`, 1px `border`,
/// `rounded-md`, `shadow-md`, `p-1`, min-width 8rem).
class MenuPopupTheme extends ComponentThemeData implements Mergeable<MenuPopupTheme> {
  /// Creates a menu popup theme.
  const MenuPopupTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.foreground, this.borderColor, this.borderWidth, this.borderRadius, this.padding, this.minWidth, this.surfaceBlur});
  /// Surface fill; null resolves the `popover` token.
  final ThemedColor? background;
  /// Content colour; null resolves `popoverForeground`.
  final ThemedColor? foreground;
  /// Border colour; null resolves the `border` token.
  final ThemedColor? borderColor;
  /// Border width; null resolves 1.0.
  final double? borderWidth;
  /// Corner radius; null resolves `borderRadiusMd`.
  final BorderRadiusGeometry? borderRadius;
  /// Inner padding; null resolves 4 on all sides.
  final EdgeInsetsGeometry? padding;
  /// Minimum popup width; null resolves 128 (8rem).
  final double? minWidth;
  /// Backdrop blur radius; null resolves the app theme's `surfaceBlur`.
  final double? surfaceBlur;
  /// Returns a copy with the given fields replaced.
  MenuPopupTheme copyWith({ValueGetter<ThemedColor?>? background, ValueGetter<ThemedColor?>? foreground, ValueGetter<ThemedColor?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<double?>? minWidth, ValueGetter<double?>? surfaceBlur});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  MenuPopupTheme merge(MenuPopupTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
