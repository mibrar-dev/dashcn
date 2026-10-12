---
title: "Class: FileItem"
description: "One row of an upload list: a file plus its transfer state."
---

```dart
/// One row of an upload list: a file plus its transfer state.
class FileItem {
  /// Creates an upload item.
  const FileItem({required this.file, this.status = FileStatus.queued, this.progress});
  /// The file this row tracks.
  final FileValue file;
  /// Transfer state.
  final FileStatus status;
  /// Upload progress in `[0, 1]`; null when unknown or not uploading.
  final double? progress;
  /// A copy with the given fields replaced.
  ///
  /// Pass `resetProgress: true` to clear [progress]. The old
  /// `FileUploadItem.copyWith` dropped progress on *every* call, so a progress
  /// tick followed by a status change silently reset the bar.
  FileItem copyWith({FileStatus? status, double? progress, bool resetProgress = false});
  String toString();
}
```
