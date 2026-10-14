---
title: "Class: TextAnimateTheme"
description: "Theme of the animated text."
---

```dart
/// Theme of the animated text.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class TextAnimateTheme extends ComponentThemeData implements Mergeable<TextAnimateTheme> {
  const TextAnimateTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.style, this.typewriter, this.effect, this.cursor});
  /// Base text style, merged over the ambient `DefaultTextStyle`.
  final TextStyle? style;
  /// Reveal pacing; null falls back to an enabled 48-units/s typewriter.
  final TextAnimateTypewriter? typewriter;
  /// Animation of newly revealed units; null falls back to no animation.
  final TextAnimateEffect? effect;
  /// Cursor; null falls back to hidden.
  final TextAnimateCursor? cursor;
  TextAnimateTheme copyWith({ValueGetter<TextStyle?>? style, ValueGetter<TextAnimateTypewriter?>? typewriter, ValueGetter<TextAnimateEffect?>? effect, ValueGetter<TextAnimateCursor?>? cursor});
  /// Receiver wins per field; [fallback] only fills null cells.
  TextAnimateTheme merge(TextAnimateTheme? fallback);
  /// Styles lerp; pacing, effects and cursors step at `t = 0.5`.
  static TextAnimateTheme lerp(TextAnimateTheme a, TextAnimateTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
