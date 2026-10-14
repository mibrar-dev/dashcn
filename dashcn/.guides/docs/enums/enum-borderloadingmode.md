---
title: "Enum: BorderLoadingMode"
description: "Visual rendering mode of [BorderLoading]."
---

```dart
/// Visual rendering mode of [BorderLoading].
enum BorderLoadingMode {
  /// Rotating border that loops forever.
  sweepGradient,
  /// One or more tracer segments travelling around the outline.
  tracer,
  /// Determinate upload-style progress (`0.0 -> 1.0`).
  progress,
  /// A complete, non-animated border.
  staticBorder,
}
```
