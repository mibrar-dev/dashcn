---
title: "Class: MultiDataItem"
description: "An item that can be mixed into [MultiData]."
---

```dart
/// An item that can be mixed into [MultiData].
abstract class MultiDataItem {
  /// The compile-time type of the data.
  Type get dataType;
  /// Wraps [child] with the data.
  Widget wrapWidget(Widget child);
}
```
