---
title: "Class: AppBarTheme"
description: "Theme of the [AppBar] bar."
---

```dart
/// Theme of the [AppBar] bar.
///
/// Every field is nullable: `null` means "inherit".
class AppBarTheme extends ComponentThemeData implements Mergeable<AppBarTheme> {
  /// Creates an app bar theme.
  const AppBarTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.padding, this.leadingGap, this.trailingGap, this.contentGap, this.surfaceBlur, this.surfaceOpacity});
  /// Bar surface fill. Default: the `card` token.
  final ThemedColor? background;
  /// Inner padding. Default: horizontal 18px, vertical 12px at base density.
  final EdgeInsetsGeometry? padding;
  /// Gap between leading widgets. Default: 4px scaled.
  final double? leadingGap;
  /// Gap between trailing widgets. Default: 4px scaled.
  final double? trailingGap;
  /// Gap between the leading/center/trailing sections. Default: 18px scaled.
  final double? contentGap;
  /// Backdrop blur under the bar. Default: the ambient surface blur (or 0).
  final double? surfaceBlur;
  /// Opacity multiplied onto [background]. Default: 1 (opaque).
  final double? surfaceOpacity;
  /// Returns a copy with the given fields replaced.
  AppBarTheme copyWith({ValueGetter<ThemedColor?>? background, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<double?>? leadingGap, ValueGetter<double?>? trailingGap, ValueGetter<double?>? contentGap, ValueGetter<double?>? surfaceBlur, ValueGetter<double?>? surfaceOpacity});
  /// Receiver wins per field; [fallback] only fills null cells.
  AppBarTheme merge(AppBarTheme? fallback);
  /// Steps at `t = 0.5`, except gaps and blur which interpolate.
  static AppBarTheme lerp(AppBarTheme a, AppBarTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
