---
title: "Class: FeatureCarouselItem"
description: "One item of a `FeatureCarousel`."
---

```dart
/// One item of a `FeatureCarousel`.
class FeatureCarouselItem {
  /// Creates a carousel item.
  const FeatureCarouselItem({this.title, this.description, this.icon, this.iconBuilder, this.accentColor});
  final String? title;
  final String? description;
  final IconData? icon;
  final FeatureCarouselIconBuilder? iconBuilder;
  final ThemedColor? accentColor;
}
```
