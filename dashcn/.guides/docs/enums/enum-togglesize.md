---
title: "Enum: ToggleSize"
description: "Fixed toggle sizes (upstream `toggleVariants` sizes, new-york default  density): h-8/h-9/h-10 = 32/36/40."
---

```dart
/// Fixed toggle sizes (upstream `toggleVariants` sizes, new-york default
/// density): h-8/h-9/h-10 = 32/36/40. Horizontal padding is px-2 (8);
/// vertical padding is zero so height comes from `minHeight` + centering
/// (vertical padding would stack on top of it, as with `Button`).
enum ToggleSize {
  sm,
  md,
  lg,
}
```
