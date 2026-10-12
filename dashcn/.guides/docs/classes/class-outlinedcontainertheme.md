---
title: "Class: OutlinedContainerTheme"
description: "Theme container for the outlined container component."
---

```dart
/// Theme container for the outlined container component.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class OutlinedContainerTheme extends ComponentThemeData implements Mergeable<OutlinedContainerTheme> {
  /// Creates an outlined container theme.
  const OutlinedContainerTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.backgroundColor, this.borderColor, this.borderRadius, this.borderStyle, this.borderWidth, this.boxShadow, this.padding, this.surfaceOpacity, this.surfaceBlur});
  /// Surface fill. Default: the `background` token.
  final ThemedColor? backgroundColor;
  /// Border colour. Default: the `muted` token.
  final ThemedColor? borderColor;
  /// Corner radius. Default: the ambient `borderRadiusXl`.
  final BorderRadiusGeometry? borderRadius;
  /// Border style. Default: solid.
  final BorderStyle? borderStyle;
  /// Border width. Default: 1 times the ambient scaling.
  final double? borderWidth;
  /// Elevation shadows. Default: none.
  final List<BoxShadow>? boxShadow;
  /// Inner padding. Default: zero.
  final EdgeInsetsGeometry? padding;
  /// Multiplies the surface fill alpha; null keeps the token alpha.
  final double? surfaceOpacity;
  /// Backdrop blur sigma; null or <= 0 draws no blur layer.
  final double? surfaceBlur;
  /// Returns a copy with the given fields replaced.
  OutlinedContainerTheme copyWith({ValueGetter<ThemedColor?>? backgroundColor, ValueGetter<ThemedColor?>? borderColor, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<BorderStyle?>? borderStyle, ValueGetter<double?>? borderWidth, ValueGetter<List<BoxShadow>?>? boxShadow, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<double?>? surfaceOpacity, ValueGetter<double?>? surfaceBlur});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  OutlinedContainerTheme merge(OutlinedContainerTheme? fallback);
  /// Colours and enums step at `t = 0.5`; geometry is lerped.
  static OutlinedContainerTheme lerp(OutlinedContainerTheme a, OutlinedContainerTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
