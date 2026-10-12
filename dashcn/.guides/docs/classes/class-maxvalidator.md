---
title: "Class: MaxValidator"
description: "Bounds a numeric value from above."
---

```dart
/// Bounds a numeric value from above.
class MaxValidator<T extends num> extends Validator<T> {
  /// Creates a maximum validator.
  const MaxValidator(this.max, {this.inclusive = true, this.message});
  /// Upper bound.
  final T max;
  /// Whether the bound itself is accepted.
  final bool inclusive;
  /// Failure text; null uses the localized bound messages.
  final String? message;
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode lifecycle);
  bool operator ==(Object other);
  int get hashCode;
}
```
