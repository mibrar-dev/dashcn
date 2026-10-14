---
title: "Class: CarouselController"
description: "The fractional page position a [Carousel] is animating towards."
---

```dart
/// The fractional page position a [Carousel] is animating towards.
/// The fractional page position a [Carousel] is animating towards.
///
/// The value is a page index (`2.5` is halfway between page 2 and page 3), so
/// a drag and an autoplay step share one scale.
class CarouselController extends ChangeNotifier {
  /// Creates a controller. One handed to a [Carousel] is never disposed by
  /// that carousel; one it created for itself is.
  CarouselController();
  /// The current fractional page position.
  double get value;
  /// Whether a queued page animation is still running.
  bool get isAnimating;
  /// Advances a running animation; called by the owning [Carousel].
  void tick(Duration delta);
  void next();
  void previous();
  /// Animates to [target] over [duration], replacing a queued animation.
  void animateTo(double target, Duration duration, [Curve curve = Curves.easeInOut]);
  /// Jumps to [target] without animating.
  void jumpTo(double target);
  /// The index [value] resolves to inside `[0, itemCount)`: wraps when [wrap]
  /// is true, clamps otherwise, and is untouched for an unbounded carousel.
  double resolvedIndex({required int? itemCount, required bool wrap});
  /// Marks this controller as owned by a [Carousel], which must therefore
  /// not dispose it.
  void attach();
  void addListener(VoidCallback listener);
  void removeListener(VoidCallback listener);
  void dispose();
}
```
