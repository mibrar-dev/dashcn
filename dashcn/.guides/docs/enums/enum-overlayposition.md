---
title: "Enum: OverlayPosition"
description: "Edge a drawer or sheet slides in from."
---

```dart
/// Edge a drawer or sheet slides in from.
///
/// `start`/`end` follow the ambient [TextDirection]; [resolve] maps them to a
/// physical edge before the shell builds.
enum OverlayPosition {
  /// Left edge.
  left,
  /// Right edge.
  right,
  /// Top edge.
  top,
  /// Bottom edge.
  bottom,
  /// Leading edge (left in LTR, right in RTL).
  start,
  /// Trailing edge (right in LTR, left in RTL).
  end,
}
```
