---
title: "Class: FileDiffLine"
description: "A single visual row in a file diff."
---

```dart
/// A single visual row in a file diff.
class FileDiffLine {
  const FileDiffLine({required this.type, required this.content, this.oldLineNumber, this.newLineNumber});
  /// Semantic line type; `oldLineNumber`/`newLineNumber` are null for the
  /// side the line does not exist on (and for hunk headers).
  final FileDiffLineType type;
  final int? oldLineNumber;
  final int? newLineNumber;
  /// Source text without the diff marker.
  final String content;
  /// Prefix used in unified patch text.
  String get marker;
}
```
