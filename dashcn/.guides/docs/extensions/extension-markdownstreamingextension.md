---
title: "Extension: MarkdownStreamingExtension"
description: "Streams a text-only `Markdown` document."
---

```dart
/// Streams a text-only `Markdown` document.
///
/// The stable prefix commits verbatim; the unstable tail reveals per
/// [typewriter] under [effect]. Asset/file sources are gone (read the content
/// yourself and stream the string), as are `followLinks` (use `onTapLink`
/// with `url_launcher`), `loading` and `errorBuilder`.
extension MarkdownStreamingExtension on Markdown {
  TextAnimateMarkdown withTextStreaming({TextAnimateTypewriter typewriter = const TextAnimateTypewriter(enabled: false), TextAnimateEffect effect = const TextAnimateEffect.fade(duration: Duration(milliseconds: 220)), bool animateByWord = false});
}
```
