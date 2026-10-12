---
title: "Class: FormKey"
description: "Identifies one form field and the type of its value."
---

```dart
/// Identifies one form field and the type of its value.
///
/// The key doubles as a [LocalKey], so it can be handed to widgets, and carries
/// its type parameter for type-safe value lookup:
///
/// ```dart
/// const emailKey = FormKey<String>('email');
/// const agreedKey = FormKey<bool>('agreed');
/// ```
class FormKey<T> extends LocalKey {
  /// Creates a [FormKey] wrapping [key].
  const FormKey(this.key);
  /// The underlying identity of this key.
  final Object key;
  /// The value type this key addresses.
  Type get type;
  /// Whether [value] is of this key's type.
  bool isInstanceOf(dynamic value);
  /// Reads this key's value out of [values].
  T? getValue(FormMapValues values);
  /// Shorthand for [getValue].
  T? operator [](FormMapValues values);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
