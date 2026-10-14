---
title: "Class: CompareWith"
description: "Compares the value against another field's value."
---

```dart
/// Compares the value against another field's value.
class CompareWith<T extends Comparable<T>> extends Validator<T> {
  /// Creates a cross-field comparison validator.
  const CompareWith(this.key, this.type, {this.message});
  /// Compares for equality with another field.
  const CompareWith.equal(this.key, {this.message});
  /// Value must be greater than another field.
  const CompareWith.greater(this.key, {this.message});
  /// Value must be greater or equal to another field.
  const CompareWith.greaterOrEqual(this.key, {this.message});
  /// Value must be less than another field.
  const CompareWith.less(this.key, {this.message});
  /// Value must be less or equal to another field.
  const CompareWith.lessOrEqual(this.key, {this.message});
  /// The other field's key.
  final FormKey<T> key;
  /// The comparison to perform.
  final CompareType type;
  /// Failure text.
  final String? message;
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode lifecycle);
  bool shouldRevalidate(FormKey source);
  bool operator ==(Object other);
  int get hashCode;
}
```
