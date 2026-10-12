---
title: "Extension: TextThenExtension"
description: "Appends an inline span to the text held by this widget."
---

```dart
/// Appends an inline span to the text held by this widget.
///
/// Supports [Text] and [RichText]; anything else throws. Chaining works — each
/// call returns another appender carrying the spans collected so far.
///
/// ```dart
/// Text('Total: ').then(TextSpan(text: '\$42'));
/// ```
extension TextThenExtension on Widget {
  /// Returns a widget rendering this one's text with [span] appended.
  Widget then(InlineSpan span);
}
```
