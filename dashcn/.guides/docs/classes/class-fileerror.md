---
title: "Class: FileError"
description: "One rejection produced by [validateFiles] or by the upload controller."
---

```dart
/// One rejection produced by [validateFiles] or by the upload controller.
class FileError {
  /// Creates an error.
  const FileError({required this.code, required this.message, this.file});
  /// Why the file was rejected.
  final FileErrorCode code;
  /// User-facing message. Components build this from `ComponentLocalizations`; the
  /// validation helper takes it as a parameter so it never hard-codes English.
  final String message;
  /// The rejected file, when the error is about a single file.
  final FileValue? file;
  String toString();
}
```
