---
title: "Class: MinValidator"
description: "Bounds a numeric value from below."
---

```dart
/// Bounds a numeric value from below.
class MinValidator<T extends num> extends Validator<T> {
  /// Creates a minimum validator.
  const MinValidator(this.min, {this.inclusive = true, this.message});
  /// Lower bound.
  final T min;
  /// Whether the bound itself is accepted.
  final bool inclusive;
  /// Failure text; null uses the localized bound messages.
  final String? message;
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode lifecycle);
  bool operator ==(Object other);
  int get hashCode;
}
```
