---
title: "Enum: PopoverConstraint"
description: "Size constraint strategies for popover overlays."
---

```dart
/// Size constraint strategies for popover overlays.
enum PopoverConstraint {
  /// Size flexibly based on content and available space.
  flexible,
  /// Use the intrinsic content size.
  intrinsic,
  /// Match the anchor's exact size.
  anchorFixedSize,
  /// Use the anchor size as a minimum.
  anchorMinSize,
  /// Use the anchor size as a maximum.
  anchorMaxSize,
}
```
