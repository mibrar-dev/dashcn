---
title: "Function: resolveMarkdownStyle"
description: "Resolves a [MarkdownTheme] into concrete renderer values once per build,  so the primitive renderer stays theme-free."
---

Signature
```dart
MarkdownRenderStyle resolveMarkdownStyle(BuildContext context, {required MarkdownTheme? widgetTheme, TextStyle? style, required bool selectable, required Map<String, MarkdownLinkTarget> references, required List<String> footnoteOrder});
```
