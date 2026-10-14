---
title: "Class: ForwardableDataState"
description: "The state of a [ForwardableData] widget."
---

```dart
/// The state of a [ForwardableData] widget.
class ForwardableDataState<T> extends State<ForwardableData<T>> {
  /// The compile-time type of the data.
  Type get dataType;
  void didChangeDependencies();
  void dispose();
  Widget build(BuildContext context);
}
```
