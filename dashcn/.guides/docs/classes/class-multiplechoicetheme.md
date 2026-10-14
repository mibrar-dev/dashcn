---
title: "Class: MultipleChoiceTheme"
description: "Whether re-selecting the current choice clears it, per widget kind."
---

```dart
/// Whether re-selecting the current choice clears it, per widget kind.
///
/// A single [MultipleChoice] keeps a selection once made (upstream radio
/// behaviour), while a [MultipleAnswer] toggles items off.
class MultipleChoiceTheme extends ComponentThemeData implements Mergeable<MultipleChoiceTheme> {
  /// Creates a selection theme.
  const MultipleChoiceTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.allowUnselect});
  /// Whether picking the current choice again clears it; null keeps the
  /// widget kind's default (`false` for choice, `true` for answer).
  final bool? allowUnselect;
  /// Returns a copy with the given field replaced.
  MultipleChoiceTheme copyWith({ValueGetter<bool?>? allowUnselect});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  MultipleChoiceTheme merge(MultipleChoiceTheme? fallback);
  /// Steps at t < 0.5; booleans do not interpolate.
  static MultipleChoiceTheme lerp(MultipleChoiceTheme a, MultipleChoiceTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
