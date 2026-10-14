---
title: "Class: InputAppendTextIntent"
description: "Appends [text] at the end of the field and moves the caret after it."
---

```dart
/// Appends [text] at the end of the field and moves the caret after it.
class InputAppendTextIntent extends Intent {
  /// Creates an [InputAppendTextIntent] carrying [text].
  const InputAppendTextIntent(this.text);
  /// Text to append.
  final String text;
}
```
