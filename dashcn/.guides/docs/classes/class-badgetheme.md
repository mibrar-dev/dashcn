---
title: "Class: BadgeTheme"
description: "Per-variant theme container for the badge component."
---

```dart
/// Per-variant theme container for the badge component.
class BadgeTheme extends ComponentThemeData implements Mergeable<BadgeTheme> {
  /// Creates a badge theme with one nullable slice per variant.
  const BadgeTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.primary, this.secondary, this.outline, this.destructive, this.textStyle});
  /// Style for [BadgeVariant.primary].
  final BadgeStyle? primary;
  /// Style for [BadgeVariant.secondary].
  final BadgeStyle? secondary;
  /// Style for [BadgeVariant.outline].
  final BadgeStyle? outline;
  /// Style for [BadgeVariant.destructive].
  final BadgeStyle? destructive;
  /// Text style shared by every variant; a variant row wins over it.
  final TextStyle? textStyle;
  /// The slice for [variant], or null when this leg leaves it unset.
  BadgeStyle? forVariant(BadgeVariant variant);
  /// Returns a copy with the given fields replaced.
  BadgeTheme copyWith({ValueGetter<BadgeStyle?>? primary, ValueGetter<BadgeStyle?>? secondary, ValueGetter<BadgeStyle?>? outline, ValueGetter<BadgeStyle?>? destructive, ValueGetter<TextStyle?>? textStyle});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  BadgeTheme merge(BadgeTheme? fallback);
  /// Lerps each row; state scales step at t < 0.5.
  static BadgeTheme lerp(BadgeTheme a, BadgeTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
