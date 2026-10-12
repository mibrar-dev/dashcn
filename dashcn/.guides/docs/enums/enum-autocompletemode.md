---
title: "Enum: AutoCompleteMode"
description: "How an accepted suggestion is written into the field."
---

```dart
/// How an accepted suggestion is written into the field.
enum AutoCompleteMode {
  /// Inserts the suggestion at the caret, keeping the rest of the text.
  append,
  /// Replaces the word around the caret. The default.
  replaceWord,
  /// Replaces the whole field content.
  replaceAll,
}
```
