---
title: "Class: ScaffoldBarData"
description: "Position of a bar inside a scaffold shell."
---

```dart
/// Position of a bar inside a scaffold shell.
///
/// [AppBar] reads it for edge-aware `SafeArea` handling.
class ScaffoldBarData {
  /// Creates bar position data.
  const ScaffoldBarData({this.isHeader = true, required this.childIndex, required this.childrenCount});
  /// Whether this bar lives in the header section (else footer).
  final bool isHeader;
  /// Zero-based index of this bar among its section siblings.
  final int childIndex;
  /// Total number of bars in this bar's section.
  final int childrenCount;
}
```
