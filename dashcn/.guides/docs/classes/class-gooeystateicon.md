---
title: "Class: GooeyStateIcon"
description: "Circular icon bubble for the compact leading slot."
---

```dart
/// Circular icon bubble for the compact leading slot.
///
/// [loading] spins the glyph, replacing the old Material
/// `CircularProgressIndicator` in the gooey toast.
class GooeyStateIcon extends StatelessWidget {
  /// Creates a state icon.
  const GooeyStateIcon({super.key, required this.icon, required this.color, this.loading = false});
  /// Glyph shown inside the bubble.
  final IconData icon;
  /// Bubble tint; the glyph uses it at full strength.
  final Color color;
  /// Whether to spin the glyph.
  final bool loading;
  Widget build(BuildContext context);
}
```
