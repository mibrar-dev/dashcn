---
title: "Class: TextAnimate"
description: "Stream-aware text renderer for incremental updates."
---

```dart
/// Stream-aware text renderer for incremental updates.
///
/// Pass each new revision of the full text as [text]: the shared prefix with
/// the previous revision stays settled and only the tail animates. A
/// non-append edit restarts the animation from scratch.
class TextAnimate extends StatefulWidget {
  const TextAnimate({super.key, required this.text, this.style, this.typewriter, this.animateByWord = false, this.effect, this.cursor, this.textAlign, this.smoothLayout = true, this.layoutAnimationDuration = const Duration(milliseconds: 180), this.layoutAnimationCurve = Curves.easeOutCubic, this.onSettled, this.theme});
  /// Latest full text value received from the stream.
  final String text;
  /// Base style, merged over the theme style and the ambient default.
  final TextStyle? style;
  /// Reveal pacing; null falls back through the theme legs.
  final TextAnimateTypewriter? typewriter;
  /// Word units (with trailing whitespace) instead of characters.
  final bool animateByWord;
  /// Animation of newly revealed units; null falls back through the legs.
  final TextAnimateEffect? effect;
  /// Cursor; null falls back through the theme legs.
  final TextAnimateCursor? cursor;
  final TextAlign? textAlign;
  /// Smoothly animates height when wrapping changes the layout.
  final bool smoothLayout;
  /// Duration of the smooth layout height transition.
  final Duration layoutAnimationDuration;
  /// Curve of the smooth layout height transition.
  final Curve layoutAnimationCurve;
  /// Fired once per revision when it has fully settled.
  final TextAnimateSettled? onSettled;
  /// Widget-leg theme override, merged over the other legs.
  final TextAnimateTheme? theme;
  State<TextAnimate> createState();
}
```
