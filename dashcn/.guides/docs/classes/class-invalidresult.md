---
title: "Class: InvalidResult"
description: "A validation result indicating the value is invalid."
---

```dart
/// A validation result indicating the value is invalid.
class InvalidResult extends ValidationResult {
  /// Creates an unattached failure with [message].
  const InvalidResult(this.message, {required super.state});
  /// Creates a failure already bound to [_key].
  const InvalidResult.attached(this.message, {required FormKey this._key, required super.state});
  /// The error message shown to the user.
  final String message;
  FormKey get key;
  InvalidResult attach(FormKey key);
}
```
