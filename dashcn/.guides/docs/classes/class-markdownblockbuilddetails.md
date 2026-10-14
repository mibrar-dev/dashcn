---
title: "Class: MarkdownBlockBuildDetails"
description: "Per-block override hook payload."
---

```dart
/// Per-block override hook payload.
class MarkdownBlockBuildDetails {
  const MarkdownBlockBuildDetails({required this.kind, required this.text, required this.blockIndex, required this.buildDefault, this.headingLevel, this.headingAnchor, this.language, this.orderedIndex, this.checked, this.tableRows = const <List<String>>[], this.tableAlignments = const <TextAlign>[], this.imageUrl, this.imageAlt, this.summary, this.footnoteId});
  final MarkdownBlockKind kind;
  final String text;
  final int blockIndex;
  final Widget Function() buildDefault;
  final int? headingLevel;
  final String? headingAnchor;
  final String? language;
  final int? orderedIndex;
  final bool? checked;
  final List<List<String>> tableRows;
  final List<TextAlign> tableAlignments;
  final String? imageUrl;
  final String? imageAlt;
  /// Disclosure summary for details blocks; body stays in [text].
  final String? summary;
  /// Footnote id for footnote blocks; ordinal is [orderedIndex].
  final String? footnoteId;
  /// Builds details for [block] with [buildDefault] as the default branch.
  factory MarkdownBlockBuildDetails.fromBlock(MarkdownBlock block, int blockIndex, String? slug, Widget Function() buildDefault);
}
```
