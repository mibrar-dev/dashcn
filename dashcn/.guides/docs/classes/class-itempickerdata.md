---
title: "Class: ItemPickerData"
description: "Selection scope a layout reads."
---

```dart
/// Selection scope a layout reads.
class ItemPickerData {
  const ItemPickerData({this.value, this.onChanged});
  final Object? value;
  final ValueChanged<Object?>? onChanged;
  bool operator ==(Object other);
  int get hashCode;
}
```
