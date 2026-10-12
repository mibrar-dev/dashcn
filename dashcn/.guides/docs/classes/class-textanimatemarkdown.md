---
title: "Class: TextAnimateMarkdown"
description: "Streaming markdown: stable lines render settled while the unstable tail  re-renders with the reveal animation."
---

```dart
/// Streaming markdown: stable lines render settled while the unstable tail
/// re-renders with the reveal animation.
///
/// Built with `Markdown(...).withTextStreaming(...)`. The source stays a
/// plain `Markdown` value (copied per section), so taps, builders and styles
/// keep working mid-stream.
class TextAnimateMarkdown extends StatefulWidget {
  const TextAnimateMarkdown({super.key, required this.source, this.typewriter = const TextAnimateTypewriter(enabled: false), this.effect = const TextAnimateEffect.fade(duration: Duration(milliseconds: 220)), this.animateByWord = false});
  /// Base document; every rendered section copies it with new data.
  final Markdown source;
  /// Reveal pacing of the unstable tail.
  final TextAnimateTypewriter typewriter;
  /// Whole-block animation of the unstable tail.
  final TextAnimateEffect effect;
  /// Word units instead of characters for the tail reveal.
  final bool animateByWord;
  State<TextAnimateMarkdown> createState();
}
```
