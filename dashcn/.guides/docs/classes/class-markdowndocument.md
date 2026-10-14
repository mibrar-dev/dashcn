---
title: "Class: MarkdownDocument"
description: "Parsed document: blocks in order, plus reference definitions collected  along the way."
---

```dart
/// Parsed document: blocks in order, plus reference definitions collected
/// along the way. Footnote definitions render as trailing [MarkdownBlockKind]
/// footnote blocks (referenced ids only, first-ref order); unreferenced
/// definitions and bare `[x]` shortcuts never render literally.
class MarkdownDocument {
  const MarkdownDocument({required this.blocks, this.references = const <String, MarkdownLinkTarget>{}, this.footnotes = const <String, String>{}});
  final List<MarkdownBlock> blocks;
  /// Normalized `[ref]` destinations: lowercase, collapsed whitespace.
  final Map<String, MarkdownLinkTarget> references;
  /// `[^id]` definition bodies by id.
  final Map<String, String> footnotes;
}
```
