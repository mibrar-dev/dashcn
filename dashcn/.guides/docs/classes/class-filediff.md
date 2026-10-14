---
title: "Class: FileDiff"
description: "One file in a diff."
---

```dart
/// One file in a diff.
class FileDiff {
  const FileDiff({required this.path, required this.hunks, this.oldPath, this.status = 'modified'});
  /// Display path of the file.
  final String path;
  /// Previous path when the file was renamed.
  final String? oldPath;
  /// Diff hunks in this file.
  final List<FileDiffHunk> hunks;
  /// File status label (`modified`, `added`, ...).
  final String status;
  /// Total number of added lines.
  int get additions;
  /// Total number of deleted lines.
  int get deletions;
  /// Plain-text patch representation (used by the copy action).
  String toPatch();
}
```
