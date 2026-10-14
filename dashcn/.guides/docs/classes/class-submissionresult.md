---
title: "Class: SubmissionResult"
description: "Outcome of [FormController."
---

```dart
/// Outcome of [FormController.submit].
class SubmissionResult {
  /// Creates a submission result.
  const SubmissionResult({required this.values, required this.errors});
  /// The values of every attached field at submit time.
  final FormMapValues values;
  /// The validation failures at submit time.
  final Map<FormKey, ValidationResult> errors;
  /// Whether the form passed validation.
  bool get isValid;
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
