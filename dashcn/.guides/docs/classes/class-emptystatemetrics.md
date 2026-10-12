---
title: "Class: EmptyStateMetrics"
description: "Every metric one [EmptyStateSize] resolves."
---

```dart
/// Every metric one [EmptyStateSize] resolves.
class EmptyStateMetrics {
  /// Creates a metrics slice.
  const EmptyStateMetrics({required this.iconSize, required this.titleStyle, required this.descriptionStyle, required this.padding, required this.contentGap, required this.titleGap, required this.actionGap, required this.actionSpacing, required this.maxWidth, required this.descriptionMaxWidth, this.iconContainerPadding, this.iconContainerBorderRadius});
  /// Icon side.
  final double iconSize;
  /// Title text style.
  final TextStyle titleStyle;
  /// Description text style.
  final TextStyle descriptionStyle;
  /// Padding around the whole block; the size table stores density
  /// multipliers, resolved by [emptyStateMetrics].
  final EdgeInsetsGeometry padding;
  /// Space between the icon block and the title.
  final double contentGap;
  /// Space between the title and the description.
  final double titleGap;
  /// Space above the action row.
  final double actionGap;
  /// Horizontal gap between two actions.
  final double actionSpacing;
  /// Clamp of the whole block.
  final double maxWidth;
  /// Clamp of the description measure.
  final double descriptionMaxWidth;
  /// Padding inside the icon container; null falls through to the theme field
  /// and then to the size table, whose value is a density multiplier resolved
  /// by [emptyStateMetrics].
  final EdgeInsetsGeometry? iconContainerPadding;
  /// Corner radius of the icon container; null falls through to the theme field
  /// and then to the size table.
  final BorderRadiusGeometry? iconContainerBorderRadius;
}
```
