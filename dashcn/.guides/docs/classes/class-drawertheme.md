---
title: "Class: DrawerTheme"
description: "Surface, border, barrier and sizing contract of a drawer or sheet."
---

```dart
/// Surface, border, barrier and sizing contract of a drawer or sheet.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class DrawerTheme extends ComponentThemeData implements Mergeable<DrawerTheme>, DrawerRouteTheme {
  /// Creates a drawer theme.
  const DrawerTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.foreground, this.borderColor, this.borderWidth, this.borderRadius, this.padding, this.barrierColor, this.maxSize, this.showDragHandle, this.dragHandleSize, this.dragHandleColor, this.transitionDuration, this.shadows});
  /// Panel fill. Default: the `background` token.
  final ThemedColor? background;
  /// Panel content colour. Default: the `foreground` token.
  final ThemedColor? foreground;
  /// Inner-edge border colour; null draws no border. Default: `border`.
  final ThemedColor? borderColor;
  /// Border width; `0` hides the border. Default: `1`.
  final double? borderWidth;
  /// Inner-corner radius; null resolves the ambient `radiusLg` at build.
  final BorderRadius? borderRadius;
  /// Panel padding. Default: upstream `p-6`, density-scaled.
  final EdgeInsetsGeometry? padding;
  /// Barrier colour. Default: black at 50%.
  final ThemedColor? barrierColor;
  /// Panel extent along its slide axis. Default: `320`; ignored when the call
  /// expands it.
  final double? maxSize;
  /// Whether the drag handle is drawn. Default: `true`.
  final bool? showDragHandle;
  /// Drag handle size. Default: `Size(36, 4)`.
  final Size? dragHandleSize;
  /// Drag handle colour. Default: the `muted` token.
  final ThemedColor? dragHandleColor;
  /// Open/close transition duration. Default: `250ms`.
  final Duration? transitionDuration;
  /// Drop shadows; null resolves the ambient `shadowLg`, `const []` removes.
  final List<BoxShadow>? shadows;
  /// Returns a copy with the given fields replaced.
  DrawerTheme copyWith({ValueGetter<ThemedColor?>? background, ValueGetter<ThemedColor?>? foreground, ValueGetter<ThemedColor?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<BorderRadius?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<ThemedColor?>? barrierColor, ValueGetter<double?>? maxSize, ValueGetter<bool?>? showDragHandle, ValueGetter<Size?>? dragHandleSize, ValueGetter<ThemedColor?>? dragHandleColor, ValueGetter<Duration?>? transitionDuration, ValueGetter<List<BoxShadow>?>? shadows});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  DrawerTheme merge(DrawerTheme? fallback);
  /// Colours, durations and flags step at `t < 0.5`; geometry and shadows
  /// interpolate.
  static DrawerTheme lerp(DrawerTheme a, DrawerTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
