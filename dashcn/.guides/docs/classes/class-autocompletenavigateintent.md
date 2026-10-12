---
title: "Class: AutoCompleteNavigateIntent"
description: "Moves the highlight inside the suggestion list by [direction] rows."
---

```dart
/// Moves the highlight inside the suggestion list by [direction] rows.
class AutoCompleteNavigateIntent extends Intent {
  /// Creates a navigation intent.
  const AutoCompleteNavigateIntent(this.direction);
  /// `1` for the next row, `-1` for the previous one.
  final int direction;
}
```
