---
title: "Class: IconContainerTheme"
description: "One icon container's visual contract."
---

```dart
/// One icon container's visual contract.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields. `borderRadius` resolves at
/// build from the ambient radius token.
class IconContainerTheme extends ComponentThemeData implements Mergeable<IconContainerTheme> {
  /// Creates an icon container theme.
  const IconContainerTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.backgroundColor, this.iconColor, this.padding, this.borderRadius});
  /// Container fill; null resolves the `primary` token.
  final ThemedColor? backgroundColor;
  /// Icon colour; null resolves the `primaryForeground` token.
  final ThemedColor? iconColor;
  /// Inner padding; null resolves `padXs` x container density.
  final EdgeInsetsGeometry? padding;
  /// Corner radius; null resolves `radiusMd`.
  final BorderRadiusGeometry? borderRadius;
  /// Returns a copy with the given fields replaced.
  IconContainerTheme copyWith({ValueGetter<ThemedColor?>? backgroundColor, ValueGetter<ThemedColor?>? iconColor, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<BorderRadiusGeometry?>? borderRadius});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  IconContainerTheme merge(IconContainerTheme? fallback);
  /// Colours and styles step at t < 0.5; dimensions are lerped.
  static IconContainerTheme lerp(IconContainerTheme a, IconContainerTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
