---
title: "Class: TripleDotsTheme"
description: "One dots row's visual contract."
---

```dart
/// One dots row's visual contract.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class TripleDotsTheme extends ComponentThemeData implements Mergeable<TripleDotsTheme> {
  /// Creates a dots theme.
  const TripleDotsTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.color, this.size, this.spacing});
  /// Dot colour; null resolves the `mutedForeground` token.
  final ThemedColor? color;
  /// Dot diameter; null resolves `4 * scaling`.
  final double? size;
  /// Gap between dots; null resolves `2`.
  final double? spacing;
  /// Returns a copy with the given fields replaced.
  TripleDotsTheme copyWith({ValueGetter<ThemedColor?>? color, ValueGetter<double?>? size, ValueGetter<double?>? spacing});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  TripleDotsTheme merge(TripleDotsTheme? fallback);
  /// Colours step at t < 0.5; dimensions are lerped.
  static TripleDotsTheme lerp(TripleDotsTheme a, TripleDotsTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
