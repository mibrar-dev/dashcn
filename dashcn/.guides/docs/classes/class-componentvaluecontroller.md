---
title: "Class: ComponentValueController"
description: "A plain [ComponentController] holding one value."
---

```dart
/// A plain [ComponentController] holding one value.
class ComponentValueController<T> extends ValueNotifier<T> implements ComponentController<T> {
  /// Creates a controller seeded with [value].
  ComponentValueController(super.value);
}
```
