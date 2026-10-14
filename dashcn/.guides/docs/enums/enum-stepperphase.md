---
title: "Enum: StepperPhase"
description: "Where a step sits relative to the active one: the phase picks the glyph,  the theme picks the ring colours (so a themed `failed` ring keeps its  cross)."
---

```dart
/// Where a step sits relative to the active one: the phase picks the glyph,
/// the theme picks the ring colours (so a themed `failed` ring keeps its
/// cross).
enum StepperPhase {
  pending,
  active,
  completed,
  failed,
}
```
