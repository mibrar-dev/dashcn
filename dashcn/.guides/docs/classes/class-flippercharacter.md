---
title: "Class: FlipperCharacter"
description: "One rolling character: slides from the previous match to the next match  in [charset], fading through a vertical gradient mask."
---

```dart
/// One rolling character: slides from the previous match to the next match
/// in [charset], fading through a vertical gradient mask.
class FlipperCharacter extends StatelessWidget {
  const FlipperCharacter({super.key, required this.charset, required this.character, this.duration = const Duration(milliseconds: 500), this.curve = Curves.easeInOut});
  /// Pool rolled through.
  final FlipperCharset charset;
  /// Target character.
  final String character;
  /// Roll duration.
  final Duration duration;
  /// Roll curve.
  final Curve curve;
  Widget build(BuildContext context);
}
```
