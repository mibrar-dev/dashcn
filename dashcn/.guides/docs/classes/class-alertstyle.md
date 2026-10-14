---
title: "Class: AlertStyle"
description: "One variant's styling slice."
---

```dart
/// One variant's styling slice.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class AlertStyle implements Mergeable<AlertStyle> {
  /// Creates a variant style slice.
  const AlertStyle({this.background, this.borderColor, this.borderRadius, this.padding, this.titleStyle, this.contentStyle, this.titleColor, this.contentColor, this.iconColor, this.gap});
  /// Surface fill.
  final ThemedColor? background;
  /// Border colour.
  final ThemedColor? borderColor;
  /// Corner radius; null resolves the ambient `radiusLg` (upstream `rounded-lg`).
  final BorderRadiusGeometry? borderRadius;
  /// Inner padding. The default is upstream `px-4 py-3` (16/12) as an
  /// [EdgeInsetsDensity], so it scales with the ambient density; a literal
  /// override passes through `Alert` unchanged.
  final EdgeInsetsGeometry? padding;
  /// Title text style; its colour falls back to [titleColor].
  final TextStyle? titleStyle;
  /// Content text style; its colour falls back to [contentColor].
  final TextStyle? contentStyle;
  /// Title colour.
  final ThemedColor? titleColor;
  /// Content colour.
  final ThemedColor? contentColor;
  /// Leading icon colour.
  final ThemedColor? iconColor;
  /// Space between the leading icon and the text column.
  ///
  /// A raw `double` (handed straight to `BasicLayout.contentSpacing`), so it
  /// cannot carry a density multiplier: the 12 default is the `spacing.md`
  /// step of the default spacing scale (base 4, upstream `gap-3`). An app that
  /// wants it to follow a preset spacing base resolves it at build time.
  final double? gap;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  AlertStyle merge(AlertStyle? fallback);
  /// Colours step at `t = 0.5`; dimensions are lerped.
  static AlertStyle lerp(AlertStyle a, AlertStyle b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
