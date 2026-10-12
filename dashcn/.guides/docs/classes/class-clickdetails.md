---
title: "Class: ClickDetails"
description: "Details about one detected click."
---

```dart
/// Details about one detected click.
class ClickDetails {
  /// Creates click details.
  const ClickDetails({required this.clickCount, this.localPosition});
  /// Consecutive clicks seen inside `ClickDetector.threshold`; `1` for the
  /// first click of a sequence.
  final int clickCount;
  /// Where the click landed, in the detector's local coordinates.
  final Offset? localPosition;
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
