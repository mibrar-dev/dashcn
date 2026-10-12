---
title: "Class: ReplaceResult"
description: "A validation result that asks the field to replace its value."
---

```dart
/// A validation result that asks the field to replace its value.
///
/// Validators use it to normalise input (trimming, formatting, upper-casing)
/// while still reporting through the normal validation channel.
class ReplaceResult<T> extends ValidationResult {
  /// Creates an unattached replacement of [value].
  const ReplaceResult(this.value, {required super.state});
  /// Creates a replacement of [value] already bound to [_key].
  const ReplaceResult.attached(this.value, {required FormKey this._key, required super.state});
  /// The replacement value.
  final T value;
  FormKey get key;
  ReplaceResult<T> attach(FormKey key);
}
```
