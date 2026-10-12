---
title: "Class: DotIndicatorDefaults"
description: "The token-derived rows of [dotIndicatorDefaults], for callers that paint  their own dots instead of using the default builder."
---

```dart
/// The token-derived rows of [dotIndicatorDefaults], for callers that paint
/// their own dots instead of using the default builder.
abstract class DotIndicatorDefaults {
  /// The active row.
  static DotStyle get active;
  /// The inactive row.
  static DotStyle get inactive;
  /// The row that matches [isActive].
  static DotStyle forIndex(bool isActive);
}
```
