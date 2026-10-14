---
title: "Class: FocusOutlineTheme"
description: "Alignment, radius and border of the [FocusOutline] ring."
---

```dart
/// Alignment, radius and border of the [FocusOutline] ring.
class FocusOutlineTheme extends ComponentThemeData implements Mergeable<FocusOutlineTheme> {
  /// Extra distance between the child edge and the ring. Defaults to 3.
  final double? align;
  /// Corner radius of the ring.
  final BorderRadiusGeometry? borderRadius;
  /// Ring border. Defaults to a 3px `ring`-colored border at half alpha.
  final Border? border;
  /// Creates a [FocusOutlineTheme].
  const FocusOutlineTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.align, this.border, this.borderRadius});
  /// Returns a copy with the given fields replaced.
  FocusOutlineTheme copyWith({ValueGetter<Border?>? border, ValueGetter<double?>? align, ValueGetter<BorderRadiusGeometry?>? borderRadius});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  FocusOutlineTheme merge(FocusOutlineTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
