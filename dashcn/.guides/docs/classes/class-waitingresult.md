---
title: "Class: WaitingResult"
description: "A validation result indicating the check is still running."
---

```dart
/// A validation result indicating the check is still running.
class WaitingResult extends ValidationResult {
  /// Creates a waiting result bound to [_key].
  const WaitingResult.attached({required this._key, required super.state});
  FormKey get key;
  WaitingResult attach(FormKey key);
}
```
