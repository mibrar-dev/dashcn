---
title: "Class: GooeyCompactMorphFrame"
description: "The outgoing compact frame while a morph runs."
---

```dart
/// The outgoing compact frame while a morph runs.
///
/// [progress] is the eased morph position: `0` fully on the previous frame,
/// `1` settled on the current one. A progress of `1` (the default) means no
/// morph is running and only the current frame paints.
class GooeyCompactMorphFrame {
  /// Creates a morph frame.
  const GooeyCompactMorphFrame({this.progress = 1, this.title, this.titleStyle, this.leading});
  /// Eased morph position, `0..1`.
  final double progress;
  /// Outgoing compact title, or null when no morph runs.
  final String? title;
  /// Outgoing compact title style, tone already applied.
  final TextStyle? titleStyle;
  /// Outgoing leading widget (state icon).
  final Widget? leading;
}
```
