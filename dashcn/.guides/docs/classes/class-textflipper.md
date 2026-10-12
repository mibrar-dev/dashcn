---
title: "Class: TextFlipper"
description: "Animates [text] by rolling each character through [charset]."
---

```dart
/// Animates [text] by rolling each character through [charset].
class TextFlipper extends StatelessWidget {
  const TextFlipper({super.key, this.charset = FlipperCharset.all, required this.text, this.duration = const Duration(milliseconds: 500), this.curve = Curves.easeInOut});
  /// Pool each character rolls through.
  final FlipperCharset charset;
  /// Target text.
  final String text;
  /// Roll duration per character.
  final Duration duration;
  /// Roll curve.
  final Curve curve;
  Widget build(BuildContext context);
}
```
