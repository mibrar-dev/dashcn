---
title: "Enum: MarkdownBlockKind"
description: "Block shapes the renderer dispatches on."
---

```dart
/// Block shapes the renderer dispatches on. One item per list entry; quotes
/// carry their raw text so the renderer can re-parse nested blocks.
enum MarkdownBlockKind {
  blank,
  paragraph,
  heading,
  unorderedList,
  orderedList,
  taskList,
  quote,
  codeBlock,
  table,
  image,
  details,
  footnote,
  horizontalRule,
}
```
