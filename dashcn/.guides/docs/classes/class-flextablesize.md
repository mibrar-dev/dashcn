---
title: "Class: FlexTableSize"
description: "Sizes a column or row proportionally to its [flex] factor."
---

```dart
/// Sizes a column or row proportionally to its [flex] factor.
class FlexTableSize extends TableSize {
  /// Creates a flexible size.
  const FlexTableSize({this.flex = 1, this.fit = FlexFit.tight});
  /// Flex factor.
  final double flex;
  /// Whether the item must fill its allocation.
  final FlexFit fit;
}
```
