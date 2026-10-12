---
title: "Class: FileDiffHunk"
description: "A diff hunk with source and target line ranges."
---

```dart
/// A diff hunk with source and target line ranges.
class FileDiffHunk {
  const FileDiffHunk({required this.header, required this.lines, this.collapsed = false});
  /// Hunk header label.
  final String header;
  /// Lines in this hunk.
  final List<FileDiffLine> lines;
  /// Whether this hunk starts collapsed when `collapseUnchanged` is on.
  final bool collapsed;
  /// Number of added lines.
  int get additions;
  /// Number of deleted lines.
  int get deletions;
}
```
