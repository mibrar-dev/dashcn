---
title: "Enum: TreeSelectionGesture"
description: "What the user asked the selection to do."
---

```dart
/// What the user asked the selection to do.
enum TreeSelectionGesture {
  /// Replace the selection with this row.
  plain,
  /// Add this row to the selection, or take it out again (Ctrl/Cmd-click).
  toggle,
  /// Select everything between the anchor and this row (Shift).
  range,
  /// Select every visible row (Ctrl/Cmd+A).
  all,
}
```
