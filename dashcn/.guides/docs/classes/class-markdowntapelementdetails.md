---
title: "Class: MarkdownTapElementDetails"
description: "Details of a generic element tap."
---

```dart
/// Details of a generic element tap.
class MarkdownTapElementDetails {
  const MarkdownTapElementDetails({required this.kind, required this.text, this.url, this.anchor, this.headingLevel, this.blockIndex, this.tableRow, this.tableColumn, this.orderedIndex, this.checked});
  final MarkdownTapElementKind kind;
  final String text;
  final String? url;
  final String? anchor;
  final int? headingLevel;
  final int? blockIndex;
  final int? tableRow;
  final int? tableColumn;
  final int? orderedIndex;
  final bool? checked;
}
```
