---
title: "Class: FileValidationResult"
description: "Outcome of [validateFiles]."
---

```dart
/// Outcome of [validateFiles].
class FileValidationResult {
  /// Creates a result.
  const FileValidationResult({required this.accepted, required this.errors});
  /// Files that passed every check, in input order.
  final List<FileValue> accepted;
  /// One error per rejection.
  final List<FileError> errors;
  /// Whether anything was rejected.
  bool get hasErrors;
  String toString();
}
```
