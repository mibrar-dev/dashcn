---
title: "Class: BorderLoadingSpec"
description: "Abstract shader spec: extend it for custom border painting."
---

```dart
/// Abstract shader spec: extend it for custom border painting.
abstract class BorderLoadingSpec {
  /// Base constructor for all border shader specs.
  const BorderLoadingSpec();
  /// Creates the frame shader for [bounds] at normalized [progress].
  ///
  /// [colors] are the resolved gradient colours (the ambient tokens when the
  /// spec does not carry its own).
  Shader createShader({required Rect bounds, required double progress, required List<Color> colors});
}
```
