---
title: "Class: SliderMark"
description: "One paintable mark on the track."
---

```dart
/// One paintable mark on the track.
class SliderMark {
  /// Creates a mark; [t] is the normalized `0..1` position.
  const SliderMark({required this.value, required this.t});
  /// Value at this mark.
  final double value;
  /// Normalized position in `[0, 1]`.
  final double t;
}
```
