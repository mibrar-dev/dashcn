---
title: "Class: ResizableItem"
description: "One item managed by a [Resizer]."
---

```dart
/// One item managed by a [Resizer].
class ResizableItem {
  /// Minimum size this item can be resized to.
  final double min;
  /// Maximum size this item can be resized to.
  final double max;
  /// Whether this item is currently in collapsed state.
  final bool collapsed;
  /// Size of the item when collapsed. If null, collapsed size is 0.
  final double? collapsedSize;
  /// Whether this item can be resized.
  final bool resizable;
  ResizableItem({required this._value, this.min = 0, this.max = double.infinity, this.collapsed = false, this.collapsedSize, this.resizable = true});
  /// Whether this item is collapsed after pending resize operations.
  bool get newCollapsed;
  /// The size of this item after pending resize operations.
  double get newValue;
  /// The current committed size of this item.
  double get value;
  /// Whether a pending value was set by a resize operation.
  bool get hasPendingValue;
  /// Sets the pending size of this item.
  void setNewValue(double? value);
  /// Sets the pending collapsed state of this item.
  void setNewCollapsed(bool? value);
  /// Commits [value] as the new current size.
  void setValue(double value);
  /// Clears pending size/collapsed values.
  void resetPending();
  String toString();
}
```
