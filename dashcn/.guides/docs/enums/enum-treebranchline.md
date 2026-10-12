---
title: "Enum: TreeBranchLine"
description: "How the guide between a row and its parent is drawn."
---

```dart
/// How the guide between a row and its parent is drawn.
enum TreeBranchLine {
  /// No guide.
  none,
  /// A vertical line per level.
  line,
  /// A vertical line plus a tick towards the row.
  path,
}
```
