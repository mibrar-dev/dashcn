---
title: "Class: FeatureCarouselGhostCard"
description: "A stacked, semi-transparent card behind the centre card."
---

```dart
/// A stacked, semi-transparent card behind the centre card.
class FeatureCarouselGhostCard extends StatelessWidget {
  /// Creates a ghost card.
  const FeatureCarouselGhostCard({super.key, required this.indexFromFront, required this.radius, required this.fill, required this.border});
  final int indexFromFront;
  final double radius;
  final Color fill;
  final Color border;
  Widget build(BuildContext context);
}
```
