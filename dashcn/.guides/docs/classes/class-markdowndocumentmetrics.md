---
title: "Class: MarkdownDocumentMetrics"
description: "Block counts reported once a document parses."
---

```dart
/// Block counts reported once a document parses.
class MarkdownDocumentMetrics {
  const MarkdownDocumentMetrics({required this.blockCount, required this.chunkCount, required this.headingCount, required this.imageCount, required this.tableCount});
  final int blockCount;
  final int chunkCount;
  final int headingCount;
  final int imageCount;
  final int tableCount;
}
```
