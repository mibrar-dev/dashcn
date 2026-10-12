---
title: "Class: GooeyActionChip"
description: "Inline action chip for the expanded body."
---

```dart
/// Inline action chip for the expanded body.
///
/// Replaces the old Material `TextButton`; height 28, stadium shape, tinted
/// with the toast tone.
class GooeyActionChip extends StatelessWidget {
  /// Creates an action chip.
  const GooeyActionChip({super.key, required this.label, required this.color, required this.onPressed});
  /// Chip label.
  final String label;
  /// Tone colour of label, tint and border.
  final Color color;
  /// Called when the chip is tapped.
  final VoidCallback onPressed;
  Widget build(BuildContext context);
}
```
