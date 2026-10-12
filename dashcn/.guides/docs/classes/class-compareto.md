---
title: "Class: CompareTo"
description: "Compares the value against a fixed value."
---

```dart
/// Compares the value against a fixed value.
class CompareTo<T extends Comparable<T>> extends Validator<T> {
  /// Creates a comparison validator.
  const CompareTo(this.value, this.type, {this.message});
  /// Compares for equality.
  const CompareTo.equal(this.value, {this.message});
  /// Value must be greater.
  const CompareTo.greater(this.value, {this.message});
  /// Value must be greater or equal.
  const CompareTo.greaterOrEqual(this.value, {this.message});
  /// Value must be less.
  const CompareTo.less(this.value, {this.message});
  /// Value must be less or equal.
  const CompareTo.lessOrEqual(this.value, {this.message});
  /// The value to compare against.
  final T? value;
  /// The comparison to perform.
  final CompareType type;
  /// Failure text.
  final String? message;
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode lifecycle);
  bool operator ==(Object other);
  int get hashCode;
}
```
