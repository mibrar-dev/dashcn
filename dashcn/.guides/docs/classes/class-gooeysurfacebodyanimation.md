---
title: "Class: GooeySurfaceBodyAnimation"
description: "Expanded-body content animation profile."
---

```dart
/// Expanded-body content animation profile.
class GooeySurfaceBodyAnimation {
  /// Creates a profile.
  const GooeySurfaceBodyAnimation({this.slide = 0, this.scaleFrom = 1, this.instant = false});
  /// Fades content in/out while the height opens/closes.
  static const GooeySurfaceBodyAnimation fade = GooeySurfaceBodyAnimation();
  /// Fades content while sliding from the toast seam.
  static const GooeySurfaceBodyAnimation fadeSlide = GooeySurfaceBodyAnimation(slide: kGooeyBodySlide);
  /// Fades content while slightly scaling from compact to expanded.
  static const GooeySurfaceBodyAnimation fadeScale = GooeySurfaceBodyAnimation(scaleFrom: 0.96);
  /// Shows content without extra opacity/transform animation.
  static const GooeySurfaceBodyAnimation none = GooeySurfaceBodyAnimation(instant: true);
  /// Slide distance in logical px while the body fades in.
  final double slide;
  /// Starting scale of the body content.
  final double scaleFrom;
  /// Snaps the body in at the end of the open animation instead of fading.
  final bool instant;
}
```
