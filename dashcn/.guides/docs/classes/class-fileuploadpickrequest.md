---
title: "Class: FileUploadPickRequest"
description: "Reference for FileUploadPickRequest"
---

```dart
class FileUploadPickRequest {
  /// Creates a pick request.
  const FileUploadPickRequest({required this.allowMultiple, this.allowedExtensions, this.allowedMimeTypes});
  final bool allowMultiple;
  final List<String>? allowedExtensions;
  final List<String>? allowedMimeTypes;
}
```
