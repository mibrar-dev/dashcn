---
title: "Class: FadeScrollTheme"
description: "Offset defaults for [FadeScroll]."
---

```dart
/// Offset defaults for [FadeScroll].
class FadeScrollTheme extends ComponentThemeData implements Mergeable<FadeScrollTheme> {
  /// Fade length from the start edge in logical pixels.
  final double? startOffset;
  /// Fade length from the end edge in logical pixels.
  final double? endOffset;
  /// Creates a [FadeScrollTheme].
  const FadeScrollTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.startOffset, this.endOffset});
  /// Returns a copy with the given fields replaced.
  FadeScrollTheme copyWith({ValueGetter<double?>? startOffset, ValueGetter<double?>? endOffset});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  FadeScrollTheme merge(FadeScrollTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
