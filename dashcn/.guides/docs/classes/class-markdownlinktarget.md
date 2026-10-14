---
title: "Class: MarkdownLinkTarget"
description: "Link target of a `[ref]: url \"title\"` reference definition."
---

```dart
/// Link target of a `[ref]: url "title"` reference definition.
class MarkdownLinkTarget {
  const MarkdownLinkTarget({required this.url, this.title});
  final String url;
  final String? title;
}
```
