---
title: "Class: AvatarTheme"
description: "One avatar's visual contract."
---

```dart
/// One avatar's visual contract.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields. `size`, `borderRadius` and
/// `badgeSize` resolve at build because their real defaults follow the
/// ambient scaling factor (`32 * scaling`, a full circle, `10 * scaling`).
class AvatarTheme extends ComponentThemeData implements Mergeable<AvatarTheme> {
  /// Creates an avatar theme.
  const AvatarTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.size, this.borderRadius, this.backgroundColor, this.foregroundColor, this.textStyle, this.badgeSize, this.badgeBorderRadius, this.badgeColor, this.badgeForeground, this.badgeAlignment, this.badgeGap});
  /// Diameter in logical pixels; null resolves `32 * scaling`.
  final double? size;
  /// Corner radius of the tile; null resolves a full circle.
  final BorderRadiusGeometry? borderRadius;
  /// Fill behind the initials (and behind a transparent image).
  final ThemedColor? backgroundColor;
  /// Initials colour.
  final ThemedColor? foregroundColor;
  /// Initials text style; its colour is overridden by [foregroundColor].
  final TextStyle? textStyle;
  /// Badge diameter; null resolves `10 * scaling`.
  final double? badgeSize;
  /// Badge corner radius; null resolves a full circle.
  final BorderRadiusGeometry? badgeBorderRadius;
  /// Badge fill; null resolves the `primary` token.
  final ThemedColor? badgeColor;
  /// Colour applied to the badge's child (text/icon).
  final ThemedColor? badgeForeground;
  /// Where the badge sits inside the tile.
  final AlignmentGeometry? badgeAlignment;
  /// Inset of the badge from the tile edge.
  final double? badgeGap;
  /// Returns a copy with the given fields replaced.
  AvatarTheme copyWith({ValueGetter<double?>? size, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<ThemedColor?>? backgroundColor, ValueGetter<ThemedColor?>? foregroundColor, ValueGetter<TextStyle?>? textStyle, ValueGetter<double?>? badgeSize, ValueGetter<BorderRadiusGeometry?>? badgeBorderRadius, ValueGetter<ThemedColor?>? badgeColor, ValueGetter<ThemedColor?>? badgeForeground, ValueGetter<AlignmentGeometry?>? badgeAlignment, ValueGetter<double?>? badgeGap});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  AvatarTheme merge(AvatarTheme? fallback);
  /// Colours and styles step at t < 0.5; dimensions are lerped.
  static AvatarTheme lerp(AvatarTheme a, AvatarTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
