---
title: "Class: PaginationTheme"
description: "Visual contract of the pagination control."
---

```dart
/// Visual contract of the pagination control.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class PaginationTheme extends ComponentThemeData implements Mergeable<PaginationTheme> {
  /// Creates a pagination theme.
  const PaginationTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.gap, this.showLabel});
  /// Gap between the controls. Default: `4` (× scaling).
  final double? gap;
  /// Whether the previous/next buttons show their text label. Default: `true`.
  final bool? showLabel;
  /// Returns a copy with the given fields replaced.
  PaginationTheme copyWith({ValueGetter<double?>? gap, ValueGetter<bool?>? showLabel});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  PaginationTheme merge(PaginationTheme? fallback);
  /// Dimensions are lerped; flags step at `t < 0.5`.
  static PaginationTheme lerp(PaginationTheme a, PaginationTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
