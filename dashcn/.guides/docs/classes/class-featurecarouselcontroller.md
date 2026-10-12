---
title: "Class: FeatureCarouselController"
description: "Runtime configuration of a `FeatureCarousel`."
---

```dart
/// Runtime configuration of a `FeatureCarousel`.
///
/// A controller is optional: a carousel creates and disposes its own when none
/// is given. The old `update()`, `cycleAnimationStyles`, `next`/`previous` and
/// `primaryActionLabel` setter are gone (clean break).
class FeatureCarouselController extends ChangeNotifier {
  /// Creates a carousel controller.
  FeatureCarouselController({int initialIndex = 0, this.showCta = true, this.showNavArrows = true, this.autoPlay = true, this.autoPlayInterval = const Duration(seconds: 5), this.animationStyle = FeatureCarouselAnimationStyle.slideFade, this.enableKeyboardNavigation = true, this.enableSwipe = true, this.primaryActionLabel = 'Add to chat', this.onPrimaryAction, this.onIndexChanged});
  bool showCta;
  bool showNavArrows;
  bool autoPlay;
  Duration autoPlayInterval;
  FeatureCarouselAnimationStyle animationStyle;
  bool enableKeyboardNavigation;
  bool enableSwipe;
  /// Label of the call-to-action control (English fallback: no ARB key).
  final String primaryActionLabel;
  void Function(FeatureCarouselItem item, int index)? onPrimaryAction;
  void Function(int index)? onIndexChanged;
  int get index;
  set index(int value);
}
```
