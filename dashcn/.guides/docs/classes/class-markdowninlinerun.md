---
title: "Class: MarkdownInlineRun"
description: "One inline run: literal text plus its emphasis flags and link target."
---

```dart
/// One inline run: literal text plus its emphasis flags and link target.
/// Inline images are out of scope and surface as their alt text.
class MarkdownInlineRun {
  const MarkdownInlineRun({required this.text, this.bold = false, this.italic = false, this.code = false, this.strikethrough = false, this.linkUrl, this.linkTitle, this.superscript = false});
  final String text;
  final bool bold;
  final bool italic;
  final bool code;
  final bool strikethrough;
  final String? linkUrl;
  final String? linkTitle;
  /// Footnote marker: rendered smaller, linked to `#fn-<id>`.
  final bool superscript;
}
```
