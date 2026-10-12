---
title: "Class: WindowTheme"
description: "Chrome metrics and snap-preview colours of a window."
---

```dart
/// Chrome metrics and snap-preview colours of a window.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class WindowTheme extends ComponentThemeData implements Mergeable<WindowTheme> {
  /// Creates a window theme.
  const WindowTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.titleBarHeight, this.resizeThickness, this.titleBarPadding, this.titleColor, this.snapOverlayColor, this.snapOverlayOpacity, this.snapOverlayBlur});
  /// Height of the title bar. Default: 32 (scaled).
  final double? titleBarHeight;
  /// Grab thickness of the resize edges. Default: 8 (scaled).
  final double? resizeThickness;
  /// Padding inside the title bar. Default: 8 horizontal, density-scaled.
  final EdgeInsetsGeometry? titleBarPadding;
  /// Title colour. Default: the `foreground` token.
  final ThemedColor? titleColor;
  /// Fill of the snap preview. Default: the `card` token.
  final ThemedColor? snapOverlayColor;
  /// Fill opacity of the snap preview. Default: 0.8.
  final double? snapOverlayOpacity;
  /// Backdrop blur sigma of the snap preview. Default: 8; 0 disables it.
  final double? snapOverlayBlur;
  /// Returns a copy with the given fields replaced.
  WindowTheme copyWith({ValueGetter<double?>? titleBarHeight, ValueGetter<double?>? resizeThickness, ValueGetter<EdgeInsetsGeometry?>? titleBarPadding, ValueGetter<ThemedColor?>? titleColor, ValueGetter<ThemedColor?>? snapOverlayColor, ValueGetter<double?>? snapOverlayOpacity, ValueGetter<double?>? snapOverlayBlur});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  WindowTheme merge(WindowTheme? fallback);
  /// Colours and flags step at `t = 0.5`; dimensions are lerped.
  static WindowTheme lerp(WindowTheme a, WindowTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
