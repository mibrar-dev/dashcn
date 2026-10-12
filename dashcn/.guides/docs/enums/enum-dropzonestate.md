---
title: "Enum: DropzoneState"
description: "Visual state of a dropzone surface."
---

```dart
/// Visual state of a dropzone surface.
///
/// The widget owns none of these transitions: the caller drives them from the
/// drag stream and the upload result.
enum DropzoneState {
  /// Nothing is happening.
  idle,
  /// A drag is hovering over the surface.
  dragging,
  /// Files are being written.
  uploading,
  /// The upload finished.
  success,
  /// The upload failed or the files did not validate.
  error,
  /// The surface does not accept input.
  disabled,
}
```
