---
title: "Class: RegexValidator"
description: "Requires a string to match [pattern]."
---

```dart
/// Requires a string to match [pattern].
class RegexValidator extends Validator<String> {
  /// Creates a regex validator.
  const RegexValidator(this.pattern, {this.message});
  /// Pattern the value must match.
  final RegExp pattern;
  /// Failure text; null uses `invalidValue`.
  final String? message;
  FutureOr<ValidationResult?> validate(BuildContext context, String? value, FormValidationMode lifecycle);
  bool operator ==(Object other);
  int get hashCode;
}
```
