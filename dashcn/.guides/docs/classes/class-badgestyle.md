---
title: "Class: BadgeStyle"
description: "One variant's state-aware styling slice."
---

```dart
/// One variant's state-aware styling slice.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining states/fields. Unlike the old
/// `Styleable<BadgeTheme>` bags, a leg no longer replaces a whole property:
/// `StateValue.merge` fills the states it leaves unset, so an override that
/// only sets `hovered` keeps the default `rest` colour.
class BadgeStyle implements Mergeable<BadgeStyle> {
  /// Creates a badge style slice.
  const BadgeStyle({this.background, this.foreground, this.borderColor, this.borderWidth, this.padding, this.textStyle, this.iconSize});
  /// Per-state fill of the badge surface.
  final StateValue<ThemedColor>? background;
  /// Per-state label/icon color.
  final StateValue<ThemedColor>? foreground;
  /// Per-state border color; null draws no border.
  final StateValue<ThemedColor>? borderColor;
  /// Border width used when [borderColor] resolves non-null.
  final double? borderWidth;
  /// Padding override; null falls back to the size table.
  final EdgeInsetsGeometry? padding;
  /// Text style override; its color is ignored (taken from [foreground]).
  final TextStyle? textStyle;
  /// Icon size override; null resolves 12 logical pixels at build.
  final double? iconSize;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  BadgeStyle merge(BadgeStyle? fallback);
  /// State scales are stepped at t < 0.5; dimensions are lerped.
  static BadgeStyle lerp(BadgeStyle a, BadgeStyle b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
