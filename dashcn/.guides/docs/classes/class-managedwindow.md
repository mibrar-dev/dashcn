---
title: "Class: ManagedWindow"
description: "A window that a [WindowHost] can manage: its identity and layer."
---

```dart
/// A window that a [WindowHost] can manage: its identity and layer.
abstract class ManagedWindow extends Widget {
  const ManagedWindow({super.key});
  /// Whether the window belongs to the always-on-top layer.
  bool get alwaysOnTop;
}
```
