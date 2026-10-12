---
title: "Enum: FileUploadVariant"
description: "The surface a [FileUpload] renders."
---

```dart
/// The surface a [FileUpload] renders.
enum FileUploadVariant {
  /// Drag-and-drop surface; a drag needs a caller-supplied `dropTargetBuilder`.
  dragDrop,
  /// One-line picker tile (label + chosen file name).
  tile,
  /// Compact trigger for small layouts.
  mobile,
}
```
