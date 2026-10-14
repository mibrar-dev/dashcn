---
title: "Class: TreeSelectionRange"
description: "An inclusive span of visible-row indices."
---

```dart
/// An inclusive span of visible-row indices.
class TreeSelectionRange {
  /// Creates a range from [start] to [end], inclusive.
  const TreeSelectionRange(this.start, this.end);
  /// A range that covers nothing.
  static const TreeSelectionRange empty = TreeSelectionRange(0, -1);
  /// First index covered.
  final int start;
  /// Last index covered, inclusive.
  final int end;
  /// Whether the range covers no index at all.
  bool get isEmpty;
  /// How many indices the range covers.
  int get length;
  /// Whether [index] falls inside the range.
  bool contains(int index);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
