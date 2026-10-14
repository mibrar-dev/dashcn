---
title: "Class: WidgetStatesData"
description: "The set of interactive states propagated through the tree."
---

```dart
/// The set of interactive states propagated through the tree.
class WidgetStatesData {
  /// The current states.
  final Set<WidgetState> states;
  /// Creates widget state data.
  const WidgetStatesData(this.states);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
