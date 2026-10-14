---
title: "Class: SileoSpringCurve"
description: "Piecewise spring curve ported from the CSS `linear(."
---

```dart
/// Piecewise spring curve ported from the CSS `linear(...)` Sileo profile.
///
/// Used by the `gooey_toast` component's `springEasing` animation style; the
/// stop list is a verbatim transcription of the old
/// `_SileoSpringEasingCurve`.
class SileoSpringCurve extends Curve {
  /// Creates the curve.
  const SileoSpringCurve();
  double transformInternal(double t);
}
```
