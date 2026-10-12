---
title: "Enum: HSLColorSliderType"
description: "Which channel(s) the slider drives."
---

```dart
/// Which channel(s) the slider drives.
///
/// `hue`, `sat`, `lum`, `alpha` are single-channel bars; the rest are 2D pads.
enum HSLColorSliderType {
  hue,
  hueSat,
  hueLum,
  hueAlpha,
  sat,
  satLum,
  satAlpha,
  lum,
  lumAlpha,
  alpha,
}
```
