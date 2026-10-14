---
title: "Mixin: ComponentController"
description: "The value interface a component exposes so it can be driven from outside."
---

```dart
/// The value interface a component exposes so it can be driven from outside.
///
/// Adds nothing to [ValueNotifier]; it names the role so a form or a screen
/// can hold a controller for any controlled component without knowing its type.
mixin ComponentController<T> implements ValueNotifier<T> {
}
```
