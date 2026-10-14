---
title: "Enum: FileStatus"
description: "What a picked file is doing right now."
---

```dart
/// What a picked file is doing right now.
enum FileStatus {
  /// Picked, not uploaded yet.
  queued,
  /// Being uploaded; [FileItem.progress] is between 0 and 1.
  uploading,
  /// Upload finished.
  success,
  /// Upload failed and may be retried.
  error,
}
```
