---
title: "Class: EmptyStateTheme"
description: "Styling of the `empty_state` block."
---

```dart
/// Styling of the `empty_state` block.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields. Colours are
/// [ThemedColor]s so they resolve against the ambient palette rather than
/// being frozen at construction.
class EmptyStateTheme extends ComponentThemeData implements Mergeable<EmptyStateTheme> {
  /// Creates an empty-state theme.
  const EmptyStateTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.iconColor, this.iconContainerBackground, this.iconContainerBorderColor, this.iconContainerPadding, this.iconContainerBorderRadius, this.titleStyle, this.descriptionStyle, this.padding, this.maxWidth, this.metrics, this.surface});
  /// Icon colour; null falls back to `mutedForeground`.
  final ThemedColor? iconColor;
  /// Fill of the icon container; null falls back to `muted`.
  final ThemedColor? iconContainerBackground;
  /// Border colour of the icon container; null falls back to `border`.
  final ThemedColor? iconContainerBorderColor;
  /// Padding inside the icon container.
  final EdgeInsetsGeometry? iconContainerPadding;
  /// Corner radius of the icon container.
  final BorderRadiusGeometry? iconContainerBorderRadius;
  /// Title text style; the size table's style is used when null.
  final TextStyle? titleStyle;
  /// Description text style; the size table's style is used when null.
  final TextStyle? descriptionStyle;
  /// Padding around the whole block; the size table's is used when null.
  final EdgeInsetsGeometry? padding;
  /// Clamp of the whole block; the size table's is used when null.
  final double? maxWidth;
  /// Per-size metric overrides; a size the caller does not list falls through
  /// to [emptyStateDefaults].
  final Map<EmptyStateSize, EmptyStateMetrics>? metrics;
  /// Fill of the compact surface; null draws no surface (full-page style).
  final ThemedColor? surface;
  /// The metrics for [size]: this leg's slice for that size when it lists one,
  /// otherwise the token-derived table entry. A listed slice wins as a whole,
  /// so a restyled size is never half-default. The top-level
  /// [iconContainerPadding]/[iconContainerBorderRadius] legs win over the size
  /// table, so an explicit widget/container leg is never shadowed by it.
  EmptyStateMetrics metricsFor(EmptyStateSize size, ThemeData theme);
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  EmptyStateTheme merge(EmptyStateTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
