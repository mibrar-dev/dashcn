---
title: "Class: TextAnimateEffect"
description: "Per-unit animation applied to newly revealed text."
---

```dart
/// Per-unit animation applied to newly revealed text.
///
/// [wrap] is the inline-span path (every row baselines its span);
/// [buildSpan] turns a wrapped character into its span. Block content uses
/// `animateStreamingBlock` (`streaming_block.dart`, same folder).
class TextAnimateEffect {
  /// No animation: units appear settled.
  const TextAnimateEffect.none();
  /// Opacity-only fade-in.
  const TextAnimateEffect.fade({Duration duration = const Duration(milliseconds: 240), Curve curve = Curves.easeOut});
  /// Vertical slide-in, optionally fading while moving into place.
  const TextAnimateEffect.slide({Duration duration = const Duration(milliseconds: 280), double offsetY = 10, bool fadeIn = true, Curve curve = Curves.easeOutCubic});
  /// Blur-to-sharp, with an optional rise.
  const TextAnimateEffect.blur({Duration duration = const Duration(milliseconds: 260), double maxBlurSigma = 6, bool fadeIn = true, double slideUpPx = 0, Curve curve = Curves.easeOut});
  /// Scrambles through glyphs before resolving to the final unit.
  const TextAnimateEffect.scramble({Duration duration = const Duration(milliseconds: 460), double scrambleUntil = 0.74, bool fadeIn = true, Curve curve = Curves.easeOut, String characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#%&*+=?'});
  /// Runs several effects over the same unit, innermost first.
  const TextAnimateEffect.combined(List<TextAnimateEffect> effects);
  final TextAnimateEffectKind kind;
  final Duration duration;
  final Curve curve;
  /// Slide distance in logical pixels (slide).
  final double offsetY;
  /// Starting blur sigma (blur).
  final double maxBlurSigma;
  /// Fade from transparent while settling (slide/blur/scramble).
  final bool fadeIn;
  /// Rise in logical pixels while settling (blur).
  final double slideUpPx;
  /// Fraction of the duration showing scramble glyphs (scramble).
  final double scrambleUntil;
  /// Glyph pool for the scramble phase (scramble).
  final String characters;
  /// Inner effects, applied innermost first (combined).
  final List<TextAnimateEffect> effects;
  /// Time until one unit reads as settled (longest inner, if combined).
  Duration get settleDuration;
  /// Wraps [child] with the effect at reveal [age] (inline-span path).
  Widget wrap({required Widget child, required String char, required int index, required Duration age, required TextStyle baseStyle});
  /// Inline span for one unit; newlines stay plain spans.
  InlineSpan buildSpan({required String char, required int index, required Duration age, required TextStyle baseStyle});
  bool operator ==(Object other);
  int get hashCode;
}
```
