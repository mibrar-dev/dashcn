---
title: "Class: MarkdownBlock"
description: "One parsed block."
---

```dart
/// One parsed block. Per-item blocks carry their own index/indent/checked so
/// lists need no wrapper node; tables carry header-first rows plus alignments.
class MarkdownBlock {
  const MarkdownBlock({required this.kind, required this.text, this.headingLevel, this.orderedIndex = 1, this.indentLevel = 0, this.checked, this.language, this.tableRows = const <List<String>>[], this.tableAlignments = const <TextAlign>[], this.imageUrl, this.imageAlt, this.imageTitle, this.summary, this.footnoteId});
  final MarkdownBlockKind kind;
  final String text;
  final int? headingLevel;
  final int orderedIndex;
  final int indentLevel;
  final bool? checked;
  final String? language;
  final List<List<String>> tableRows;
  final List<TextAlign> tableAlignments;
  final String? imageUrl;
  final String? imageAlt;
  final String? imageTitle;
  /// Disclosure summary for [MarkdownBlockKind.details]; body stays in [text].
  final String? summary;
  /// Footnote id for [MarkdownBlockKind.footnote]; its ordinal is
  /// [orderedIndex], its anchor is `fn-<id>`.
  final String? footnoteId;
}
```
