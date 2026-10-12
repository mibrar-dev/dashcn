---
title: "Class: ScrollableTheme"
description: "Theme container for the scrollable component."
---

```dart
/// Theme container for the scrollable component.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class ScrollableTheme extends ComponentThemeData implements Mergeable<ScrollableTheme> {
  /// Creates a scrollable theme.
  const ScrollableTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.fadeExtent, this.fadeSize});
  /// Scroll distance over which the fade reaches full strength.
  final double? fadeExtent;
  /// Length of the fade gradient.
  final double? fadeSize;
  /// Returns a copy with the given fields replaced.
  ScrollableTheme copyWith({ValueGetter<double?>? fadeExtent, ValueGetter<double?>? fadeSize});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  ScrollableTheme merge(ScrollableTheme? fallback);
  /// Lerps both geometry fields.
  static ScrollableTheme lerp(ScrollableTheme a, ScrollableTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
