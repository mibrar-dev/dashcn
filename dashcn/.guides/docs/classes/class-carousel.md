---
title: "Class: Carousel"
description: "A paged carousel; a [CarouselController] drives the fractional page position."
---

```dart
/// A paged carousel; a [CarouselController] drives the fractional page position.
class Carousel extends StatefulWidget {
  /// Creates a carousel.
  const Carousel({super.key, required this.itemBuilder, this.itemCount, this.controller, this.transition, this.alignment, this.direction, this.viewportFraction, this.itemExtent, this.gap, this.speed, this.curve, this.autoplayInterval, this.autoplayReverse = false, this.onIndexChanged, this.onPageChanged, this.theme});
  /// Builds the page at [index].
  final CarouselItemBuilder itemBuilder;
  /// Number of pages; null means unbounded.
  final int? itemCount;
  /// Controller driving the page position; the carousel creates and disposes
  /// its own when null.
  final CarouselController? controller;
  /// Page transition; null resolves sliding.
  final CarouselTransition? transition;
  /// Page alignment; null resolves center.
  final CarouselAlignment? alignment;
  /// Scroll axis; null resolves horizontal.
  final Axis? direction;
  /// Viewport fraction per page; null resolves 1.
  final double? viewportFraction;
  /// Fixed page extent; wins over [viewportFraction].
  final double? itemExtent;
  /// Gap between two pages.
  final double? gap;
  /// Page-change duration; null resolves 150 ms.
  final Duration? speed;
  /// Page-change curve; null resolves easeInOut.
  final Curve? curve;
  /// Hold time per page; null disables autoplay.
  final Duration? autoplayInterval;
  /// Whether autoplay walks backwards.
  final bool autoplayReverse;
  /// Called with the rounded page index whenever it changes.
  final ValueChanged<int>? onIndexChanged;
  /// Called with the fractional page position on every change.
  final ValueChanged<double>? onPageChanged;
  /// Widget leg of [CarouselTheme].
  final CarouselTheme? theme;
  State<Carousel> createState();
}
```
