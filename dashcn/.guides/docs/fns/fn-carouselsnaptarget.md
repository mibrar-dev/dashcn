---
title: "Function: carouselSnapTarget"
description: "The whole page a drag fling lands on: the pointer velocity (px/s) is  projected forward over a short horizon, capped at one page (a violent  flick must not skip ten), then rounded."
---

Signature
```dart
double carouselSnapTarget({required double value, required double velocity, required double extent, required int? itemCount, required bool wrap});
```
