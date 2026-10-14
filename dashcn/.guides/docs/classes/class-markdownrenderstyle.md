---
title: "Class: MarkdownRenderStyle"
description: "Resolved per-build style: concrete values, no tokens."
---

```dart
/// Resolved per-build style: concrete values, no tokens. The component
/// resolves its [MarkdownTheme] once per build into this snapshot so the
/// primitive renderer stays theme-free.
class MarkdownRenderStyle {
  const MarkdownRenderStyle({required this.body, required this.link, required this.mono, required this.codeBackground, required this.quote, required this.quoteBorder, required this.tableHeader, required this.tableCell, required this.tableBorder, required this.tableHeaderBackground, required this.headings, required this.rule, required this.blockSpacing, required this.selectable, required this.dismissLabel, required this.onLink, required this.surface, required this.onSurface, required this.muted, required this.selection, this.references = const <String, MarkdownLinkTarget>{}, this.footnoteOrder = const <String>[]});
  final TextStyle body;
  final TextStyle link;
  final TextStyle mono;
  final Color codeBackground;
  final TextStyle quote;
  final Color quoteBorder;
  final TextStyle tableHeader;
  final TextStyle tableCell;
  final Color tableBorder;
  final Color tableHeaderBackground;
  final List<TextStyle> headings;
  final Color rule;
  final double blockSpacing;
  final bool selectable;
  final String dismissLabel;
  /// Glyph color drawn on link-colored fills (task-checkbox check).
  final Color onLink;
  /// Card surface and its foreground for the image preview chrome.
  final Color surface;
  final Color onSurface;
  /// Muted foreground for captions and language labels.
  final Color muted;
  /// Selection highlight for spans with an explicit registrar. Defaults to
  /// the ambient selection color, then `primary` at 20%.
  final Color selection;
  /// Normalized `[ref]` destinations for reference-style links.
  final Map<String, MarkdownLinkTarget> references;
  /// Referenced footnote ids in first-ref order (ordinals are 1-based).
  final List<String> footnoteOrder;
}
```
