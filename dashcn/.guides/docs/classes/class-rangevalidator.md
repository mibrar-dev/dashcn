---
title: "Class: RangeValidator"
description: "Bounds a numeric value, inclusively or exclusively."
---

```dart
/// Bounds a numeric value, inclusively or exclusively.
class RangeValidator<T extends num> extends Validator<T> {
  /// Creates a range validator.
  const RangeValidator(this.min, this.max, {this.inclusive = true, this.message});
  /// Lower bound.
  final T min;
  /// Upper bound.
  final T max;
  /// Whether the bounds themselves are accepted.
  final bool inclusive;
  /// Failure text; null uses the localized range messages.
  final String? message;
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode lifecycle);
  bool operator ==(Object other);
  int get hashCode;
}
```
