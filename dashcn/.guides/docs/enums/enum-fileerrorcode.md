---
title: "Enum: FileErrorCode"
description: "Why a file was rejected."
---

```dart
/// Why a file was rejected.
enum FileErrorCode {
  /// The extension or MIME type is not allowed.
  invalidType,
  /// The file is bigger than the configured limit.
  tooLarge,
  /// Adding it would exceed the configured file count.
  tooMany,
  /// The upload itself failed.
  uploadFailed,
}
```
