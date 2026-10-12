---
title: "Class: URLValidator"
description: "Requires a string with a scheme and a host."
---

```dart
/// Requires a string with a scheme and a host.
class URLValidator extends Validator<String> {
  /// Creates a URL validator.
  const URLValidator({this.message});
  /// Failure text; null uses `invalidURL`.
  final String? message;
  FutureOr<ValidationResult?> validate(BuildContext context, String? value, FormValidationMode lifecycle);
  bool operator ==(Object other);
  int get hashCode;
}
```
