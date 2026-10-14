---
title: "Class: MenuItem"
description: "One row inside a [MenuGroup]."
---

```dart
/// One row inside a [MenuGroup].
abstract class MenuItem extends Widget {
  const MenuItem({super.key});
  bool get hasLeading;
  bool get enabled;
}
```
