---
title: "Class: FileUpload"
description: "Reference for FileUpload"
---

```dart
class FileUpload extends StatefulWidget {
  const FileUpload({super.key, this.variant = FileUploadVariant.dragDrop, this.controller, this.constraints = const FileConstraints(), this.pick, this.upload, this.dropTargetBuilder, this.onFilesChanged, this.onComplete, this.onError, this.layout = FileUploadItemsLayout.list, this.gridColumns = 2, this.groupKey, this.groupHeaderBuilder, this.iconBuilder, this.itemsMaxHeight, this.maxConcurrentUploads = 1, this.enabled = true, this.theme});
  final FileUploadVariant variant;
  final FileUploadController? controller;
  final FileConstraints constraints;
  final FileUploadPick? pick;
  final FileUploadFn? upload;
  /// Platform drag intake wrapper; null leaves the dropzone click-only.
  final FileUploadDropTargetBuilder? dropTargetBuilder;
  final ValueChanged<List<FileValue>>? onFilesChanged;
  final ValueChanged<List<FileValue>>? onComplete;
  final ValueChanged<FileError>? onError;
  final FileUploadItemsLayout layout;
  final int gridColumns;
  /// Groups rows under a header per returned key; null keeps one list.
  final String Function(FileItem item)? groupKey;
  /// Builds a group header; null renders the key as muted text.
  final Widget Function(BuildContext context, String key)? groupHeaderBuilder;
  /// Per-row thumbnail builder; null renders the extension icon.
  final FileUploadIconBuilder? iconBuilder;
  final double? itemsMaxHeight;
  final int maxConcurrentUploads;
  final bool enabled;
  final FileUploadTheme? theme;
  State<FileUpload> createState();
}
```
