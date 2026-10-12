---
title: "Extension: FormMapValuesExtension"
description: "Typed reads over [FormMapValues]."
---

```dart
/// Typed reads over [FormMapValues].
extension FormMapValuesExtension on FormMapValues {
  /// Returns the value stored under [key], or null when absent.
  ///
  /// In debug builds a stored value of the wrong type trips an assertion.
  T? getValue<T>(FormKey<T> key);
}
```
