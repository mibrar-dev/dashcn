---
title: "Class: FeatureCarousel"
description: "Reference for FeatureCarousel"
---

```dart
class FeatureCarousel extends StatefulWidget {
  const FeatureCarousel({super.key, required this.items, this.controller, this.width, this.height, this.theme, this.cardBuilder, this.autofocus = false});
  final List<FeatureCarouselItem> items;
  final FeatureCarouselController? controller;
  final double? width;
  final double? height;
  final FeatureCarouselTheme? theme;
  final FeatureCarouselCardBuilder? cardBuilder;
  final bool autofocus;
  State<FeatureCarousel> createState();
}
```
