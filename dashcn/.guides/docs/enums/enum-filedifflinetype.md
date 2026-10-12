---
title: "Enum: FileDiffLineType"
description: "Semantic type of a diff line."
---

```dart
/// Semantic type of a diff line.
enum FileDiffLineType {
  /// Unchanged context line.
  context,
  /// Added line.
  addition,
  /// Deleted line.
  deletion,
  /// Hunk header such as `@@ -1,4 +1,6 @@`.
  hunk,
}
```
