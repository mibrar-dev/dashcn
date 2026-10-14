---
title: "Class: DropzoneTheme"
description: "Styling of the dropzone surface."
---

```dart
/// Styling of the dropzone surface.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class DropzoneTheme extends ComponentThemeData implements Mergeable<DropzoneTheme> {
  /// Creates a dropzone theme.
  const DropzoneTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.borderColor, this.dragBorder, this.borderWidth, this.borderRadius, this.padding, this.minHeight, this.iconColor, this.iconSize, this.statusStyle, this.hintStyle, this.gap, this.hintGap, this.actionGap, this.focusRingColor, this.focusRingSpread, this.hoverScale, this.duration});
  /// Surface fill; null draws no fill (the ambient background shows through).
  final ThemedColor? background;
  /// Per-state border colour; a state's own colour wins over this.
  final StateValue<ThemedColor>? borderColor;
  /// Border colour while a drag hovers over the surface; null falls back to
  /// the `hovered` row of [borderColor], then to [DropzoneState.dragging]'s
  /// token.
  final ThemedColor? dragBorder;
  /// Border width; null resolves 1.
  final double? borderWidth;
  /// Corner radius; null resolves the ambient `radiusLg`.
  final BorderRadiusGeometry? borderRadius;
  /// Inner padding; null resolves `p-6` (24), density-scaled.
  final EdgeInsetsGeometry? padding;
  /// Minimum height; null resolves 0 (the surface hugs its content).
  final double? minHeight;
  /// Icon colour; null resolves `mutedForeground`.
  final ThemedColor? iconColor;
  /// Icon side; null resolves 28.
  final double? iconSize;
  /// Status line style; its colour falls back to `mutedForeground`.
  final TextStyle? statusStyle;
  /// Hint line style; its colour falls back to `mutedForeground`.
  final TextStyle? hintStyle;
  /// Space between the icon, the status line and the action; null resolves 16.
  final double? gap;
  /// Space between the status line and the hint; null resolves 4.
  final double? hintGap;
  /// Space between the hint and the action; null resolves 24.
  final double? actionGap;
  /// Focus ring colour; null resolves `ring`.
  final ThemedColor? focusRingColor;
  /// Focus ring spread; null resolves 2.
  final double? focusRingSpread;
  /// Icon scale while a drag hovers; null resolves 1.05.
  final double? hoverScale;
  /// Animation duration; null resolves 150ms.
  final Duration? duration;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  DropzoneTheme merge(DropzoneTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
