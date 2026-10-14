---
title: "Class: ResizerEngine"
description: "Internal helper of [Resizer]: owns the borrowed-space bookkeeping and the  collapse/expand thresholds."
---

```dart
/// Internal helper of [Resizer]: owns the borrowed-space bookkeeping and the
/// collapse/expand thresholds. Public only so `resizer.dart` can share it;
/// not part of the layer's public API.
class ResizerEngine {
  /// The list of resizable items being managed.
  final List<ResizableItem> items;
  /// Ratio threshold for collapsing an item (0.0 to 1.0).
  final double collapseRatio;
  /// Ratio threshold for expanding a collapsed item (0.0 to 1.0).
  final double expandRatio;
  /// Pending unfulfilled borrow, signed.
  double couldNotBorrow;
  ResizerEngine(this.items, {this.collapseRatio = 0.5, this.expandRatio = 0.5});
  /// Returns the item at [index], or null when out of bounds.
  ResizableItem? getItem(int index);
  /// Pays back loans between [index] and the given [direction].
  double payOffLoanSize(int index, double delta, int direction);
  /// Borrows [delta] for the item at [index], walking towards [until] in
  /// [direction] (-1 or 1). Returns how much was actually borrowed and from
  /// where.
  BorrowResult borrowSize(int index, double delta, int until, int direction);
  /// Collapses items near [index] when more space could not be borrowed.
  void checkCollapseUntil(int index);
  /// Expands collapsed items near [index] when enough space was borrowed.
  void checkExpanding(int index);
  /// Clears pending resize values on every item.
  void reset();
}
```
