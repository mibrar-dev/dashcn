---
title: "Class: FeatureCarouselCenterCard"
description: "The centre card: a token-filled surface with an accent icon."
---

```dart
/// The centre card: a token-filled surface with an accent icon.
class FeatureCarouselCenterCard extends StatelessWidget {
  /// Creates a centre card.
  const FeatureCarouselCenterCard({super.key, required this.item, required this.radius, required this.fill, required this.border, required this.accent, required this.shadow});
  final FeatureCarouselItem item;
  final double radius;
  final Color fill;
  final Color border;
  final Color accent;
  /// Elevation shadows, from the preset's shadow scale (`shadowLg`).
  final List<BoxShadow> shadow;
  Widget build(BuildContext context);
}
```
